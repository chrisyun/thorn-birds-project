package org.thorn.spass.entity;

import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-8-26 下午2:49
 * @Version: 1.0
 */
public class Account {

    private String id;

    private String address;

    private String username;

    private String password;

    private String remark;

    private Set<String> tag;

    public Set<String> getTag() {
        return tag;
    }

    public void setTag(Set<String> tag) {
        this.tag = tag;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
