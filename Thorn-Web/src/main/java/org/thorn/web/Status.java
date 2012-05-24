package org.thorn.web;

import java.io.Serializable;

/** 
 * @ClassName: Status 
 * @Description: 
 * @author chenyun
 * @date 2012-5-6 下午08:08:52 
 */
public class Status implements Serializable {
	
	public static final String SUCCESS = "success";
	
	public static final String FAILURE = "failure";
	
	/** */
	private static final long serialVersionUID = 1902952901629816953L;
	
	private boolean success = true;
	
	private String message;

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}

