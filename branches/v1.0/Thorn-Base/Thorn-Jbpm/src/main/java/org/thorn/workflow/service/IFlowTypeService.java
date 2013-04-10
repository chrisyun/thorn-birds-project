package org.thorn.workflow.service;

import java.util.List;

import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.FlowType;

/**
 * @ClassName: IFlowTypeService
 * @Description:
 * @author chenyun
 * @date 2012-6-23 下午07:08:43
 */
public interface IFlowTypeService {

	public void saveOrModifyFlowType(FlowType flow) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public List<FlowType> queryByType(String type) throws DBAccessException;

	public FlowType query(String flowKey, String flowName, String flowType)
			throws DBAccessException;
}
