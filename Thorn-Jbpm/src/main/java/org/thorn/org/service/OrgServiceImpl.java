package org.thorn.org.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.org.dao.IOrgDao;
import org.thorn.org.entity.Org;

/** 
 * @ClassName: OrgServiceImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-5-10 下午03:33:53 
 */
public class OrgServiceImpl implements IOrgService {
	
	@Autowired
	@Qualifier("orgDao")
	private IOrgDao orgDao;
	
	public List<Org> queryLeftTree(String pid) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		
		filter.put("parentOrg", pid);
		filter.put("isShow", Configuration.DB_YES);
		filter.put("isDisabled", Configuration.DB_NO);
		filter.put(Configuration.SROT_NAME, "SORTNUM");
		filter.put(Configuration.ORDER_NAME, "ASC");
		
		return orgDao.queryList(filter);
	}

	public void save(Org org) throws DBAccessException {
		orgDao.save(org);
	}

	public void modify(Org org) throws DBAccessException {
		orgDao.modify(org);
	}

	public void delete(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		orgDao.delete(list);
	}

	public Page<Org> queryPage(String pid, String orgCode, String orgName,
			String orgType, long start, long limit, String sort, String dir)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		
		filter.put("parentOrg", pid);
		filter.put("showName", orgName);
		filter.put("orgCode", orgCode);
		filter.put("orgType", orgType);
		
		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);
		
		if(LocalStringUtils.isEmpty(sort)) {
			filter.put(Configuration.SROT_NAME, "SORTNUM");
			filter.put(Configuration.ORDER_NAME, Configuration.ORDER_ASC);
		} else {
			filter.put(Configuration.SROT_NAME, sort);
			filter.put(Configuration.ORDER_NAME, dir);
		}
		
		return orgDao.queryPage(filter);
	}
	
	public Org queryOrg(String orgCode, String orgId) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("orgCode", orgCode);
		filter.put("orgId", orgId);
		
		List<Org> list = orgDao.queryList(filter);
		
		if(list.size() != 1) {
			throw new DBAccessException("queryOrg find result size:" + list.size());
		}
		
		return list.get(0);
	}

}

