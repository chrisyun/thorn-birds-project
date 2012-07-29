package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.Entruster;

/**
 * @ClassName: IPageAuthDao
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:26:45
 */
public interface IEntrustDao {

	public int save(Entruster entruster) throws DBAccessException;

	public int modify(Entruster entruster) throws DBAccessException;

	public int delete(List<String> ids) throws DBAccessException;

	public Entruster queryOne(Map<String, Object> filter)
			throws DBAccessException;

	public List<Entruster> queryList(Map<String, Object> filter)
			throws DBAccessException;

}
