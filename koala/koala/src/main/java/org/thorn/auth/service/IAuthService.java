package org.thorn.auth.service;

import java.util.List;

import org.thorn.web.entity.Page;
import org.thorn.auth.entity.AuthUser;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.entity.Role;

/**
 * @ClassName: IAuthService
 * @Description:
 * @author chenyun
 * @date 2012-5-25 上午11:35:13
 */
public interface IAuthService {

	/**
	 * 
	 * @Description：根据角色ID查找授权的资源
	 * @author：chenyun
	 * @date：2012-5-19 下午02:11:02
	 * @param roleId
	 * @return
	 * @throws DBAccessException
	 */
	public List<String> queryResourceByRole(String roleId)
			throws DBAccessException;

	/**
	 * 
	 * @Description：根据角色集合查找授权的资源集合
	 * @author：chenyun
	 * @date：2012-6-1 下午04:24:04
	 * @param roleIds
	 * @return
	 * @throws DBAccessException
	 */
	public List<String> queryResourceByRole(List<String> roleIds)
			throws DBAccessException;

	/**
	 * 
	 * @Description：保存角色权限
	 * @author：chenyun
	 * @date：2012-5-25 上午11:49:12
	 * @param roleCode
	 *            角色code
	 * @param sourceIds
	 *            资源的主键集合
	 * @throws DBAccessException
	 */
	public void saveRoleAuth(String roleCode, String[] sourceIds)
			throws DBAccessException;

	/**
	 * 
	 * @Description：根据用户查找授权的角色
	 * @author：chenyun
	 * @date：2012-5-25 下午01:24:04
	 * @param userId
	 * @return
	 * @throws DBAccessException
	 */
	public List<Role> queryRoleByUser(String userId) throws DBAccessException;

	/**
	 * 
	 * @Description：根据权限ID列表查找对应的角色，返回的角色列表需要去重
	 * @author：chenyun
	 * @date：2012-5-4 下午03:48:01
	 * @param source
	 * @return
	 * @throws DBAccessException
	 */
	public List<Role> queryRoleBySource(List<String> source)
			throws DBAccessException;

	/**
	 * 
	 * @Description：分页查询角色中的用户
	 * @author：chenyun
	 * @date：2012-5-25 下午02:03:45
	 * @param userName
	 *            姓名
	 * @param orgCode
	 *            组织编码
	 * @param roleCode
	 *            角色编码
	 * @param userAccount
	 *            用户ID或账号
	 * @param start
	 * @param limit
	 * @param sort
	 * @param dir
	 * @return
	 * @throws DBAccessException
	 */
	public Page<AuthUser> queryPageByRole(String userName, String orgCode,
			String roleCode, String userAccount, long start, long limit,
			String sort, String dir) throws DBAccessException;

	/**
	 * 
	 * @Description：用户绑定角色
	 * @author：chenyun
	 * @date：2012-5-25 下午02:06:02
	 * @param userId
	 * @param roleCodes
	 * @throws DBAccessException
	 */
	public void saveRoleByUser(String userId, String roleCodes)
			throws DBAccessException;
	
	/**
	 * 
	 * @Description：
	 * @author：chenyun 	        
	 * @date：2013-2-16 上午10:43:04
	 * @param roleCodes
	 * @param addUserIds
	 * @param delUserIds
	 * @throws DBAccessException
	 */
	public void saveUserRole(String roleCode, List<String> addUserIds,
			List<String> delUserIds) throws DBAccessException;
}
