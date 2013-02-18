package org.thorn.user.entity;

import java.io.Serializable;

import org.thorn.dao.mybatis.annotation.Mapper;
import org.thorn.dao.mybatis.annotation.MapperNode;
import org.thorn.dao.mybatis.annotation.MethodType;

/** 
 * @ClassName: FindBackEntry 
 * @Description: 
 * @author chenyun
 * @date 2013-2-16 下午5:50:48 
 */
@Mapper(nameSpace="FindBackMapper",node= {
		@MapperNode(id="insert",type=MethodType.INSERT),
		@MapperNode(id="update",type=MethodType.UPDATE),
		@MapperNode(id="select",type=MethodType.QUERY)
})
public class FindBackEntry implements Serializable {

	/** */
	private static final long serialVersionUID = 6886333864989485915L;
	
	private Integer id;
	
	private String userId;
	
	private String captcha;
	
	private String used;
	
	private String startTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCaptcha() {
		return captcha;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

	public String getUsed() {
		return used;
	}

	public void setUsed(String used) {
		this.used = used;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
}

