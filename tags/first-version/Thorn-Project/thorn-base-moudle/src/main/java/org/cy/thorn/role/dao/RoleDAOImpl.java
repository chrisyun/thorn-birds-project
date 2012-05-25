package org.cy.thorn.role.dao;

import java.util.ArrayList;
import java.util.List;

import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.role.entity.Authority;
import org.cy.thorn.role.entity.UserRole;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.util.Assert;

/**
 * <p>文件名称: RoleDAOImpl.java</p>
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
public class RoleDAOImpl implements IRoleDAO {
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	public List<UserRole> searchRoleByUid(String uid) throws DBAccessException {
		Assert.hasText(uid);
		
		List<UserRole> ur = new ArrayList<UserRole>();
		
		try {
			ur = (List<UserRole>) sqlSessionTemplate.selectList("UserRoleMapper.selectByUser", uid);
		} catch (Exception e) {
			String exceptMsg = "excute to select userrole data exception,uid:"+uid;
			throw new DBAccessException(exceptMsg,e);
		}
		
		return ur;
	}

	public List<Authority> searchRoleByResorce(String rid)
			throws DBAccessException {
		Assert.hasText(rid);
		
		List<Authority> au = new ArrayList<Authority>();
		
		try {
			au = (List<Authority>) sqlSessionTemplate.selectList("AuthorityMapper.selectByRes", rid);
		} catch (Exception e) {
			String exceptMsg = "excute to select authority data exception,rid:"+rid;
			throw new DBAccessException(exceptMsg,e);
		}
		
		return au;
	}
}

