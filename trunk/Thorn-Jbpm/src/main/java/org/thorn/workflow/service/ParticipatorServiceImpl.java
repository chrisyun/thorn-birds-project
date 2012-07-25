package org.thorn.workflow.service;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.dao.IParticipatorDao;
import org.thorn.workflow.entity.Participator;

/**
 * @ClassName: PermissionServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:50:40
 */
public class ParticipatorServiceImpl implements IParticipatorService {

	@Autowired
	@Qualifier("participatorDao")
	private IParticipatorDao participatorDao;

	public void save(Participator participator) throws DBAccessException {
		participatorDao.save(participator);
	}

	public void modify(Participator participator) throws DBAccessException {
		participatorDao.modify(participator);
	}

	public void delete(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		participatorDao.delete(list);
	}

	public Page<Participator> queryPage(String activityId, String processDfId,
			String variable, String entityType, long start, long limit,
			String sort, String dir) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();

		filter.put("activityId", activityId);
		filter.put("processDfId", processDfId);
		filter.put("entityType", entityType);
		filter.put("variable", variable);

		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);

		if (LocalStringUtils.isEmpty(sort)) {
			filter.put(Configuration.SROT_NAME, "PRCESSDFID");
			filter.put(Configuration.ORDER_NAME, Configuration.ORDER_ASC);
		} else {
			filter.put(Configuration.SROT_NAME, sort);
			filter.put(Configuration.ORDER_NAME, dir);
		}

		Page<Participator> page = new Page<Participator>();

		page.setTotal(participatorDao.queryPageCount(filter));
		if (page.getTotal() > 0) {
			page.setReslutSet(participatorDao.queryList(filter));
		}

		return page;
	}

	public Participator queryParticipator(String activityId, String processDfId)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();

		filter.put("activityId", activityId);
		filter.put("processDfId", processDfId);

		List<Participator> list = participatorDao.queryList(filter);

		if(list == null || list.size() == 0) {
			return null;
		} else if(list.size() == 1) {
			return list.get(0);
		} else {
			throw new DBAccessException(
					"queryParticipator find multiple valued");
		}
	}

	public List<Participator> queryList(Collection<String> keys,
			String activityId) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();

		filter.put("activityId", activityId);
		filter.put("keys", keys);

		List<Participator> list = participatorDao.queryList(filter);

		return list;
	}

}
