package org.thorn.workflow.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.dao.IPageAuthDao;
import org.thorn.workflow.entity.PageAuth;

/**
 * @ClassName: PermissionServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:50:40
 */
public class PageAuthServiceImpl implements IPageAuthService {

	@Autowired
	@Qualifier("pageAuthDao")
	private IPageAuthDao authDao;

	public void save(PageAuth auth) throws DBAccessException {
		authDao.save(auth);
	}

	public void modify(PageAuth auth) throws DBAccessException {
		authDao.modify(auth);
	}

	public void delete(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		authDao.delete(list);
	}

	public Page<PageAuth> queryPage(String activityId, String processDfId,
			long start, long limit, String sort, String dir)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();

		filter.put("activityId", activityId);
		filter.put("processDfId", processDfId);

		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);

		if (LocalStringUtils.isEmpty(sort)) {
			filter.put(Configuration.SROT_NAME, "PROCESSDFID");
			filter.put(Configuration.ORDER_NAME, Configuration.ORDER_ASC);
		} else {
			filter.put(Configuration.SROT_NAME, sort);
			filter.put(Configuration.ORDER_NAME, dir);
		}

		Page<PageAuth> page = new Page<PageAuth>();

		page.setTotal(authDao.queryPageCount(filter));
		if (page.getTotal() > 0) {
			page.setReslutSet(authDao.queryList(filter));
		}

		return page;
	}

	public PageAuth queryPageAuth(String activityId, String processDfId)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();

		filter.put("activityId", activityId);
		filter.put("processDfId", processDfId);

		List<PageAuth> list = authDao.queryList(filter);

		if (list == null || list.size() == 0) {
			return null;
		} else if (list.size() == 1) {
			return list.get(0);
		} else {
			throw new DBAccessException("queryPageAuth find multiple valued");
		}
	}

}
