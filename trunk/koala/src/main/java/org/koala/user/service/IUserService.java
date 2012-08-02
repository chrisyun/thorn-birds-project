package org.koala.user.service;

import org.koala.user.entity.User;
import org.thorn.dao.exception.DBAccessException;

/**
 * @ClassName: IUserService
 * @Description:
 * @author chenyun
 * @date 2012-5-4 下午03:02:29
 */
public interface IUserService {

	public User queryUserByLogin(String idOrAccount) throws DBAccessException;

	public void regist(User user) throws DBAccessException;

	public void modify(User user) throws DBAccessException;

	public void changePwd(Integer userId, String account, String newPwd)
			throws DBAccessException;
}
