package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.Participator;

/**
 * @ClassName: IPermissionDao
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:26:45
 */
public interface IParticipatorDao {

	public int save(Participator permission) throws DBAccessException;

	public int modify(Participator permission) throws DBAccessException;

	public int delete(List<String> ids) throws DBAccessException;

	public Page<Participator> queryPage(Map<String, Object> filter)
			throws DBAccessException;

	public List<Participator> queryList(Map<String, Object> filter)
			throws DBAccessException;

}
