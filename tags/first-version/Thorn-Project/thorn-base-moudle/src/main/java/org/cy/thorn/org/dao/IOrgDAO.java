package org.cy.thorn.org.dao;

import java.util.List;
import java.util.Map;

import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.org.entity.Org;

/**
 * <p>文件名称: IOrgDAO.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-10-19</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public interface IOrgDAO {
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-19
	 * @Description：组织新增
	 * @param org
	 * @throws DBAccessException
	 */
	public void insertOrg(Org org) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-19
	 * @Description：组织修改
	 * @param org
	 * @throws DBAccessException
	 */
	public void updateOrg(Org org) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-19
	 * @Description：组织批量删除
	 * @param oids
	 * @throws DBAccessException
	 */
	public void deleteOrg(List<String> oids) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-19
	 * @Description：根据主键查找组织
	 * @param oid
	 * @return
	 * @throws DBAccessException
	 */
	public Org searchByPK(String oid) throws DBAccessException;
	
}

