package org.thorn.core.util;

import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class AESUtils {

    private final static String AES = "AES";

    private final static String STRING_ENCODE = "utf-8";

    public static String encrypt(String content, String password) throws Exception {
        KeyGenerator keyGenerator = KeyGenerator.getInstance(AES);
        keyGenerator.init(128, new SecureRandom(password.getBytes()));
        SecretKey secretKey = keyGenerator.generateKey();
        
        byte[] enCodeFormat = secretKey.getEncoded();
        SecretKeySpec key = new SecretKeySpec(enCodeFormat, AES);
        Cipher cipher = Cipher.getInstance(AES);
        byte[] byteContent = content.getBytes(STRING_ENCODE);
        cipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] result = cipher.doFinal(byteContent);
        return ByteArrayUtils.encodeOfBASE64(result); 
    }

    public static String decrypt(String content, String password) throws Exception {
        byte[] digest = ByteArrayUtils.decodeOfBASE64(content);
        
        KeyGenerator keyGenerator = KeyGenerator.getInstance(AES);
        keyGenerator.init(128, new SecureRandom(password.getBytes()));
        SecretKey secretKey = keyGenerator.generateKey();
        
        byte[] enCodeFormat = secretKey.getEncoded();
        SecretKeySpec key = new SecretKeySpec(enCodeFormat, AES);
        Cipher cipher = Cipher.getInstance(AES);
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] result = cipher.doFinal(digest);
        
        return new String(result, STRING_ENCODE);
    }

}
