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

        StringBuilder content = new StringBuilder();
        InputStream input = null;
        BufferedReader reader = null;

        try {
            input = new FileInputStream(file);
            InputStreamReader streamReader = new InputStreamReader(input, CHARSET_CODE);
            reader = new BufferedReader(streamReader);
            content.append(reader.readLine());

            String str = null;
            while ((str = reader.readLine()) != null) {
                content.append("\n");
                content.append(str);
            }
        } finally {
            reader.close();
            input.close();
        }

        return content.toString();
    }
}
