package org.koala.user.service;

import org.koala.user.entity.User;
import org.thorn.dao.exception.DBAccessException;

/** 
 * @ClassName: UserServiceImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-8-1 下午08:35:53 
 */
public class UserServiceImpl implements IUserService {

	public User queryUserByLogin(String idOrAccount) throws DBAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	public void regist(User user) throws DBAccessException {
		// TODO Auto-generated method stub

	}

	public void modify(User user) throws DBAccessException {
		// TODO Auto-generated method stub

	}

	public void changePwd(String userId, String newPwd)
			throws DBAccessException {
		// TODO Auto-generated method stub

	}

}

