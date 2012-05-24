package org.thorn.role.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.entity.Role;

/**
 * @ClassName: RoleDaoImpl
 * @Description:
 * @author chenyun
 * @date 2012-5-6 上午10:51:05
 */
public class RoleDaoImpl implements IRoleDao {
	static Logger log = LoggerFactory.getLogger(RoleDaoImpl.class);

	private final static String nameSpace = "RoleMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public List<Role> queryRolesByUser(String userId) throws DBAccessException {
		try {
			return (List<Role>) sqlSessionTemplate.selectList(nameSpace
					+ "queryByUser", userId);
		} catch (Exception e) {
			throw new DBAccessException("RoleDaoImpl", "queryByUser", e);
		}
	}

	public List<Role> queryRolesByResource(List<String> source)
			throws DBAccessException {
		try {
			return (List<Role>) sqlSessionTemplate.selectList(nameSpace
					+ "queryBySource", source);
		} catch (Exception e) {
			throw new DBAccessException("RoleDaoImpl", "queryRolesByResource",
					e);
		}
	}

	public int save(Role role) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insert", role);
		} catch (Exception e) {
			throw new DBAccessException("RoleDaoImpl", "save", e);
		}
	}

	public int modify(Role role) throws DBAccessException {
		try {
			return sqlSessionTemplate.update(nameSpace + "update", role);
		} catch (Exception e) {
			throw new DBAccessException("RoleDaoImpl", "modify", e);
		}
	}

	public int delete(List<String> ids) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "delete", ids);
		} catch (Exception e) {
			throw new DBAccessException("RoleDaoImpl", "delete", e);
		}
	}

	public Page<Role> queryPage(Map<String, Object> filter)
			throws DBAccessException {
		Page<Role> page = new Page<Role>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<Role>) sqlSessionTemplate.selectList(
						nameSpace + "selectPage", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("RoleDaoImpl", "queryPage", e);
		}
	}

	public int deleteRoleSource(String roleCode) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "deleteSourceByRole",
					roleCode);
		} catch (Exception e) {
			throw new DBAccessException("RoleDaoImpl", "deleteRoleSource", e);
		}
	}

	public int saveRoleSource(Map<String, String> rs) throws DBAccessException {
		try {
			return sqlSessionTemplate
					.insert(nameSpace + "insertRoleSource", rs);
		} catch (Exception e) {
			throw new DBAccessException("RoleDaoImpl", "saveRoleSource", e);
		}
	}

	public List<Role> query(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<Role>) sqlSessionTemplate.selectList(nameSpace
					+ "select", filter);
		} catch (Exception e) {
			throw new DBAccessException("RoleDaoImpl", "query", e);
		}
	}

}
