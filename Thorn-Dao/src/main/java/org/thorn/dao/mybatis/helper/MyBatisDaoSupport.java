package org.thorn.dao.mybatis.helper;

import java.util.List;
import java.util.Map;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.helper.SimpleDaoSupport;

public interface MyBatisDaoSupport extends SimpleDaoSupport {

	public int deleteForBatch(List<String> ids, Class bean)
			throws DBAccessException;

	public <T> Page<T> queryForPage(Map<String, Object> filter, Class<T> bean)
			throws DBAccessException;

	public <T> List<T> queryForList(Map<String, Object> filter, Class<T> bean)
			throws DBAccessException;
	
}
