package org.thorn.org.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.org.entity.Org;

/**
 * @ClassName: IOrgDao
 * @Description:
 * @author chenyun
 * @date 2012-5-10 下午02:41:07
 */
public interface IOrgDao {

	public Page<Org> queryPage(Map<String, Object> filter)
			throws DBAccessException;

	public List<Org> queryList(Map<String, Object> filter)
			throws DBAccessException;

	public int save(Org org) throws DBAccessException;

	public int modify(Org org) throws DBAccessException;

	public int delete(List<String> ids) throws DBAccessException;
}
