package org.thorn.dd.service;

import java.util.List;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dd.entity.Dict;
import org.thorn.dd.entity.DictType;

/**
 * @ClassName: IDataDictService
 * @Description:
 * @author chenyun
 * @date 2012-5-7 上午11:00:49
 */
public interface IDataDictService {

	public Page<DictType> queryDtPage(String ename, String cname, long start,
			long limit, String sort, String dir) throws DBAccessException;

	public List<Dict> queryDdList(String typeId) throws DBAccessException;

	public void saveDd(Dict dd) throws DBAccessException;

	public void saveDt(DictType dt) throws DBAccessException;

	public void modifyDd(Dict dd) throws DBAccessException;

	public void modifyDt(DictType dt) throws DBAccessException;

	public void deleteDd(String ids) throws DBAccessException;

	public void deleteDt(String ids) throws DBAccessException;
}
