package org.thorn.workflow.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.workflow.entity.FlowType;
import org.thorn.workflow.service.IFlowTypeService;

/**
 * @ClassName: CreatProcessController
 * @Description:
 * @author chenyun
 * @date 2012-6-23 下午09:54:49
 */
@Controller
public class CreatProcessController extends BaseController {

	static Logger log = LoggerFactory.getLogger(CreatProcessController.class);

	@Autowired
	@Qualifier("flowTypeService")
	private IFlowTypeService flowTypeService;

	@RequestMapping("/wf/cr/getCreatProcessList")
	@ResponseBody
	public Page<FlowType> getCreatProcessList(String type) {
		Page<FlowType> page = new Page<FlowType>();

		try {
			List<FlowType> list = flowTypeService.queryByType(type);
			page.setReslutSet(list);
			page.setTotal(list.size());
		} catch (DBAccessException e) {
			log.error("getCreatProcessList[FlowType] - " + e.getMessage(), e);
		}

		return page;
	}

	@RequestMapping("/wf/cr/modifyFlowType")
	@ResponseBody
	public Status modifyFlowType(FlowType type) {
		Status status = new Status();

		try {
			flowTypeService.saveOrModifyFlowType(type);
			status.setMessage("修改流程类型成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("modifyFlowType[FlowType] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/wf/cr/deleteFlowType")
	@ResponseBody
	public Status deleteFlowType(String ids) {
		Status status = new Status();

		try {
			flowTypeService.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteFlowType[FlowType] - " + e.getMessage(), e);
		}

		return status;
	}

}
