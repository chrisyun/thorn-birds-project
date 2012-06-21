package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.core.Page;
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
			return sqlSessionTemplate.insert(nameSpace + "insert", participator);
		} catch (Exception e) {
			throw new DBAccessException("ParticipatorDaoImpl", "save", e);
		}
	}

	public int modify(Participator participator) throws DBAccessException {
		try {
			return sqlSessionTemplate.update(nameSpace + "update", participator);
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

	public Page<Participator> queryPage(Map<String, Object> filter)
			throws DBAccessException {
		Page<Participator> page = new Page<Participator>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<Participator>) sqlSessionTemplate
						.selectList(nameSpace + "selectPage", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("ParticipatorDaoImpl", "queryPage", e);
		}
	}

	public List<Participator> queryList(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<Participator>) sqlSessionTemplate.selectList(nameSpace
					+ "queryList", filter);
		} catch (Exception e) {
			throw new DBAccessException("ParticipatorDaoImpl", "queryList", e);
		}
	}

}

