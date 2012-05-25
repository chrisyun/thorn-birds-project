package org.cy.thorn.dd.entity;

import java.io.Serializable;

public class DictType implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 4856563207895351678L;

	private String ename;

    private String cname;

    private String creattime;

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename == null ? null : ename.trim();
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname == null ? null : cname.trim();
    }

    public String getCreattime() {
        return creattime;
    }

    public void setCreattime(String creattime) {
        this.creattime = creattime;
    }
    
    public String toString() {
    	return String.format("DictType [ename=%s, cname=%s, creattime=%s]", 
    			ename, cname, creattime);
    }
}