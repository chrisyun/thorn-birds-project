package org.thorn.web.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.theme.CookieThemeResolver;
import org.thorn.web.entity.Status;

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
	

	/**
	 * 
	 * @Description：处理自定义换肤的请求
	 * @author：chenyun
	 * @date：2012-5-25 上午10:22:29
	 * @param theme
	 *            皮肤类型
	 * @param response
	 * @return
	 */
	@RequestMapping("/theme/change")
	@ResponseBody
	public Status changeTheme(String theme, HttpServletResponse response) {
		Status status = new Status();

		Cookie cookie = new Cookie(CookieThemeResolver.DEFAULT_COOKIE_NAME,
				theme);
		cookie.setPath("/");
		cookie.setMaxAge(600000);
		response.addCookie(cookie);

		status.setMessage("更换皮肤成功!");

		return status;
	}

}
