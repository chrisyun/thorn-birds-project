package org.thorn.org.service;

import java.util.List;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.org.entity.Org;

/**
 * @ClassName: IOrgService
 * @Description:
 * @author chenyun
 * @date 2012-5-10 下午02:51:01
 */
public interface IOrgService {

	public List<Org> queryLeftTree(String pid) throws DBAccessException;

	public void save(Org org) throws DBAccessException;

	public void modify(Org org) throws DBAccessException;

	public void delete(String ids) throws DBAccessException;

	public Page<Org> queryPage(String pid, String orgCode, String orgName,
			String orgType, long start, long limit, String sort, String dir)
			throws DBAccessException;
	
	public Org queryOrg(String orgCode, String orgId) throws DBAccessException;
	
}
