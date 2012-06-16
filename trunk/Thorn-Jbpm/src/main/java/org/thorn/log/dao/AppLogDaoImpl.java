package org.thorn.log.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.log.entity.AppLog;

/** 
 * @ClassName: AppLogDaoImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-5-26 下午03:38:18 
 */
public class AppLogDaoImpl implements IAppLogDao {
	
	private final static String nameSpace = "LogMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public int save(AppLog log) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insert", log);
		} catch (Exception e) {
			throw new DBAccessException("AppLogDaoImpl", "save", e);
		}
	}

	public Page<AppLog> queryPage(Map<String, Object> filter)
			throws DBAccessException {
		Page<AppLog> page = new Page<AppLog>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<AppLog>) sqlSessionTemplate.selectList(
						nameSpace + "selectPage", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("AppLogDaoImpl", "queryPage", e);
		}
	}

	public List<AppLog> queryList(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<AppLog>) sqlSessionTemplate.selectList(
					nameSpace + "selectList", filter);
		} catch (Exception e) {
			throw new DBAccessException("AppLogDaoImpl", "queryList", e);
		}
	}

}

