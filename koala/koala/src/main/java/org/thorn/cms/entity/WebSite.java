package org.thorn.cms.entity;

import java.io.Serializable;

import org.thorn.dao.mybatis.annotation.Mapper;
import org.thorn.dao.mybatis.annotation.MapperNode;
import org.thorn.dao.mybatis.annotation.MethodType;

/**
 * @ClassName: WebSite
 * @Description:
 * @author chenyun
 * @date 2013-2-18 下午5:13:10
 */
@Mapper(nameSpace = "WebSiteMapper", node = {
		@MapperNode(id = "insert", type = MethodType.INSERT),
		@MapperNode(id = "update", type = MethodType.UPDATE),
		@MapperNode(id = "delete", type = MethodType.DELETE_BATCH),
		@MapperNode(id = "select", type = MethodType.QUERY_LIST),
		@MapperNode(id = "select", type = MethodType.QUERY) })
public class WebSite implements Serializable {

	/** */
	private static final long serialVersionUID = -3518605993757283766L;

	private Integer id;

	private String name;

	private String shortName;

	private String templateFolder;

	private String templatePrefix;

	private String path;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public String getTemplateFolder() {
		return templateFolder;
	}

	public void setTemplateFolder(String templateFolder) {
		this.templateFolder = templateFolder;
	}

	public String getTemplatePrefix() {
		return templatePrefix;
	}

	public void setTemplatePrefix(String templatePrefix) {
		this.templatePrefix = templatePrefix;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
}
