package org.thorn.dd.dao;

import java.util.List;
import java.util.Map;

import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dd.entity.Dict;
import org.thorn.dd.entity.DictType;

/** 
 * @ClassName: IDataDictDao 
 * @Description: 
 * @author chenyun
 * @date 2012-5-7 上午10:39:54 
 */
public interface IDataDictDao {
	
	public Page<DictType> queryDtPage(Map<String, Object> filter) throws DBAccessException;
	
	public List<Dict> queryDdList(Map<String, Object> filter) throws DBAccessException;
	
	public int saveDd(Dict dd) throws DBAccessException;
	
	public int saveDt(DictType dt) throws DBAccessException;
	
	public int modifyDd(Dict dd) throws DBAccessException;
	
	public int modifyDt(DictType dt) throws DBAccessException;
	
	public int deleteDd(List<String> ids) throws DBAccessException;
	
	public int deleteDt(List<String> ids) throws DBAccessException;
	
	public int deleteDdByType(List<String> ids) throws DBAccessException;
}

