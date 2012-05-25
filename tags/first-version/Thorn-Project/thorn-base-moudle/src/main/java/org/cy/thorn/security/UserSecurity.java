package org.cy.thorn.security;

import java.util.ArrayList;
import java.util.Collection;

import org.cy.thorn.user.entity.User;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;

public class UserSecurity implements UserDetails {
	
	private Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
	
	private User user;
	
	public UserSecurity(User user) {
		//设置普通用户的角色
		if(user != null) {
			GrantedAuthority auth = new GrantedAuthorityImpl(user.getDefaultrole());
			authorities.add(auth);
			this.user = user;
		}
	}
	
	public Collection<GrantedAuthority> getAuthorities() {
		return authorities;
	}
	
	public void setAuthorities(Collection<GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

	public String getPassword() {
		return this.user.getUserpwd();
	}
	
	public String getUsername() {
		return this.user.getUseraccount();
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	/**
	 * 判断账号是否过期
	 */
	public boolean isAccountNonExpired() {
		if(this.user.getIsdisabled() != SecurityConstant.IF_OR_NOT 
				&& this.user.getIsvalid() != SecurityConstant.IF_OR_NOT) {
			return true;
		} 
		
		return false;
	}
	
	/**
	 * 判断账号是否锁定
	 */
	public boolean isAccountNonLocked() {
		return isAccountNonExpired();
	}
	
	/**
	 * 判断证书是否过期
	 */
	public boolean isCredentialsNonExpired() {
		return isAccountNonExpired();
	}
	
	/**
	 * 判断账号是否可用
	 */
	public boolean isEnabled() {
		return isAccountNonExpired();
	}
	
}
