package org.thorn.process.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.mybatis.helper.MyBatisDaoSupport;
import org.thorn.process.entity.FlowMinds;

/** 
 * @ClassName: FlowServiceImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-8-10 下午05:18:47 
 */
public class FlowServiceImpl implements IFlowService {
	
	@Autowired
	@Qualifier("myBatisDaoSupport")
	private MyBatisDaoSupport myBatisDaoSupport;
	
	public List<FlowMinds> queryFlowMinds(Integer flowId)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("flowId", flowId);
		
		return myBatisDaoSupport.queryList(filter, FlowMinds.class);
		
	}

}

