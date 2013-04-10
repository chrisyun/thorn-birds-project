package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.PageAuth;

/**
 * @ClassName: PageAuthDaoImpl
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:43:07
 */
public class PageAuthDaoImpl implements IPageAuthDao {

	private final static String nameSpace = "PageAuthMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public int save(PageAuth auth) throws DBAccessException {
		try {
			return sqlSessionTemplate
					.insert(nameSpace + "insert", auth);
		} catch (Exception e) {
			throw new DBAccessException("PageAuthDaoImpl", "save", e);
		}
	}

	public int modify(PageAuth auth) throws DBAccessException {
		try {
			return sqlSessionTemplate
					.update(nameSpace + "update", auth);
		} catch (Exception e) {
			throw new DBAccessException("PageAuthDaoImpl", "modify", e);
		}
	}

	public int delete(List<String> ids) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "delete", ids);
		} catch (Exception e) {
			throw new DBAccessException("PageAuthDaoImpl", "delete", e);
		}
	}

	public long queryPageCount(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageCount", filter);
		} catch (Exception e) {
			throw new DBAccessException("PageAuthDaoImpl",
					"queryPageCount", e);
		}
	}

	public List<PageAuth> queryList(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<PageAuth>) sqlSessionTemplate.selectList(nameSpace
					+ "selectPage", filter);
		} catch (Exception e) {
			throw new DBAccessException("PageAuthDaoImpl", "queryList", e);
		}
	}

}
