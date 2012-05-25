package org.cy.thorn.user.dao;

import java.util.List;

import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.user.entity.User;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.util.Assert;

/**
 * <p>文件名称: UserDAOImpl.java</p>
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
public class UserDAOImpl implements IUserDAO {
	
	private SqlSessionTemplate sqlSessionTemplate;
	
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	public void deleteUser(List<String> uids) throws DBAccessException {
		Assert.notEmpty(uids);
		
		try {
			sqlSessionTemplate.delete("UserMapper.deleteByPKs", uids);
		} catch (Exception e) {
			String exceptMsg = "excute to delete user data exception";
			throw new DBAccessException(exceptMsg,e);
		}

	}

	public void insertUser(User user) throws DBAccessException {
		Assert.notNull(user);
		
		try {
			sqlSessionTemplate.insert("UserMapper.insert", user);
		} catch (Exception e) {
			String exceptMsg = "excute to insert org data exception,org:"+user.toString();
			throw new DBAccessException(exceptMsg,e);
		}
	}

	public User searchByPK(String uid) throws DBAccessException {
		Assert.hasText(uid);
		
		User user = null;
		
		try {
			user = (User) sqlSessionTemplate.selectOne("UserMapper.selectByPK", uid);
		} catch (Exception e) {
			String exceptMsg = "excute to select user data exception,uid:"+uid;
			throw new DBAccessException(exceptMsg,e);
		}
		
		return user;
	}

	public void updateUser(User user) throws DBAccessException {
		Assert.notNull(user);
		
		try {
			sqlSessionTemplate.insert("UserMapper.update", user);
		} catch (Exception e) {
			String exceptMsg = "excute to update user data exception,user:"+user.toString();
			throw new DBAccessException(exceptMsg,e);
		}
	}
	
	public User searchByAccount(String account) throws DBAccessException {
		Assert.hasText(account);
		
		User user = null;
		
		try {
			user = (User) sqlSessionTemplate.selectOne("UserMapper.selectByAccount", account);
		} catch (Exception e) {
			String exceptMsg = "excute to select user data exception,account:"+account;
			throw new DBAccessException(exceptMsg,e);
		}
		
		return user;
	}

}

