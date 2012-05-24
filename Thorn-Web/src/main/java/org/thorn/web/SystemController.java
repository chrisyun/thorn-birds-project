package org.thorn.web;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.ThemeResolver;
import org.springframework.web.servlet.theme.CookieThemeResolver;
import org.thorn.core.context.SpringContext;

/**
 * @ClassName: TagController
 * @Description:
 * @author chenyun
 * @date 2012-5-5 下午11:00:33
 */
@Controller
public class SystemController {

	@RequestMapping("/springTag/ext")
	public String ext() {
		return "/reference/ext";
	}
	
	@RequestMapping("/springTag/header")
	public String header() {
		return "/reference/header";
	}

	@RequestMapping("/theme/change")
	@ResponseBody
	public Status changeTheme(String theme,HttpServletResponse response) {
		Status status = new Status();
		
		Cookie cookie = new Cookie(CookieThemeResolver.DEFAULT_COOKIE_NAME,theme);
		cookie.setPath("/");
		cookie.setMaxAge(600000);
		response.addCookie(cookie);
		
		status.setMessage("更换皮肤成功!");

		return status;
	}

}
