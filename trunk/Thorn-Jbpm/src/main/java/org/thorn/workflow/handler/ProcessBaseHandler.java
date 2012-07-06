package org.thorn.workflow.handler;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.jbpm.api.TaskService;
import org.jbpm.pvm.internal.model.ActivityImpl;
import org.jbpm.pvm.internal.model.ExecutionImpl;
import org.jbpm.pvm.internal.model.TransitionImpl;
import org.jbpm.pvm.internal.task.TaskImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
public abstract class ProcessBaseHandler {

	@Autowired
	@Qualifier("taskService")
	protected TaskService taskService;
	
	@Autowired
	@Qualifier("participatorService")
	protected IParticipatorService ppService;
	

	public void execute(Map<String, Object> parameters,
			HttpServletRequest request) {
		Map<String, Object> variable = new HashMap<String, Object>();
		
		String taskId = (String) parameters.get("taskId");
		String nextStep = (String) parameters.get("nextStep");
		String flowKey = (String) parameters.get("flowKey");
		String activityName = (String) parameters.get("activityName");
		
		String title = (String) parameters.get("title");
		variable.put("title", title);
		
		TaskImpl task = (TaskImpl) taskService.getTask(taskId);
		ExecutionImpl execu = task.getProcessInstance();

		// 获取当前任务的活动节点
		ActivityImpl curActivity = execu.getActivity();

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
		
		// 计算下一环节处理人
		Participator pp = ppService.queryParticipator(activityName, flowKey);
		
		putNextActivityPp(pp, variable);
		
		if (StringUtils.isNotBlank(nextStep)) {
			taskService.completeTask(taskId, variable);
		} else {
			taskService.completeTask(taskId, nextStep, variable);
		}
	}

	public Set<String> getNextActivityLines(String taskId) {
		TaskImpl task = (TaskImpl) taskService.getTask(taskId);
		ExecutionImpl execu = task.getProcessInstance();

		// 获取当前任务的活动节点
		ActivityImpl curActivity = execu.getActivity();

		List<TransitionImpl> outgoings = (List<TransitionImpl>) curActivity
				.getOutgoingTransitions();

		Set<String> outgoingNames = new HashSet<String>();

		for (TransitionImpl transition : outgoings) {
			outgoingNames.add(transition.getName());
		}

		return outgoingNames;
	}
	
	public void putNextActivityPp(Participator pp, Map<String, Object> variable) {
		
		if(pp == null) {
			return ;
		}
		
		if(StringUtils.equals(pp.getVariableType(), WorkflowConfiguration.PP_GROUP)) {
			String groupType = pp.getEntityType();
			String groupId = pp.getEntity();
			String limit = pp.getLimitType();
			String limitCode = "";
			
			if(StringUtils.isBlank(limit)) {
				limit = WorkflowConfiguration.LIMIT_NONE;
			} else {
				
			}
			
			
		} else {
			
		}
		
	}

}
