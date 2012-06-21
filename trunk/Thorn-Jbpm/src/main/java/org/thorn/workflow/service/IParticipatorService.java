package org.thorn.workflow.service;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.Participator;

/**
 * @ClassName: IPermission
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:47:52
 */
public interface IParticipatorService {

	public void save(Participator permission) throws DBAccessException;

	public void modify(Participator permission) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<Participator> queryPage(String activityId, String processDfId,
			String variable, String entityType, long start, long limit,
			String sort, String dir) throws DBAccessException;

	public Participator queryPermission(String activityId, String processDfId) throws DBAccessException;

}
