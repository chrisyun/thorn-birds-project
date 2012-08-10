package org.thorn.app.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.app.AppConfiguration;
import org.thorn.app.entity.Heritor;
import org.thorn.app.service.IHeritorService;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Page;
import org.thorn.web.entity.Status;

/**
 * @ClassName: ProjectController
 * @Description:
 * @author chenyun
 * @date 2012-8-10 上午11:10:06
 */
@Controller
@RequestMapping("/heritor")
public class HeritorController extends BaseController {

	static Logger log = LoggerFactory.getLogger(HeritorController.class);

	@Autowired
	@Qualifier("heritorService")
	private IHeritorService heritorService;

	@RequestMapping("/saveOrModifyHeritor")
	@ResponseBody
	public Status saveOrModifyHeritor(Heritor heritor, String opType) {
		Status status = new Status();

		try {

			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				heritorService.save(heritor);
				status.setMessage("新增传承人成功！");
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				heritorService.modify(heritor);
				status.setMessage("修改传承人成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyHeritor[Heritor] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/deleteHeritor")
	@ResponseBody
	public Status deleteHeritor(String ids) {
		Status status = new Status();

		try {
			heritorService.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteHeritor[Heritor] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/getHeritorPage")
	@ResponseBody
	public Page<Heritor> getHeritorPage(long start, long limit, String sort,
			String dir, String name, String gender, String projectName,
			String isDie, String province) {
		Page<Heritor> page = new Page<Heritor>();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			List<String> roleList = SecurityUserUtils.getRoleList();

			if (!SecurityUserUtils.isSysAdmin()
					&& !roleList.contains(AppConfiguration.ROLE_CENTRAL)) {

				province = user.getArea();
			}

			page = heritorService.queryPage(name, gender, projectName, isDie,
					province, start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getHeritorPage[Heritor] - " + e.getMessage(), e);
		}

		return page;
	}

}
