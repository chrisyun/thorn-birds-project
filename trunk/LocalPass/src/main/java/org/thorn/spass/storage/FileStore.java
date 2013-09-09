package org.thorn.spass.storage;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.stereotype.Service;
import org.thorn.core.excel.ArrayAdapter;

import java.io.*;
import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-8-28 上午10:10
 * @Version: 1.0
 */
@Service
public class FileStore {

    private static String CHARSET_CODE = "UTF-8";

    public void write(String fileName, String content) throws IOException {
        File file = new File(fileName);
        File folder = new File(file.getParent());

        if (!folder.exists()) {
            folder.mkdirs();
        }

        if (!file.exists()) {
            file.createNewFile();
        }

        OutputStream output = null;
        try {
            byte[] bytes = content.getBytes(CHARSET_CODE);

            output = new FileOutputStream(file);
            output.write(bytes);
            output.flush();

        } finally {
            output.close();
        }
    }

    public String read(String fileName) throws IOException {
        File file = new File(fileName);

        if (!file.exists()) {
            throw new IOException(fileName + " not exists!");
        }

        byte[] bytes = new byte[1024];
        StringBuilder content = new StringBuilder();
        InputStream input = null;

        try {
            input = new FileInputStream(file);
            while (input.read(bytes) != -1) {
                content.append(new String(bytes, CHARSET_CODE));
            }
        } finally {
            input.close();
        }

        return content.toString();
    }
}
