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
import org.thorn.workflow.entity.WfPermission;
import org.thorn.workflow.service.IPermissionService;

/**
 * @ClassName: WfPermissionController
 * @Description:
 * @author chenyun
 * @date 2012-6-21 下午03:16:54
 */
@Controller
public class WfPermissionController extends BaseController {

	static Logger log = LoggerFactory.getLogger(WfPermissionController.class);

	@Autowired
	@Qualifier("permissionService")
	private IPermissionService permissionService;

	@RequestMapping("/wf/permisson/saveOrModifyPermission")
	@ResponseBody
	public Status saveOrModifyPermission(WfPermission permission, String opType) {
		Status status = new Status();

		try {

			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				permissionService.save(permission);
				status.setMessage("设置环节权限成功！");
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				permissionService.modify(permission);
				status.setMessage("修改环节权限成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error(
					"saveOrModifyPermission[WfPermission] - " + e.getMessage(),
					e);
		}

		return status;
	}

	@RequestMapping("/wf/permisson/deletePermission")
	@ResponseBody
	public Status deletePermission(String ids) {
		Status status = new Status();

		try {
			permissionService.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deletePermission[WfPermission] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/wf/permisson/getPermissionPage")
	@ResponseBody
	public Page<WfPermission> getPermissionPage(long start, long limit,
			String sort, String dir, String activityId, String processDfId,
			String variable, String entityType) {
		Page<WfPermission> page = new Page<WfPermission>();

		try {
			page = permissionService.queryPage(activityId, processDfId,
					variable, entityType, start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getPermissionPage[WfPermission] - " + e.getMessage(), e);
		}

		return page;
	}

}
