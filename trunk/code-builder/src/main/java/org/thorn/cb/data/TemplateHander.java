package org.thorn.cb.data;

import java.io.File;
import java.io.IOException;

import freemarker.template.Configuration;

public class TemplateHander {
	
	private Configuration cf = new Configuration();
	
	public TemplateHander(String dir) throws IOException {
		
		File tempFolder = new File(new File("/").getAbsoluteFile() + dir);
		
		if(tempFolder.exists()) {
			System.out.println("目录存在：" + tempFolder.getAbsolutePath());
		}
		
		cf.setDirectoryForTemplateLoading(tempFolder);
		cf.setDefaultEncoding("UTF-8");
	}
	
}
