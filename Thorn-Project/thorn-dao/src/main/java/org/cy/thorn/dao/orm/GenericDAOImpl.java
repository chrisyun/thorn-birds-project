package org.cy.thorn.dao.orm;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.cy.thorn.core.entity.JSONPageRequest;
import org.cy.thorn.core.entity.JSONRequest;
import org.cy.thorn.core.entity.JSONSetResponse;
import org.cy.thorn.core.entity.Status;
import org.cy.thorn.core.exceptions.DBAccessException;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.util.Assert;

/**
 * <p>文件名称: GenericDAOImpl.java</p>
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
public class GenericDAOImpl implements IGenericDAO {
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}
	
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	public void insert(String sqlStatement, Object[] objs)
			throws DBAccessException {
		Assert.notEmpty(objs, "the input is empty");
		
		try {
			for (Object obj : objs) {
				getSqlSessionTemplate().insert(sqlStatement, obj);
			}
		} catch (Exception e) {
			String exceptMsg = "excute " + sqlStatement + 
				" to insert data exception, condition[" + objs + "]";
			throw new DBAccessException(exceptMsg,e);
		}
	}
	
	public void update(String sqlStatement, Object[] objs)
			throws DBAccessException {
		Assert.notEmpty(objs, "the input is empty");
		
		try {
			for (Object obj : objs) {
				getSqlSessionTemplate().update(sqlStatement, obj);
			}
		} catch (Exception e) {
			String exceptMsg = "excute " + sqlStatement + 
				" to update data exception, condition[" + objs + "]";
			throw new DBAccessException(exceptMsg,e);
		}
	}
	
	public void delete(String sqlStatement, Object condition)
			throws DBAccessException {
		Assert.notNull(condition, "the input is null");
		try {
			getSqlSessionTemplate().delete(sqlStatement, condition);
		} catch (Exception e) {
			String exceptMsg = "excute " + sqlStatement + 
				" to delete data exception, condition[" + condition + "]";
			throw new DBAccessException(exceptMsg,e);
		}
	}

	public Object searchObj(String sqlStatement, Object condition)
			throws DBAccessException {
		Object obj = null;
		try {
			obj = getSqlSessionTemplate().selectOne(sqlStatement, condition);
		} catch (Exception e) {
			String exceptMsg = "excute " + sqlStatement + 
				" to select one data exception, condition[" + condition + "]";
			throw new DBAccessException(exceptMsg,e);
		}
		return obj;
	}

	public <T> JSONSetResponse<T> searchList(String sqlStatement, 
			Map<String, Object> filter) {
		JSONSetResponse<T> resultSet = new JSONSetResponse<T>();
		
		try {
			resultSet.setResultSet(
					(List<T>) getSqlSessionTemplate().selectList(sqlStatement, filter));
			resultSet.setTotalCount(resultSet.getResultSet().size());
		} catch (Exception e) {
			String msg = "search " + sqlStatement + " list happens exception:" + e.getMessage();
			resultSet.setSuccess(false);
			resultSet.setMessage(msg);
		}
		
		return resultSet;
	}

	public <T> JSONSetResponse<T> searchPage(String sqlStatement,
			Map<String, Object> filter){
		JSONSetResponse<T> resultSet = new JSONSetResponse<T>();
		
		try {
			resultSet.setTotalCount(
					searchCount(sqlStatement+"Count", filter));
			if(resultSet.getTotalCount() > 0) {
				resultSet.setResultSet(
						(List<T>) getSqlSessionTemplate().selectList(sqlStatement, filter));
			}
		} catch (Exception e) {
			String msg = "search " + sqlStatement + " page happens exception:" + e.getMessage();
			resultSet.setSuccess(false);
			resultSet.setMessage(msg);
		}
		
		return resultSet;
	}

	public long searchCount(String sqlStatement, Object condition)
			throws DBAccessException {
		return (Long) this.searchObj(sqlStatement, condition);
	}

}

