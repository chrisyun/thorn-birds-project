package org.cy.thorn.dao.incrementer;

import javax.sql.DataSource;

import org.cy.thorn.core.cache.ICacheManage;

/**
 * <p>文件名称: AbstractIncrementer.java</p>
 * <p>文件描述: 本类描述</p>
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
public abstract class AbstractIncrementer {
	
	public static final String CACHE_END_STR = "_tb_seq";
	
	private ICacheManage cache;
	
	private DataSource dataSource;
	
	private int cacheSize = 10;
	
	public ICacheManage getCache() {
		return cache;
	}

	public void setCache(ICacheManage cache) {
		this.cache = cache;
	}

	public int getCacheSize() {
		return cacheSize;
	}

	public void setCacheSize(int cacheSize) {
		this.cacheSize = cacheSize;
	}

	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：
	 * @param tableName
	 * @param columnName
	 * @return
	 * @throws Exception
	 */
	public int getNextIntKey(String tableName, String columnName) throws Exception {
		return (int) getNextLongKey(tableName, columnName);
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：
	 * @param tableName
	 * @param columnName
	 * @return
	 * @throws Exception
	 */
	public String getNextStrKey(String tableName, String columnName) throws Exception {
		return String.valueOf(getNextLongKey(tableName, columnName));
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：
	 * @param tableName
	 * @param columnName
	 * @return
	 * @throws Exception
	 */
	public abstract long getNextLongKey(String tableName, String columnName) throws Exception;
	
}

