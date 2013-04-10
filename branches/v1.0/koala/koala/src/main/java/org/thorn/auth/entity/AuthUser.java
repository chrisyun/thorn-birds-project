package org.thorn.auth.entity;

import java.io.Serializable;

/** 
 * @ClassName: AuthUser 
 * @Description: 
 * @author chenyun
 * @date 2013-2-16 上午9:36:36 
 */
public class AuthUser implements Serializable {

	/** */
	private static final long serialVersionUID = 8978459624837345127L;

	private String userId;
	
	private String userName;
	
	private String userAccount;
	
	private String cumail;
	
	private String phone;
	
	private String defaultRole;
	
	private String orgCode;
	
	private String orgName;
	
	private String isShow;
	
	private String roleCode;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getCumail() {
		return cumail;
	}

	public void setCumail(String cumail) {
		this.cumail = cumail;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDefaultRole() {
		return defaultRole;
	}

	public void setDefaultRole(String defaultRole) {
		this.defaultRole = defaultRole;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}
	
}

