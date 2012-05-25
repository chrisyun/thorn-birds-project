package org.cy.thorn.dao.entity;
/**
 * <p>文件名称: SequenceCache.java</p>
 * <p>文件描述: 用于cache的seq对象</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-9-29</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class Sequence {
	
	private long max_seq = 0;
	
	private long cur_seq = 0;

	public long getMax_seq() {
		return max_seq;
	}

	public void setMax_seq(long max_seq) {
		this.max_seq = max_seq;
	}

	public long getCur_seq() {
		return cur_seq;
	}

	public void setCur_seq(long cur_seq) {
		this.cur_seq = cur_seq;
	}
	
}

