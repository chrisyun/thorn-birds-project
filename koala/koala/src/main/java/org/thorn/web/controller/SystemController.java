package org.thorn.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @ClassName: SystemController
 * @Description:系统级的controller
 * @author chenyun
 * @date 2012-5-5 下午11:00:33
 */
@Controller
public class SystemController {
	
	@RequestMapping("/html/**")
	public String toStaticJsp(HttpServletRequest request) {
		String url = request.getServletPath();
		url = url.replaceAll(".jhtml", "");

		return url;
	}
	
	@RequestMapping("/index*")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/home*")
	public String home() {
		return "home";
	}

}
