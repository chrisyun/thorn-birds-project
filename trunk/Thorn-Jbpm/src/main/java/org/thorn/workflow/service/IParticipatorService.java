package org.thorn.workflow.service;

import java.util.Collection;
import java.util.List;

import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.Participator;

/**
 * @ClassName: IPermission
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:47:52
 */
public interface IParticipatorService {

	public void save(Participator participator) throws DBAccessException;

	public void modify(Participator participator) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<Participator> queryPage(String activityId, String processDfId,
			String variable, String entityType, long start, long limit,
			String sort, String dir) throws DBAccessException;

	public Participator queryParticipator(String activityId, String processDfId) throws DBAccessException;
	
	public List<Participator> queryList(Collection<String> keys, String activityId) throws DBAccessException; 
}
