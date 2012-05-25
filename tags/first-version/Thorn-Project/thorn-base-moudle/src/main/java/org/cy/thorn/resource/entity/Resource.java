package org.cy.thorn.resource.entity;

import java.math.BigDecimal;

public class Resource {
    private String resid;

    private String sname;

    private String resurl;

    private String isleaf;

    private String isshow;

    private String parentres;

    private String ismodule;

    private BigDecimal sortnum;
    
    private String iconscls;

    public String getResid() {
        return resid;
    }

    public void setResid(String resid) {
        this.resid = resid == null ? null : resid.trim();
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname == null ? null : sname.trim();
    }

    public String getResurl() {
        return resurl;
    }

    public void setResurl(String resurl) {
        this.resurl = resurl == null ? null : resurl.trim();
    }

    public String getIsleaf() {
        return isleaf;
    }

    public void setIsleaf(String isleaf) {
        this.isleaf = isleaf == null ? null : isleaf.trim();
    }

    public String getIsshow() {
        return isshow;
    }

    public void setIsshow(String isshow) {
        this.isshow = isshow == null ? null : isshow.trim();
    }

    public String getParentres() {
        return parentres;
    }

    public void setParentres(String parentres) {
        this.parentres = parentres == null ? null : parentres.trim();
    }

    public String getIsmodule() {
        return ismodule;
    }

    public void setIsmodule(String ismodule) {
        this.ismodule = ismodule == null ? null : ismodule.trim();
    }

    public BigDecimal getSortnum() {
        return sortnum;
    }

    public void setSortnum(BigDecimal sortnum) {
        this.sortnum = sortnum;
    }
    
    public String getIconscls() {
		return iconscls;
	}

	public void setIconscls(String iconscls) {
		this.iconscls = iconscls;
	}

	public String toString() {
    	return String.format("Resource [sid=%s, sname=%s, url=%s, isleaf=%s, "+
    			"isshow=%s, parentres=%s, ismodule=%s, sort=%s]", 
    			resid, sname, resurl, isleaf, isshow, parentres,ismodule, sortnum);
    }
}