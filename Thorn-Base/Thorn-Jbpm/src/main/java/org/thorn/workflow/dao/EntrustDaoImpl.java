package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.Entruster;

/**
 * @ClassName: EntrustDaoImpl
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:43:07
 */
public class EntrustDaoImpl implements IEntrustDao {

	private final static String nameSpace = "EntrustMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public int save(Entruster entruster) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insert", entruster);
		} catch (Exception e) {
			throw new DBAccessException("EntrustDaoImpl", "save", e);
		}
	}

	public int modify(Entruster entruster) throws DBAccessException {
		try {
			return sqlSessionTemplate.update(nameSpace + "update", entruster);
		} catch (Exception e) {
			throw new DBAccessException("EntrustDaoImpl", "modify", e);
		}
	}

	public int delete(List<String> ids) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "delete", ids);
		} catch (Exception e) {
			throw new DBAccessException("EntrustDaoImpl", "delete", e);
		}
	}

	public Entruster queryOne(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (Entruster) sqlSessionTemplate.selectOne(nameSpace
					+ "select", filter);
		} catch (Exception e) {
			throw new DBAccessException("EntrustDaoImpl", "queryOne", e);
		}
	}

	public List<Entruster> queryList(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<Entruster>) sqlSessionTemplate.selectList(nameSpace
					+ "selectList", filter);
		} catch (Exception e) {
			throw new DBAccessException("EntrustDaoImpl", "queryList", e);
		}
	}

}
