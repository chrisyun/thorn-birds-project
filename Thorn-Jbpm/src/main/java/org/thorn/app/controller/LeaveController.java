package org.thorn.app.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.app.entity.LeaveForm;
import org.thorn.app.service.LeaveService;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;

/** 
 * @ClassName: LeaveController 
 * @Description: 
 * @author chenyun
 * @date 2012-7-17 下午03:37:51 
 */
@Controller
@RequestMapping("/app/leave")
public class LeaveController extends BaseController {
	
	static Logger log = LoggerFactory.getLogger(LeaveController.class);
	
	@Autowired
	@Qualifier("leaveService")
	private LeaveService service;
	
	@RequestMapping("/saveOrModify")
	@ResponseBody
	public JsonResponse<Integer> saveOrModify(LeaveForm form, String opType) {
		JsonResponse<Integer> json = new JsonResponse<Integer>();
		
		try {
			
			if(LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				service.save(form);
				
			} else if(LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				service.modify(form);
			}
			json.setMessage("请假单数据保存成功！");
			json.setObj(form.getId());
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModify[LeaveForm] - " + e.getMessage(), e);
		}
		
		return json;
	}
	
	@RequestMapping("/getLeaveForm")
	@ResponseBody
	public JsonResponse<LeaveForm> getLeaveForm(Integer appId) {
		JsonResponse<LeaveForm> json = new JsonResponse<LeaveForm>();
		
		try {
			json.setObj(service.queryByAppId(appId));
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("请假单获取失败：" + e.getMessage());
			log.error("getLeaveForm[LeaveForm] - " + e.getMessage(), e);
		}
		
		return json;
	}
	
}

