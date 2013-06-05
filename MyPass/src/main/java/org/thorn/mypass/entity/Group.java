package org.thorn.mypass.entity;

public class Group extends BaseEntity {

    private String name;

    private String pname;

    public Group() {

    }

    public Group(String name) {
        this.name = name;
    }

    public Group(String name, String pname) {
        this.name = name;
        this.pname = pname;
    }

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

    @Override
    public String toString() {
        return this.name;
    }
}
