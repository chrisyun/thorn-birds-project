package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.PageAuth;

/**
 * @ClassName: IPageAuthDao
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:26:45
 */
public interface IPageAuthDao {

	public int save(PageAuth auth) throws DBAccessException;

	public int modify(PageAuth auth) throws DBAccessException;

	public int delete(List<String> ids) throws DBAccessException;

	public long queryPageCount(Map<String, Object> filter)
			throws DBAccessException;

	public List<PageAuth> queryList(Map<String, Object> filter)
			throws DBAccessException;

}
