package org.thorn.workflow.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import org.jbpm.api.ExecutionService;
import org.jbpm.api.TaskQuery;
import org.jbpm.api.TaskService;
import org.jbpm.api.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Page;
import org.thorn.workflow.entity.TaskInfo;

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
	
	@RequestMapping("/getTodoPage")
	@ResponseBody
	public Page<TaskInfo> getTodoPage(long start, long limit, String flowKey) {
		
		Page<TaskInfo> page = new Page<TaskInfo>();
		
		User user = SecurityUserUtils.getCurrentUser();
		
		TaskQuery query = taskService.createTaskQuery();
		query = query.assignee(user.getUserId());
		
		if(LocalStringUtils.isNotBlank(flowKey)) {
			query = query.processDefinitionId(flowKey);
		}
		
		long count = query.count();
		page.setTotal(count);
		
		query = query.orderDesc(TaskQuery.PROPERTY_PRIORITY);
		query = query.page((int) start, (int) limit);
		List<Task> tasks = query.list();
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		for(Task task : tasks) {
			TaskInfo tsInfo = new TaskInfo();
			
			tsInfo.setActivityName(task.getActivityName());
			tsInfo.setPriority(task.getPriority());
			tsInfo.setReceiptTime(df.format(task.getCreateTime()));
			tsInfo.setTaskId(task.getId());
			
			tsInfo.setTitle((String) execution.getVariable(task.getExecutionId(), "title"));
			
			
			page.getReslutSet().add(tsInfo);
		}
		
		
		return page;
	}
	
}

