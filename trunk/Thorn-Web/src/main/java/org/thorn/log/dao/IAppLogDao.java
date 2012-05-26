package org.thorn.log.dao;

import java.util.Map;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.log.entity.AppLog;

/**
 * @ClassName: IAppLogDao
 * @Description:
 * @author chenyun
 * @date 2012-5-26 下午03:36:52
 */
public interface IAppLogDao {

	public int save(AppLog log) throws DBAccessException;

	public Page<AppLog> queryPage(Map<String, Object> filter)
			throws DBAccessException;

}
