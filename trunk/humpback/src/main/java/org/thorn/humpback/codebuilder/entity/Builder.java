package org.thorn.humpback.codebuilder.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/** 
 * @ClassName: Builder 
 * @Description: 
 * @author chenyun
 * @date 2013-3-7 上午10:17:44 
 */
public class Builder implements Serializable {

	/** */
	private static final long serialVersionUID = 4701567767668563226L;
	
	private String output;
	
	private String name;
	
	private String pkg;
	
	private Table table;
	
	private List<Column> ids = new ArrayList<Column>();
	
	private List<Column> columns = new ArrayList<Column>();

	public String getOutput() {
		return output;
	}

	public void setOutput(String output) {
		this.output = output;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPkg() {
		return pkg;
	}

	public void setPkg(String pkg) {
		this.pkg = pkg;
	}

	public Table getTable() {
		return table;
	}

	public void setTable(Table table) {
		this.table = table;
	}

	public List<Column> getIds() {
		return ids;
	}

	public void setIds(List<Column> ids) {
		this.ids = ids;
	}

	public List<Column> getColumns() {
		return columns;
	}

	public void setColumns(List<Column> columns) {
		this.columns = columns;
	}
	
}

