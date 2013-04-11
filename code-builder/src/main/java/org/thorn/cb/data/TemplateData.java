package org.thorn.cb.data;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class TemplateData implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6074929541203563326L;
	
	/**
	 * 模块名称
	 */
	private String name;
	
	/**
	 * 数据库表名（大写）
	 */
	private String tableName;
	
	/**
	 * 包根路径（小写）
	 */
	private String pkg;
	
	/**
	 * 属性信息（数据库字段与实体类信息）
	 */
	private Set<Field> fields = new HashSet<Field>();
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 
	 * @return 全大写的模块名称
	 */
	public String getNameAllUpperCase() {
		return name.toUpperCase();
	}
	
	/**
	 * 
	 * @return 全小写的模块名称
	 */
	public String getNameAllLowerCase() {
		return name.toLowerCase();
	}
	
	/**
	 * 
	 * @return 第一个字母小写的模块名称
	 */
	public String getNameFirLetterLc() {
		String firLetter = name.substring(0, 1);
		return name.replaceFirst(firLetter, firLetter.toLowerCase());
	}
	
	/**
	 * 
	 * @return 第一个字母大写的模块名称
	 */
	public String getNameFirLetterUc() {
		String firLetter = name.substring(0, 1);
		return name.replaceFirst(firLetter, firLetter.toUpperCase());
	}
	
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getPkg() {
		return pkg;
	}

	public void setPkg(String pkg) {
		this.pkg = pkg;
	}

	public Set<Field> getFields() {
		return fields;
	}

	public void setFields(Set<Field> fields) {
		this.fields = fields;
	}
	
}
