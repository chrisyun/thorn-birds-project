package org.thorn.cms.entity;

import java.io.Serializable;

import org.thorn.dao.mybatis.annotation.Mapper;
import org.thorn.dao.mybatis.annotation.MapperNode;
import org.thorn.dao.mybatis.annotation.MethodType;

/** 
 * @ClassName: Channel 
 * @Description: 
 * @author chenyun
 * @date 2013-2-18 下午5:17:09 
 */
@Mapper(nameSpace = "ChannelMapper", node = {
		@MapperNode(id = "insert", type = MethodType.INSERT),
		@MapperNode(id = "update", type = MethodType.UPDATE),
		@MapperNode(id = "delete", type = MethodType.DELETE_BATCH),
		@MapperNode(id = "select", type = MethodType.QUERY_LIST),
		@MapperNode(id = "count", type = MethodType.COUNT),
		@MapperNode(id = "select", type = MethodType.QUERY) })
public class Channel implements Serializable {

	/** */
	private static final long serialVersionUID = 1630673031966162039L;
	
	private Integer id;
	
	private Integer pid;
	
	private Integer siteId;
	
	private String name;
	
	private Integer channelTemplate;
	
	private Integer contentTemplate;
	
	private String title;
	
	private String description;
	
	private String tags;
	
	private String isShow;
	
	private String isDisabled;
	
	private String path;
	
	private Integer sortNum;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
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

	public Integer getChannelTemplate() {
		return channelTemplate;
	}

	public void setChannelTemplate(Integer channelTemplate) {
		this.channelTemplate = channelTemplate;
	}

	public Integer getContentTemplate() {
		return contentTemplate;
	}

	public void setContentTemplate(Integer contentTemplate) {
		this.contentTemplate = contentTemplate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String getIsDisabled() {
		return isDisabled;
	}

	public void setIsDisabled(String isDisabled) {
		this.isDisabled = isDisabled;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Integer getSortNum() {
		return sortNum;
	}

	public void setSortNum(Integer sortNum) {
		this.sortNum = sortNum;
	}
}

