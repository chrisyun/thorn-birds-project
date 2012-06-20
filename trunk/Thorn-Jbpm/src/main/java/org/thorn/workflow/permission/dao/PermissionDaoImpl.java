package org.thorn.workflow.permission.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.permission.entity.WfPermission;

/** 
 * @ClassName: PermissionDaoImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-6-20 下午10:43:07 
 */
public class PermissionDaoImpl implements IPermissionDao {
	
	private final static String nameSpace = "WfPermissionMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int save(WfPermission permission) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insert", permission);
		} catch (Exception e) {
			throw new DBAccessException("PermissionDaoImpl", "save", e);
		}
	}

	public int modify(WfPermission permission) throws DBAccessException {
		try {
			return sqlSessionTemplate.update(nameSpace + "update", permission);
		} catch (Exception e) {
			throw new DBAccessException("PermissionDaoImpl", "modify", e);
		}
	}

	public int delete(List<String> ids) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "delete", ids);
		} catch (Exception e) {
			throw new DBAccessException("PermissionDaoImpl", "delete", e);
		}
	}

	public Page<WfPermission> queryPage(Map<String, Object> filter)
			throws DBAccessException {
		Page<WfPermission> page = new Page<WfPermission>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<WfPermission>) sqlSessionTemplate
						.selectList(nameSpace + "selectPage", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("PermissionDaoImpl", "queryPage", e);
		}
	}

	public List<WfPermission> queryList(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<WfPermission>) sqlSessionTemplate.selectList(nameSpace
					+ "queryList", filter);
		} catch (Exception e) {
			throw new DBAccessException("PermissionDaoImpl", "queryList", e);
		}
	}

}

