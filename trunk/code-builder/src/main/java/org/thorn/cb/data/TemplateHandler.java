package org.thorn.cb.data;

import java.io.File;
import java.io.FileFilter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import org.springframework.core.io.Resource;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;

public class TemplateHandler {

	private Configuration cf = new Configuration();

	private File tempFolder;

	public TemplateHandler(Resource localtion) throws IOException {

		tempFolder = localtion.getFile().getParentFile();

		cf.setDirectoryForTemplateLoading(tempFolder);
		cf.setDefaultEncoding("UTF-8");
	}

	public File getTempFolder() {
		return tempFolder;
	}

	/**
	 * 递归获取目录下的所有文件
	 * 
	 * @param dir
	 * @param list
	 */
	public void listFile(File dir, List<Template> list) {

		if (dir == null) {
			return;
		}

		File[] files = dir.listFiles(new FileFilter() {

			@Override
			public boolean accept(File pathname) {

				if (pathname.isDirectory()) {
					return true;
				}

				String name = pathname.getName();

				if (name.indexOf(".fl") > 0 && name.split("\\.").length == 3) {
					return true;
				}

				return false;
			}
		});

		for (File fl : files) {

			if (fl.isDirectory()) {
				listFile(fl, list);
			} else {
				list.add(new Template(fl, tempFolder));
			}
		}
	}

	public void applyTemplate(TemplateData data, Template template,
			File destFile) throws IOException, TemplateException {

		String tpName = template.getFolder() + File.separator
				+ template.getFile().getName();
		freemarker.template.Template tp = cf.getTemplate(tpName);
		
		tp.process(data, new FileWriter(destFile));
	}

}
