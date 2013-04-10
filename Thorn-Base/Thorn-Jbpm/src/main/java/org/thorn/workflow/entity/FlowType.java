package org.thorn.workflow.entity;

import java.io.Serializable;

/** 
 * @ClassName: FlowType 
 * @Description: 
 * @author chenyun
 * @date 2012-6-23 下午06:50:11 
 */
public class FlowType implements Serializable {
	
	/** */
	private static final long serialVersionUID = 3279480781149683667L;
	
	private Integer id;
	
	private String flowName;
	
	private String flowKey;
	
	private String flowType;
	
	private String flowDesc;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFlowName() {
		return flowName;
	}

	public void setFlowName(String flowName) {
		this.flowName = flowName;
	}

	public String getFlowKey() {
		return flowKey;
	}

	public void setFlowKey(String flowKey) {
		this.flowKey = flowKey;
	}

	public String getFlowType() {
		return flowType;
	}

	public void setFlowType(String flowType) {
		this.flowType = flowType;
	}

	public String getFlowDesc() {
		return flowDesc;
	}

	public void setFlowDesc(String flowDesc) {
		this.flowDesc = flowDesc;
	}
}

