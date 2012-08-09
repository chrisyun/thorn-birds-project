package org.thorn.process.entity;

import java.io.Serializable;

/** 
 * @ClassName: FlowMinds 
 * @Description: 
 * @author chenyun
 * @date 2012-8-9 上午10:51:14 
 */
public class FlowMinds implements Serializable {
	
	/** */
	private static final long serialVersionUID = -4856007665108428162L;

	private Integer id;
	
	private Integer flowId;
	
	private String userId;
	
	private String userName;
	
	private String mind;
	
	private String time;
	
	private String activityName;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getFlowId() {
		return flowId;
	}

	public void setFlowId(Integer flowId) {
		this.flowId = flowId;
	}

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

	public String getMind() {
		return mind;
	}

	public void setMind(String mind) {
		this.mind = mind;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
}

