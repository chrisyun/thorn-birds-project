package org.koala.user.entity;

import java.io.Serializable;

/** 
 * @ClassName: User 
 * @Description: 
 * @author chenyun
 * @date 2012-7-31 下午02:09:04 
 */
public class User implements Serializable {

	/** */
	private static final long serialVersionUID = -1330849141542518589L;
	
	private Integer id;
	
	private String account;
	
	private String nickName;
	
	private String pwd;
	
	private String defaultRole;
	
	/** 是否邮箱验证  0 ：未验证，1： 已验证*/
	private Integer isVerfiy;
	
	private String lastLogin;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getDefaultRole() {
		return defaultRole;
	}

	public void setDefaultRole(String defaultRole) {
		this.defaultRole = defaultRole;
	}

	public Integer getIsVerfiy() {
		return isVerfiy;
	}

	public void setIsVerfiy(Integer isVerfiy) {
		this.isVerfiy = isVerfiy;
	}

	public String getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(String lastLogin) {
		this.lastLogin = lastLogin;
	}
}

