package org.thorn.cms.service;

import java.util.List;

import org.thorn.cms.entity.WebSite;
import org.thorn.dao.exception.DBAccessException;

/**
 * @ClassName: IWebSiteService
 * @Description:
 * @author chenyun
 * @date 2013-2-19 上午9:12:24
 */
public interface IWebSiteService {

	public void save(WebSite ws) throws DBAccessException;

	public void modify(WebSite ws) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public WebSite queryOne(Integer id) throws DBAccessException;

	public List<WebSite> queryList(String name) throws DBAccessException;
}
