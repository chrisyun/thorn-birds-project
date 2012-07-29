package org.thorn.workflow.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.dao.IEntrustDao;
import org.thorn.workflow.entity.Entruster;

/**
 * @ClassName: PermissionServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:50:40
 */
public class EntrustServiceImpl implements IEntrustService {

	@Autowired
	@Qualifier("entrustDao")
	private IEntrustDao entrustDao;

	public void save(Entruster entruster) throws DBAccessException {
		entrustDao.save(entruster);
	}

	public void modify(Entruster entruster) throws DBAccessException {
		entrustDao.modify(entruster);
	}

	public void delete(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		entrustDao.delete(list);
	}

	public List<Entruster> queryList(String userId, String processDfId,
			String sort, String dir) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();

		filter.put("userId", userId);
		filter.put("processDfId", processDfId);

		if (LocalStringUtils.isEmpty(sort)) {
			filter.put(Configuration.SROT_NAME, "PROCESSDFID");
			filter.put(Configuration.ORDER_NAME, Configuration.ORDER_ASC);
		} else {
			filter.put(Configuration.SROT_NAME, sort);
			filter.put(Configuration.ORDER_NAME, dir);
		}

		return entrustDao.queryList(filter);
	}

	public Entruster queryEntruster(String userId, String processDfId,
			String date) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();

		filter.put("userId", userId);
		filter.put("processDfId", processDfId);
		filter.put("beginDate", date);
		filter.put("endDate", date);

		return entrustDao.queryOne(filter);
	}

}
