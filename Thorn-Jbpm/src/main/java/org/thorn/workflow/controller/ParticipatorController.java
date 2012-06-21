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
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.workflow.entity.Participator;
import org.thorn.workflow.service.IParticipatorService;

/**
 * @ClassName: WfPermissionController
 * @Description:
 * @author chenyun
 * @date 2012-6-21 下午03:16:54
 */
@Controller
public class ParticipatorController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ParticipatorController.class);

	@Autowired
	@Qualifier("participatorService")
	private IParticipatorService participatorService;

	@RequestMapping("/wf/pp/saveOrModifyParticipator")
	@ResponseBody
	public Status saveOrModifyParticipator(Participator permission,
			String opType) {
		Status status = new Status();

		try {

			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				participatorService.save(permission);
				status.setMessage("绑定环节参与者成功！");
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				participatorService.modify(permission);
				status.setMessage("修改环节参与者成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error(
					"saveOrModifyParticipator[Participator] - "
							+ e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/wf/pp/deleteParticipator")
	@ResponseBody
	public Status deleteParticipator(String ids) {
		Status status = new Status();

		try {
			participatorService.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteParticipator[Participator] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/wf/pp/getParticipatorPage")
	@ResponseBody
	public Page<Participator> getParticipatorPage(long start, long limit,
			String sort, String dir, String activityId, String processDfId,
			String variable, String entityType) {
		Page<Participator> page = new Page<Participator>();

		try {
			page = participatorService.queryPage(activityId, processDfId,
					variable, entityType, start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getParticipatorPage[Participator] - " + e.getMessage(),
					e);
		}

		return page;
	}

}
