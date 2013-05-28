package org.thorn.core.util;

import java.io.IOException;

public class ByteArrayUtils {

    private static char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            'a', 'b', 'c', 'd', 'e', 'f' };

    public static String encodeOfBASE64(byte[] b) {
        return Base64Utils.encode(b);
    }

    public static byte[] decodeOfBASE64(String str) throws IOException {
        return Base64Utils.decode(str);
    }

    public static String encode(byte[] b) {
        StringBuilder buff = new StringBuilder();
        for (int i = 0; i < b.length; i++) {
            buff.append(b[i]);
        }
        return buff.toString();
    }

    public static String encodeOf16Band(byte[] b) {
        char str[] = new char[b.length * 2];
        int k = 0;
        for (int i = 0; i < b.length; i++) {
            byte byte0 = b[i];
            str[k++] = hexDigits[byte0 >>> 4 & 0xf];
            str[k++] = hexDigits[byte0 & 0xf];
        }
        return new String(str);
    }
}
