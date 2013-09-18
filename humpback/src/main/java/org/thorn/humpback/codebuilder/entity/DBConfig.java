package org.thorn.humpback.codebuilder.entity;

/**
 * @Author: yfchenyun
 * @Since: 13-9-17 下午4:16
 * @Version: 1.0
 */
public class DBConfig {

    private String driverClass;

    private String url;

    private String username;

    private String password;

    public DBConfig() {
    }

    public DBConfig(String driverClass, String url, String username, String password) {
        this.driverClass = driverClass;
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public String getDriverClass() {
        return driverClass;
    }

    public void setDriverClass(String driverClass) {
        this.driverClass = driverClass;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
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
}
