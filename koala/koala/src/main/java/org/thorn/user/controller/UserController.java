package org.thorn.user.controller;

import java.util.ArrayList;
import java.util.HashSet;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.auth.entity.AuthUser;
import org.thorn.auth.service.IAuthService;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Page;
import org.thorn.web.entity.Relation;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.entity.Role;
import org.thorn.role.service.IRoleService;
import org.thorn.security.SecurityConfiguration;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.user.service.IUserService;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;

/**
 * @ClassName: UserController
 * @Description:
 * @author chenyun
 * @date 2012-5-15 下午05:16:07
 */
@Controller
@RequestMapping("/System/user")
public class UserController extends BaseController {

	static Logger log = LoggerFactory.getLogger(UserController.class);

	@Autowired
	@Qualifier("userService")
	private IUserService service;

	@Autowired
	@Qualifier("authService")
	private IAuthService authService;
	
	@Autowired
	@Qualifier("roleService")
	private IRoleService roleService;

	@RequestMapping("/queryUserPage.jhtml")
	public String userPage(Long pageIndex, Long pageSize, String sort,
			String dir, String orgCode, String userName, String cumail,
			String userAccount, ModelMap model) {
		Page<User> page = new Page<User>(pageIndex, pageSize);
		String area = null;
		
		try {
			User user = SecurityUserUtils.getCurrentUser();
			
			if(! SecurityUserUtils.isSysAdmin()) {
				area = user.getArea();
			}
			
			page.setPageData(service.queryPage(orgCode, userName, cumail, area, userAccount,
					page.getStart(), page.getPageSize(), sort, dir));
			
			model.put("page", page);
		} catch (DBAccessException e) {
			log.error("userPage[User] - " + e.getMessage(), e);
		}

		return "system/user";
	}
	
	@RequestMapping(value = "/deleteUser.jmt", method = RequestMethod.POST)
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
	
	@RequestMapping(value = "/disabledUser.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status disabledUser(String ids, String isDisabled) {
		Status status = new Status();

		try {
			service.disabledUser(ids, isDisabled);

			if (StringUtils.equals(isDisabled, Configuration.DB_YES)) {
				status.setMessage("用户禁用成功！");
			} else {
				status.setMessage("用户启用成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据处理失败：" + e.getMessage());
			log.error("disabledUser[User] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping(value = "/queryUser.jmt", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponse<User> queryUser(String userId) {
		JsonResponse<User> json = new JsonResponse<User>();
		
		try {
			json.setObj(service.queryUser(userId, null));
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("数据获取失败：" + e.getMessage());
			log.error("queryUser[User] - " + e.getMessage(), e);
		}
		
		return json;
	}
	
	@RequestMapping(value = "/saveOrModifyUser.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyUser(User user, String opType) {
		Status status = new Status();

		try {

			if (StringUtils.equals(opType, Configuration.OP_SAVE)) {
				service.save(user);
				status.setMessage("新增用户成功！");
			} else if (StringUtils.equals(opType, Configuration.OP_MODIFY)) {
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

	@RequestMapping(value = "/restPwd.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status restPwd(String newPwd, String userId) {
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
	
	/**
	 * 
	 * @Description：获取用户与所有角色的关系
	 * @author：chenyun
	 * @date：2012-5-25 上午11:54:53
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "/queryUserRole.jmt", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponse<List<Relation>> queryUserRole(String userId) {
		JsonResponse<List<Relation>> json = new JsonResponse<List<Relation>>();

		List<Relation> list = new ArrayList<Relation>();

		try {
			// 只有rolecode
			List<Role> userRole = authService.queryRoleByUser(userId);

			List<Role> role = roleService.queryAllRoles();
			for (Role r : role) {
				//不显示默认角色
				if (StringUtils.equals(r.getRoleCode(),
						SecurityConfiguration.COMMON_USER_ROLE)
						|| StringUtils.equals(r.getRoleCode(),
								SecurityConfiguration.SYS_ADMIN_ROLE)) {
					continue;
				}

				Relation relation = new Relation();
				relation.setSubject(userId);
				relation.setObject(r);
				relation.setRelevance(false);
				list.add(relation);
			}

			for (Role ur : userRole) {

				for (Relation r : list) {

					if (StringUtils.equals(ur.getRoleCode(),
							((Role) r.getObject()).getRoleCode())) {
						r.setRelevance(true);
						break;
					}
				}
			}

			json.setObj(list);
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("数据加载失败：" + e.getMessage());
			log.error("queryUserRole[Relation] - " + e.getMessage(), e);
		}

		return json;
	}
	
	@RequestMapping(value = "/saveRoleByUser.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveRoleByUser(String roleCodes, String userId) {
		Status status = new Status();

		try {
			authService.saveRoleByUser(userId, roleCodes);
			status.setMessage("设置用户角色成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("设置用户角色失败：" + e.getMessage());
			log.error("saveRoleByUser[String] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/queryUserPageByRole.jhtml")
	public String queryUserPageByRole(Long pageIndex, Long pageSize, String sort,
			String dir, String orgCode, String userName, String roleCode,
			String userAccount, ModelMap model) {
		Page<AuthUser> page = new Page<AuthUser>(pageIndex, pageSize);

		try {
			model.put("roles", roleService.queryAllRoles());
			
			if(StringUtils.isNotBlank(roleCode)) {
				page.setPageData(authService.queryPageByRole(userName, orgCode, roleCode,
						userAccount, page.getStart(), page.getPageSize(), sort, dir));
			}
			
			model.put("page", page);
		} catch (DBAccessException e) {
			log.error("queryUserPageByRole[AuthUser] - " + e.getMessage(), e);
		}

		return "system/auth";
	}
	
	@RequestMapping(value = "/saveUserRoleSetting.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveUserRoleSetting(String roleCode, String[] oldUserIds, String[] newUserIds) {
		Status status = new Status();

		try {
			List<String> add = new ArrayList<String>();
			List<String> del = new ArrayList<String>();
			
			for (int i = 0; i < oldUserIds.length; i++) {
				for (int j = 0; j < newUserIds.length; j++) {
					if(StringUtils.equals(oldUserIds[i], newUserIds[j])) {
						oldUserIds[i] = null;
						newUserIds[j] = null;
					}
				}
			}
			
			for(String uid : oldUserIds) {
				if(uid != null) {
					del.add(uid);
				}
			}
			
			for(String uid : newUserIds) {
				if(uid != null) {
					add.add(uid);
				}
			}
			
			authService.saveUserRole(roleCode, add, del);
			status.setMessage("用户权限保存成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("用户权限保存失败：" + e.getMessage());
			log.error("saveUserRoleSetting[String] - " + e.getMessage(), e);
		}

		return status;
	}
	
	public List<User> getUserList(String area) {
		List<User> list = new ArrayList<User>();
		
		Set<String> areas = new HashSet<String>();
		areas.add(area);
		
		try {
			list = service.queryList(null, null, null, areas, null, null, null);
		} catch (DBAccessException e) {
			log.error("getUserList[User] - " + e.getMessage(), e);
		}
		
		return list;
	}
	
	public List<User> getUsersInSameOrg() {
		List<User> list = new ArrayList<User>();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			list = service.queryList(user.getOrgCode(), null, null, null, null,
					null, null);
		} catch (DBAccessException e) {
			log.error("getUsersInSameOrg[User] - " + e.getMessage(), e);
		}

		return list;
	}
}
