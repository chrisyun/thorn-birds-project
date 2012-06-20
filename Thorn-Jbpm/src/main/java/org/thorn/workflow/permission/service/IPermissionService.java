package org.thorn.workflow.permission.service;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.permission.entity.WfPermission;

/**
 * @ClassName: IPermission
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:47:52
 */
public interface IPermissionService {

	public void save(WfPermission permission) throws DBAccessException;

	public void modify(WfPermission permission) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<WfPermission> queryPage(String activityId, String processDfId,
			String variable, String entityType, long start, long limit,
			String sort, String dir) throws DBAccessException;

	public WfPermission queryPermission(String activityId, String processDfId) throws DBAccessException;

}
