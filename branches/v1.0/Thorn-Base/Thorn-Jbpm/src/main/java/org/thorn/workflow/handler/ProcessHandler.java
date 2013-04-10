package org.thorn.workflow.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.jbpm.api.ExecutionService;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.TaskService;
import org.jbpm.pvm.internal.model.ActivityImpl;
import org.jbpm.pvm.internal.model.ProcessDefinitionImpl;
import org.jbpm.pvm.internal.model.TransitionImpl;
import org.jbpm.pvm.internal.task.TaskImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.auth.service.IAuthService;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.org.entity.Org;
import org.thorn.org.service.IOrgService;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.user.service.IUserService;
import org.thorn.workflow.HandlerException;
import org.thorn.workflow.WorkflowConfiguration;
import org.thorn.workflow.entity.Participator;
import org.thorn.workflow.service.IParticipatorService;

/**
 * @ClassName: ProcessCustomHandler
 * @Description: 1、根据流程数据取出下一环节的参与者 2、如何根据线条获取下一环节
 *               3、如何与自定义的接口绑定，将不同流程自定义的处理部分加载进来 ，实现最大化的松耦合与灵活控制
 * @author chenyun
 * @date 2012-7-3 下午09:11:58
 */
public abstract class ProcessHandler {

	@Autowired
	@Qualifier("taskService")
	protected TaskService taskService;

	@Autowired
	@Qualifier("repositoryService")
	private RepositoryService repository;

	@Autowired
	@Qualifier("executionService")
	private ExecutionService execution;

	@Autowired
	@Qualifier("participatorService")
	protected IParticipatorService ppService;

	@Autowired
	@Qualifier("orgService")
	protected IOrgService orgService;

	@Autowired
	@Qualifier("userService")
	protected IUserService userService;

	@Autowired
	@Qualifier("authService")
	protected IAuthService authService;

	public final void execute(Map<String, Object> parameters,
			HttpServletRequest request) throws DBAccessException {
		Map<String, Object> variable = new HashMap<String, Object>();

		String taskId = (String) parameters.get("taskId");
		String nextStep = (String) parameters.get("nextStep");
		String flowKey = (String) parameters.get("flowKey");

		String flowAtts = (String) parameters.get("flowAtts");
		variable.put("flowAtts", flowAtts);
		
		String appId = (String) parameters.get("appId");
		variable.put("appId", appId);
		
		String title = (String) parameters.get("title");
		variable.put("title", title);

		String nextActivity = getNextActivityName(taskId, nextStep);

		// 计算下一环节处理人
		Participator pp = ppService.queryParticipator(nextActivity, flowKey);

		putNextActivityPp(pp, taskId, variable);

		executeCustomHandlerBefore(parameters, request, variable);

		// 是否按照默认的执行
		if (completeTaskHook()) {
			if (!StringUtils.isNotBlank(nextStep)) {
				taskService.completeTask(taskId, variable);
			} else {
				taskService.completeTask(taskId, nextStep, variable);
			}
		}

		executeCustomHandlerAfter(parameters, request);
	}

	protected abstract void executeCustomHandlerAfter(
			Map<String, Object> parameters, HttpServletRequest request)
			throws DBAccessException;

	protected abstract void executeCustomHandlerBefore(
			Map<String, Object> parameters, HttpServletRequest request,
			Map<String, Object> variable) throws DBAccessException;

	protected boolean completeTaskHook() {
		return true;
	}

	/**
	 * 
	 * @Description：
	 * @author：chenyun
	 * @date：2012-7-11 上午10:21:28
	 * @param taskId
	 * @param nextStep
	 * @return
	 */
	protected String getNextActivityName(String taskId, String nextStep) {
		TaskImpl task = (TaskImpl) taskService.getTask(taskId);
		ProcessInstance inst = execution.findProcessInstanceById(task
				.getExecutionId());

		// 获取当前任务的活动节点
		// ActivityImpl curActivity = execu.getActivity();
		ProcessDefinitionImpl dfImpl = (ProcessDefinitionImpl) repository
				.createProcessDefinitionQuery()
				.processDefinitionId(inst.getProcessDefinitionId())
				.uniqueResult();

		ActivityImpl curActivity = dfImpl.findActivity(task.getName());

		// 获取下一环节的转移线
		TransitionImpl nextTrans = null;
		if (StringUtils.isNotBlank(nextStep)) {
			nextTrans = curActivity.getOutgoingTransition(nextStep);
		} else {
			List<TransitionImpl> outgoings = (List<TransitionImpl>) curActivity
					.getOutgoingTransitions();

			if (outgoings != null && outgoings.size() == 1) {
				nextTrans = outgoings.get(0);
			} else {
				throw new HandlerException(
						"multiple outgoingTransitions and don't point out outgoingTransition,curActivityName:"
								+ curActivity.getName());
			}
		}

		// 获取下一环节
		ActivityImpl nextActivity = nextTrans.getDestination();

		return nextActivity.getName();
	}

	/**
	 * 
	 * @Description：获取可以送出的环节线名称
	 * @author：chenyun
	 * @date：2012-7-11 上午10:09:26
	 * @param taskId
	 * @return
	 */
	public Set<String> getNextActivityLines(String taskId) {

		return taskService.getOutcomes(taskId);
		// TaskImpl task = (TaskImpl) taskService.getTask(taskId);
		// ExecutionImpl execu = task.getProcessInstance();
		//
		// // 获取当前任务的活动节点
		// ActivityImpl curActivity = execu.getActivity();
		//
		// List<TransitionImpl> outgoings = (List<TransitionImpl>) curActivity
		// .getOutgoingTransitions();
		//
		// Set<String> outgoingNames = new HashSet<String>();
		//
		// for (TransitionImpl transition : outgoings) {
		// outgoingNames.add(transition.getName());
		// }
		//
		// return outgoingNames;
	}

