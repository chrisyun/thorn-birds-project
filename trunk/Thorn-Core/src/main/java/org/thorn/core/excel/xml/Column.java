package org.thorn.core.excel.xml;

import java.io.Serializable;

public class Column implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6738196209484216802L;

	private String name;
	
	private String attribute;
	
	private Style style;
	
	public Column() {
		
	}
	
	public Column(String name, String attribute, String style) {
		this.name = name;
		this.attribute = attribute;
		this.style = new Style(style);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAttribute() {
		return attribute;
	}

	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}

	public Style getStyle() {
		return style;
	}

	public void setStyle(Style style) {
		this.style = style;
	}
}
