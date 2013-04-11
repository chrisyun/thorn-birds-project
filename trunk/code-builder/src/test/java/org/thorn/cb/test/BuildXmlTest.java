package org.thorn.cb.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.thorn.cb.xml.BuildXmlContext;
import org.thorn.cb.xml.Builder;
import org.thorn.cb.xml.Column;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class BuildXmlTest {
	
	@Test
	public void xmlTest() {
		Builder xml = BuildXmlContext.getXmlInformation();
		
		System.out.println(
			xml.getName() + " | " + 
			xml.getOutput() + " | " + 
			xml.getPkg() + " | "
		);
		
		System.out.println(
			xml.getTable().getSql() + " | " + 
			xml.getTable().getTable() + " | " + 
			xml.getTable().getOverride() + " | "
		);
		
		System.out.println("-----------------ids--------------------");
		
		for(Column col : xml.getIds()) {
			System.out.println(
				col.getName() + " | " + 
				col.getProperty() + " | " + 
				col.getJavaType() + " | "
			);
		}
		
		System.out.println("-----------------columns--------------------");
		
		for(Column col : xml.getColumns()) {
			System.out.println(
				col.getName() + " | " + 
				col.getProperty() + " | " + 
				col.getJavaType() + " | "
			);
		}
		
	}
	
}
