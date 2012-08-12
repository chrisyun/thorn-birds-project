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
import org.thorn.app.entity.Resever;
import org.thorn.app.service.IReseverService;
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
@RequestMapping("/resever")
public class ReseverController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ReseverController.class);

	@Autowired
	@Qualifier("reseverService")
	private IReseverService reseverService;

	@RequestMapping("/saveOrModifyResever")
	@ResponseBody
	public Status saveOrModifyResever(Resever resever, String opType) {
		Status status = new Status();

		try {

			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				reseverService.save(resever);
				status.setMessage("新增生态保护区成功！");
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				reseverService.modify(resever);
				status.setMessage("修改生态保护区成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyResever[Resever] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/deleteResever")
	@ResponseBody
	public Status deleteResever(String ids) {
		Status status = new Status();

		try {
			reseverService.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteResever[Resever] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/getReseverPage")
	@ResponseBody
	public Page<Resever> getReseverPage(long start, long limit, String sort,
			String dir, String name, String userName, String resverName,
			 String province) {
		Page<Resever> page = new Page<Resever>();
		String userId = null;
		
		try {
			User user = SecurityUserUtils.getCurrentUser();
			List<String> roleList = SecurityUserUtils.getRoleList();

			if (!SecurityUserUtils.isSysAdmin()
					&& !roleList.contains(AppConfiguration.ROLE_CENTRAL)) {

				if (roleList.contains(AppConfiguration.ROLE_PROVINCE)) {
					province = user.getArea();
				} else {
					province = user.getArea();
					userId = user.getUserId();
				}
			}

			page = reseverService.queryPage(resverName, userName, userId, province, start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getReseverPage[Resever] - " + e.getMessage(), e);
		}

		return page;
	}

}
