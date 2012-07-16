package org.thorn.workflow.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Status;
import org.thorn.workflow.HandlerException;
import org.thorn.workflow.handler.CustomHandlerFactory;
import org.thorn.workflow.handler.ProcessHandler;

/**
 * @ClassName: HandlerController
 * @Description:
 * @author chenyun
 * @date 2012-6-28 下午08:28:04
 */
@Controller
@RequestMapping("/wf/cm")
public class HandlerController extends BaseController {

	static Logger log = LoggerFactory.getLogger(HandlerController.class);

	/**
	 * 流程处理的入口方法
	 * 
	 * @Description：
	 * @author：chenyun
	 * @date：2012-6-28 下午08:40:13
	 * @param request
	 * @param taskId
	 *            任务实例ID
	 * @param titile
	 *            标题
	 * @param outcome
	 *            下一环节的线名称，多个环节需要指定
	 * @param flowInstId
	 *            流程实例ID
	 * @param flowKey
	 * @return
	 */
	@RequestMapping("/handlerTask")
	@ResponseBody
	public Status handlerTask(HttpServletRequest request, String taskId, String appId,
			String titile, String outcome, String flowInstId, String flowKey) {
		Status status = new Status();

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("taskId", taskId);
		parameters.put("title", titile);
		parameters.put("nextStep", outcome);
		parameters.put("flowInstId", flowInstId);
		parameters.put("flowKey", flowKey);
		parameters.put("appId", appId);

		ProcessHandler handler = CustomHandlerFactory
				.getProcessHandlerByDefault(flowKey);

		try {
			handler.execute(parameters, request);
			status.setMessage("流程处理成功！");
		} catch (HandlerException e) {
			status.setSuccess(false);
			status.setMessage("流程获取一下环节信息失败：" + e.getMessage());
			log.error("handlerTask[Workflow] - " + e.getMessage(), e);
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("流程数据库处理失败：" + e.getMessage());
			log.error("handlerTask[Workflow] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/getNextActivities")
	@ResponseBody
	public JsonResponse<Set<String>> getNextActivities(String taskId, String flowKey) {
		
		JsonResponse<Set<String>> json = new JsonResponse<Set<String>>();
		
		ProcessHandler handler = CustomHandlerFactory
			.getProcessHandlerByDefault(flowKey);
		
		Set<String> lines = handler.getNextActivityLines(taskId);
		json.setObj(lines);
		
		return json;
	}
	

}
