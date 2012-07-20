package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.ActivityMind;

/**
 * @ClassName: IFlowMindsDao
 * @Description:
 * @author chenyun
 * @date 2012-7-20 下午03:26:37
 */
public interface IFlowMindsDao {

	public int save(ActivityMind mind) throws DBAccessException;

	public List<ActivityMind> queryList(Map<String, Object> filter)
			throws DBAccessException;
}
