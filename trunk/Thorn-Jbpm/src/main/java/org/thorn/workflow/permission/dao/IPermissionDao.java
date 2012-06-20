package org.thorn.workflow.permission.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.permission.entity.WfPermission;

/** 
 * @ClassName: IPermissionDao 
 * @Description: 
 * @author chenyun
 * @date 2012-6-20 下午10:26:45 
 */
public interface IPermissionDao {
	
	public int save(WfPermission permission) throws DBAccessException;
	
	public int modify(WfPermission permission) throws DBAccessException;
	
	public int delete(List<String> ids) throws DBAccessException;
	
	public Page<WfPermission> queryPage(Map<String, Object> filter)
		throws DBAccessException;
	
	public List<WfPermission> queryList(Map<String, Object> filter)
	throws DBAccessException;
	
}

