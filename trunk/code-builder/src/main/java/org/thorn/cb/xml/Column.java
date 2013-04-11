package org.thorn.cb.xml;

import java.io.Serializable;

import org.apache.commons.lang.StringUtils;

/** 
 * @ClassName: Column 
 * @Description: 
 * @author chenyun
 * @date 2013-3-7 上午10:18:21 
 */
public class Column implements Serializable {
	
	/** */
	private static final long serialVersionUID = -4672555167550182245L;
	
	/**
	 * 数据库字段名（不可为空）
	 */
	private String name;
	
	/**
	 * 实体类属性（可为空）
	 */
	private String property;
	
	/**
	 * 实体类类型（可为空）
	 */
	private String javaType;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProperty() {
		return property;
	}

	public void setProperty(String property) {
		this.property = property;
	}

	public String getJavaType() {
		return javaType;
	}

	public void setJavaType(String javaType) {
		this.javaType = javaType;
	}
	
	@Override
	public boolean equals(Object obj) {
		
		if(obj instanceof String 
				&& StringUtils.equalsIgnoreCase(name, (String)obj)) {
			return true;
		} else {
			return super.equals(obj);
		}
	}
	
}

