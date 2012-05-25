package org.cy.thorn.dd.entity;

import java.io.Serializable;
import java.math.BigDecimal;

public class Dict implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 5062161434786999802L;

	private String dname;

    private String dvalue;

    private BigDecimal sort;

    private String typeid;

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname == null ? null : dname.trim();
    }

    public String getDvalue() {
        return dvalue;
    }

    public void setDvalue(String dvalue) {
        this.dvalue = dvalue == null ? null : dvalue.trim();
    }

    public BigDecimal getSort() {
        return sort;
    }

    public void setSort(BigDecimal sort) {
        this.sort = sort;
    }

    public String getTypeid() {
        return typeid;
    }

    public void setTypeid(String typeid) {
        this.typeid = typeid == null ? null : typeid.trim();
    }
    
    public String toString() {
    	return String.format("Dict [dname=%s, dvalue=%s, typeid=%s, sort=%s]", 
    			dname, dvalue, typeid, sort);
    }
}