package org.thorn.workflow.service;

import java.util.List;

import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.Entruster;

/**
 * @ClassName: IPermission
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:47:52
 */
public interface IEntrustService {

	public void save(Entruster entruster) throws DBAccessException;

	public void modify(Entruster entruster) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public List<Entruster> queryList(String userId, String processDfId,
			String sort, String dir) throws DBAccessException;

	public Entruster queryEntruster(String userId, String processDfId,
			String date) throws DBAccessException;

}
