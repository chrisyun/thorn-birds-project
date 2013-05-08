package org.thorn.test.excel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import junit.framework.TestCase;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.XMLConfiguration;
import org.thorn.core.excel.xml.ExcelByXmlException;
import org.thorn.core.excel.xml.ExcelByXmlUtils;

public class ExcelByXmlTest extends TestCase {
    
    public List<Student> list = new ArrayList<Student>();

    @Override
    protected void setUp() throws Exception {
        
        list.add(new Student("cy", "男", 12, new Date()));
        list.add(new Student("cy1", "男1", 13, new Date()));
        list.add(new Student("cy2", "男2", 13, new Date()));
        
        super.setUp();
    }
    
    public void testXml() {
        try {
            Configuration config = new XMLConfiguration("student.xml");
            
            Object oj = config.getProperty("title");
            
            System.out.println(config.getStringArray("title(0).header").length);
            
            
        } catch (ConfigurationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
    public void testCreatXml() {
        File excel = new File("d:\\student.xls");
        
        try {
            if(!excel.exists()) {
                excel.createNewFile();
            }
            
            OutputStream os = new FileOutputStream(excel);
            
            ExcelByXmlUtils excelUtils = new ExcelByXmlUtils("student.xml");
            
            excelUtils.outputExcel(list, os);
            
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ExcelByXmlException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
}
