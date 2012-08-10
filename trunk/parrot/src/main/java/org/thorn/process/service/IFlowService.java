package org.thorn.process.service;

import java.util.List;

import org.thorn.dao.exception.DBAccessException;
import org.thorn.process.entity.FlowMinds;

/**
 * @ClassName: IFlowService
 * @Description:
 * @author chenyun
 * @date 2012-8-10 下午05:18:25
 */
public interface IFlowService {

	public List<FlowMinds> queryFlowMinds(Integer flowId)
			throws DBAccessException;

}
