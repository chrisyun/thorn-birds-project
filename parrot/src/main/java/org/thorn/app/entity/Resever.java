package org.thorn.app.entity;

import java.io.Serializable;

/** 
 * @ClassName: Resever 
 * @Description: 
 * @author chenyun
 * @date 2012-8-9 上午10:44:25 
 */
public class Resever implements Serializable {
	
	/** */
	private static final long serialVersionUID = 3799670210897226440L;

	private Integer id;
	
	private String name;
	
	private String buildTime;
	
	private String area;
	
	private String userId;
	
	private String province;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBuildTime() {
		return buildTime;
	}

	public void setBuildTime(String buildTime) {
		this.buildTime = buildTime;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}
}

