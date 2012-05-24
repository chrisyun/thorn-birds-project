package org.thorn.user.service;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.user.entity.User;

/**
 * @ClassName: IUserService
 * @Description:
 * @author chenyun
 * @date 2012-5-4 下午03:02:29
 */
public interface IUserService {

	public User queryUserByLogin(String idOrAccount) throws DBAccessException;

	public void save(User user) throws DBAccessException;

	public void modify(User user) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<User> queryPage(String orgCode, String userName, String cumail,
			String userAccount, long start, long limit, String sort, String dir)
			throws DBAccessException;

	public void disabledUser(String ids, String isDisabled)
			throws DBAccessException;

	public void changePwd(String userId, String newPwd)
			throws DBAccessException;

	public Page<User> queryPageByRole(String userName, String orgCode,
			String roleCode, String userAccount, long start, long limit,
			String sort, String dir) throws DBAccessException;

	public Page<User> queryPageNotInRole(String orgCode, String roleCode,
			long start, long limit, String sort, String dir)
			throws DBAccessException;

	public void saveUserRole(String roleCode, String userIds)
			throws DBAccessException;

	public void saveRoleByUser(String userId, String roleCodes)
			throws DBAccessException;

	public void deleteUserRole(String roleCode, String userIds)
			throws DBAccessException;

}
