package org.thorn.auth.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.entity.Role;
import org.thorn.user.entity.User;

/**
 * @ClassName: AuthDaoImpl
 * @Description:
 * @author chenyun
 * @date 2012-5-25 上午11:36:25
 */
public class AuthDaoImpl implements IAuthDao {

	private final static String nameSpace = "AuthMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public List<String> queryResourceByRole(String roleId)
			throws DBAccessException {
		try {
			return (List<String>) sqlSessionTemplate.selectList(nameSpace
					+ "querySourceByRole", roleId);
		} catch (Exception e) {
			throw new DBAccessException("AuthDaoImpl", "queryResourceByRole", e);
		}
	}

	public int deleteRoleSource(String roleCode) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "deleteSourceByRole",
					roleCode);
		} catch (Exception e) {
			throw new DBAccessException("AuthDaoImpl", "deleteRoleSource", e);
		}
	}

	public int saveRoleSource(Map<String, String> rs) throws DBAccessException {
		try {
			return sqlSessionTemplate
					.insert(nameSpace + "insertRoleSource", rs);
		} catch (Exception e) {
			throw new DBAccessException("AuthDaoImpl", "saveRoleSource", e);
		}
	}

	public List<Role> queryRoleBySource(List<String> source)
			throws DBAccessException {
		try {
			return (List<Role>) sqlSessionTemplate.selectList(nameSpace
					+ "queryRoleBySource", source);
		} catch (Exception e) {
			throw new DBAccessException("AuthDaoImpl", "queryRolesByResource",
					e);
		}
	}

	public List<Role> queryRoleByUser(String userId) throws DBAccessException {
		try {
			return (List<Role>) sqlSessionTemplate.selectList(nameSpace
					+ "queryRoleByUser", userId);
		} catch (Exception e) {
			throw new DBAccessException("AuthDaoImpl", "queryRoleByUser", e);
		}
	}

	public Page<User> queryPageByRole(Map<String, Object> filter)
			throws DBAccessException {
		Page<User> page = new Page<User>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectUserPageByRoleCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<User>) sqlSessionTemplate.selectList(
						nameSpace + "selectUserPageByRole", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("AuthDaoImpl", "queryPageByRole", e);
		}
	}

	public int saveUserRole(Map<String, String> ur) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insertUserRole", ur);
		} catch (Exception e) {
			throw new DBAccessException("AuthDaoImpl", "saveUserRole", e);
		}
	}

	public int deleteUserInRole(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "deleteUserRole",
					filter);
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "deleteUserInRole", e);
		}
	}

	public Page<User> queryPageNotInRole(Map<String, Object> filter)
			throws DBAccessException {
		Page<User> page = new Page<User>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectUserPageNotInRoleCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<User>) sqlSessionTemplate.selectList(
						nameSpace + "selectUserPageNotInRole", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("AuthDaoImpl", "queryPageNotInRole", e);
		}
	}

	public int deleteUserAllRole(String userId) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "deleteUserAllRole",
					userId);
		} catch (Exception e) {
			throw new DBAccessException("AuthDaoImpl", "deleteUserAllRole", e);
		}
	}

}
