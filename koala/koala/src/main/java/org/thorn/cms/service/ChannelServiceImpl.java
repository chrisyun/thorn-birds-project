package org.thorn.cms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.cms.entity.Channel;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.mybatis.helper.MyBatisDaoSupport;
import org.thorn.web.entity.Page;

/**
 * @ClassName: ChannelServiceImpl
 * @Description:
 * @author chenyun
 * @date 2013-2-19 下午4:28:16
 */
public class ChannelServiceImpl implements IChannelService {

	@Autowired
	@Qualifier("myBatisDaoSupport")
	private MyBatisDaoSupport myBatisDaoSupport;

	public void save(Channel cl) throws DBAccessException {
		myBatisDaoSupport.save(cl);
	}

	public void modify(Channel cl) throws DBAccessException {
		myBatisDaoSupport.modify(cl);
	}

	public void delete(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		myBatisDaoSupport.deleteForBatch(list, Channel.class);
	}

	public Channel queryOne(Integer id) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("id", id);

		return (Channel) myBatisDaoSupport.queryOne(filter, Channel.class);
	}

	public Page<Channel> queryPage(String name, Integer pid, Integer siteId,
			String isShow, long start, long limit, String sort, String dir)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("name", name);
		filter.put("pid", pid);
		filter.put("siteId", siteId);
		filter.put("isShow", isShow);
		filter.put("isDisabled", Configuration.DB_NO);
		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);

		if (StringUtils.isEmpty(sort)) {
			filter.put(Configuration.SROT_NAME, "c.sortNum");
			filter.put(Configuration.ORDER_NAME, Configuration.ORDER_ASC);
		} else {
			filter.put(Configuration.SROT_NAME, sort);
			filter.put(Configuration.ORDER_NAME, dir);
		}

		Page<Channel> page = new Page<Channel>();

		page.setTotal(myBatisDaoSupport.queryCount(filter, Channel.class));
		if (page.getTotal() > 0) {
			page.setReslutSet(myBatisDaoSupport
					.queryList(filter, Channel.class));
		}

		return page;
	}

	public List<Channel> queryList(String name, Integer pid, Integer siteId,
			String isShow) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("name", name);
		filter.put("pid", pid);
		filter.put("siteId", siteId);
		filter.put("isShow", isShow);
		filter.put("isDisabled", Configuration.DB_NO);
		return myBatisDaoSupport.queryList(filter, Channel.class);
	}

}
