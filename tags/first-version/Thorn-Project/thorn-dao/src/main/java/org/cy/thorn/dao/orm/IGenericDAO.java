package org.cy.thorn.dao.orm;

import java.util.Map;

import org.cy.thorn.core.entity.JSONPageRequest;
import org.cy.thorn.core.entity.JSONRequest;
import org.cy.thorn.core.entity.JSONSetResponse;
import org.cy.thorn.core.exceptions.DBAccessException;

/**
 * <p>文件名称: IGenericDAO.java</p>
 * <p>文件描述: 通用DAO接口，可满足一般数据库操作需求</p>
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
public interface IGenericDAO {
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：批量新增数据
	 * @param sqlStatement sql实例
	 * @param objs	需要插入的对象数组
	 * @throws DBAccessException
	 */
	public void insert(String sqlStatement, Object[] objs) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：批量更新数据
	 * @param sqlStatement	sql实例
	 * @param objs	需要更新的对象数组
	 * @throws DBAccessException
	 */
	public void update(String sqlStatement, Object[] objs) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：
	 * @param sqlStatement	sql实例
	 * @param condition
	 * @throws DBAccessException
	 */
	public void delete(String sqlStatement, Object condition) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：
	 * @param sqlStatement	sql实例
	 * @param condition
	 * @return
	 * @throws DBAccessException
	 */
	public Object searchObj(String sqlStatement, Object condition) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-8
	 * @Description：
	 * @param <T>
	 * @param sqlStatement
	 * @param filter
	 * @return
	 */
	public <T> JSONSetResponse<T> searchList(String sqlStatement, 
			Map<String, Object> filter);
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-8
	 * @Description：
	 * @param <T>
	 * @param sqlStatement
	 * @param filter
	 * @return
	 */
	public <T> JSONSetResponse<T> searchPage(String sqlStatement,
			Map<String, Object> filter);
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-9-29
	 * @Description：获得最大结果集数量
	 * @param sqlStatement	sql实例
	 * @param condition
	 * @return
	 * @throws DBAccessException
	 */
	public long searchCount(String sqlStatement, Object condition) throws DBAccessException;
}

