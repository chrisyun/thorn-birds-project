package org.thorn.role.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.entity.Role;
import org.thorn.role.service.IRoleService;
import org.thorn.web.BaseController;
import org.thorn.web.JsonResponse;
import org.thorn.web.Relation;
import org.thorn.web.Status;

/**
 * @ClassName: RoleController
 * @Description:
 * @author chenyun
 * @date 2012-5-17 下午09:22:41
 */
@Controller
public class RoleController extends BaseController {

	static Logger log = LoggerFactory.getLogger(RoleController.class);

	@Autowired
	@Qualifier("roleService")
	private IRoleService service;

	@RequestMapping("/role/deleteRole")
	@ResponseBody
	public Status deleteRole(String ids) {
		Status status = new Status();

		try {
			service.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteResource[Role] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/role/getRolePage")
	@ResponseBody
	public Page<Role> getRolePage(long start, long limit, String sort,
			String dir, String roleCode, String roleName) {
		Page<Role> page = new Page<Role>();

		try {
			page = service.queryPage(roleCode, roleName, start, limit, sort,
					dir);
		} catch (DBAccessException e) {
			log.error("getRolePage[Role] - " + e.getMessage(), e);
		}

		return page;
	}

	@RequestMapping("/role/getAllRole")
	@ResponseBody
	public List<Role> getAllRole() {
		List<Role> list = new ArrayList<Role>();

		try {
			list = service.queryAllRoles();
		} catch (DBAccessException e) {
			log.error("getRolePage[Role] - " + e.getMessage(), e);
		}

		return list;
	}

	@RequestMapping("/role/getUserRole")
	@ResponseBody
	public JsonResponse<List<Relation>> getUserRoles(String userId) {
		JsonResponse<List<Relation>> json = new JsonResponse<List<Relation>>();

		List<Relation> list = new ArrayList<Relation>();

		try {
			// 只有rolecode
			List<Role> userRole = service.queryRolesByUser(userId);

			List<Role> role = service.queryAllRoles();
			for (Role r : role) {
				Relation relation = new Relation();
				relation.setSubject(userId);
				relation.setObject(r);
				relation.setRelevance(false);
				list.add(relation);
			}

			for (Role ur : userRole) {

				for (Relation r : list) {

					if (LocalStringUtils.equals(ur.getRoleCode(),
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
			log.error("getUserRoles[Relation] - " + e.getMessage(), e);
		}

		return json;
	}

	@RequestMapping("/role/saveAuth")
	@ResponseBody
	public Status saveAuth(String roleCode, String ids) {
		Status status = new Status();

		try {
			service.saveAuth(roleCode, ids);
			status.setMessage("角色授权成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyOrg[Role] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/role/saveOrModifyRole")
	@ResponseBody
	public Status saveOrModifyRole(Role role, String opType) {
		Status status = new Status();

		try {

			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				service.save(role);
				status.setMessage("新增角色成功！");
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				service.modify(role);
				status.setMessage("修改角色成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyOrg[Role] - " + e.getMessage(), e);
		}

		return status;
	}
}
