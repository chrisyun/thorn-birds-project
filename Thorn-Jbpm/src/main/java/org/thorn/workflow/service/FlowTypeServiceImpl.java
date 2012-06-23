package org.thorn.workflow.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.dao.IFlowTypeDao;
import org.thorn.workflow.entity.FlowType;

/** 
 * @ClassName: FlowTypeServiceImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-6-23 下午09:32:36 
 */
public class FlowTypeServiceImpl implements IFlowTypeService {
	
	@Autowired
	@Qualifier("flowTypeDao")
	private IFlowTypeDao flowTypeDao;
	
	public void saveOrModifyFlowType(FlowType flow) throws DBAccessException {
		int num = flowTypeDao.modify(flow);
		
		if(num == 0 && flow.getId() == null) {
			flowTypeDao.save(flow);
		}
	}

	public void delete(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		
		flowTypeDao.delete(list);
	}

	public List<FlowType> queryByType(String type) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		
		filter.put("flowType", type);
		
		return flowTypeDao.queryList(filter);
	}

}

