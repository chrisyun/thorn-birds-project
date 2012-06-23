package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.FlowType;

/** 
 * @ClassName: IFlowTypeDao 
 * @Description: 
 * @author chenyun
 * @date 2012-6-23 下午07:04:10 
 */
public interface IFlowTypeDao {
	
	public int save(FlowType flow) throws DBAccessException;

	public int modify(FlowType flow) throws DBAccessException;

	public int delete(List<String> ids) throws DBAccessException;
	
	public List<FlowType> queryList(Map<String, Object> filter)
		throws DBAccessException;
}

