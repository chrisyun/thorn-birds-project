package org.thorn.core.excel.xml;

import java.io.Serializable;
import java.util.List;

public class ExcelConfig implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7325281616616369697L;

	private String fileName;
	
	private String sheetName;
	
	private Class object;
	
	private Style defaultStyle;
	
	private List<Header> title;
	
	private List<Column> columns;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getSheetName() {
		return sheetName;
	}

	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}

	public Class getObject() {
		return object;
	}

	public void setObject(Class object) {
		this.object = object;
	}

	public Style getDefaultStyle() {
		return defaultStyle;
	}

	public void setDefaultStyle(Style defaultStyle) {
		this.defaultStyle = defaultStyle;
	}

	public List<Header> getTitle() {
		return title;
	}

	public void setTitle(List<Header> title) {
		this.title = title;
	}

	public List<Column> getColumns() {
		return columns;
	}

	public void setColumns(List<Column> columns) {
		this.columns = columns;
	}
}
