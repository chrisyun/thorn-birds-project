package org.thorn.workflow.entity;

import java.io.Serializable;

/** 
 * @ClassName: Entruster 
 * @Description: 
 * @author chenyun
 * @date 2012-7-29 上午10:00:34 
 */
public class Entruster implements Serializable {
	
	/** */
	private static final long serialVersionUID = 6262490332548285738L;

	private Integer id;
	
	private String userId;
	
	private String processDfId;
	
	private String entruster;
	
	private String entrusterName;
	
	private String beginDate;
	
	private String endDate;

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

	public String getProcessDfId() {
		return processDfId;
	}

	public void setProcessDfId(String processDfId) {
		this.processDfId = processDfId;
	}

	public String getEntruster() {
		return entruster;
	}

	public void setEntruster(String entruster) {
		this.entruster = entruster;
	}

	public String getEntrusterName() {
		return entrusterName;
	}

	public void setEntrusterName(String entrusterName) {
		this.entrusterName = entrusterName;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
}

