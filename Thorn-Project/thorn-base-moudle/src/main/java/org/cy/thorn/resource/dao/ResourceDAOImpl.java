package org.cy.thorn.resource.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.resource.entity.Resource;
import org.mybatis.spring.SqlSessionTemplate;

/**
 * <p>文件名称: ResourceDAOImpl.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-10-20</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class ResourceDAOImpl implements IResourceDAO {
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	public List<Resource> searchResource(Map<String, Object> map) throws DBAccessException {
		List<Resource> resList = new ArrayList<Resource>();
		
		try {
			resList = (List<Resource>) sqlSessionTemplate.selectList("ResourceMapper.select",map);
		} catch (Exception e) {
			String exceptMsg = "excute to select resource data exception";
			throw new DBAccessException(exceptMsg,e);
		}
		
		return resList;
	}
	
	public List<Resource> searchParent(Map<String, Object> map) throws DBAccessException {
		List<Resource> resList = new ArrayList<Resource>();
		
		try {
			resList = (List<Resource>) sqlSessionTemplate.selectList("ResourceMapper.selectByParent",map);
		} catch (Exception e) {
			String exceptMsg = "excute to select resource data exception";
			throw new DBAccessException(exceptMsg,e);
		}
		
		return resList;
	}
	
	
}

