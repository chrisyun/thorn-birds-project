package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.Participator;

/**
 * @ClassName: ParticipatorDaoImpl
 * @Description:
 * @author chenyun
 * @date 2012-6-20 下午10:43:07
 */
public class ParticipatorDaoImpl implements IParticipatorDao {

	private final static String nameSpace = "ParticipatorMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public int save(Participator participator) throws DBAccessException {
		try {
			return sqlSessionTemplate
					.insert(nameSpace + "insert", participator);
		} catch (Exception e) {
			throw new DBAccessException("ParticipatorDaoImpl", "save", e);
		}
	}

	public int modify(Participator participator) throws DBAccessException {
		try {
			return sqlSessionTemplate
					.update(nameSpace + "update", participator);
		} catch (Exception e) {
			throw new DBAccessException("ParticipatorDaoImpl", "modify", e);
		}
	}

	public int delete(List<String> ids) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "delete", ids);
		} catch (Exception e) {
			throw new DBAccessException("ParticipatorDaoImpl", "delete", e);
		}
	}

	public long queryPageCount(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageCount", filter);
		} catch (Exception e) {
			throw new DBAccessException("ParticipatorDaoImpl",
					"queryPageCount", e);
		}
	}

	public List<Participator> queryList(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<Participator>) sqlSessionTemplate.selectList(nameSpace
					+ "selectPage", filter);
		} catch (Exception e) {
			throw new DBAccessException("ParticipatorDaoImpl", "queryList", e);
		}
	}

}
