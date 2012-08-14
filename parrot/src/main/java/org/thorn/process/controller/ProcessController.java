package org.thorn.process.controller;

import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.app.AppConfiguration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.process.ProcessConfiguration;
import org.thorn.process.entity.Process;
import org.thorn.process.service.IFlowService;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Page;

/**
 * @ClassName: ProcessOpenController
 * @Description:
 * @author chenyun
 * @date 2012-8-13 上午10:12:18
 */
@Controller
@RequestMapping("/wf/cm")
public class ProcessController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ProcessController.class);

	@Autowired
	@Qualifier("flowService")
	private IFlowService flowService;

	@RequestMapping("/startNewProcess")
	public String startNewProcess(String key, ModelMap model) {

		User user = SecurityUserUtils.getCurrentUser();

		model.put("flowKey", key);
		model.put("flowInstId", "");
		model.put("creater", user.getUserId());
		model.put("createrName", user.getUserName());
		model.put("openType", "create");
		model.put("activityName", ProcessConfiguration.ACTIVITY_CREATE);
		model.put("pid", "");

		Set<String> nextStep = ActivityUtils.getNextStep(user,
				ProcessConfiguration.ACTIVITY_CREATE);
		model.put("nextStep", nextStep);

		if (StringUtils.equals(key, ProcessConfiguration.PROJECT_KEY)) {
			model.put("pageUrl", ProcessConfiguration.PROJECT_JSP);
			model.put("title", ProcessConfiguration.PROJECT_TITLE);
		} else {
			model.put("pageUrl", ProcessConfiguration.RESEVER_JSP);
			model.put("title", ProcessConfiguration.RESEVER_TITLE);
		}

		return "/process/process";
	}
	
	@RequestMapping("/openDoneProcess")
	public String openDoneProcess(Integer pid, String flowType, ModelMap model) {
		
		Process process = null;
		
		try {
			process = flowService.queryProcess(pid, flowType, null);
			
			if(process == null 
					|| process.getPid() == null) {
				return "process/failure";
			}
			
			model.put("flowKey", process.getFlowType());
			model.put("flowInstId", process.getId());
			model.put("creater", process.getCreater());
			model.put("createrName", process.getCreaterName());
			model.put("openType", "done");
			model.put("activityName", process.getActivity());
			model.put("pid", process.getPid());

			model.put("nextStep", null);

			if (StringUtils.equals(process.getFlowType(), ProcessConfiguration.PROJECT_KEY)) {
				model.put("pageUrl", ProcessConfiguration.PROJECT_JSP);
				model.put("title", ProcessConfiguration.PROJECT_TITLE);
			} else {
				model.put("pageUrl", ProcessConfiguration.RESEVER_JSP);
				model.put("title", ProcessConfiguration.RESEVER_TITLE);
			}

			return "/process/process";
			
		} catch (DBAccessException e) {
			log.error("openDoneProcess[Process] - " + e.getMessage(), e);
			
			return "process/failure";
		}
	}
	
	@RequestMapping("/openTodoProcess")
	public String openTodoProcess(Integer id, ModelMap model) {
		
		Process process = null;
		
		try {
			process = flowService.queryProcess(null, null, id);
			
			if(process == null 
					|| process.getPid() == null) {
				return "process/failure";
			}
			
			User user = SecurityUserUtils.getCurrentUser();

			model.put("flowKey", process.getFlowType());
			model.put("flowInstId", process.getId());
			model.put("creater", process.getCreater());
			model.put("createrName", process.getCreaterName());
			model.put("openType", "todo");
			model.put("activityName", process.getActivity());
			model.put("pid", process.getPid());

			Set<String> nextStep = ActivityUtils.getNextStep(user,
					process.getActivity());
			model.put("nextStep", nextStep);

			if (StringUtils.equals(process.getFlowType(), ProcessConfiguration.PROJECT_KEY)) {
				model.put("pageUrl", ProcessConfiguration.PROJECT_JSP);
				model.put("title", ProcessConfiguration.PROJECT_TITLE);
			} else {
				model.put("pageUrl", ProcessConfiguration.RESEVER_JSP);
				model.put("title", ProcessConfiguration.RESEVER_TITLE);
			}

			return "/process/process";
			
		} catch (DBAccessException e) {
			log.error("openTodoProcess[Process] - " + e.getMessage(), e);
			
			return "process/failure";
		}
	}
	
	@RequestMapping("/getPendingPage")
	@ResponseBody
	public Page<Process> getPendingPage(long start, long limit, String sort,
			String dir, String flowType, String province,String flowStatus, String creater,
			String createrName, String startTime, String endTime) {
		Page<Process> page = new Page<Process>();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			List<String> roles = SecurityUserUtils.getRoleList();
			
			if(!roles.contains(AppConfiguration.ROLE_CENTRAL)) {
				province = user.getArea();
			}
			
			page = flowService.queryPendingProcess(flowType, province, user.getUserId(),
					roles, flowStatus, creater, createrName, startTime, endTime,
					start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getPendingPage[Process] - " + e.getMessage(), e);
		}
		
		return page;
	}

}
