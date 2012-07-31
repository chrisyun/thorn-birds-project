package org.thorn.security;

import org.koala.user.entity.User;
import org.koala.user.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.security.entity.UserSecurity;

/**
 * 
 * @ClassName: UserSecurityDetailsService 
 * @Description: 提供查找用户的service服务
 * @author chenyun
 * @date 2012-5-4 下午03:22:18 
 *
 */
public class UserSecurityDetailsService implements UserDetailsService {
	
	@Autowired
	@Qualifier("userSecurityCache")
	private UserCache userCache;
	
	@Autowired
	@Qualifier("userService")
	private IUserService userService;

	public UserDetails loadUserByUsername(String arg0)
			throws UsernameNotFoundException, DataAccessException {
		arg0 = arg0.toUpperCase();

		UserSecurity us = (UserSecurity) userCache.getUserFromCache(arg0);

		try {
			if (us == null) {
				us = new UserSecurity(userService.queryUserByLogin(arg0));
				User user = us.getUser();
				if (user != null && LocalStringUtils.isNotEmpty(user.getAccount())) {
					us.initUserAuth(null);

					// 将UserSecurity放入cache中
					userCache.putUserInCache(us);
				}
			}
		} catch (DBAccessException e) {
			throw new DataAccessResourceFailureException(
					"User Query Exception", e);
		}

		if (us.getUser() == null
				|| LocalStringUtils.isEmpty(us.getUser().getAccount())) {
			throw new UsernameNotFoundException(
					"User Not Found From DataSource");
		}

		return us;
	}

}
