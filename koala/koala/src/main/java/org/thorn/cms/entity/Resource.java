package org.thorn.cms.entity;

import java.io.Serializable;

/** 
 * @ClassName: Resource 
 * @Description: 
 * @author chenyun
 * @date 2013-2-22 上午11:05:54 
 */
public class Resource implements Serializable {

	/** */
	private static final long serialVersionUID = -3486984397214323659L;
	
	private String name;
	
	private String lastModifyTime;
	
	private String size;
	
	private String type;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLastModifyTime() {
		return lastModifyTime;
	}

	public void setLastModifyTime(String lastModifyTime) {
		this.lastModifyTime = lastModifyTime;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
}

