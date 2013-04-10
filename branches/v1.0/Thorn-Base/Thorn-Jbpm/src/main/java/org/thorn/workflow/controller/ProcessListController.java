package org.thorn.workflow.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jbpm.api.ExecutionService;
import org.jbpm.api.TaskQuery;
import org.jbpm.api.TaskService;
import org.jbpm.api.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.org.entity.Org;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Page;
import org.thorn.workflow.WorkflowConfiguration;
import org.thorn.workflow.entity.FlowType;
import org.thorn.workflow.entity.Participator;
import org.thorn.workflow.entity.TaskInfo;
import org.thorn.workflow.service.IFlowTypeService;
import org.thorn.workflow.service.IParticipatorService;

/**
 * @ClassName: ProcessListController
 * @Description:
 * @author chenyun
 * @date 2012-7-11 上午10:49:24
 */
@Controller
@RequestMapping("/wf/cm")
public class ProcessListController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ProcessListController.class);

	@Autowired
	@Qualifier("taskService")
	private TaskService taskService;

	@Autowired
	@Qualifier("executionService")
	private ExecutionService execution;

	@Autowired
	@Qualifier("flowTypeService")
	private IFlowTypeService flowTypeService;

	@Autowired
	@Qualifier("participatorService")
	private IParticipatorService participatorService;

	@RequestMapping("/getCreatProcessList")
	@ResponseBody
	public Page<FlowType> getCreatProcessList(String type) {
		Page<FlowType> page = new Page<FlowType>();

		try {
			List<FlowType> list = flowTypeService.queryByType(type);

			if (list != null && list.size() > 0) {
				Set<String> keys = new HashSet<String>();
				for (FlowType ft : list) {
					keys.add(ft.getFlowKey());
				}
				List<Participator> ptLits = participatorService.queryList(keys,
						WorkflowConfiguration.START_ACTIVITY_ID);

				User user = SecurityUserUtils.getCurrentUser();
				List<String> roleList = SecurityUserUtils.getRoleList();
				String deptCode = null;
				String companyCode = null;
				if (!LocalStringUtils.equals(user.getOrgType(),
						WorkflowConfiguration.COMPANY)) {
					Org org = SecurityUserUtils.getUserParentOrg();
					deptCode = org.getOrgCode();
					companyCode = org.getParentOrg();
				}

				// 比较权限，环节绑定的参与者可能是多值
				List<Integer> rmIndex = new ArrayList<Integer>();
				for (int i = 0; i < list.size(); i++) {

					FlowType ft = list.get(i);
					for (Participator pt : ptLits) {

						if (LocalStringUtils.equalsIgnoreCase(ft.getFlowKey(),
								pt.getProcessDfId())) {

							String entityType = pt.getEntityType();
							String entity = pt.getEntity();

							if (LocalStringUtils.equals(entityType,
									WorkflowConfiguration.GROUP_ROLE)) {

								for (String role : roleList) {
									if (LocalStringUtils.indexOf(entity, role) > -1) {
										break;
									}
								}

								// 不符合角色的要求
								rmIndex.add(i);
							} else if (LocalStringUtils.equals(entityType,
									WorkflowConfiguration.GROUP_AREA)
									&& LocalStringUtils.indexOf(entity,
											user.getArea()) == -1) {
								// 不符合区域的要求
								rmIndex.add(i);
							} else if (LocalStringUtils.equals(entityType,
									WorkflowConfiguration.GROUP_USER)
									&& LocalStringUtils.indexOf(entity,
											user.getUserId()) == -1) {
								// 不符合人员的要求
								rmIndex.add(i);
							} else if (LocalStringUtils.equals(entityType,
									WorkflowConfiguration.GROUP_ORG)
									&& LocalStringUtils.indexOf(entity,
											user.getOrgCode()) == -1
									&& LocalStringUtils.indexOf(entity,
											deptCode) == -1
									&& LocalStringUtils.indexOf(entity,
											companyCode) == -1) {
								// 不符合组织的要求
								rmIndex.add(i);
							}
						} else {
							continue;
						}

					}
				}

				// 去掉没有权限的，list从后往前删除
				for (int i = rmIndex.size() - 1; i >= 0; i--) {
					list.remove((int) rmIndex.get(i));
				}
			}

			page.setReslutSet(list);
		} catch (DBAccessException e) {
			log.error("getCreatProcessList[FlowType] - " + e.getMessage(), e);
		}

		return page;
	}

	@RequestMapping("/getTodoPage")
	@ResponseBody
	public Page<TaskInfo> getTodoPage(long start, long limit, String sort,
			String dir, String flowKey) {

		Page<TaskInfo> page = new Page<TaskInfo>();

		User user = SecurityUserUtils.getCurrentUser();

		TaskQuery query = taskService.createTaskQuery();
		query = query.assignee(user.getUserId());

		if (LocalStringUtils.isNotBlank(flowKey)) {
			query = query.processDefinitionId(flowKey);
		}

		long count = query.count();
		page.setTotal(count);

		query = query.orderDesc(TaskQuery.PROPERTY_PRIORITY);
		query = query.page((int) start, (int) limit);
		List<Task> tasks = query.list();

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		for (Task task : tasks) {
			TaskInfo tsInfo = new TaskInfo();

			tsInfo.setActivityName(task.getActivityName());
			tsInfo.setPriority(task.getPriority());
			tsInfo.setReceiptTime(df.format(task.getCreateTime()));
			tsInfo.setTaskId(task.getId());

			tsInfo.setTitle((String) execution.getVariable(
					task.getExecutionId(), "title"));
			tsInfo.setFlowInstId(task.getExecutionId());

			int index = task.getExecutionId().indexOf(".");
			tsInfo.setFlowKey(task.getExecutionId().substring(0, index));

			page.getReslutSet().add(tsInfo);
		}

		return page;
	}

}
