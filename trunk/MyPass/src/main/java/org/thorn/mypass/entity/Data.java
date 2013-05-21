package org.thorn.mypass.entity;

public class Data extends BaseEntity {
    
    private String dataInfo;
    
    private String groupName;

    public String getDataInfo() {
        return dataInfo;
    }

    public void setDataInfo(String dataInfo) {
        this.dataInfo = dataInfo;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }
}
