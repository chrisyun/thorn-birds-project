package org.cy.thorn.org.entity;

import java.math.BigDecimal;

public class Org {
	
    private String orgid;

    private String ou;

    private String parentorg;

    private String showname;

    private String orgtype;

    private String orgmail;

    private BigDecimal sortnum;

    private String isshow;

    private String isvalid;

    private String isdisabled;

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid == null ? null : orgid.trim();
    }

    public String getOu() {
        return ou;
    }

    public void setOu(String ou) {
        this.ou = ou == null ? null : ou.trim();
    }

    public String getParentorg() {
        return parentorg;
    }

    public void setParentorg(String parentorg) {
        this.parentorg = parentorg == null ? null : parentorg.trim();
    }

    public String getShowname() {
        return showname;
    }

    public void setShowname(String showname) {
        this.showname = showname == null ? null : showname.trim();
    }

    public String getOrgtype() {
        return orgtype;
    }

    public void setOrgtype(String orgtype) {
        this.orgtype = orgtype == null ? null : orgtype.trim();
    }

    public String getOrgmail() {
        return orgmail;
    }

    public void setOrgmail(String orgmail) {
        this.orgmail = orgmail == null ? null : orgmail.trim();
    }

    public BigDecimal getSortnum() {
        return sortnum;
    }

    public void setSortnum(BigDecimal sortnum) {
        this.sortnum = sortnum;
    }

    public String getIsshow() {
        return isshow;
    }

    public void setIsshow(String isshow) {
        this.isshow = isshow == null ? null : isshow.trim();
    }

    public String getIsvalid() {
        return isvalid;
    }

    public void setIsvalid(String isvalid) {
        this.isvalid = isvalid == null ? null : isvalid.trim();
    }

    public String getIsdisabled() {
        return isdisabled;
    }

    public void setIsdisabled(String isdisabled) {
        this.isdisabled = isdisabled == null ? null : isdisabled.trim();
    }
    
    public String toString() {
    	return String.format("Org [orgid=%s, ou=%s, parentorg=%s, showname=%s, "+
    			"orgtype=%s, orgmail=%s, sortnum=%s, isshow=%s, isvalid=%s, isdisabled=%s]", 
    			orgid, ou, parentorg, showname, orgtype, orgmail, sortnum, isshow, isvalid, isdisabled);
    }
}