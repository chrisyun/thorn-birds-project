package org.thorn.workflow.entity;

import java.io.Serializable;

/** 
 * @ClassName: TaskInfo 
 * @Description: 
 * @author chenyun
 * @date 2012-7-13 下午03:55:29 
 */
public class TaskInfo implements Serializable {

	/** */
	private static final long serialVersionUID = 8458569542864497706L;
	
	private String title;
	
	private String taskId;
	
	private String flowKey;
	
	private String flowInstId;
	
	private String activityName;
	
	private String sender;
	
	private String receiptTime;
	
	private Integer priority;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getFlowKey() {
		return flowKey;
	}

	public void setFlowKey(String flowKey) {
		this.flowKey = flowKey;
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

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiptTime() {
		return receiptTime;
	}

	public void setReceiptTime(String receiptTime) {
		this.receiptTime = receiptTime;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}
}

