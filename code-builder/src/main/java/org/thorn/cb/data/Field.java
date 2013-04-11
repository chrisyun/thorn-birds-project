package org.thorn.cb.data;

import java.io.Serializable;

public class Field implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5382511124963448144L;
	
	/**
	 * 是否主键（true是\false否）
	 */
	private boolean isKey;
	
	/**
	 * 数据库字段名称（大写）
	 */
	private String tabName;
	
	/**
	 * 数据库字段类型
	 */	
	private String tabType;
	
	/**
	 * 字段长度
	 */		
	private int tabLength;
	
	/**
	 * 数据库字段类型对应的java的jdbc类型
	 */		
	private int jdbcType;
	
	/**
	 * 数据库字段描述
	 */		
	private String comment;
	
	/**
	 * 实体类名称
	 */		
	private String fieldName;
	
	/**
	 * 实体类型
	 */		
	private String fieldType;

	public boolean isKey() {
		return isKey;
	}

	public void setKey(boolean isKey) {
		this.isKey = isKey;
	}

	public String getTabName() {
		return tabName;
	}

	public void setTabName(String tabName) {
		this.tabName = tabName;
	}

	public String getTabType() {
		return tabType;
	}

	public void setTabType(String tabType) {
		this.tabType = tabType;
	}

	public int getTabLength() {
		return tabLength;
	}

	public void setTabLength(int tabLength) {
		this.tabLength = tabLength;
	}


	public int getJdbcType() {
		return jdbcType;
	}

	public void setJdbcType(int jdbcType) {
		this.jdbcType = jdbcType;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public String getFieldType() {
		return fieldType;
	}

	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}
	
}
