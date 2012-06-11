package org.thorn.log.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;

/**
 * @ClassName: SysLogController
 * @Description:
 * @author chenyun
 * @date 2012-6-10 下午09:56:17
 */
@Controller
public class SysLogController extends BaseController {

	Logger log = LoggerFactory.getLogger(SysLogController.class);
	
	@RequestMapping("/log/modifyLogLevel")
	@ResponseBody
	public Status modifyLogLevel(int level) {
		Status status = new Status();

		try {
			LoggerContext context = (LoggerContext) LoggerFactory
					.getILoggerFactory();
			ch.qos.logback.classic.Logger rootLogger = context
					.getLogger(Logger.ROOT_LOGGER_NAME);
			rootLogger.setLevel(Level.toLevel(level));
			status.setMessage("修改日志级别成功！");
		} catch (Exception e) {
			status.setSuccess(false);
			status.setMessage("修改日志级别失败：" + e.getMessage());
			log.error("modifyLogLevel[int] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/log/getLogLevel")
	@ResponseBody
	public Map<Integer, String> getLogBackLevel() {
		Map<Integer, String> level = new HashMap<Integer, String>();
		level.put(Level.ALL.toInteger(), Level.ALL.toString());
		level.put(Level.TRACE.toInteger(), Level.TRACE.toString());
		level.put(Level.DEBUG.toInteger(), Level.DEBUG.toString());
		level.put(Level.INFO.toInteger(), Level.INFO.toString());
		level.put(Level.WARN.toInteger(), Level.WARN.toString());
		level.put(Level.ERROR.toInteger(), Level.ERROR.toString());
		level.put(Level.OFF.toInteger(), Level.OFF.toString());
		
		return level;
	}
	
}