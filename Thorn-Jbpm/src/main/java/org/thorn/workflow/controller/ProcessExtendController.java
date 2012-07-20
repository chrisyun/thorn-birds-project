package org.thorn.workflow.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.workflow.entity.ActivityMind;
import org.thorn.workflow.service.IFlowMindsService;

/**
 * @ClassName: ProcessExtendController
 * @Description:
 * @author chenyun
 * @date 2012-7-20 下午03:45:14
 */
@Controller
@RequestMapping("/wf/cm")
public class ProcessExtendController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ProcessExtendController.class);

	@Autowired
	@Qualifier("flowMindsService")
	private IFlowMindsService flowMindsService;
	
	
	@RequestMapping("/saveActivityMind")
	@ResponseBody
	public Status saveActivityMind(ActivityMind mind) {
		Status status = new Status();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			mind.setUserId(user.getUserId());
			mind.setUserName(user.getUserName());

			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			mind.setCreateTime(df.format(new Date()));

			flowMindsService.save(mind);
			status.setMessage("意见保存成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveActivityMind[ActivityMind] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/getProcessMinds")
	@ResponseBody
	public List<ActivityMind> getProcessMinds(String flowInstId) {
		List<ActivityMind> list = new ArrayList<ActivityMind>();

		try {
			list = flowMindsService.queryByInst(flowInstId);
		} catch (DBAccessException e) {
			log.error("getProcessMinds[ActivityMind] - " + e.getMessage(), e);
		}

		return list;
	}

}
