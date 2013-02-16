package org.thorn.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

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
import org.thorn.core.jmail.MailEntity;
import org.thorn.core.util.ExecutorUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.security.SecurityConfiguration;
import org.thorn.user.entity.FindBackEntry;
import org.thorn.user.entity.User;
import org.thorn.user.service.IUserService;
import org.thorn.user.task.MailTask;
import org.thorn.user.task.MailTemplete;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Status;

import freemarker.template.TemplateException;

/**
 * @ClassName: NewUserController
 * @Description:
 * @author chenyun
 * @date 2013-2-16 下午2:48:10
 */
@Controller
@RequestMapping("/html")
public class NewUserController extends BaseController {

	static Logger log = LoggerFactory.getLogger(NewUserController.class);

	@Autowired
	@Qualifier("userService")
	private IUserService service;

	@RequestMapping("/register.jhtml")
	public String register() {

		return "register";
	}

	@RequestMapping(value = "/registerUser.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status registerUser(User user) {
		Status status = new Status();
		
		user.setUserId(null);
		
		try {
			User dbUser = service.queryUser(null, user.getCumail());
			
			if(dbUser != null && StringUtils.isNotEmpty(dbUser.getUserId())) {
				status.setSuccess(false);
				status.setMessage("该邮箱已经注册，请更换其他邮箱！");
			} else {
				//设置用户角色
				user.setDefaultRole(SecurityConfiguration.COMMON_USER_ROLE);
				user.setIsDisabled(Configuration.DB_NO);
				user.setIsShow(Configuration.DB_YES);
				service.save(user);
				
				if (StringUtils.isNotEmpty(user.getCumail())) {
					Map<String, Object> data = new HashMap<String, Object>();

					data.put("userName", user.getUserName());
					data.put("userId", user.getUserId());

					MailEntity mailInfo = MailTemplete.getMailEntity(
							"register.htm", data, "新用户注册成功", user.getUserName(),
							user.getCumail());
					MailTask task = new MailTask(mailInfo);
					ExecutorUtils.executeTask(task);
				}
				
				status.setMessage("恭喜您注册成功！我们已将您的登录账号发送至您的注册邮箱，请注意查收！");
			}
			
		} catch (IOException e) {
			status.setSuccess(false);
			status.setMessage("注册邮件发送失败：" + e.getMessage());
			log.error("registerUser[Mail] - " + e.getMessage(), e);
		} catch (TemplateException e) {
			status.setSuccess(false);
			status.setMessage("注册邮件发送失败：" + e.getMessage());
			log.error("registerUser[Mail] - " + e.getMessage(), e);
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("registerUser[User] - " + e.getMessage(), e);
		}
		
		return status;
	}

	@RequestMapping("/findBack.jhtml")
	public String findBack() {

		return "findBack1";
	}
	
	public Status verifyEmail(String email) {
		Status status = new Status();
		
		
		return status;
	}
	
	public String findBackMyPwd(String captcha, ModelMap model) {
		
		Status status = verifyCaptcha(captcha);
		model.put("status", status);
		
		return "findBack2";
	}
	
	public Status modifyMyPwd(String pwd, String captcha) {
		JsonResponse<FindBackEntry> json = verifyCaptcha(captcha);
		
		if(json.isSuccess()) {
			try {
				service.changePwd(json.getObj().getUserId(), pwd);
			} catch (DBAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return json;
	}
	
	private JsonResponse<FindBackEntry> verifyCaptcha(String captcha) {
		JsonResponse<FindBackEntry> json = new JsonResponse<FindBackEntry>();
		
		
		return json;
	}
	

}
