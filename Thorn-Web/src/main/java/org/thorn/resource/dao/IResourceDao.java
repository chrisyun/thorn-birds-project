package org.thorn.resource.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.resource.entity.Resource;

/**
 * @ClassName: IResourceDao
 * @Description:
 * @author chenyun
 * @date 2012-5-6 上午10:22:39
 */
public interface IResourceDao {

	public List<Resource> queryByList(Map<String, Object> filter)
			throws DBAccessException;

	public Page<Resource> queryPage(Map<String, Object> filter)
			throws DBAccessException;

	public int save(Resource source) throws DBAccessException;

	public int modify(Resource source) throws DBAccessException;

	public int delete(List<String> ids) throws DBAccessException;

	public List<String> queryResourceByRole(String roleId)
			throws DBAccessException;
}
