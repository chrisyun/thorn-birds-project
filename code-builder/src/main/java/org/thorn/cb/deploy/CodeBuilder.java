package org.thorn.cb.deploy;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.thorn.cb.dao.DBOperater;
import org.thorn.cb.data.DataConverter;
import org.thorn.cb.data.Field;
import org.thorn.cb.data.Template;
import org.thorn.cb.data.TemplateData;
import org.thorn.cb.data.TemplateHandler;
import org.thorn.cb.xml.BuildXmlContext;
import org.thorn.cb.xml.Builder;

public class CodeBuilder {

	static Logger log = LoggerFactory.getLogger(CodeBuilder.class);

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"applicationContext.xml");

		Builder xml = BuildXmlContext.getXmlInformation();

		DBOperater operater = context.getBean(DBOperater.class);

		boolean isTableExist = operater.isTableExist(xml.getTable().getTable());

		if (!xml.getTable().getOverride() && isTableExist) {
			log.warn("Table ? exist, please confirm.", xml.getTable()
					.getTable());
			return;
		}

		try {
			if (isTableExist) {
				operater.dropTable(xml.getTable().getTable());
			}

			operater.executeSql(xml.getTable().getSql());

			Set<Field> set = operater.queryDBField(xml.getTable().getTable());

			TemplateData data = DataConverter.convert(xml, set);

			TemplateHandler handler = context.getBean(TemplateHandler.class);

			List<Template> list = new ArrayList<Template>();

			handler.listFile(handler.getTempFolder(), list);
			
			//生成的文件的根文件夹
			File destRoot = new File(xml.getOutput(), xml.getPkg().replaceAll(".", "/"));
			
			if(!destRoot.exists()) {
				destRoot.mkdirs();
			}
			
			
			for (Template file : list) {
				log.debug("load template file: {}", file.getFolder() + "|"
						+ file.getName() + "|" + file.getType());
				
				String fileName = data.getNameFirLetterUc() + file.getName() + "." + file.getType();
				
				File folder = new File(destRoot, file.getFolder());
				if(!folder.exists()) {
					folder.mkdirs();
				}
				
				File destFile = new File(folder, fileName);
				destFile.createNewFile();
				
				handler.applyTemplate(data, file, destFile);
				
				log.debug("apply this Template finish.");
			}
			
			log.info("Good job! done.");

		} catch (Exception e) {
			log.error("build failure! please check and try again!\n", e);
		}

	}

}
