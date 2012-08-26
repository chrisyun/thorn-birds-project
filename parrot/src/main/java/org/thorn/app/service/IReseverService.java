package org.thorn.app.service;

import java.util.List;

import org.thorn.app.entity.Resever;
import org.thorn.app.entity.ReseverCost;
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

	public List<Resever> queryReseverList(String province, String userId)
			throws DBAccessException;

	public ReseverCost queryReseverCost(Integer id) throws DBAccessException;

	public Page<ReseverCost> queryCostPage(String name, Integer pid,
			String userName, String userId, String province, String startTime,
			String endTime, Integer year, long start, long limit, String sort,
			String dir) throws DBAccessException;

	public Double queryReseverCostSum(Integer year, String province)
			throws DBAccessException;

	public ReseverCost queryReseverDW(Integer reseverId)
			throws DBAccessException;
}
