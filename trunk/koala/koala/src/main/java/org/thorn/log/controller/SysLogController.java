package org.thorn.log.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Status;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.html.HTMLLayout;
import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.classic.spi.LoggingEvent;
import ch.qos.logback.core.read.CyclicBufferAppender;

/**
 * @ClassName: SysLogController
 * @Description:
 * @author chenyun
 * @date 2012-6-10 下午09:56:17
 */
@Controller
@RequestMapping("/System/log")
public class SysLogController extends BaseController {
	
	private static final String CYCLIC_BUFFER_APPENDER_NAME = "CYCLIC";
	
	private CyclicBufferAppender<ILoggingEvent> cyclicBufferAppender;
	
	private HTMLLayout layout;
	
	private static String PATTERN = "%d%thread%level%logger{25}%msg";
	
	Logger log = LoggerFactory.getLogger(SysLogController.class);
	
	@RequestMapping("/querySysLog.jhtml")
	public String querySysLog(ModelMap model) {
		
		Map<Integer, String> levels = new HashMap<Integer, String>();
		levels.put(Level.ALL.toInteger(), Level.ALL.toString());
		levels.put(Level.TRACE.toInteger(), Level.TRACE.toString());
		levels.put(Level.DEBUG.toInteger(), Level.DEBUG.toString());
		levels.put(Level.INFO.toInteger(), Level.INFO.toString());
		levels.put(Level.WARN.toInteger(), Level.WARN.toString());
		levels.put(Level.ERROR.toInteger(), Level.ERROR.toString());
		levels.put(Level.OFF.toInteger(), Level.OFF.toString());
		model.put("levels", levels);
		
		return "system/syslog";
	}
	
	@RequestMapping(value = "/querylogRows.jmt", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponse<String> querylogRows() {
		JsonResponse<String> json = new JsonResponse<String>();
		
		LoggerContext lc = (LoggerContext) LoggerFactory.getILoggerFactory();
		log.debug("Initializing ViewLastLog Servlet");
		cyclicBufferAppender = (CyclicBufferAppender<ILoggingEvent>) lc
				.getLogger(Logger.ROOT_LOGGER_NAME).getAppender(
						CYCLIC_BUFFER_APPENDER_NAME);

		layout = new HTMLLayout();
		layout.setContext(lc);
		layout.setPattern(PATTERN);
		layout.start();
		
		StringBuilder html = new StringBuilder();
		int count = -1;
		if (cyclicBufferAppender != null) {
			count = cyclicBufferAppender.getLength();
		}

		if (count == -1) {
			json.setObj("<tr><td td colspan='5'>Failed to locate CyclicBuffer</td></tr>\r\n");
		} else if (count == 0) {
			json.setObj("<tr><td colspan='5'>No logging events to display</td></tr>\r\n");
		} else {
			LoggingEvent le;
			//逆序排列
			for (int i = count - 1; i > -1; i--) {
				le = (LoggingEvent) cyclicBufferAppender.get(i);
				html.append(layout.doLayout(le) + "\r\n");
			}
			
			json.setObj(html.toString());
		}
		
		return json;
	}
	
	
	@RequestMapping(value = "/modifyLogLevel.jmt", method = RequestMethod.POST)
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
	
	
	public List<Map<String, Object>> getLogBackLevel() {
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		Map<String, Object> all = new HashMap<String, Object>();
		all.put("name", Level.ALL.toString());
		all.put("id", Level.ALL.toInteger());
		list.add(all);
		
		Map<String, Object> trace = new HashMap<String, Object>();
		trace.put("name", Level.TRACE.toString());
		trace.put("id", Level.TRACE.toInteger());
		list.add(trace);
		
		Map<String, Object> debug = new HashMap<String, Object>();
		debug.put("name", Level.DEBUG.toString());
		debug.put("id", Level.DEBUG.toInteger());
		list.add(debug);
		
		Map<String, Object> info = new HashMap<String, Object>();
		info.put("name", Level.INFO.toString());
		info.put("id", Level.INFO.toInteger());
		list.add(info);
		
		Map<String, Object> warn = new HashMap<String, Object>();
		warn.put("name", Level.WARN.toString());
		warn.put("id", Level.WARN.toInteger());
		list.add(warn);
		
		Map<String, Object> error = new HashMap<String, Object>();
		error.put("name", Level.ERROR.toString());
		error.put("id", Level.ERROR.toInteger());
		list.add(error);
		
		Map<String, Object> off = new HashMap<String, Object>();
		off.put("name", Level.OFF.toString());
		off.put("id", Level.OFF.toInteger());
		list.add(off);
		
		return list;
	}
	
}