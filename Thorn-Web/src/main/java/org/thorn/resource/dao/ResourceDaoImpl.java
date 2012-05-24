package org.thorn.resource.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.resource.entity.Resource;

/**
 * @ClassName: ResourceDaoImpl
 * @Description:
 * @author chenyun
 * @date 2012-5-6 上午10:24:53
 */
public class ResourceDaoImpl implements IResourceDao {

	static Logger log = LoggerFactory.getLogger(ResourceDaoImpl.class);

	private final static String nameSpace = "ResourceMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public List<Resource> queryByList(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<Resource>) sqlSessionTemplate.selectList(nameSpace
					+ "queryList", filter);
		} catch (Exception e) {
			throw new DBAccessException("ResourceDaoImpl", "queryList", e);
		}
	}

	public Page<Resource> queryPage(Map<String, Object> filter)
			throws DBAccessException {
		Page<Resource> page = new Page<Resource>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<Resource>) sqlSessionTemplate.selectList(
						nameSpace + "selectPage", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("ResourceDaoImpl", "queryPage", e);
		}
	}

	public int save(Resource source) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insert", source);
		} catch (Exception e) {
			throw new DBAccessException("ResourceDaoImpl", "save", e);
		}
	}

	public int modify(Resource source) throws DBAccessException {
		try {
			return sqlSessionTemplate.update(nameSpace + "update", source);
		} catch (Exception e) {
			throw new DBAccessException("ResourceDaoImpl", "modify", e);
		}
	}

	public int delete(List<String> ids) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "delete", ids);
		} catch (Exception e) {
			throw new DBAccessException("ResourceDaoImpl", "delete", e);
		}
	}

	public List<String> queryResourceByRole(String roleId)
			throws DBAccessException {
		try {
			return (List<String>) sqlSessionTemplate.selectList(nameSpace
					+ "queryByRole", roleId);
		} catch (Exception e) {
			throw new DBAccessException("ResourceDaoImpl", "queryResourceByRole", e);
		}
	}

}
