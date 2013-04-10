package org.thorn.workflow.entity;

import java.io.Serializable;

/** 
 * @ClassName: ProcessInstance 
 * @Description: 
 * @author chenyun
 * @date 2012-6-17 下午08:30:54 
 */
public class ProcessInstance implements Serializable {
	
	/** */
	private static final long serialVersionUID = 6828504608149571312L;

	private String id;
	
	private String name;
	
	private String key;
	
	private boolean processInstance;
	
	private String state;
	
	private boolean ended;
	
	private boolean suspended;
	
	private String processDefinitionId;
	
	private int priority;
	
	private String activeActivityName;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public boolean isProcessInstance() {
		return processInstance;
	}

	public void setProcessInstance(boolean processInstance) {
		this.processInstance = processInstance;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public boolean isEnded() {
		return ended;
	}

	public void setEnded(boolean ended) {
		this.ended = ended;
	}

	public boolean isSuspended() {
		return suspended;
	}

	public void setSuspended(boolean suspended) {
		this.suspended = suspended;
	}

	public String getProcessDefinitionId() {
		return processDefinitionId;
	}

	public void setProcessDefinitionId(String processDefinitionId) {
		this.processDefinitionId = processDefinitionId;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public String getActiveActivityName() {
		return activeActivityName;
	}

	public void setActiveActivityName(String activeActivityName) {
		this.activeActivityName = activeActivityName;
	}

}

