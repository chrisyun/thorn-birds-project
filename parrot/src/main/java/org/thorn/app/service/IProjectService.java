package org.thorn.app.service;

import java.util.List;

import org.thorn.app.entity.Project;
import org.thorn.app.entity.ProjectCost;
import org.thorn.app.entity.UserExtend;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.entity.Page;

/**
 * @ClassName: IProjectServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-8-10 上午10:59:16
 */
public interface IProjectService {

	public UserExtend queryUserExtend(String userId) throws DBAccessException;

	public void save(UserExtend ue) throws DBAccessException;

	public void modify(UserExtend ue) throws DBAccessException;

	public Page<UserExtend> queryPage(String orgCode, String userName,
			String cumail, String userId, long start, long limit, String sort,
			String dir) throws DBAccessException;

	public void save(Project project) throws DBAccessException;

	public void modify(Project project) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<Project> queryPage(String name, String code, String userName,
			String userId, String type, String isUnProject, String province,
			String provinceArea, long start, long limit, String sort, String dir)
			throws DBAccessException;

	public List<Project> queryProjectList(String province, String userId)
			throws DBAccessException;

	public ProjectCost queryProjectCost(Integer id) throws DBAccessException;

	public Page<ProjectCost> queryCostPage(String name, Integer pid,
			String userName, String userId, String isUnProject,
			String province, String projectType, String startTime,
			String endTime, Integer year, String provinceArea, Long start,
			Long limit, String sort, String dir) throws DBAccessException;

	public Double queryProjectCostSum(Integer year, String province)
			throws DBAccessException;

}
