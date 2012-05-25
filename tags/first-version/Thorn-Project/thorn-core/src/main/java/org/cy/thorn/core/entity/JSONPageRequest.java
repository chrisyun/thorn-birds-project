package org.cy.thorn.core.entity;
/**
 * <p>文件名称: JSONPageRequest.java</p>
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
public class JSONPageRequest extends JSONRequest {
	/**
	 * 每页大小
	 */
	private int limit;
	/**
	 * 开始页，起始页为0
	 */
	private long start;

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public long getStart() {
		return start;
	}

	public void setStart(long start) {
		this.start = start;
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-4
	 * @Description：获取当前页在所有结果集中的起始行
	 * @return
	 */
	public long generateSRowNum() {
		return this.start*this.limit + 1;
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-4
	 * @Description：获取当前页在所有结果集中的结束行
	 * @return
	 */
	public long generateERowNum() {
		return this.start*(this.limit+1);
	}
}

