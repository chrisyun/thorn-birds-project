package org.thorn.app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.app.AppConfiguration;
import org.thorn.app.entity.Project;
import org.thorn.app.entity.ProjectCost;
import org.thorn.app.entity.UserExtend;
import org.thorn.app.service.IProjectService;
import org.thorn.core.excel.ArrayAdapter;
import org.thorn.core.excel.ExcelStyle;
import org.thorn.core.excel.ExcelUtils;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.core.util.ReflectUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Page;
import org.thorn.web.entity.Status;
import org.thorn.web.util.DDUtils;
import org.thorn.web.util.ResponseHeaderUtils;

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
	
	@RequestMapping("/getProjectDW")
	@ResponseBody
	public JsonResponse<UserExtend> getProjectDW() {
		JsonResponse<UserExtend> json = new JsonResponse<UserExtend>();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			json.setObj(projectService.queryUserExtend(user.getUserId()));
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("数据获取失败：" + e.getMessage());
			log.error("getProjectDW[UserExtend] - " + e.getMessage(), e);
		}

		return json;
	}
	
	@RequestMapping("/dw/getProjectDWPage")
	@ResponseBody
	public Page<UserExtend> getProjectDWPage(long start, long limit,
			String sort, String dir, String orgCode, String userName,
			String cumail, String userId) {
		Page<UserExtend> page = new Page<UserExtend>();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			List<String> roles = SecurityUserUtils.getRoleList();
			
			if (!SecurityUserUtils.isSysAdmin() 
					&& !roles.contains(AppConfiguration.ROLE_CENTRAL)) {
				orgCode = user.getOrgCode();
			}

			page = projectService.queryPage(orgCode, userName, cumail, userId,
					start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getProjectDWPage[UserExtend] - " + e.getMessage(), e);
		}

		return page;
	}
	
	@RequestMapping("/dw/saveOrModifyProjectDW")
	@ResponseBody
	public Status saveOrModifyProjectDW(UserExtend ue, String opType) {
		Status status = new Status();

		try {
			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				projectService.save(ue);
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				projectService.modify(ue);
			}
			status.setMessage("修改项目保护单位基本信息成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyProjectDW[UserExtend] - " + e.getMessage(), e);
		}

		return status;
	}

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

	@RequestMapping("/getProjectByProvince")
	@ResponseBody
	public List<Project> getProjectByProvince(String province) {
		List<Project> list = new ArrayList<Project>();

		if (StringUtils.isBlank(province)) {
			return list;
		}

		try {
			list = projectService.queryProjectList(province, null);
		} catch (DBAccessException e) {
			log.error("getProjectByProvince[Project] - " + e.getMessage(), e);
		}

		return list;
	}

	@RequestMapping("/getProjectByUser")
	@ResponseBody
	public List<Project> getProjectByUser() {
		List<Project> list = new ArrayList<Project>();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			list = projectService.queryProjectList(null, user.getUserId());
		} catch (DBAccessException e) {
			log.error("getProjectByUser[Project] - " + e.getMessage(), e);
		}

		return list;
	}
	
	@RequestMapping("/getProjectOfDW")
	@ResponseBody
	public Page<Project> getProjectByUser(String userId) {
		Page<Project> page = new Page<Project>();
		
		try {
			page.setReslutSet(projectService.queryProjectList(null, userId));
		} catch (DBAccessException e) {
			log.error("getProjectByUser[Project] - " + e.getMessage(), e);
		}
		
		return page;
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
			log.error("getProjectPage[Project] - " + e.getMessage(), e);
		}

		return page;
	}

	@RequestMapping("/getProjectCostById")
	@ResponseBody
	public JsonResponse<ProjectCost> getProjectCostById(Integer id) {
		JsonResponse<ProjectCost> json = new JsonResponse<ProjectCost>();

		try {
			json.setObj(projectService.queryProjectCost(id));
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("项目费用获取失败：" + e.getMessage());
			log.error("getProjectCostById[ProjectCost] - " + e.getMessage(), e);
		}

		return json;
	}

	@RequestMapping("/getProjectCostPage")
	@ResponseBody
	public Page<ProjectCost> getProjectCostPage(long start, long limit,
			String sort, String dir, String name, Integer pid, String userName,
			String userId, String isUnProject, String province,
			String projectType, String startTime, String endTime, Integer year) {
		Page<ProjectCost> page = new Page<ProjectCost>();

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

			page = projectService.queryCostPage(name, pid, userName, userId,
					isUnProject, province, projectType, startTime, endTime,
					year, start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getProjectCostPage[ProjectCost] - " + e.getMessage(), e);
		}

		return page;
	}

	@RequestMapping("/getProjectCostSummary")
	@ResponseBody
	public Page<ProjectCost> getProjectCostSummary(Integer year,
			String province, String sort, String dir) {
		Page<ProjectCost> page = new Page<ProjectCost>();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			List<String> roleList = SecurityUserUtils.getRoleList();

			if (!SecurityUserUtils.isSysAdmin()
					&& !roleList.contains(AppConfiguration.ROLE_CENTRAL)) {

				province = user.getArea();
			}

			page = projectService.queryCostPage(null, null, null, null, null,
					province, null, null, null, year, null, null, sort, dir);
		} catch (DBAccessException e) {
			log.error("getProjectCostSummary[ProjectCost] - " + e.getMessage(),
					e);
		}

		return page;
	}

	@RequestMapping("/exportProjectCostExcel")
	public void exportProjectCostExcel(Integer year, String province,
			HttpServletResponse response) {

		try {
			User user = SecurityUserUtils.getCurrentUser();
			List<String> roleList = SecurityUserUtils.getRoleList();

			if (!SecurityUserUtils.isSysAdmin()
					&& !roleList.contains(AppConfiguration.ROLE_CENTRAL)) {

				province = user.getArea();
			}

			String provinceName = DDUtils.queryDdById("AREA", province);

			List<ProjectCost> list = projectService.queryCostPage(null, null,
					null, null, null, province, null, null, null, year, null,
					null, null, null).getReslutSet();

			StringBuilder title = new StringBuilder(String.valueOf(year));
			title.append("年度").append(provinceName);
			title.append("国家级非物质文化遗产代表性项目补助费申报汇总表");

			ResponseHeaderUtils.setExcelResponse(response, title.toString());

			String[] header = new String[] { "序号", "项目编号", "项目名称", "资金申报单位",
					"金额（万元）", "备注" };
			int[] columnWidth = new int[] { 100, 150, 250, 250, 100, 500 };

			int i = 1;
			Double money = 0.0;
			for (ProjectCost pc : list) {
				pc.setAddress(String.valueOf(i));

				if (StringUtils.equals(pc.getIsUnProject(),
						Configuration.DB_YES)) {
					pc.setProjectName("★" + pc.getProjectName());
				}

				money += pc.getMoney();
				i++;
			}

			ProjectCost pc = new ProjectCost();
			pc.setAddress("合计");
			pc.setCode("-");
			pc.setProjectName("-");
			pc.setCreaterName("-");
			pc.setMoney(money);
			list.add(pc);

			String[] orderArray = new String[] { "address", "code",
					"projectName", "createrName", "money", "appReason" };
			List<Object[]> dataSource = ReflectUtils.object2Array(list);

			ExcelStyle style = new ExcelStyle();

			ArrayAdapter adapter = new ArrayAdapter(header, orderArray,
					dataSource);

			ExcelUtils.write2Excel(adapter, "汇总表", columnWidth, style,
					response.getOutputStream());
			response.getOutputStream().flush();
		} catch (DBAccessException e) {
			log.error(
					"exportProjectCostExcel[ProjectCost] - " + e.getMessage(),
					e);
		} catch (IOException e) {
			log.error(
					"exportProjectCostExcel[ProjectCost] - " + e.getMessage(),
					e);
		}
	}

}
