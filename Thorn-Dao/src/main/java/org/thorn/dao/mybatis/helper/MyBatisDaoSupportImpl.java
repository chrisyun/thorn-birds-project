package org.thorn.dao.mybatis.helper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.mybatis.annotation.MapperUtils;
import org.thorn.dao.mybatis.annotation.MethodType;

public class MyBatisDaoSupportImpl implements MyBatisDaoSupport {

	static Logger log = LoggerFactory.getLogger(MyBatisDaoSupportImpl.class);

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public int save(Object obj) throws DBAccessException {
		String mapper = "";

		try {
			mapper = MapperUtils.getMapperSource(obj.getClass(),
					MethodType.INSERT);
			return sqlSessionTemplate.insert(mapper, obj);
		} catch (Exception e) {
			throw new DBAccessException("MyBatisDaoSupport", "save", "Object["
					+ obj.getClass().getName() + "],mapper[" + mapper + "]", e);
		}
	}

	public int modify(Object obj) throws DBAccessException {
		String mapper = "";

		try {
			mapper = MapperUtils.getMapperSource(obj.getClass(),
					MethodType.UPDATE);
			return sqlSessionTemplate.update(mapper, obj);
		} catch (Exception e) {
			throw new DBAccessException("MyBatisDaoSupport", "modify",
					"Object[" + obj.getClass().getName() + "],mapper[" + mapper
							+ "]", e);
		}
	}

	public int delete(Object obj) throws DBAccessException {
		String mapper = "";

		try {
			mapper = MapperUtils.getMapperSource(obj.getClass(),
					MethodType.DELETE);
			return sqlSessionTemplate.delete(mapper, obj);
		} catch (Exception e) {
			throw new DBAccessException("MyBatisDaoSupport", "delete",
					"Object[" + obj.getClass().getName() + "],mapper[" + mapper
							+ "]", e);
		}
	}

	public void query(Object obj) throws DBAccessException {
		String mapper = "";

		try {
			mapper = MapperUtils.getMapperSource(obj.getClass(),
					MethodType.QUERY);
			obj = sqlSessionTemplate.selectOne(mapper, obj);
		} catch (Exception e) {
			throw new DBAccessException("MyBatisDaoSupport", "query", "Object["
					+ obj.getClass().getName() + "],mapper[" + mapper + "]", e);
		}
	}

	public int deleteForBatch(List<String> ids, Class bean)
			throws DBAccessException {
		String mapper = "";

		try {
			mapper = MapperUtils.getMapperSource(bean, MethodType.DELETE_BATCH);
			return sqlSessionTemplate.delete(mapper, ids);
		} catch (Exception e) {
			throw new DBAccessException("MyBatisDaoSupport", "deleteForBatch",
					"Object[" + bean.getName() + "],mapper[" + mapper + "]", e);
		}
	}

	public <T> Page<T> queryForPage(Map<String, Object> filter, Class<T> bean)
			throws DBAccessException {
		String pageMapper = "";
		String pageCountMapper = "";

		try {
			pageMapper = MapperUtils.getMapperSource(bean,
					MethodType.QUERY_PAGE);
			pageCountMapper = MapperUtils.getMapperSource(bean,
					MethodType.COUNT_PAGE);

			Page<T> page = new Page<T>();

			page.setTotal((Long) sqlSessionTemplate.selectOne(pageCountMapper,
					filter));

			if (page.getTotal() > 0) {
				page.setReslutSet((List<T>) sqlSessionTemplate.selectList(
						pageMapper, filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("MyBatisDaoSupport", "queryForPage",
					"Object[" + bean.getName() + "],mapper[" + pageMapper
							+ "],countMapper[" + pageCountMapper + "]", e);
		}
	}

	public <T> List<T> queryForList(Map<String, Object> filter, Class<T> bean)
			throws DBAccessException {
		String mapper = "";

		try {
			mapper = MapperUtils.getMapperSource(bean, MethodType.QUERY_LIST);
			return (List<T>) sqlSessionTemplate.selectList(mapper, filter);
		} catch (Exception e) {
			throw new DBAccessException("MyBatisDaoSupport", "queryForList",
					"Object[" + bean.getName() + "],mapper[" + mapper + "]", e);
		}
	}

}
