package org.thorn.app.entity;

import java.io.Serializable;

/** 
 * @ClassName: CostBudget 
 * @Description: 
 * @author chenyun
 * @date 2012-8-9 上午10:44:08 
 */
public class CostBudget implements Serializable {
	
	/** */
	private static final long serialVersionUID = 8691006689017041036L;

	private Integer id;
	
	private Integer pid;
	
	private String type;
	
	private String detail;
	
	private String remark;
	
	private double money;

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public double getMoney() {
		return money;
	}

	public void setMoney(double money) {
		this.money = money;
	}
	
}

