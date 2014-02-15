package org.thorn.coral.console.web;

import java.io.Serializable;

/**
 * @Author: yfchenyun
 * @Since: 13-10-14 下午6:11
 * @Version: 1.0
 */
public class SessionData implements Serializable {

    private static final long serialVersionUID = 6039043983707287664L;

    private String userId;

    private String userName;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
