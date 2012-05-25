package org.cy.thorn.role.entity;

public class UserRole {
    private String remark;

    private String creattime;
    
    private String rid;

    private String userid;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid == null ? null : rid.trim();
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid == null ? null : userid.trim();
    }
    
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getCreattime() {
        return creattime;
    }

    public void setCreattime(String creattime) {
        this.creattime = creattime;
    }
    
    public String toString() {
    	return String.format("UserRole [rid=%s, userid=%s]", rid, userid);
    }
}