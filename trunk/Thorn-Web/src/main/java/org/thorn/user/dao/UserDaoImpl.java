package org.thorn.user.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.user.entity.User;

/**
 * @ClassName: UserDaoImpl
 * @Description:
 * @author chenyun
 * @date 2012-5-6 上午11:15:55
 */
public class UserDaoImpl implements IUserDao {

	static Logger log = LoggerFactory.getLogger(UserDaoImpl.class);

	private final static String nameSpace = "UserMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public User queryUser(Map<String, Object> filter) throws DBAccessException {
		try {
			return (User) sqlSessionTemplate.selectOne(nameSpace + "queryList",
					filter);
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "queryUser", e);
		}
	}

	public int save(User user) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insert", user);
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "save", e);
		}
	}

	public int modify(User user) throws DBAccessException {
		try {
			return sqlSessionTemplate.update(nameSpace + "update", user);
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "modify", e);
		}
	}

	public int delete(List<String> ids) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "delete", ids);
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "delete", e);
		}
	}

	public Page<User> queryPage(Map<String, Object> filter)
			throws DBAccessException {
		Page<User> page = new Page<User>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<User>) sqlSessionTemplate.selectList(
						nameSpace + "selectPage", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "queryPage", e);
		}
	}

	public int disabled(Map<String, Object> filter) throws DBAccessException {
		try {
			return sqlSessionTemplate.update(nameSpace + "disabled", filter);
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "disabled", e);
		}
	}

	public Page<User> queryPageByRole(Map<String, Object> filter)
			throws DBAccessException {
		Page<User> page = new Page<User>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageByRoleCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<User>) sqlSessionTemplate.selectList(
						nameSpace + "selectPageByRole", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "queryPageByRole", e);
		}
	}

	public int saveUserRole(Map<String, String> ur) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insertUserRole", ur);
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "saveUserRole", e);
		}
	}

	public int deleteUserRole(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "deleteUserRole", filter);
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "deleteUserRole", e);
		}
	}

	public Page<User> queryPageNotInRole(Map<String, Object> filter)
			throws DBAccessException {
		Page<User> page = new Page<User>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageNotInRoleCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<User>) sqlSessionTemplate.selectList(
						nameSpace + "selectPageNotInRole", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "queryPageNotInRole", e);
		}
	}

	public int deleteUserAllRole(String userId) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "deleteUserAllRole", userId);
		} catch (Exception e) {
			throw new DBAccessException("UserDaoImpl", "deleteUserAllRole", e);
		}
	}

}
