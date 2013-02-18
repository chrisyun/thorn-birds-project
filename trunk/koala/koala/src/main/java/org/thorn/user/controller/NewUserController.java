package org.thorn.user.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.core.jmail.MailEntity;
import org.thorn.core.util.DateTimeUtils;
import org.thorn.core.util.EncryptUtils;
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

			if (dbUser != null && StringUtils.isNotEmpty(dbUser.getUserId())) {
				status.setSuccess(false);
				status.setMessage("该邮箱已经注册，请更换其他邮箱！");
			} else {
				// 设置用户角色
				user.setDefaultRole(SecurityConfiguration.COMMON_USER_ROLE);
				user.setIsDisabled(Configuration.DB_NO);
				user.setIsShow(Configuration.DB_YES);
				service.save(user);

				if (StringUtils.isNotEmpty(user.getCumail())) {
					Map<String, Object> data = new HashMap<String, Object>();

					data.put("userName", user.getUserName());
					data.put("userId", user.getUserId());
					data.put("date", DateTimeUtils.getCurrentDate());

					MailEntity mailInfo = MailTemplete.getMailEntity(
							"register.htm", data, "新用户注册成功",
							user.getUserName(), user.getCumail());
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

	@RequestMapping(value = "/verifyIdentity.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status verifyIdentity(String userId, String email,
			HttpServletRequest request) {
		Status status = new Status();

		try {
			User user = service.queryUser(userId, email);

			if (user != null && StringUtils.isNotEmpty(user.getUserId())) {
				FindBackEntry fb = service.generateFindBackEntry(user
						.getUserId());

				Map<String, Object> data = new HashMap<String, Object>();

				String md5 = EncryptUtils.getMD5(fb.getUserId() + "-"
						+ fb.getCaptcha());

				StringBuilder url = new StringBuilder(request.getScheme());
				url.append("://").append(request.getServerName());
				url.append(":").append(request.getServerPort());
				url.append(request.getContextPath()).append(
						"/html/findBackMyPwd/");
				url.append(fb.getUserId()).append("/").append(fb.getCaptcha());
				url.append("/").append(md5).append(".jhtml");

				data.put("userName", user.getUserName());
				data.put("findBackUrl", url.toString());
				data.put("date", DateTimeUtils.getCurrentDate());

				MailEntity mailInfo = MailTemplete.getMailEntity(
						"findBack.htm", data, "找回密码", user.getUserName(),
						user.getCumail());
				MailTask task = new MailTask(mailInfo);
				ExecutorUtils.executeTask(task);
				
				status.setMessage("用户身份验证成功！我们已将密码修改链接发送至您的注册邮箱，请注意及时查收。");
			} else {
				status.setSuccess(false);
				status.setMessage("无法找到对应的用户，请检查您输入的用户名和邮件地址是否正确！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("用户身份验证失败：" + e.getMessage());
			log.error("verifyIdentity[User] - " + e.getMessage(), e);
		} catch (IOException e) {
			status.setSuccess(false);
			status.setMessage("找回密码邮件发送失败：" + e.getMessage());
			log.error("verifyIdentity[FindBackEntry] - " + e.getMessage(), e);
		} catch (TemplateException e) {
			status.setSuccess(false);
			status.setMessage("找回密码邮件发送失败：" + e.getMessage());
			log.error("verifyIdentity[FindBackEntry] - " + e.getMessage(), e);
		} catch (NoSuchAlgorithmException e) {
			status.setSuccess(false);
			status.setMessage("找回密码邮件发送失败：" + e.getMessage());
			log.error("verifyIdentity[MD5] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/findBackMyPwd/{userId}/{captcha}/{md5Str}.jhtml")
	public String findBackMyPwd(@PathVariable("userId") String userId,
			@PathVariable("captcha") String captcha,
			@PathVariable("md5Str") String md5Str, ModelMap model) {
		Status status = new Status();

		try {
			String md5 = EncryptUtils.getMD5(userId + "-" + captcha);
			if(StringUtils.equals(md5Str, md5)) {
				status = verifyCaptcha(userId, captcha);
			} else {
				status.setSuccess(false);
				status.setMessage("该链接参数已经失效！");
			}
		} catch (NoSuchAlgorithmException e) {
			status.setSuccess(false);
			status.setMessage("该链接参数已经失效！");
		}
		
		model.put("finder", userId);
		model.put("captcha", captcha);
		model.put("status", status);

		return "findBack2";
	}
	
	@RequestMapping(value = "/modifyMyPwd.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status modifyMyPwd(String pwd, String captcha, String userId) {
		JsonResponse<FindBackEntry> json = verifyCaptcha(userId, captcha);

		if (json.isSuccess()) {
			try {
				service.changeMyPwd(json.getObj().getUserId(), captcha, pwd);
				
				json.setMessage("密码修改成功！");
			} catch (DBAccessException e) {
				json.setSuccess(false);
				json.setMessage("修改密码失败：" + e.getMessage());
				log.error("modifyMyPwd[String] - " + e.getMessage(), e);
			}
		}

		return json;
	}

	private JsonResponse<FindBackEntry> verifyCaptcha(String userId, String captcha) {
		JsonResponse<FindBackEntry> json = new JsonResponse<FindBackEntry>();
		
		try {
			FindBackEntry fb = service.queryFindBackEntry(userId, captcha);
			
			if(fb == null || fb.getId() == null) {
				json.setSuccess(false);
				json.setMessage("该链接地址不存在！");
			} else if(StringUtils.equals(fb.getUsed(), Configuration.DB_YES)) {
				json.setSuccess(false);
				json.setMessage("该链接已经被使用！");
			} 
			
			Date date = DateTimeUtils.formatTime(fb.getStartTime());
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.MINUTE, 90);
			
			Calendar now = Calendar.getInstance();
			now.setTime(new Date());
			
			if(cal.before(now)) {
				json.setSuccess(false);
				json.setMessage("该链接已经过期！");
			}
			
			json.setObj(fb);
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("授权码查询失败：" + e.getMessage());
			log.error("verifyCaptcha[FindBackEntry] - " + e.getMessage(), e);
		} catch (ParseException e) {
			json.setSuccess(false);
			json.setMessage("该链接已经过期！");
		}
		
		return json;
	}

}
