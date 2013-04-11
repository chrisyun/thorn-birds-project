package org.thorn.cb.xml;

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
	
	private List<Mapper> ids = new ArrayList<Mapper>();
	
	private List<Mapper> columns = new ArrayList<Mapper>();

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

	public List<Mapper> getIds() {
		return ids;
	}

	public void setIds(List<Mapper> ids) {
		this.ids = ids;
	}

	public List<Mapper> getColumns() {
		return columns;
	}

	public void setColumns(List<Mapper> columns) {
		this.columns = columns;
	}
	
}

