package org.thorn.workflow.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.dao.IFlowMindsDao;
import org.thorn.workflow.entity.ActivityMind;

/**
 * @ClassName: FlowMindsServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-7-20 下午03:32:47
 */
public class FlowMindsServiceImpl implements IFlowMindsService {

	@Autowired
	@Qualifier("flowMindsDao")
	private IFlowMindsDao flowMindsDao;

	public void save(ActivityMind mind) throws DBAccessException {
		flowMindsDao.save(mind);
	}

	public List<ActivityMind> queryByInst(String flowInstId)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("flowInstId", flowInstId);

		return flowMindsDao.queryList(filter);
	}

}
