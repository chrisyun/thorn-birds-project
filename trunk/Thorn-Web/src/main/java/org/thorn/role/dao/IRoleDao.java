package org.thorn.role.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.entity.Role;

/**
 * @ClassName: IRoleDao
 * @Description:
 * @author chenyun
 * @date 2012-5-6 上午10:48:02
 */
public interface IRoleDao {
	
	/**
	 * 
	 * @Description：
	 * @author：chenyun 	        
	 * @date：2012-5-6 上午11:14:15
	 * @param userId
	 * @return
	 * @throws DBAccessException
	 */
	public List<Role> queryRolesByUser(String userId) throws DBAccessException;
	
	public List<Role> query(Map<String, Object> filter) throws DBAccessException;
	
	public List<Role> queryRolesByResource(List<String> source)
			throws DBAccessException;
	
	public int save(Role role) throws DBAccessException;

	public int modify(Role role) throws DBAccessException;

	public int delete(List<String> ids) throws DBAccessException;
	
	public Page<Role> queryPage(Map<String, Object> filter) throws DBAccessException;
	
	public int deleteRoleSource(String roleCode) throws DBAccessException;
	
	public int saveRoleSource(Map<String, String> rs) throws DBAccessException;
}
