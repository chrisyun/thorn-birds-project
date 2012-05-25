package org.cy.thorn.dd.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.cy.thorn.core.entity.JSONPageRequest;
import org.cy.thorn.core.entity.JSONSetResponse;
import org.cy.thorn.core.entity.Status;
import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.core.util.CacheUtil;
import org.cy.thorn.dao.orm.GenericDAOImpl;
import org.cy.thorn.dd.entity.Dict;
import org.cy.thorn.dd.entity.DictType;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.util.Assert;

/**
 * <p>文件名称: DataDictDAOImpl.java</p>
 * <p>文件描述: 数据字典的数据库操作</p>
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
public class DataDictDAOImpl extends GenericDAOImpl implements IDataDictDAO {
	
	static Log log = LogFactory.getLog(DataDictDAOImpl.class);
	
	private static final String DICT_LIST_SUFFIX = ".dictList";
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	public JSONSetResponse<DictType> searchDtPage(Map<String, Object> filter) {
		return this.searchPage("DictTypeMapper.selectPage", filter);
	}
	
	public void insertDtType(DictType dictType) throws DBAccessException {
		this.insert("DictTypeMapper.insert", new Object[]{dictType});
	}
	
	public void updateDtType(DictType dictType) throws DBAccessException {
		this.update("DictTypeMapper.update", new Object[]{dictType});
	}
	
	public void deleteByTypeId(List<String> ids) throws DBAccessException {
		this.delete("DictTypeMapper.deleteByPKs", ids);
		this.delete("DictMapper.deleteByTypeIds", ids);
		
		for(String id : ids) {
			CacheUtil.deleteObject(id + DICT_LIST_SUFFIX);
		}
	}
	
	public JSONSetResponse<Dict> searchDdList(String typeid) {
		JSONSetResponse<Dict> jr = (JSONSetResponse<Dict>) CacheUtil.getObject(typeid + DICT_LIST_SUFFIX);

		if(jr == null) {
			Map<String, Object> filter = new HashMap<String, Object>();
			filter.put("typeid", typeid);
			jr = this.searchList("DictMapper.select", filter);
			CacheUtil.updateObject(typeid + DICT_LIST_SUFFIX, jr);
		}
		
		return jr;
	}
	
	public void insertDd(Dict dict) throws DBAccessException {
		this.insert("DictMapper.insert", new Object[]{dict});
		CacheUtil.deleteObject(dict.getTypeid() + DICT_LIST_SUFFIX);
	}
	
	public void updateDd(Dict dict) throws DBAccessException {
		this.insert("DictMapper.update", new Object[]{dict});
		CacheUtil.deleteObject(dict.getTypeid() + DICT_LIST_SUFFIX);
	}
	
	
	public void deleteDd(List<String> ids, String typeid) throws DBAccessException {
		this.delete("DictMapper.deleteByPKs", ids);
		CacheUtil.deleteObject(typeid + DICT_LIST_SUFFIX);
	}
}

