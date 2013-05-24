package org.thorn.mypass.core;

import org.thorn.mypass.entity.User;

public class Session {

    private User user;
    
    /**
     * 数据库数据加密密钥
     */
    private String encrypt;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getEncrypt() {
        return encrypt;
    }

    public void setEncrypt(String encrypt) {
        this.encrypt = encrypt;
    }
    
}
