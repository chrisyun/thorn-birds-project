package org.cy.thorn.core.entity;

import java.io.Serializable;

/**
 * <p>文件名称: JSONResponse.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-11-4</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class JSONResponse implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5244025339496642219L;

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
		int i = message.indexOf("\n");
		int j = message.indexOf("\n", i+1);
		
		if(j > 0) {
			message = message.substring(0, j);
		}
		
		message = message.replaceAll("\n", " ");
		message = message.replaceAll("\r", " ");
		message = message.replaceAll("'", "‘");
		message = message.replaceAll("\"", "”");
		this.message = message;
	}
}

