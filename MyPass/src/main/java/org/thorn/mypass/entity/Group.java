package org.thorn.mypass.entity;

public class Group extends BaseEntity {
    
    private String name;
    
    private String pname;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }
}
