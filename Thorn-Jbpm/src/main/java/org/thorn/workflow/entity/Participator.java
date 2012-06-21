package org.thorn.workflow.entity;

import java.io.Serializable;

/** 
 * @ClassName: WfPermission 
 * @Description: 
 * @author chenyun
 * @date 2012-6-20 下午09:45:24 
 */
public class Participator implements Serializable {

	/** */
	private static final long serialVersionUID = -2955763101291011116L;
	
	private Integer id;
	
	private String processDfId;
	
	private String activityId;
	
	private String entityType;
	
	private String entity;
	
	private String limitType;
	
	private String variable;

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

	public String getEntityType() {
		return entityType;
	}

	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

	public String getLimitType() {
		return limitType;
	}

	public void setLimitType(String limitType) {
		this.limitType = limitType;
	}

	public String getVariable() {
		return variable;
	}

	public void setVariable(String variable) {
		this.variable = variable;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
}

