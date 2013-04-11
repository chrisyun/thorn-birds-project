package org.thorn.cb.xml;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.core.io.Resource;

public class BuildXmlContext {
	
	private static Builder xmlInformation = new Builder();
	
	/**
	 * 初始化时解析build.xml
	 * @param resource
	 * @throws IOException
	 * @throws DocumentException
	 */
	public BuildXmlContext(Resource resource) throws IOException, DocumentException {
		File xml = resource.getFile();
		
		SAXReader saxReader = new SAXReader();
		Document doc = saxReader.read(xml);
		Element root = doc.getRootElement();
		
		xmlInformation.setName(root.element("name").getTextTrim());
		xmlInformation.setOutput(root.element("output").getTextTrim());
		xmlInformation.setPkg(root.element("package").getTextTrim());
		
		Element sql = root.element("sql");
		
		Table table = new Table();
		table.setSql(sql.getText());
		table.setTable(sql.attributeValue("tableName"));
		table.setOverride(sql.attributeValue("override"));
		
		xmlInformation.setTable(table);
		
		Element mapper = root.element("mapper");
		
		List<Element> keys = mapper.elements("id");
		
		if(keys != null) {
			for(Element key : keys) {
				
				Column column = new Column();
				
				column.setName(key.getStringValue());
				if(StringUtils.isEmpty(column.getName())) {
					column.setName(key.attributeValue("value"));
				} 
				
				column.setJavaType(key.attributeValue("type"));
				column.setProperty(key.attributeValue("property"));
				
				xmlInformation.getIds().add(column);
			}
		}
		
		List<Element> columns = mapper.elements("column");
		
		if(keys != null) {
			for(Element key : columns) {
				
				Column column = new Column();
				
				column.setName(key.getStringValue());
				if(StringUtils.isEmpty(column.getName())) {
					column.setName(key.attributeValue("value"));
				} 
				
				column.setJavaType(key.attributeValue("type"));
				column.setProperty(key.attributeValue("property"));
				
				xmlInformation.getColumns().add(column);
			}
		}
	}
	
	public static Builder getXmlInformation() {
		return xmlInformation;
	}
	
}
