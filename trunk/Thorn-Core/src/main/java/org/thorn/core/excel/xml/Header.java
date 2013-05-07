package org.thorn.core.excel.xml;

public class Header extends Column {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7354291243021958266L;

	private Integer colSpan;

	public Header() {

	}

	public Header(String name, Integer colSpan, String style) {
		super(name, null, style);
		this.colSpan = colSpan;
	}

	public Integer getColSpan() {
		return colSpan;
	}

	public void setColSpan(Integer colSpan) {
		this.colSpan = colSpan;
	}
}
