package org.thorn.workflow.entity;

import java.io.Serializable;

/** 
 * @ClassName: Group 
 * @Description: 
 * @author chenyun
 * @date 2012-6-23 上午11:03:35 
 */
public class Group implements Serializable {

	/** */
	private static final long serialVersionUID = 976725502504716513L;
	
	private String id;
	
	private String name;
	
	private String isShow;
	
	private String isDisabled;

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

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String getIsDisabled() {
		return isDisabled;
	}

	public void setIsDisabled(String isDisabled) {
		this.isDisabled = isDisabled;
	}
}

