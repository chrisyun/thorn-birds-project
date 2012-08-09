package org.thorn.process.entity;

import java.io.Serializable;

/**
 * @ClassName: Process
 * @Description:
 * @author chenyun
 * @date 2012-8-9 上午10:50:56
 */
public class Process implements Serializable {

	/** */
	private static final long serialVersionUID = -5363259355484582696L;

	private Integer id;
	
	private String flowType;
	
	private String activity;
	
	private String flowStatus;
	
	private String creater;
	
	private String createrName;
	
	private String createTime;
	
	private Integer pid;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFlowType() {
		return flowType;
	}
	public void setFlowType(String flowType) {
		this.flowType = flowType;
	}
	public String getActivity() {
		return activity;
	}
	public void setActivity(String activity) {
		this.activity = activity;
	}
	public String getFlowStatus() {
		return flowStatus;
	}
	public void setFlowStatus(String flowStatus) {
		this.flowStatus = flowStatus;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public String getCreaterName() {
		return createrName;
	}
	public void setCreaterName(String createrName) {
		this.createrName = createrName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
}
