package org.thorn.dd.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dd.dao.IDataDictDao;
import org.thorn.dd.entity.Dict;
import org.thorn.dd.entity.DictType;

/**
 * @ClassName: DataDictServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-5-7 上午11:01:06
 */
public class DataDictServiceImpl implements IDataDictService {

	static Logger log = LoggerFactory.getLogger(DataDictServiceImpl.class);

	@Autowired
	@Qualifier("ddDao")
	private IDataDictDao ddDao;

	public Page<DictType> queryDtPage(String ename, String cname, long start,
			long limit, String sort, String dir) throws DBAccessException {
		
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("ename", ename);
		filter.put("cname", cname);
		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);
		filter.put(Configuration.SROT_NAME, sort);
		filter.put(Configuration.ORDER_NAME, dir);

		return ddDao.queryDtPage(filter);
	}

	public List<Dict> queryDdList(String typeId) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		if (LocalStringUtils.isNotEmpty(typeId)) {
			filter.put("typeId", typeId);
		}
		
		filter.put(Configuration.SROT_NAME, "SORTNUM");
		filter.put(Configuration.ORDER_NAME, Configuration.ORDER_ASC);
		
		return ddDao.queryDdList(filter);
	}

	public void saveDd(Dict dd) throws DBAccessException {
		ddDao.saveDd(dd);
	}

	public void saveDt(DictType dt) throws DBAccessException {
		ddDao.saveDt(dt);
	}

	public void modifyDd(Dict dd) throws DBAccessException {
		ddDao.modifyDd(dd);
	}

	public void modifyDt(DictType dt) throws DBAccessException {
		ddDao.modifyDt(dt);
	}

	public void deleteDd(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		ddDao.deleteDd(list);
	}

	public void deleteDt(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		ddDao.deleteDt(list);
		ddDao.deleteDdByType(list);
		
	}

}
