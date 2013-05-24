package org.thorn.mypass.test;

import junit.framework.TestCase;

import org.thorn.core.context.SpringContext;
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
    
}
