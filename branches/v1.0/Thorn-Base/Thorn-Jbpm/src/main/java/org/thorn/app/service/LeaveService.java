package org.thorn.app.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.app.entity.LeaveForm;
import org.thorn.dao.core.AOPTransactional;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.mybatis.helper.MyBatisDaoSupport;

/**
 * @ClassName: LeaveService
 * @Description:
 * @author chenyun
 * @date 2012-7-17 下午03:05:07
 */
@AOPTransactional
public class LeaveService {

	@Autowired
	@Qualifier("myBatisDaoSupport")
	private MyBatisDaoSupport myBatisDaoSupport;

	public void save(LeaveForm form) throws DBAccessException {
		myBatisDaoSupport.save(form);
	}
	
	public void modify(LeaveForm form) throws DBAccessException {
		myBatisDaoSupport.modify(form);
	}

	public LeaveForm queryByAppId(Integer appId) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("id", appId);

		LeaveForm form = (LeaveForm) myBatisDaoSupport.queryOne(filter,
				LeaveForm.class);
		return form;
	}

}
