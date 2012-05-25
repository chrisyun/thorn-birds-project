package org.cy.thorn.dd.dao;

import java.util.List;
import java.util.Map;

import org.cy.thorn.core.entity.JSONSetResponse;
import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.dd.entity.Dict;
import org.cy.thorn.dd.entity.DictType;

/**
 * <p>文件名称: IDataDictDao.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-10-18</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public interface IDataDictDAO {
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-8
	 * @Description：分页查询字典类型
	 * @param filter
	 * @return
	 */
	public JSONSetResponse<DictType> searchDtPage(Map<String, Object> filter);
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-18
	 * @Description：新增数据字典类型
	 * @param dictType
	 * @throws DBAccessException
	 */
	public void insertDtType(DictType dictType) throws DBAccessException;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-18
	 * @Description：更新数据字典类型
	 * @param dictType
	 * @throws DBAccessException
	 */
	public void updateDtType(DictType dictType) throws DBAccessException;
	
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-18
	 * @Description：根据字典类型ID删除字典类型及字典数据项
	 * @param ids	  字典类型ID集合
	 * @throws DBAccessException
	 */
	public void deleteByTypeId(List<String> ids) throws DBAccessException;
	
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-24
	 * @Description：查询数据字典
	 * @param filter
	 * @return
	 */
	public JSONSetResponse<Dict> searchDdList(String typeid);
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-18
	 * @Description：新增数据字典项
	 * @param dict
	 * @throws DBAccessException
	 */
	public void insertDd(Dict dict) throws DBAccessException; 
	
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-18
	 * @Description：更新数据字典项
	 * @param dict
	 * @throws DBAccessException
	 */
	public void updateDd(Dict dict) throws DBAccessException;
	
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-24
	 * @Description：根据字典数据ID删除字典数据项
	 * @param ids
	 * @param typeid
	 * @throws DBAccessException
	 */
	public void deleteDd(List<String> ids, String typeid) throws DBAccessException;
}

