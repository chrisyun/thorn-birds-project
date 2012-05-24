package org.thorn.user.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.user.entity.User;

/** 
 * @ClassName: IUserDao 
 * @Description: 
 * @author chenyun
 * @date 2012-5-6 上午11:15:37 
 */
public interface IUserDao {
	
	public User queryUser(Map<String, Object> filter) throws DBAccessException;
	
	public int save(User user) throws DBAccessException;
	
	public int saveUserRole(Map<String, String> ur) throws DBAccessException;
	
	public int deleteUserRole(Map<String, Object> filter) throws DBAccessException;
	
	public int deleteUserAllRole(String userId) throws DBAccessException;
	
	public int modify(User user) throws DBAccessException;

	public int delete(List<String> ids) throws DBAccessException;
	
	public int disabled(Map<String, Object> filter) throws DBAccessException;
	
	public Page<User> queryPage(Map<String, Object> filter) throws DBAccessException;
	
	public Page<User> queryPageByRole(Map<String, Object> filter) throws DBAccessException;
	
	public Page<User> queryPageNotInRole(Map<String, Object> filter) throws DBAccessException;
}

