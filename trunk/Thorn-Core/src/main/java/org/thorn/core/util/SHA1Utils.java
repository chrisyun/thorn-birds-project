package org.thorn.core.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SHA1Utils {
    
    public static String encodeBySalt(String str, String salt) throws NoSuchAlgorithmException,
            UnsupportedEncodingException {
        MessageDigest md5 = MessageDigest.getInstance("SHA-1");
        md5.update(salt.getBytes("utf-8"));
        md5.update(str.getBytes("utf-8"));
        byte[] digesta = md5.digest();
        return ByteArrayUtils.encode(digesta);
    }

    public static byte[] encode(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        MessageDigest md5 = MessageDigest.getInstance("SHA-1");
        md5.update(str.getBytes("utf-8"));
        byte[] digesta = md5.digest();

        return digesta;
    }

    public static String encodeByString(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        return ByteArrayUtils.encode(encode(str));
    }

    public static String encodeByStringOf16(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        return ByteArrayUtils.encodeOf16Band(encode(str));
    }

    public static String encodeByBASE64(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        return ByteArrayUtils.encodeOfBASE64(encode(str));
    }
}
