package org.thorn.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import junit.framework.TestCase;

/** 
 * @ClassName: FileTest 
 * @Description: 
 * @author chenyun
 * @date 2012-6-8 上午10:40:08 
 */
public class FileTest extends TestCase {
	
	public void testCreat() throws IOException {
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String date = df.format(new Date());
		
		StringBuilder path = new StringBuilder("d:\\");
		path.append(File.separator).append(date);
		path.append(File.separator).append("ADMIN").append(File.separator);
		
		File dir = new File(path.toString());
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		String[] name = null;
		
		if("a.txt".indexOf(".") > 0) {
			name = "a.txt".split("\\.");
			name[1] = "." + name[1];
		} else {
			name = new String[]{"a",""};
		}
		
		
		
		String fileName = path.toString() + "a.txt";
		
		File file = new File(fileName);
		
		int i = 1;
		while(file.exists()) {
			fileName = path.toString() + name[0] + "_" + i + name[1];
			
			file = new File(fileName);
			i++;
		}
		
		file.createNewFile();

		
		OutputStream os = new FileOutputStream(file);
		
		String a = "gggggggggggggggggggggggggggggggggggggggg";
		
		os.write(a.getBytes());
		os.flush();
		os.close();
		
	}
	
}

