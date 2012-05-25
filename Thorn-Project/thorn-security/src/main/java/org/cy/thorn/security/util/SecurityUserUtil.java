package org.cy.thorn.security.util;

import java.util.Collection;

import org.cy.thorn.security.UserSecurity;
import org.cy.thorn.user.entity.User;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * <p>文件名称: SecurityUserUtil.java</p>
 * <p>文件描述: 获取登陆用户信息的util类</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-11-2</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class SecurityUserUtil {
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-2
	 * @Description：获取User对象
	 * @return
	 */
	public static User getCurrentUser() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(auth == null) {
			return null;
		}
		
		UserSecurity us = (UserSecurity) auth.getPrincipal();
		User user = us.getUser();
		return user;
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-2
	 * @Description：获取当前用户角色
	 * @return
	 */
	public static String getRoleList() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(auth == null) {
			return "";
		}
		
		UserSecurity us = (UserSecurity) auth.getPrincipal();
		Collection<GrantedAuthority> authorities = us.getAuthorities();
		
		StringBuffer bf = new StringBuffer();
		for(GrantedAuthority authority : authorities) {
			bf.append(authority.getAuthority()).append(",");
		}
		
		if(bf.length() == 0) {
			return "";
		}
		return bf.substring(0, bf.length()-1);
	}
	
}

