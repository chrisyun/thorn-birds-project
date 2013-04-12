package org.thorn.cb.test;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.thorn.cb.data.Template;
import org.thorn.cb.data.TemplateHandler;

import freemarker.template.TemplateException;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class TemplateTest {
	
	@Autowired
	TemplateHandler handler;
	
	@Test
	public void fileTest() {
		List<Template> list = new ArrayList<Template>();
		
		handler.listFile(handler.getTempFolder(), list);
		
		for(Template file : list) {
			System.out.println("load template file: " + file.getFolder() + "|" + file.getName() + "|" + file.getType());
			
			try {
				handler.applyTemplate(null, file, null);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (TemplateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
	}
	
	
}
