package org.cy.thorn.core.exceptions;
/**
 * <p>文件名称: DBAccessException.java</p>
 * <p>文件描述: 数据库访问异常</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-9-28</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class DBAccessException extends Exception {
	
	public DBAccessException() {
		super();
	}
	
	public DBAccessException(String msg) {
		super(msg);
	}
	
	public DBAccessException(Throwable cause) {
		super(cause);
	}
	
	public DBAccessException(String msg, Throwable cause) {
		super(cause);
	}
	
	
}

