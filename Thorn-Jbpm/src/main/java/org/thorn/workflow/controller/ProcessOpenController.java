package org.thorn.workflow.controller;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.jbpm.api.ExecutionService;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.TaskService;
import org.jbpm.api.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.thorn.web.controller.BaseController;

/**
 * @ClassName: ProcessOpenController
 * @Description:
 * @author chenyun
 * @date 2012-7-16 上午10:31:16
 */
@Controller
@RequestMapping("/wf/cm")
public class ProcessOpenController extends BaseController {

	@Autowired
	@Qualifier("taskService")
	private TaskService taskService;

	@Autowired
	@Qualifier("executionService")
	private ExecutionService execution;

	@RequestMapping("/openTodoProcess")
	public String openTodoProcess(String taskId, ModelMap model) {

		Task task = taskService.getTask(taskId);
		ProcessInstance inst = execution.findProcessInstanceById(task
				.getExecutionId());
		Set<String> nextStep = taskService.getOutcomes(taskId);
		
		Set<String> variable = new HashSet<String>();
		variable.add("pid");
		variable.add("title");
		variable.add("creater");
		
		Map<String, Object> parameters = taskService.getVariables(taskId, variable);
		
		model.put("flowKey", inst.getKey());
		model.put("flowName", inst.getName());
		model.put("flowInstId", inst.getId());
		model.put("activityName", task.getActivityName());
		model.put("pageUrl", task.getFormResourceName());
		model.put("taskId", task.getId());
		model.put("creater", parameters.get("creater"));
		model.put("pid", parameters.get("pid"));
		model.put("title", parameters.get("title"));
		model.put("nextStep", nextStep);
		model.put("openType", "todo");
		
		return "/workflow/template/todoProcess";
	}

}
