package org.thorn.mypass.entity;

public class User {

    private Integer id;

    private String username;

    private String password;

    private Integer usedVersion;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Integer getUsedVersion() {
        return usedVersion;
    }

    public void setUsedVersion(Integer usedVersion) {
        this.usedVersion = usedVersion;
    }

}
