package org.thorn.cms.entity;

import java.io.Serializable;

import org.thorn.dao.mybatis.annotation.Mapper;
import org.thorn.dao.mybatis.annotation.MapperNode;
import org.thorn.dao.mybatis.annotation.MethodType;

/** 
 * @ClassName: Template 
 * @Description: 
 * @author chenyun
 * @date 2013-2-20 上午11:46:08 
 */
@Mapper(nameSpace = "TemplateMapper", node = {
		@MapperNode(id = "insert", type = MethodType.INSERT),
		@MapperNode(id = "update", type = MethodType.UPDATE),
		@MapperNode(id = "select", type = MethodType.QUERY_LIST),
		@MapperNode(id = "select", type = MethodType.QUERY) })
public class Template implements Serializable {

	/** */
	private static final long serialVersionUID = 436518866200695059L;
	
	private Integer id;
	
	private Integer siteId;
	
	private String name;
	
	private String folder;
	
	private String updater;
	
	private String updaterName;
	
	private String updateTime;
	
	private String isDisabled;
	
	private String content;
	
	private String absolutePath;
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAbsolutePath() {
		return absolutePath;
	}

	public void setAbsolutePath(String absolutePath) {
		this.absolutePath = absolutePath;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSiteId() {
		return siteId;
	}

	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFolder() {
		return folder;
	}

	public void setFolder(String folder) {
		this.folder = folder;
	}

	public String getUpdater() {
		return updater;
	}

	public void setUpdater(String updater) {
		this.updater = updater;
	}

	public String getUpdaterName() {
		return updaterName;
	}

	public void setUpdaterName(String updaterName) {
		this.updaterName = updaterName;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getIsDisabled() {
		return isDisabled;
	}

	public void setIsDisabled(String isDisabled) {
		this.isDisabled = isDisabled;
	}
	
}

