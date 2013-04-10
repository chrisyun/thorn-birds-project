package org.thorn.workflow.handler;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.thorn.dao.exception.DBAccessException;

/** 
 * @ClassName: SimpleProcessHandler 
 * @Description: 
 * @author chenyun
 * @date 2012-7-11 上午10:23:17 
 */
public class SimpleProcessHandler extends ProcessHandler {

	@Override
	protected void executeCustomHandlerAfter(Map<String, Object> parameters,
			HttpServletRequest request) throws DBAccessException {
		//do nothing
		
	}

	@Override
	protected void executeCustomHandlerBefore(Map<String, Object> parameters,
			HttpServletRequest request, Map<String, Object> variable)
			throws DBAccessException {
		
	}


}

