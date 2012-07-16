package org.thorn.workflow.controller;

import org.springframework.stereotype.Controller;
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
	
	@RequestMapping("/openTodoProcess")
	public String openTodoProcess(String taskId) {
		
		
		return "/workflow/template/todoProcess";
	}
	
	
}

