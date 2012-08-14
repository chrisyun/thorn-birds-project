package org.thorn.process.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.process.entity.FlowMinds;
import org.thorn.process.service.IFlowService;
import org.thorn.web.controller.BaseController;

/** 
 * @ClassName: ProcessExtendController 
 * @Description: 
 * @author chenyun
 * @date 2012-8-13 下午04:22:36 
 */
@Controller
@RequestMapping("/wf/cm")
public class ProcessExtendController extends BaseController {
	
	static Logger log = LoggerFactory.getLogger(ProcessExtendController.class);
	
	@Autowired
	@Qualifier("flowService")
	private IFlowService flowService;
	
	@RequestMapping("/getProcessMinds")
	@ResponseBody
	public List<FlowMinds> getProcessMinds(Integer flowId) {
		
		if(flowId == null) {
			return null;
		}
		
		List<FlowMinds> list = new ArrayList<FlowMinds>();
		
		try {
			list = flowService.queryFlowMinds(flowId);
		} catch (DBAccessException e) {
			log.error("getProcessMinds[FlowMinds] - " + e.getMessage(), e);
		}
		
		return list;
	}
	
}

