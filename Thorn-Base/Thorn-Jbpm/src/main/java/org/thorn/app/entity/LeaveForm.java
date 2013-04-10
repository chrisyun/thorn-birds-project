package org.thorn.app.entity;

import java.io.Serializable;

import org.thorn.dao.mybatis.annotation.Mapper;
import org.thorn.dao.mybatis.annotation.MapperNode;
import org.thorn.dao.mybatis.annotation.MethodType;

/** 
 * @ClassName: LeaveForm 
 * @Description: 
 * @author chenyun
 * @date 2012-7-17 下午02:45:55 
 */
@Mapper(nameSpace="LeaveMapper",node= {
		@MapperNode(id="insert",type=MethodType.INSERT),
		@MapperNode(id="update",type=MethodType.UPDATE),
		@MapperNode(id="selectPage",type=MethodType.QUERY)
})
public class LeaveForm implements Serializable {
	
	/** */
	private static final long serialVersionUID = 3458709610276221414L;

	private Integer id;
	
	private String days;
	
	private String reason;
	
	private String userId;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDays() {
		return days;
	}

	public void setDays(String days) {
		this.days = days;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
}

