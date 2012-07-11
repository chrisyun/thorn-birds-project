package org.thorn.workflow.controller;

import java.util.List;

import org.jbpm.api.ExecutionService;
import org.jbpm.api.TaskQuery;
import org.jbpm.api.TaskService;
import org.jbpm.api.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;

/** 
 * @ClassName: ProcessListController 
 * @Description: 
 * @author chenyun
 * @date 2012-7-11 上午10:49:24 
 */
@Controller
@RequestMapping("/wf/cm")
public class ProcessListController extends BaseController {
	
	@Autowired
	@Qualifier("taskService")
	private TaskService taskService;
	
	@Autowired
	@Qualifier("executionService")
	private ExecutionService execution;
	
	public void getTodoPage(long start, long limit) {
		
		User user = SecurityUserUtils.getCurrentUser();
		
		TaskQuery query = taskService.createTaskQuery();
		
		query = query.assignee(user.getUserId());
		query = query.orderDesc(TaskQuery.PROPERTY_PRIORITY);
		
		long count = query.count();
		
		query = query.page((int) start, (int) limit);
		List<Task> tasks = query.list();
		
	}
	
}

