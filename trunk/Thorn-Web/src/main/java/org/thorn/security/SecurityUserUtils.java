package org.thorn.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.security.entity.UserSecurity;
import org.thorn.user.entity.User;

/**
 * @ClassName: SecurityUserUtil
 * @Description:
 * @author chenyun
 * @date 2012-5-6 下午10:56:26
 */
public class SecurityUserUtils {

	public static User getCurrentUser() {
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();

		if (auth == null) {
			return null;
		}

		UserSecurity us = (UserSecurity) auth.getPrincipal();
		User user = us.getUser();
		return user;
	}

	public static List<String> getRoleList() {
		List<String> list = new ArrayList<String>();

		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();

		if (auth == null) {
			return list;
		}

		UserSecurity us = (UserSecurity) auth.getPrincipal();
		Collection<GrantedAuthority> authorities = us.getAuthorities();

		for (GrantedAuthority authority : authorities) {
			list.add(authority.getAuthority());
		}

		return list;
	}

	public static boolean isSysAdmin() {
		List<String> list = getRoleList();

		boolean isAdmin = false;
		for (String role : list) {
			if (LocalStringUtils.equals(SecurityConfiguration.SYS_ADMIN_ROLE, role)) {
				isAdmin = true;
				break;
			}
		}

		return isAdmin;
	}

}
