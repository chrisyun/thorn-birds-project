package org.thorn.app.entity;

import java.io.Serializable;

import org.thorn.dao.mybatis.annotation.Mapper;
import org.thorn.dao.mybatis.annotation.MapperNode;
import org.thorn.dao.mybatis.annotation.MethodType;

/** 
 * @ClassName: Project 
 * @Description: 
 * @author chenyun
 * @date 2012-8-9 上午10:42:47 
 */
@Mapper(nameSpace="ProjectMapper",node= {
		@MapperNode(id="insert",type=MethodType.INSERT),
		@MapperNode(id="update",type=MethodType.UPDATE),
		@MapperNode(id="delete",type=MethodType.DELETE_BATCH),
		@MapperNode(id="selectPageCount",type=MethodType.COUNT),
		@MapperNode(id="selectPage",type=MethodType.QUERY)
})
public class Project implements Serializable {
	
	/** */
	private static final long serialVersionUID = 3292109223193923149L;

	private Integer id;
	
	private String name;

	private String code;

	private String type;
	
	private String isUnProject;
	
	private String bigNo;
	
	private String smallNo;
	
	private String batchNum;
	
	private String minority;
	
	private String area;
	
	private String userId;
	
	private String userName;
	
	private String province;

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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIsUnProject() {
		return isUnProject;
	}

	public void setIsUnProject(String isUnProject) {
		this.isUnProject = isUnProject;
	}

	public String getBigNo() {
		return bigNo;
	}

	public void setBigNo(String bigNo) {
		this.bigNo = bigNo;
	}

	public String getSmallNo() {
		return smallNo;
	}

	public void setSmallNo(String smallNo) {
		this.smallNo = smallNo;
	}

	public String getBatchNum() {
		return batchNum;
	}

	public void setBatchNum(String batchNum) {
		this.batchNum = batchNum;
	}

	public String getMinority() {
		return minority;
	}

	public void setMinority(String minority) {
		this.minority = minority;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}

