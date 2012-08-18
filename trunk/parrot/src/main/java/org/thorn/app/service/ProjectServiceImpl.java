package org.thorn.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.app.entity.Project;
import org.thorn.app.entity.ProjectCost;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.mybatis.helper.MyBatisDaoSupport;
import org.thorn.web.entity.Page;

/**
 * @ClassName: ProjectServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-8-10 上午10:59:48
 */
public class ProjectServiceImpl implements IProjectService {

	@Autowired
	@Qualifier("myBatisDaoSupport")
	private MyBatisDaoSupport myBatisDaoSupport;

	public void save(Project project) throws DBAccessException {
		myBatisDaoSupport.save(project);
	}

	public void modify(Project project) throws DBAccessException {
		myBatisDaoSupport.modify(project);
	}

	public void delete(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		myBatisDaoSupport.deleteForBatch(list, Project.class);
	}

	public Page<Project> queryPage(String name, String code, String userName,
			String userId, String type, String isUnProject, String province,
			long start, long limit, String sort, String dir)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("name", name);
		filter.put("code", code);
		filter.put("userName", userName);
		filter.put("type", type);
		filter.put("isUnProject", isUnProject);
		filter.put("userId", userId);
		filter.put("province", province);
		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);
		filter.put(Configuration.SROT_NAME, sort);
		filter.put(Configuration.ORDER_NAME, dir);

		Page<Project> page = new Page<Project>();

		page.setTotal(myBatisDaoSupport.queryCount(filter, Project.class));
		if (page.getTotal() > 0) {
			page.setReslutSet(myBatisDaoSupport
					.queryList(filter, Project.class));
		}

		return page;

	}

	public List<Project> queryProjectList(String province, String userId)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("province", province);
		filter.put("userId", userId);

		return myBatisDaoSupport.queryList(filter, Project.class);
	}

	public ProjectCost queryProjectCost(Integer id) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("id", id);

		return (ProjectCost) myBatisDaoSupport.queryOne(filter,
				ProjectCost.class);
	}

	public Page<ProjectCost> queryCostPage(String name, Integer pid,
			String userName, String userId, String isUnProject,
			String province, String projectType, String startTime,
			String endTime, Integer year, Long start, Long limit, String sort,
			String dir) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("projectName", name);
		filter.put("projectId", pid);
		filter.put("createrName", userName);
		filter.put("type", projectType);
		filter.put("isUnProject", isUnProject);
		filter.put("creater", userId);
		filter.put("province", province);
		filter.put("startTime", startTime);
		filter.put("endTime", endTime);
		filter.put("year", year);
		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);

		if (LocalStringUtils.isEmpty(sort)) {
			filter.put(Configuration.SROT_NAME, "P.APPLYTIME");
			filter.put(Configuration.ORDER_NAME, Configuration.ORDER_ASC);
		} else {
			filter.put(Configuration.SROT_NAME, sort);
			filter.put(Configuration.ORDER_NAME, dir);
		}

		Page<ProjectCost> page = new Page<ProjectCost>();

		page.setTotal(myBatisDaoSupport.queryCount(filter, ProjectCost.class));
		if (page.getTotal() > 0) {
			page.setReslutSet(myBatisDaoSupport.queryList(filter,
					ProjectCost.class));
		}

		return page;
	}

	public Double queryProjectCostSum(Integer year, String province)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("province", province);
		filter.put("year", year);

		long money = myBatisDaoSupport.queryCount(filter,
				"ProjectCostMapper.selectCostSum");

		return (double) money / 10000;
	}

}
