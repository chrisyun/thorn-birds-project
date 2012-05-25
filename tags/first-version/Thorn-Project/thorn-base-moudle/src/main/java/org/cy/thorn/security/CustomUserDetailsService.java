package org.cy.thorn.security;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.role.dao.IRoleDAO;
import org.cy.thorn.role.entity.UserRole;
import org.cy.thorn.user.dao.IUserDAO;
import org.cy.thorn.user.entity.User;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;


public class CustomUserDetailsService implements UserDetailsService {
	private IUserDAO userService;
	private IRoleDAO roleService;
	private UserCache userCache;
	
	public IUserDAO getUserService() {
		return userService;
	}

	public void setUserService(IUserDAO userService) {
		this.userService = userService;
	}

	public IRoleDAO getRoleService() {
		return roleService;
	}

	public void setRoleService(IRoleDAO roleService) {
		this.roleService = roleService;
	}

	public UserCache getUserCache() {
		return userCache;
	}

	public void setUserCache(UserCache userCache) {
		this.userCache = userCache;
	}

	public UserDetails loadUserByUsername(String arg0)
			throws UsernameNotFoundException, DataAccessException {
		arg0 = arg0.toUpperCase();
		
		UserSecurity us = (UserSecurity) userCache.getUserFromCache(arg0);
		
		try {
			if(us == null) {
				us = new UserSecurity(userService.searchByAccount(arg0));
				User user = us.getUser();
				if(user != null && StringUtils.isNotEmpty(user.getUserid())) {
					List<UserRole> ur = roleService.searchRoleByUid(user.getUserid());
					
					for(UserRole userrole : ur) {
						GrantedAuthority authority = new GrantedAuthorityImpl(userrole.getRid());
						us.getAuthorities().add(authority);
					}
					
					//将UserSecurity放入cache中
					userCache.putUserInCache(us);
				}
			}
		} catch (DBAccessException e) {
			throw new DataAccessResourceFailureException("the db search error",e);
		}
		
		if(us.getUser() == null || StringUtils.isEmpty(us.getUser().getUserid())) {
			throw new UsernameNotFoundException("this user is not found from db");
		}
		
		return us;
	}

}
