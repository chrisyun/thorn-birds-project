package org.thorn.app.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.app.AppConfiguration;
import org.thorn.app.entity.Project;
import org.thorn.app.service.IProjectService;
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
@RequestMapping("/project")
public class ProjectController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ProjectController.class);

	@Autowired
	@Qualifier("projectService")
	private IProjectService projectService;

	@RequestMapping("/saveOrModifyProject")
	@ResponseBody
	public Status saveOrModifyProject(Project project, String opType) {
		Status status = new Status();

		try {

			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				projectService.save(project);
				status.setMessage("新增非遗项目成功！");
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				projectService.modify(project);
				status.setMessage("修改非遗项目成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyProject[Project] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping("/deleteProject")
	@ResponseBody
	public Status deleteProject(String ids) {
		Status status = new Status();

		try {
			projectService.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteProject[Project] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/getProjectList")
	@ResponseBody
	public List<Project> getProjectList(String province) {
		List<Project> list = new ArrayList<Project>();
		
		try {
			list = projectService.queryList(province);
		} catch (DBAccessException e) {
			log.error("getProjectList[Project] - " + e.getMessage(), e);
		}
		
		return list;
	}
	
	
	@RequestMapping("/getProjectPage")
	@ResponseBody
	public Page<Project> getProjectPage(long start, long limit, String sort,
			String dir, String name, String code, String userName, String type,
			String isUnProject, String province) {
		Page<Project> page = new Page<Project>();
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

			page = projectService.queryPage(name, code, userName, userId, type,
					isUnProject, province, start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getOrgPage[org] - " + e.getMessage(), e);
		}

		return page;
	}

}
