package org.thorn.workflow.entity;

import java.io.Serializable;

/** 
 * @ClassName: PageAuth 
 * @Description: 
 * @author chenyun
 * @date 2012-7-27 下午09:38:32 
 */
public class PageAuth implements Serializable {

	/** */
	private static final long serialVersionUID = -3213768660963275925L;
	
	private Integer id;
	
	private String processDfId;
	
	private String activityId;
	
	private String auth;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProcessDfId() {
		return processDfId;
	}

	public void setProcessDfId(String processDfId) {
		this.processDfId = processDfId;
	}

	public String getActivityId() {
		return activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}
}