	protected void putNextActivityPp(Participator pp, String taskId,
			Map<String, Object> variable) throws DBAccessException {

		if (pp == null) {
			return;
		}

		String entityType = pp.getEntityType();
		List<String> entity = LocalStringUtils.splitStr2Array(pp.getEntity());
		String limit = pp.getLimitType();
		String limitCode = "";
		User user = SecurityUserUtils.getCurrentUser();

		String lastActor = (String) taskService.getVariable(taskId,
				pp.getVariable());

		if (StringUtils.isNotBlank(lastActor)) {
			return;
		}

		if (StringUtils.equals(pp.getVariableType(),
				WorkflowConfiguration.PP_GROUP)) {

			if (StringUtils.isBlank(limit)) {
				limit = WorkflowConfiguration.LIMIT_NONE;
			} else {
				if (compareOrgLevel(limit, user.getOrgType()) == 0) {
					// 限制类型与当前用户的所属组织类型一致，取用户的所属组织
					limit = WorkflowConfiguration.LIMIT_SUBORG;
					limitCode = user.getOrgCode();
				} else if (compareOrgLevel(limit, user.getOrgType()) < 0) {
					// 限制类型组织级别小于当前用户的所属组织级别，取用户的所属组织，不向下查找
					limit = WorkflowConfiguration.LIMIT_CURORG;
					limitCode = user.getOrgCode();
				} else {
					// 限制类型组织级别大于当前用户的所属组织级别，向上取用户的同級別组织
					Org parentOrg = SecurityUserUtils.getUserParentOrg();

					if (compareOrgLevel(limit, parentOrg.getOrgType()) == 0) {
						limit = WorkflowConfiguration.LIMIT_SUBORG;
						limitCode = parentOrg.getParentOrg();
					} else {
						limit = WorkflowConfiguration.LIMIT_SUBORG;
						limitCode = parentOrg.getParentOrg();
					}
				}
			}

			StringBuilder group = new StringBuilder("{");
			group.append("groupType:\"").append(entityType).append("\",");
			group.append("groupId:\"").append(pp.getEntity()).append("\",");
			group.append("limit:\"").append(limit).append("\",");
			group.append("limitCode:\"").append(limitCode).append("\"}");

			variable.put(pp.getVariable(), group.toString());
		} else {

			Set<String> orgs = new HashSet<String>();

			if (compareOrgLevel(limit, user.getOrgType()) <= 0) {
				orgs.add(user.getOrgCode());
			} else if (compareOrgLevel(limit, user.getOrgType()) > 0) {
				Org parentOrg = SecurityUserUtils.getUserParentOrg();

				if (compareOrgLevel(limit, parentOrg.getOrgType()) == 0) {
					orgs.add(parentOrg.getOrgCode());
				} else {
					orgs.add(parentOrg.getParentOrg());
				}

				orgs.addAll(findSubOrg(orgs));

			} else {
				orgs = null;
			}

			List<User> users = new ArrayList<User>();

			if (LocalStringUtils.equals(entityType,
					WorkflowConfiguration.GROUP_ORG)) {
				if (orgs == null) {
					users = userService.queryList(null, null, null, null, null,
							null, entity);
				} else {
					orgs.addAll(entity);
					users = userService.queryList(null, null, null, null, null,
							null, orgs);
				}
			} else if (LocalStringUtils.equals(entityType,
					WorkflowConfiguration.GROUP_ROLE)) {
				users = authService.queryListByRole(entity, orgs);
			} else if (LocalStringUtils.equals(entityType,
					WorkflowConfiguration.GROUP_AREA)) {
				users = userService.queryList(null, null, null, entity, null,
						null, orgs);
			} else if (LocalStringUtils.equals(entityType,
					WorkflowConfiguration.GROUP_USER)) {
				users = userService.queryList(null, null, null, null, null,
						entity, orgs);
			}

			// 随机选一个人出来
			if (users != null && users.size() > 0) {
				variable.put(pp.getVariable(),
						users.get(RandomUtils.nextInt(users.size()))
								.getUserId());
			} else {
				throw new HandlerException("No handler was found in "
						+ pp.getActivityId());
			}
		}
	}

	/**
	 * 
	 * @Description：比较组织的级别大小：company > dept > org
	 * @author：chenyun
	 * @date：2012-7-10 下午04:48:29
	 * @param type1
	 * @param type2
	 * @return 0 type1=type2，1 type1>type2, -1 type1<type2
	 */
	private int compareOrgLevel(String type1, String type2) {

		if (StringUtils.equalsIgnoreCase(type1, type2)) {
			return 0;
		} else if (StringUtils.equals(type1, WorkflowConfiguration.COMPANY)
				|| StringUtils.equals(type2, WorkflowConfiguration.ORG)) {
			return 1;
		} else {
			return -1;
		}
	}

	/**
	 * 查找子组织，递归查找
	 * 
	 * @Description：
	 * @author：chenyun
	 * @date：2012-7-2 下午04:28:05
	 * @param pids
	 * @return
	 * @throws DBAccessException
	 */
	private Set<String> findSubOrg(Set<String> pids) throws DBAccessException {

		Set<String> orgIds = new HashSet<String>();

		List<Org> orgs = orgService.queryList(null, pids);
		for (Org org : orgs) {
			orgIds.add(org.getOrgCode());
		}

		if (orgIds.size() > 0) {
			Set<String> allIds = findSubOrg(orgIds);
			allIds.containsAll(orgIds);
			return allIds;
		}

		return orgIds;
	}

}
