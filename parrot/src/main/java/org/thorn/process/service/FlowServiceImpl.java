package org.thorn.process.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.app.entity.ProjectCost;
import org.thorn.app.entity.ReseverCost;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.mybatis.helper.MyBatisDaoSupport;
import org.thorn.log.NoLogging;
import org.thorn.process.entity.FlowMinds;
import org.thorn.process.entity.Process;

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

	@NoLogging
	public void dealWithEngine(Process process, FlowMinds flowMinds, Object form)
			throws DBAccessException {
		// 先处理表单项
		if (process.getPid() == null) {
			myBatisDaoSupport.save(form);
		} else {
			myBatisDaoSupport.modify(form);
		}

		Integer pid = null;
		if (form instanceof ProjectCost) {
			pid = ((ProjectCost) form).getId();
		} else if (form instanceof ReseverCost) {
			pid = ((ReseverCost) form).getId();
		}
		
		// 处理流程
		process.setPid(pid);
		if (process.getId() == null) {
			myBatisDaoSupport.save(process);
		} else {
			myBatisDaoSupport.modify(process);
		}
		
		// 处理流程意见
		flowMinds.setFlowId(process.getId());
		if (flowMinds.getId() == null) {
			myBatisDaoSupport.save(flowMinds);
		} else {
			myBatisDaoSupport.modify(flowMinds);
		}

	}

}
