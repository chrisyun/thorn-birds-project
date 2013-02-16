package org.thorn.auth.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.userdetails.UserCache;
import org.thorn.auth.dao.IAuthDao;
import org.thorn.auth.entity.AuthUser;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.entity.Role;

/**
 * @ClassName: AuthServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-5-25 上午11:35:58
 */
public class AuthServiceImpl implements IAuthService {

	@Autowired
	@Qualifier("authDao")
	private IAuthDao authDao;
	
	@Autowired
	@Qualifier("userSecurityCache")
	private UserCache userCache;
	
	public List<String> queryResourceByRole(String roleId)
			throws DBAccessException {
		return authDao.queryResourceByRole(roleId);
	}
	
	public void saveRoleAuth(String roleCode, String[] sourceIds)
			throws DBAccessException {
		authDao.deleteRoleSource(roleCode);

		if (sourceIds != null && sourceIds.length > 0) {
			Map<String, String> rs = new HashMap<String, String>();
			for (String sourceCode : sourceIds) {
				rs.put("roleCode", roleCode);
				rs.put("sourceCode", sourceCode);

				authDao.saveRoleSource(rs);
			}
		}
	}

	public List<Role> queryRoleBySource(List<String> source)
			throws DBAccessException {
		return authDao.queryRoleBySource(source);
	}

	public List<Role> queryRoleByUser(String userId) throws DBAccessException {
		return authDao.queryRoleByUser(userId);
	}
	
	public Page<AuthUser> queryPageByRole(String userName, String orgCode,
			String roleCode, String userAccount, long start, long limit,
			String sort, String dir) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();

		filter.put("idOrAccount", userAccount);
		filter.put("roleCode", roleCode);
		filter.put("orgCode", orgCode);
		filter.put("userName", userName);

		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);

		if (LocalStringUtils.isEmpty(sort)) {
			filter.put(Configuration.SROT_NAME, "U.SORTNUM");
			filter.put(Configuration.ORDER_NAME, Configuration.ORDER_ASC);
		} else {
			filter.put(Configuration.SROT_NAME, sort);
			filter.put(Configuration.ORDER_NAME, dir);
		}
		
		Page<AuthUser> page = new Page<AuthUser>();
		
		page.setTotal(authDao.queryPageCountInRole(filter));
		if(page.getTotal() > 0) {
			page.setReslutSet(authDao.queryListByRole(filter));
		}
		
		return page;
	}

	public void saveRoleByUser(String userId, String roleCodes)
			throws DBAccessException {
		
		authDao.deleteUserAllRole(userId);
		Map<String, String> filter = new HashMap<String, String>();
		filter.put("userId", userId);
		
		List<String> list = LocalStringUtils.splitStr2Array(roleCodes);
		
		if(list != null && list.size() > 0) {
			for (String id : list) {
				filter.put("roleCode", id);
				authDao.saveUserRole(filter);
			}
		}
		
		// 角色发生改变从缓存中清除该用户对象
		userCache.removeUserFromCache(userId);
	}

	public List<String> queryResourceByRole(List<String> roleIds)
			throws DBAccessException {
		return authDao.queryResourceByRole(roleIds);
	}

	public void saveUserRole(String roleCode, List<String> addUserIds,
			List<String> delUserIds) throws DBAccessException {
		
		if(delUserIds != null && delUserIds.size() > 0) {
			Map<String, Object> delFilter = new HashMap<String, Object>();
			delFilter.put("roleCode", roleCode);
			delFilter.put("list", delUserIds);
			
			authDao.deleteUserInRole(delFilter);
			for(String id : delUserIds) {
				// 角色发生改变从缓存中清除该用户对象
				userCache.removeUserFromCache(id);
			}
		}
		
		if(addUserIds != null && addUserIds.size() > 0) {
			Map<String, String> addFilter = new HashMap<String, String>();
			addFilter.put("roleCode", roleCode);
			
			for (String id : addUserIds) {
				addFilter.put("userId", id);
				authDao.saveUserRole(addFilter);
				
				// 角色发生改变从缓存中清除该用户对象
				userCache.removeUserFromCache(id);
			}
		}
	}

}
