package org.thorn.process.controller;

import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.thorn.process.ProcessConfiguration;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;

/**
 * @ClassName: ProcessOpenController
 * @Description:
 * @author chenyun
 * @date 2012-8-13 上午10:12:18
 */
@Controller
@RequestMapping("/wf/cm")
public class ProcessOpenController {

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
			model.put("title", "AAAAAAAAAAAAA");
		} else {
			model.put("pageUrl", ProcessConfiguration.RESEVER_JSP);
			model.put("title", "BBBBBBBBBBBBB");
		}

		return "/process/process";
	}

}
