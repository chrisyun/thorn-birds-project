package org.thorn.workflow.entity;

import java.io.Serializable;

/** 
 * @ClassName: ActivityMind 
 * @Description: 
 * @author chenyun
 * @date 2012-7-20 下午03:06:38 
 */
public class ActivityMind implements Serializable {

	/** */
	private static final long serialVersionUID = 7592800454391977080L;
	
	private Integer id;
	
	private String flowInstId;
	
	private String activityName;
	
	private String taskId;
	
	private String userId;
	
	private String userName;
	
	private String createTime;
	
	private String minds;
	
	private String isPassed;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFlowInstId() {
		return flowInstId;
	}

	public void setFlowInstId(String flowInstId) {
		this.flowInstId = flowInstId;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getMinds() {
		return minds;
	}

	public void setMinds(String minds) {
		this.minds = minds;
	}

	public String getIsPassed() {
		return isPassed;
	}

	public void setIsPassed(String isPassed) {
		this.isPassed = isPassed;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}

