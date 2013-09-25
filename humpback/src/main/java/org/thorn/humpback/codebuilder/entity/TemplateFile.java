package org.thorn.humpback.codebuilder.entity;

import org.apache.commons.lang.StringUtils;

import java.io.File;

public class TemplateFile {
	
	private File file;
	
	private String type;
	
	private String folder;
	
	private String name;
	
	public TemplateFile(File file, File root) {
		this.file = file;
		
		String fileName = file.getName();
		String[] array = fileName.split("\\.");
		
		this.type = array[0];
		this.name = array[1];
		this.folder = StringUtils.remove(file.getParent(), root.getPath());
	}
	
	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFolder() {
		return folder;
	}

	public void setFolder(String folder) {
		this.folder = folder;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
