package org.thorn.app.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
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
import org.thorn.app.service.IProjectService;
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
@RequestMapping("/heritor")
public class HeritorController extends BaseController {

	static Logger log = LoggerFactory.getLogger(HeritorController.class);

	@Autowired
	@Qualifier("heritorService")
	private IHeritorService heritorService;
	
	@Autowired
	@Qualifier("projectService")
	private IProjectService projectService;
	
	@Autowired
	@Qualifier("reseverService")
	private IReseverService reseverService;
	
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

	@RequestMapping("/getHeritorList")
	@ResponseBody
	public Page<Heritor> getHeritorList(String sort, String dir, String name,
			String province, String isDie) {
		Page<Heritor> page = new Page<Heritor>();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			List<String> roleList = SecurityUserUtils.getRoleList();

			if (!SecurityUserUtils.isSysAdmin()
					&& !roleList.contains(AppConfiguration.ROLE_CENTRAL)) {

				province = user.getArea();
			}

			if (StringUtils.isBlank(isDie)) {
				isDie = Configuration.DB_NO;
			}

			page.setReslutSet(heritorService.queryList(name, province, isDie,
					sort, dir));
		} catch (DBAccessException e) {
			log.error("getHeritorList[Heritor] - " + e.getMessage(), e);
		}

		return page;
	}

	@RequestMapping("/bingingProject")
	@ResponseBody
	public Status bingingProject(Integer projectId, String ids) {
		Status status = new Status();

		try {
			heritorService.modifyProject(projectId, ids);
			status.setMessage("设置非遗项目传承人成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("设置非遗项目传承人失败：" + e.getMessage());
			log.error("bingingProject[Heritor] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/summaryAllCost")
	@ResponseBody
	public Page<Map<String, String>> summaryAllCost(Integer year,
			String province, Integer heritorMoney) {

		Page<Map<String, String>> page = new Page<Map<String, String>>();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			List<String> roleList = SecurityUserUtils.getRoleList();

			if (!SecurityUserUtils.isSysAdmin()
					&& !roleList.contains(AppConfiguration.ROLE_CENTRAL)) {

				province = user.getArea();
			}
			
			if(year == null) {
				SimpleDateFormat df = new SimpleDateFormat("yyyy");
				String fullYear = df.format(new Date());
				
				year = Integer.parseInt(fullYear);
			}
			
			if(heritorMoney == null) {
				heritorMoney = 1;
			}
			
			Map<String, String> hMap = new HashMap<String, String>();
			long hMoney = heritorService.queryHeritorCount(province, Configuration.DB_NO) * heritorMoney;
			hMap.put("name", "国家级代表性传承人补助费");
			hMap.put("money", String.valueOf(hMoney));
			
			Map<String, String> pMap = new HashMap<String, String>();
			Double pMoney = projectService.queryProjectCostSum(year, province);
			pMap.put("name", "国家级非物质文化遗产代表性项目补助费");
			pMap.put("money", String.valueOf(pMoney));
			
			Map<String, String> rMap = new HashMap<String, String>();
			Double rMoney = reseverService.queryReseverCostSum(year, province);
			rMap.put("name", "国家级文化生态保护区补助费");
			rMap.put("money", String.valueOf(rMoney));
			
			page.getReslutSet().add(pMap);
			page.getReslutSet().add(hMap);
			page.getReslutSet().add(rMap);
		} catch (DBAccessException e) {
			log.error("summaryAllCost[Double] - " + e.getMessage(), e);
		}

		return page;
	}

}
