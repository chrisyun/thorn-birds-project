package org.thorn.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.security.entity.UserSecurity;
import org.thorn.user.entity.User;
import org.thorn.user.service.IUserService;
import org.thorn.web.BaseController;
import org.thorn.web.Status;

/**
 * @ClassName: UserController
 * @Description:
 * @author chenyun
 * @date 2012-5-15 下午05:16:07
 */
@Controller
public class UserController extends BaseController {

	static Logger log = LoggerFactory.getLogger(UserController.class);

	@Autowired
	@Qualifier("userService")
	private IUserService service;

	@RequestMapping("/user/saveOrModifyUser")
	@ResponseBody
	public Status saveOrModifyUser(User user, String opType) {
		Status status = new Status();

		try {

			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				service.save(user);
				status.setMessage("新增用户成功！");
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				service.modify(user);
				status.setMessage("修改用户成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyUser[User] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/user/deleteUser")
	@ResponseBody
	public Status deleteUser(String ids) {
		Status status = new Status();

		try {
			service.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteUser[User] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/user/disabledUser")
	@ResponseBody
	public Status disabledUser(String ids, String isDisabled) {
		Status status = new Status();

		try {
			service.disabledUser(ids, isDisabled);

			if (LocalStringUtils.equals(isDisabled, Configuration.DB_YES)) {
				status.setMessage("用户禁用成功！");
			} else {
				status.setMessage("用户启用成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据处理失败：" + e.getMessage());
			log.error("deleteUser[User] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/user/changeMyPwd")
	@ResponseBody
	public Status changeMyPwd(String newPwd) {
		Status status = new Status();

		try {
			Authentication auth = SecurityContextHolder.getContext()
					.getAuthentication();
			UserSecurity us = (UserSecurity) auth.getPrincipal();
			User user = us.getUser();

			service.changePwd(user.getUserId(), newPwd);
			status.setMessage("密码修改成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("密码修改失败：" + e.getMessage());
			log.error("changeMyPwd[User] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/user/changePwd")
	@ResponseBody
	public Status changePwd(String newPwd, String userId) {
		Status status = new Status();

		try {
			service.changePwd(userId, newPwd);
			status.setMessage("密码修改成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("密码修改失败：" + e.getMessage());
			log.error("changePwd[User] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/user/getUserPage")
	@ResponseBody
	public Page<User> getUserPage(long start, long limit, String sort,
			String dir, String orgCode, String userName, String cumail,
			String userAccount) {
		Page<User> page = new Page<User>();

		try {
			page = service.queryPage(orgCode, userName, cumail, userAccount,
					start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getUserPage[User] - " + e.getMessage(), e);
		}

		return page;
	}

	@RequestMapping("/user/getUserPageByRole")
	@ResponseBody
	public Page<User> getUserPageByRole(long start, long limit, String sort,
			String dir, String orgCode, String userName, String roleCode,
			String userAccount) {
		Page<User> page = new Page<User>();

		try {
			page = service.queryPageByRole(userName, orgCode, roleCode,
					userAccount, start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getUserPageByRole[User] - " + e.getMessage(), e);
		}

		return page;
	}

	@RequestMapping("/user/getUserPageNotInRole")
	@ResponseBody
	public Page<User> getUserPageNotInRole(long start, long limit, String sort,
			String dir, String orgCode, String roleCode) {
		Page<User> page = new Page<User>();

		try {
			page = service.queryPageNotInRole(orgCode, roleCode, start, limit,
					sort, dir);
		} catch (DBAccessException e) {
			log.error("getUserPageNotInRole[User] - " + e.getMessage(), e);
		}

		return page;
	}

	@RequestMapping("/user/saveUserRole")
	@ResponseBody
	public Status saveUserRole(String roleCode, String userIds) {
		Status status = new Status();

		try {
			service.saveUserRole(roleCode, userIds);
			status.setMessage("角色增加用户成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("角色增加用户失败：" + e.getMessage());
			log.error("saveUserRole[String] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/user/saveRoleByUser")
	@ResponseBody
	public Status saveRoleByUser(String roleCodes, String userId) {
		Status status = new Status();

		try {
			service.saveRoleByUser(userId, roleCodes);
			status.setMessage("用户绑定角色成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("用户绑定角色失败：" + e.getMessage());
			log.error("saveRoleByUser[String] - " + e.getMessage(), e);
		}

		return status;
	}
	

	@RequestMapping("/user/deleteUserRole")
	@ResponseBody
	public Status deleteUserRole(String roleCode, String userIds) {
		Status status = new Status();

		try {
			service.deleteUserRole(roleCode, userIds);
			status.setMessage("角色删除用户成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("角色删除用户失败：" + e.getMessage());
			log.error("deleteUserRole[String] - " + e.getMessage(), e);
		}

		return status;
	}

}
