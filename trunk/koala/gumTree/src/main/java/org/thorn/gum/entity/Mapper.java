package org.thorn.gum.entity;

import java.io.Serializable;

/** 
 * @ClassName: Mapper 
 * @Description: 
 * @author chenyun
 * @date 2013-3-7 上午10:18:21 
 */
public class Mapper implements Serializable {
	
	/** */
	private static final long serialVersionUID = -4672555167550182245L;

	private String column;
	
	private String property;
	
	private String javaType;
	
	private int sqlType;

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
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

	public int getSqlType() {
		return sqlType;
	}

	public void setSqlType(int sqlType) {
		this.sqlType = sqlType;
	}
	
}

