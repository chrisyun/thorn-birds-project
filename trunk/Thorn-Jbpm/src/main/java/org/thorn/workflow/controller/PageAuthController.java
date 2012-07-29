package org.thorn.workflow.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.workflow.entity.PageAuth;
import org.thorn.workflow.service.IPageAuthService;

/**
 * @ClassName: PageAuthController
 * @Description:
 * @author chenyun
 * @date 2012-6-21 下午03:16:54
 */
@Controller
@RequestMapping("/wf/pa")
public class PageAuthController extends BaseController {

	static Logger log = LoggerFactory.getLogger(PageAuthController.class);

	@Autowired
	@Qualifier("pageAuthService")
	private IPageAuthService pageAuthService;

	@RequestMapping("/saveOrModifyPageAuth")
	@ResponseBody
	public Status saveOrModifyPageAuth(PageAuth auth,
			String opType) {
		Status status = new Status();

		try {
			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				pageAuthService.save(auth);
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				pageAuthService.modify(auth);
			}
			status.setMessage("环节赋权成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error(
					"saveOrModifyPageAuth[PageAuth] - "
							+ e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/deletePageAuth")
	@ResponseBody
	public Status deletePageAuth(String ids) {
		Status status = new Status();

		try {
			pageAuthService.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deletePageAuth[PageAuth] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/getPageAuthPage")
	@ResponseBody
	public Page<PageAuth> getPageAuthPage(long start, long limit,
			String sort, String dir, String activityId, String processDfId) {
		Page<PageAuth> page = new Page<PageAuth>();

		try {
			page = pageAuthService.queryPage(activityId, processDfId,start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getPageAuthPage[PageAuth] - " + e.getMessage(),
					e);
		}

		return page;
	}

}
