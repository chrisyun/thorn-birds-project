package org.thorn.cb.xml;

import java.io.Serializable;

import org.apache.commons.lang.StringUtils;

/** 
 * @ClassName: Table 
 * @Description: 
 * @author chenyun
 * @date 2013-3-7 上午10:18:04 
 */
public class Table implements Serializable {
	
	/** */
	private static final long serialVersionUID = 8742146943087744138L;

	private String sql;
	
	private String table;
	
	private Boolean override;

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public String getTable() {
		return table;
	}

	public void setTable(String table) {
		this.table = table;
	}

	public Boolean getOverride() {
		return override;
	}

	public void setOverride(Boolean override) {
		this.override = override;
	}
	
	public void setOverride(String override) {
		if(StringUtils.equalsIgnoreCase(override, "false")) {
			this.override = false;
		} else {
			this.override = true;
		}
	}
	
}

