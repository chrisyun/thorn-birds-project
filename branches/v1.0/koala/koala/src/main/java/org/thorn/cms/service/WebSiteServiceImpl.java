package org.thorn.cms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.cms.entity.WebSite;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.mybatis.helper.MyBatisDaoSupport;

/**
 * @ClassName: WebSiteServiceImpl
 * @Description:
 * @author chenyun
 * @date 2013-2-19 上午9:27:53
 */
public class WebSiteServiceImpl implements IWebSiteService {

	@Autowired
	@Qualifier("myBatisDaoSupport")
	private MyBatisDaoSupport myBatisDaoSupport;

	public void save(WebSite ws) throws DBAccessException {
		myBatisDaoSupport.save(ws);
	}

	public void modify(WebSite ws) throws DBAccessException {
		myBatisDaoSupport.modify(ws);
	}

	public void delete(String ids) throws DBAccessException {

		List<String> list = LocalStringUtils.splitStr2Array(ids);
		myBatisDaoSupport.deleteForBatch(list, WebSite.class);
	}

	public WebSite queryOne(Integer id) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("id", id);

		return (WebSite) myBatisDaoSupport.queryOne(filter, WebSite.class);
	}

	public List<WebSite> queryList(String name) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("name", name);

		return myBatisDaoSupport.queryList(filter, WebSite.class);
	}

}
