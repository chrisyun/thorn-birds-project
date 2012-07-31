package org.thorn.security.entity;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.koala.user.entity.User;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;
/**
 * 
 * @ClassName: UserSecurity 
 * @Description: 
 * @author chenyun
 * @date 2012-5-4 下午03:22:53 
 *
 */
public class UserSecurity implements UserDetails {
	
	/** */
	private static final long serialVersionUID = -2824513603127791680L;

	private Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
	
	private User user;
	
	public void initUserAuth(List<String> roles) {
		
		//设置用户的默认角色
		if(user.getDefaultRole() != null) {
			GrantedAuthority auth = new GrantedAuthorityImpl(user.getDefaultRole());
			if(! authorities.contains(auth)) {
				authorities.add(auth);
			}
		}
	}
	
	public UserSecurity(User user) {
		this.user = user;
	}
	
	public Collection<GrantedAuthority> getAuthorities() {
		return authorities;
	}
	
	public void setAuthorities(Collection<GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

	public String getPassword() {
		return user.getPwd();
	}
	
	public String getUsername() {
		return user.getAccount();
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
		return true;
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
