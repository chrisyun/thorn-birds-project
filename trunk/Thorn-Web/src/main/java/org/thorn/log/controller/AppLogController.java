package org.thorn.log.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.log.entity.AppLog;
import org.thorn.log.service.IAppLogService;
import org.thorn.web.controller.BaseController;

/**
 * @ClassName: AppLogController
 * @Description:
 * @author chenyun
 * @date 2012-5-26 下午10:00:25
 */
@Controller
public class AppLogController extends BaseController {

	static Logger log = LoggerFactory.getLogger(AppLogController.class);

	@Autowired
	@Qualifier("logService")
	private IAppLogService logService;

	@RequestMapping("/log/getLogPage")
	@ResponseBody
	public Page<AppLog> getLogPage(long start, long limit, String sort,
			String dir, String moduleName, String handleResult,
			String startTime, String endTime) {
		Page<AppLog> page = new Page<AppLog>();

		try {
			page = logService.queryPage(moduleName, handleResult, startTime,
					endTime, start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getLogPage[AppLog] - " + e.getMessage(), e);
		}

		return page;
	}
}
