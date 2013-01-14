package org.thorn.user.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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

	@RequestMapping(value = "/changeMyPassword.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status changeMyPwd(String curPassword, String newPassword) {
		Status status = new Status();

		try {
			User user = SecurityUserUtils.getCurrentUser();

			String thisPassword = SecurityEncoderUtils.encodeUserPassword(
					curPassword, user.getUserId());
			if (StringUtils.equals(thisPassword, user.getUserPwd())) {
				service.changePwd(user.getUserId(), newPassword);
				// 更新session中的用户密码
				user.setUserPwd(thisPassword);
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

}
