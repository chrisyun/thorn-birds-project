package org.koala.user.service;

import java.util.HashMap;
import java.util.Map;

import org.koala.user.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.userdetails.UserCache;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.mybatis.helper.MyBatisDaoSupport;
import org.thorn.security.SecurityEncoderUtils;

/**
 * @ClassName: UserServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-8-1 下午08:35:53
 */
public class UserServiceImpl implements IUserService {

	@Autowired
	@Qualifier("myBatisDaoSupport")
	private MyBatisDaoSupport support;

	@Autowired
	@Qualifier("userSecurityCache")
	private UserCache userCache;

	public User queryUserByLogin(String idOrAccount) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("account", idOrAccount);
		return (User) support.queryOne(filter, User.class);
	}

	public void regist(User user) throws DBAccessException {
		user.setAccount(user.getAccount().toUpperCase());

		if (LocalStringUtils.isNotEmpty(user.getPwd())) {
			user.setPwd(SecurityEncoderUtils.encodeUserPassword(user.getPwd(),
					user.getAccount()));
		}

		support.save(user);
	}

	public void modify(User user) throws DBAccessException {
		user.setPwd(null);
		user.setAccount(user.getAccount().toUpperCase());

		support.modify(user);
		userCache.removeUserFromCache(user.getAccount());
	}

	public void changePwd(Integer userId, String account, String newPwd)
			throws DBAccessException {
		User user = new User();
		
		user.setId(userId);
		account = account.toUpperCase();
		user.setPwd(SecurityEncoderUtils.encodeUserPassword(newPwd,
				account.toUpperCase()));
		support.modify(user);
		
	}
}
