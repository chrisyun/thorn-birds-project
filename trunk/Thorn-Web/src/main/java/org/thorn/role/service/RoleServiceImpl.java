package org.thorn.role.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.dao.IRoleDao;
import org.thorn.role.entity.Role;

/** 
 * @ClassName: RoleServiceImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-5-5 下午06:11:17 
 */
public class RoleServiceImpl implements IRoleService {
	
	@Autowired
	@Qualifier("roleDao")
	private IRoleDao roleDao;
	
	public List<Role> queryRolesByResource(List<String> source)
			throws DBAccessException {
		return roleDao.queryRolesByResource(source);
	}

	public List<Role> queryRolesByUser(String userId) throws DBAccessException {
		return roleDao.queryRolesByUser(userId);
	}

	public void save(Role role) throws DBAccessException {
		roleDao.save(role);
	}

	public void modify(Role role) throws DBAccessException {
		roleDao.modify(role);
	}

	public void delete(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		roleDao.delete(list);
	}

	public Page<Role> queryPage(String roleCode, String roleName, long start,
			long limit, String sort, String dir) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("roleCode", roleCode);
		filter.put("roleName", roleName);
		
		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);
		filter.put(Configuration.SROT_NAME, sort);
		filter.put(Configuration.ORDER_NAME, dir);
		
		return roleDao.queryPage(filter);
	}

	public void saveAuth(String roleCode, String sourceIds)
			throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(sourceIds);
		
		roleDao.deleteRoleSource(roleCode);
		
		if(list != null && list.size() > 0) {
			Map<String, String> rs = new HashMap<String, String>();
			for(String sourceCode : list) {
				rs.put("roleCode", roleCode);
				rs.put("sourceCode", sourceCode);
				
				roleDao.saveRoleSource(rs);
			}
		}
	}

	public List<Role> queryAllRoles() throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("isDisabled", Configuration.DB_NO);
		
		return roleDao.query(filter);
	}

}

