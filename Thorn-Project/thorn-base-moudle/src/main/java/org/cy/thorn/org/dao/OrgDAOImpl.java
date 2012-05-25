package org.cy.thorn.org.dao;

import java.util.List;
import java.util.Map;

import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.org.entity.Org;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.util.Assert;

/**
 * <p>文件名称: OrgDAOImpl.java</p>
 * <p>文件描述: 组织类的数据库操作实现</p>
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
public class OrgDAOImpl implements IOrgDAO {
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	public void deleteOrg(List<String> oids) throws DBAccessException {
		Assert.notEmpty(oids);
		
		try {
			sqlSessionTemplate.delete("OrgMapper.deleteByPKs", oids);
		} catch (Exception e) {
			String exceptMsg = "excute to delete org data exception";
			throw new DBAccessException(exceptMsg,e);
		}
	}

	public void insertOrg(Org org) throws DBAccessException {
		Assert.notNull(org);
		
		try {
			sqlSessionTemplate.insert("OrgMapper.insert", org);
		} catch (Exception e) {
			String exceptMsg = "excute to insert org data exception,org:"+org.toString();
			throw new DBAccessException(exceptMsg,e);
		}
	}

	public Org searchByPK(String oid) throws DBAccessException {
		Assert.hasText(oid);
		
		Org org = null;
		
		try {
			org = (Org) sqlSessionTemplate.selectOne("OrgMapper.selectByPK", oid);
		} catch (Exception e) {
			String exceptMsg = "excute to select org data exception,oid:"+oid;
			throw new DBAccessException(exceptMsg,e);
		}
		
		return org;
	}
	
//	public ResultSet<Org> searchOrgByParent(String parentOid)
//			throws DBAccessException {
//		Assert.hasText(parentOid);
//		
//		ResultSet<Org> rs = new ResultSet<Org>();
//		
//		try {
//			List<Org> list = (List<Org>) sqlSessionTemplate.selectList("OrgMapper.selectByParent", parentOid);
//			rs.setResult(list);
//			rs.setCount(list.size());
//		} catch (Exception e) {
//			String exceptMsg = "excute to select orgResult data exception";
//			throw new DBAccessException(exceptMsg,e);
//		}
//		
//		return rs;
//	}
	
//	public ResultSet<Org> searchOrg(Map<String, Object> filter)
//			throws DBAccessException {
//		Assert.notEmpty(filter);
//		
//		ResultSet<Org> rs = new ResultSet<Org>();
//		
//		try {
//			List<Org> list = (List<Org>) sqlSessionTemplate.selectList("OrgMapper.select", filter);
//			rs.setResult(list);
//			rs.setCount(list.size());
//		} catch (Exception e) {
//			String exceptMsg = "excute to select orgResult data exception";
//			throw new DBAccessException(exceptMsg,e);
//		}
//		
//		return rs;
//	}

	public void updateOrg(Org org) throws DBAccessException {
		Assert.notNull(org);
		
		try {
			sqlSessionTemplate.insert("OrgMapper.update", org);
		} catch (Exception e) {
			String exceptMsg = "excute to update org data exception,org:"+org.toString();
			throw new DBAccessException(exceptMsg,e);
		}
	}

}

