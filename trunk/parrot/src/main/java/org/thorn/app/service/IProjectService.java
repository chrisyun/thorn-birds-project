package org.thorn.app.service;

import java.util.List;

import org.thorn.app.entity.Project;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.entity.Page;

/**
 * @ClassName: IProjectServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-8-10 上午10:59:16
 */
public interface IProjectService {

	public void save(Project project) throws DBAccessException;

	public void modify(Project project) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<Project> queryPage(String name, String code, String userName,
			String userId, String type, String isUnProject, String province,
			long start, long limit, String sort, String dir)
			throws DBAccessException;
	
	public List<Project> queryList(String province) throws DBAccessException;
	
}
