package org.thorn.user.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.theme.CookieThemeResolver;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.security.SecurityEncoderUtils;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.user.service.IUserService;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;

/**
 * @ClassName: MySettingController
 * @Description:
 * @author chenyun
 * @date 2013-1-5 下午9:43:47
 */
@Controller
@RequestMapping("/common/mySetting")
public class MySettingController extends BaseController {

	static Logger log = LoggerFactory.getLogger(UserController.class);

	@Autowired
	@Qualifier("userService")
	private IUserService service;

	@RequestMapping("/changeMyPassword.jhtml")
	public String changeMyPassword() {
		return "mySetting/changePassword";
	}
	
	@RequestMapping("/userInfo.jhtml")
	public String userInfo(ModelMap model) {
		
		try {
			User user = SecurityUserUtils.getCurrentUser();
			
			user = service.queryUser(user.getUserId(), null);
			
			model.put("user", user);
		} catch (DBAccessException e) {
			log.error("userInfo[User] - " + e.getMessage(), e);
		}
		
		return "mySetting/userInfo";
	}
	
	@RequestMapping("/theme.jhtml")
	public String theme() {
		
		return "mySetting/changeTheme";
	}
	
	
	@RequestMapping(value = "/changeMyInfo.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status changeMyInfo(User user) {
		Status status = new Status();
		
		try {
			User userSession = SecurityUserUtils.getCurrentUser();
			user.setUserId(userSession.getUserId());
			
			service.modify(user);
			status.setMessage("个人资料修改成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("个人资料修改失败：" + e.getMessage());
			log.error("changeMyInfo[User] - " + e.getMessage(), e);
		}
		
		return status;
	}
	
	@RequestMapping(value = "/changeMyPassword.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status changeMyPwd(String curPassword, String newPassword) {
		Status status = new Status();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			
			user = service.queryUser(user.getUserId(), null);
			
			String thisPassword = SecurityEncoderUtils.encodeUserPassword(
					curPassword, user.getUserId());
			if (StringUtils.equals(thisPassword, user.getUserPwd())) {
				service.changePwd(user.getUserId(), newPassword);
				status.setMessage("密码修改成功！");
			} else {
				status.setSuccess(false);
				status.setMessage("当前密码错误！");
			}
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("密码修改失败：" + e.getMessage());
			log.error("changeMyPwd[User] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping(value = "/changeMyTheme.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status changeMyTheme(String theme, HttpServletResponse response) {
		
		if(StringUtils.isBlank(theme)) {
			theme = "default";
		}
		
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
