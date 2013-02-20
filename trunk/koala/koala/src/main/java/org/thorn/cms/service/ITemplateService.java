package org.thorn.cms.service;

import java.util.List;

import org.thorn.cms.entity.Template;
import org.thorn.dao.exception.DBAccessException;

/**
 * @ClassName: ITemplateService
 * @Description:
 * @author chenyun
 * @date 2013-2-20 下午12:00:47
 */
public interface ITemplateService {

	public void save(Template tp) throws DBAccessException;

	public void modify(Template tp) throws DBAccessException;

	public void delete(Template tp) throws DBAccessException;

	public Template queryOne(Integer id, String absolutePath)
			throws DBAccessException;

	public List<Template> queryList(Integer siteId, String path)
			throws DBAccessException;
}
