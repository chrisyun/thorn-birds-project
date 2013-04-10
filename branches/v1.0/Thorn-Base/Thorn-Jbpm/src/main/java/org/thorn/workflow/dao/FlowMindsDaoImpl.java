package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.ActivityMind;

/** 
 * @ClassName: FlowMindsDaoImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-7-20 下午03:27:09 
 */
public class FlowMindsDaoImpl implements IFlowMindsDao {
	
	private final static String nameSpace = "FlowMindsMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int save(ActivityMind mind) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insert", mind);
		} catch (Exception e) {
			throw new DBAccessException("FlowMindsDaoImpl", "save", e);
		}
	}

	public List<ActivityMind> queryList(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<ActivityMind>) sqlSessionTemplate.selectList(nameSpace
					+ "queryList", filter);
		} catch (Exception e) {
			throw new DBAccessException("FlowMindsDaoImpl", "queryList", e);
		}
	}

	public int modify(ActivityMind mind) throws DBAccessException {
		try {
			return sqlSessionTemplate.update(nameSpace + "update", mind);
		} catch (Exception e) {
			throw new DBAccessException("FlowMindsDaoImpl", "modify", e);
		}
	}

}

