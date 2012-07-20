package org.thorn.workflow.service;

import java.util.List;

import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.ActivityMind;

/**
 * @ClassName: IFlowMindsService
 * @Description:
 * @author chenyun
 * @date 2012-7-20 下午03:26:05
 */
public interface IFlowMindsService {

	public void save(ActivityMind mind) throws DBAccessException;

	public List<ActivityMind> queryByInst(String flowInstId)
			throws DBAccessException;

}
