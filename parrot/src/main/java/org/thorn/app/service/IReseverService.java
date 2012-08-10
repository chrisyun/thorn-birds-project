package org.thorn.app.service;

import org.thorn.app.entity.Resever;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.entity.Page;

/**
 * @ClassName: IProjectServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-8-10 上午10:59:16
 */
public interface IReseverService {

	public void save(Resever resever) throws DBAccessException;

	public void modify(Resever resever) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<Resever> queryPage(String name, String userName, String userId,
			String province, long start, long limit, String sort, String dir)
			throws DBAccessException;
}
