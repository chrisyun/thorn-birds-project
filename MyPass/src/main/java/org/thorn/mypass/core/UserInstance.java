package org.thorn.mypass.core;

import org.thorn.mypass.entity.User;

public class UserInstance {
    
    private static User currentUser;
    
    private static String encrypt;

    public static User getCurrentUser() {
        return currentUser;
    }

    public static void setCurrentUser(User currentUser) {
        UserInstance.currentUser = currentUser;
    }

    public static String getEncrypt() {
        return encrypt;
    }

    public static void setEncrypt(String encrypt) {
        UserInstance.encrypt = encrypt;
    }
    
}
