package org.thorn.app.service;

import org.thorn.app.entity.Heritor;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.entity.Page;

/**
 * @ClassName: IProjectServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-8-10 上午10:59:16
 */
public interface IHeritorService {

	public void save(Heritor heritor) throws DBAccessException;

	public void modify(Heritor heritor) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<Heritor> queryPage(String name, String gender,
			String projectName, String isDie, String province, long start,
			long limit, String sort, String dir) throws DBAccessException;
}