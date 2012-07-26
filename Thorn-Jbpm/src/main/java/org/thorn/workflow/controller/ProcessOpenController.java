package org.thorn.workflow.controller;

import java.util.HashMap;
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
import org.thorn.dao.exception.DBAccessException;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;
import org.thorn.workflow.WorkflowConfiguration;
import org.thorn.workflow.entity.FlowType;
import org.thorn.workflow.service.IFlowTypeService;

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
	
	@Autowired
	@Qualifier("flowTypeService")
	private IFlowTypeService flowTypeService;
	
	@RequestMapping("/startNewProcess")
	public String startNewProcess(String key, ModelMap model) {

		User user = SecurityUserUtils.getCurrentUser();

		Map<String, Object> map = new HashMap<String, Object>();
		String title = " -" + user.getUserName();
		
		try {
			FlowType type = flowTypeService.query(key, null, null);
			title = type.getFlowName() + title;
		} catch (DBAccessException e) {
			title = key + title;
		}
		map.put("title", title);
		map.put("flowKey", key);
		map.put(WorkflowConfiguration.PROCESS_CREATER, user.getUserId());
		ProcessInstance pi = execution.startProcessInstanceByKey(key, map);
		
		
		// 已经是start节点的第一个task
		Task task = taskService.createTaskQuery().processInstanceId(pi.getId())
				.uniqueResult();
		Set<String> nextStep = taskService.getOutcomes(task.getId());
		
		model.put("nextStep", nextStep);
		model.put("flowKey", key);
		model.put("flowName", pi.getName());
		model.put("flowInstId", pi.getId());
		model.put("creater", user.getUserId());
		model.put("activityName", task.getActivityName());
		model.put("pageUrl", task.getFormResourceName());
		model.put("taskId", task.getId());
		model.put("openType", "create");
		model.put("title", title);
		
		return "/workflow/template/process";
	}
	
	
	@RequestMapping("/openTodoProcess")
	public String openTodoProcess(String taskId, ModelMap model) {

		Task task = taskService.getTask(taskId);
		ProcessInstance inst = execution.findProcessInstanceById(task
				.getExecutionId());
		Set<String> nextStep = taskService.getOutcomes(taskId);
		
		Set<String> variable = new HashSet<String>();
		variable.add("appId");
		variable.add("title");
		variable.add("creater");
		variable.add("flowKey");
		variable.add("flowAtts");
		
		Map<String, Object> parameters = taskService.getVariables(taskId, variable);
		
		model.put("flowName", inst.getName());
		model.put("flowInstId", inst.getId());
		model.put("activityName", task.getActivityName());
		model.put("pageUrl", task.getFormResourceName());
		model.put("taskId", task.getId());
		
		model.put("flowKey", parameters.get("flowKey"));
		model.put("creater", parameters.get("creater"));
		model.put("appId", parameters.get("appId"));
		model.put("title", parameters.get("title"));
		model.put("flowAtts", parameters.get("flowAtts"));
		model.put("nextStep", nextStep);
		model.put("openType", "todo");
		
		return "/workflow/template/process";
	}

}
