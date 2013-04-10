package org.thorn.workflow.service;


import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.PageAuth;

/**
 * @ClassName: IPermission
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:47:52
 */
public interface IPageAuthService {

	public void save(PageAuth auth) throws DBAccessException;

	public void modify(PageAuth auth) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<PageAuth> queryPage(String activityId, String processDfId,
			long start, long limit, String sort, String dir)
			throws DBAccessException;

	public PageAuth queryPageAuth(String activityId, String processDfId)
			throws DBAccessException;

}
