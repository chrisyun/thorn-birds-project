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
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.workflow.entity.Entruster;
import org.thorn.workflow.service.IEntrustService;

/**
 * @ClassName: PageAuthController
 * @Description:
 * @author chenyun
 * @date 2012-6-21 下午03:16:54
 */
@Controller
@RequestMapping("/wf/cm")
public class EntrustController extends BaseController {

	static Logger log = LoggerFactory.getLogger(EntrustController.class);

	@Autowired
	@Qualifier("entrustService")
	private IEntrustService entrustService;

	@RequestMapping("/saveOrModifyEntruster")
	@ResponseBody
	public Status saveOrModifyEntruster(Entruster entruster, String opType) {
		Status status = new Status();
		try {
			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				User user = SecurityUserUtils.getCurrentUser();
				entruster.setUserId(user.getUserId());
				entrustService.save(entruster);
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				entrustService.modify(entruster);
			}
			status.setMessage("设置流程委托成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyEntruster[Entruster] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/deleteEntruster")
	@ResponseBody
	public Status deleteEntruster(String ids) {
		Status status = new Status();

		try {
			entrustService.delete(ids);
			status.setMessage("取消委托成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteEntruster[Entruster] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/getEntruster")
	@ResponseBody
	public Page<Entruster> getEntruster(String sort, String dir, String processDfId) {
		Page<Entruster> page = new Page<Entruster>();

		try {
			User user = SecurityUserUtils.getCurrentUser();

			page.setReslutSet(entrustService.queryList(user.getUserId(),
					processDfId, sort, dir));
		} catch (DBAccessException e) {
			log.error("getEntruster[Entruster] - " + e.getMessage(), e);
		}

		return page;
	}

}
