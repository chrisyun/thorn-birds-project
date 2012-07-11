package org.thorn.workflow.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jbpm.api.ExecutionService;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.TaskService;
import org.jbpm.api.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.org.entity.Org;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.workflow.WorkflowConfiguration;
import org.thorn.workflow.entity.FlowType;
import org.thorn.workflow.entity.Participator;
import org.thorn.workflow.service.IFlowTypeService;
import org.thorn.workflow.service.IParticipatorService;

/**
 * @ClassName: CreatProcessController
 * @Description:
 * @author chenyun
 * @date 2012-6-23 下午09:54:49
 */
@Controller
@RequestMapping("/wf/cr")
public class CreateProcessController extends BaseController {

	static Logger log = LoggerFactory.getLogger(CreateProcessController.class);

	@Autowired
	@Qualifier("flowTypeService")
	private IFlowTypeService flowTypeService;

	@Autowired
	@Qualifier("participatorService")
	private IParticipatorService participatorService;

	@Autowired
	@Qualifier("executionService")
	private ExecutionService execution;

	@Autowired
	@Qualifier("taskService")
	private TaskService taskService;

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

	@RequestMapping("/modifyFlowType")
	@ResponseBody
	public Status modifyFlowType(FlowType type) {
		Status status = new Status();

		try {
			flowTypeService.saveOrModifyFlowType(type);
			status.setMessage("修改流程类型成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("modifyFlowType[FlowType] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/deleteFlowType")
	@ResponseBody
	public Status deleteFlowType(String ids) {
		Status status = new Status();

		try {
			flowTypeService.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteFlowType[FlowType] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/startNewProcess")
	public String startNewProcess(String key, ModelMap model) {

		User user = SecurityUserUtils.getCurrentUser();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put(WorkflowConfiguration.PROCESS_CREATER, user.getUserId());

		ProcessInstance pi = execution.startProcessInstanceByKey(key, map);

		// 已经是start节点的第一个task
		Task task = taskService.createTaskQuery().processInstanceId(pi.getId())
				.uniqueResult();
	
		model.put("flowKey", key);
		model.put("flowName", pi.getName());
		model.put("flowInstId", pi.getId());
		model.put("creater", user.getUserId());
		model.put("activityName", task.getActivityName());
		model.put("pageUrl", task.getFormResourceName());
		model.put("taskId", task.getId());
		
		return "/workflow/template/newProcess";
	}

}
