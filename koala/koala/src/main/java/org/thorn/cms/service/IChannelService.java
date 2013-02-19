package org.thorn.cms.service;

import java.util.List;

import org.thorn.cms.entity.Channel;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.entity.Page;

/**
 * @ClassName: IChannelService
 * @Description:
 * @author chenyun
 * @date 2013-2-19 下午4:11:39
 */
public interface IChannelService {

	public void save(Channel cl) throws DBAccessException;

	public void modify(Channel cl) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Channel queryOne(Integer id) throws DBAccessException;

	public Page<Channel> queryPage(String name, Integer pid, Integer siteId,
			String isShow, long start, long limit, String sort, String dir)
			throws DBAccessException;

	public List<Channel> queryList(String name, Integer pid, Integer siteId,
			String isShow) throws DBAccessException;
}
