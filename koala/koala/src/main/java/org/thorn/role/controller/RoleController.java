package org.thorn.role.controller;

import java.util.ArrayList;
import java.util.List;

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
import org.thorn.auth.service.IAuthService;
import org.thorn.dao.core.Configuration;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.entity.Role;
import org.thorn.role.service.IRoleService;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;

/**
 * @ClassName: RoleController
 * @Description:
 * @author chenyun
 * @date 2012-5-17 下午09:22:41
 */
@Controller
@RequestMapping("/System/role")
public class RoleController extends BaseController {

	static Logger log = LoggerFactory.getLogger(RoleController.class);

	@Autowired
	@Qualifier("roleService")
	private IRoleService service;

	@Autowired
	@Qualifier("authService")
	private IAuthService authService;

	/**
	 * 
	 * @Description：
	 * @author：chenyun
	 * @date：2012-5-25 上午11:54:21
	 * @param start
	 * @param limit
	 * @param sort
	 * @param dir
	 * @param roleCode
	 *            角色编码
	 * @param roleName
	 *            角色名称
	 * @return
	 */
	@RequestMapping("/queryRolePage.jhtml")
	public String rolePage(Long pageIndex, Long pageSize, String sort,
			String dir, String roleCode, String roleName, ModelMap model) {
		Page<Role> page = new Page<Role>(pageIndex, pageSize);

		try {
			page.setPageData(service.queryPage(roleCode, roleName,
					page.getStart(), page.getPageSize(), sort, dir));

			model.put("page", page);
		} catch (DBAccessException e) {
			log.error("rolePage[Role] - " + e.getMessage(), e);
		}

		return "system/role";
	}

	/**
	 * 
	 * @Description：
	 * @author：chenyun
	 * @date：2012-5-25 上午11:54:08
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/deleteRole.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status deleteRole(String ids) {
		Status status = new Status();

		try {
			service.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteRole[Role] - " + e.getMessage(), e);
		}

		return status;
	}

	/**
	 * 
	 * @Description：
	 * @author：chenyun
	 * @date：2012-5-25 上午11:56:21
	 * @param role
	 * @param opType
	 * @return
	 */
	@RequestMapping(value = "/saveOrModifyRole.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyRole(Role role, String opType) {
		Status status = new Status();

		try {

			if (StringUtils.equals(opType, Configuration.OP_SAVE)) {
				service.save(role);
				status.setMessage("新增角色成功！");
			} else if (StringUtils.equals(opType, Configuration.OP_MODIFY)) {
				service.modify(role);
				status.setMessage("修改角色成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyRole[Role] - " + e.getMessage(), e);
		}

		return status;
	}
	
	/**
	 * 
	 * @Description：获取角色授权的资源列表
	 * @author：chenyun
	 * @date：2012-5-25 上午11:07:59
	 * @param roleCode
	 * @return
	 */
	@RequestMapping(value = "/queryRoleAuth.jmt", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponse<List<String>> queryRoleAuth(String roleCode) {
		JsonResponse<List<String>> json = new JsonResponse<List<String>>();

		try {
			List<String> list = authService.queryResourceByRole(roleCode);
			json.setObj(list);

		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("获取数据失败：" + e.getMessage());
			log.error("queryRoleAuth[String] - " + e.getMessage(), e);
		}

		return json;
	}
	
	/**
	 * 
	 * @Description：授权资源给角色
	 * @author：chenyun
	 * @date：2012-5-25 上午11:55:19
	 * @param roleCode
	 *            角色编码
	 * @param ids
	 *            资源主键id
	 * @return
	 */
	@RequestMapping(value = "/authorizedRole.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status authorizedRole(String roleCode, String ids) {
		Status status = new Status();

		try {
			authService.saveRoleAuth(roleCode, null);
			status.setMessage("角色授权成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("authorizedRole[Role] - " + e.getMessage(), e);
		}

		return status;
	}
	
	
	/**
	 * 
	 * @Description：获取所有的角色
	 * @author：chenyun
	 * @date：2012-5-25 上午11:54:37
	 * @return
	 */
	public List<Role> getAllRole() {
		List<Role> list = new ArrayList<Role>();

		try {
			list = service.queryAllRoles();
		} catch (DBAccessException e) {
			log.error("getRolePage[Role] - " + e.getMessage(), e);
		}

		return list;
	}

}
