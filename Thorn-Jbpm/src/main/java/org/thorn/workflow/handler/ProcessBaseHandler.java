package org.thorn.workflow.handler;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.jbpm.api.TaskService;
import org.jbpm.pvm.internal.model.ActivityImpl;
import org.jbpm.pvm.internal.model.ExecutionImpl;
import org.jbpm.pvm.internal.model.TransitionImpl;
import org.jbpm.pvm.internal.task.TaskImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

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

	public String execute(Map<String, Object> parameters,
			HttpServletRequest request) {

		return "";
	}

	public Set<String> getNextActivityLines(String taskId) {
		TaskImpl task = (TaskImpl) taskService.getTask(taskId);
		ExecutionImpl execu = task.getProcessInstance();

		// 获取当前任务的活动节点
		ActivityImpl curActivity = execu.getActivity();

		List<TransitionImpl> outgoings = (List<TransitionImpl>) curActivity
				.getOutgoingTransitions();
		
		Set<String> outgoingNames = new HashSet<String>();
		
		for(TransitionImpl transition : outgoings) {
			outgoingNames.add(transition.getName());
		}
		
		return outgoingNames;
	}

}
