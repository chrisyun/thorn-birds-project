package org.thorn.test;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import org.thorn.core.util.AESUtils;
import org.thorn.core.util.ByteArrayUtils;
import org.thorn.core.util.MD5Utils;

import junit.framework.TestCase;

public class EncryptTest extends TestCase {

    public void testMD5() {

        try {
            System.out.println(MD5Utils.encodeByBASE64("chenyun"));
            System.out.println(MD5Utils.encodeByString("chenyun"));
            System.out.println(MD5Utils.encodeByStringOf16("chenyun"));

            System.out.println(MD5Utils.encodeByBASE64("chenyunchenyunchenyunchenyunchenyunchenyun"));
            System.out.println(MD5Utils.encodeByString("chenyunchenyunchenyunchenyunchenyunchenyun"));
            System.out.println(MD5Utils.encodeByStringOf16("chenyunchenyunchenyunchenyunchenyunchenyun"));

        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void testAES() {
        
        String password = "wqwqwqwqwqw";
        
        try {
            String mw = AESUtils.encrypt("chenyunchenyunchenyunchenyunchenyunchenyun", password);
            
            System.out.println(mw);
            
            System.out.println(AESUtils.decrypt(mw, password));
            
            
        } catch (Exception e) {
           e.printStackTrace();
        }
        
    }
    
    public void testPwd() {
        
        try {
            String encryptUsername = AESUtils.encrypt("1234", "121212121212");
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
