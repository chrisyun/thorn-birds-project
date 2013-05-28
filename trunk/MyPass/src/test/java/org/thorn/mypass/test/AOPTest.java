package org.thorn.mypass.test;

import junit.framework.TestCase;

import org.thorn.core.context.SpringContext;
import org.thorn.core.util.AESUtils;
import org.thorn.core.util.ByteArrayUtils;
import org.thorn.core.util.MD5Utils;
import org.thorn.mypass.core.Configuration;
import org.thorn.mypass.dao.UserDAO;
import org.thorn.mypass.entity.User;

public class AOPTest extends TestCase {

    public void testUserDao() {
        
        SpringContext context = new SpringContext();
        context.setApplicationContext("applicationContext.xml");
        
        UserDAO user = context.getBean("userDAO");
        
        User userEntity = user.getUserByNameAndPassword("chenyu", "121212");
        
        
        System.out.println("-----------");
        
    }
    
    public void testPwd() {
        
        try {
            String encryptUsername = AESUtils.encrypt("1234", Configuration.CORE_PASSWORD);
            String encryptPassword = MD5Utils.encodeByBASE64("chenyun313");
            encryptPassword = MD5Utils.encodeBySalt(encryptPassword, "CHENYUN");
            
            System.out.println(encryptUsername);
            
            System.out.println(ByteArrayUtils.encodeOfBASE64("qwqwqw".getBytes()));
            
            System.out.println(encryptPassword);
            System.out.println("--------------------");
            
            
        } catch (Exception e) {
            // TODO: handle exception
        }
    }
    
    
}
