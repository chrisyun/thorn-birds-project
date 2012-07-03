package org.thorn.workflow.handler;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassName: CustomHandlerFactory
 * @Description:
 * @author chenyun
 * @date 2012-7-3 下午09:13:05
 */
public class CustomHandlerFactory {
	
	static Logger log = LoggerFactory.getLogger(CustomHandlerFactory.class);
	
	private static Map<String, ProcessCustomHandler> mapper;

	public CustomHandlerFactory(Map<String, ProcessCustomHandler> mapper) {
		CustomHandlerFactory.mapper = mapper;

		if (CustomHandlerFactory.mapper == null) {
			CustomHandlerFactory.mapper = new HashMap<String, ProcessCustomHandler>();
		}

	}

	public static ProcessCustomHandler getProcessHandler(String processKey) {

		if (!CustomHandlerFactory.mapper.containsKey(processKey)) {
			log.warn("the process key:{} has no handler!",processKey);
		}

		return CustomHandlerFactory.mapper.get(processKey);
	}
}
