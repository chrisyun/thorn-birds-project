package org.thorn.workflow.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.workflow.entity.FlowType;

/** 
 * @ClassName: FlowTypeDaoImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-6-23 下午07:05:28 
 */
public class FlowTypeDaoImpl implements IFlowTypeDao {
	
	private final static String nameSpace = "FlowTypeMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public int save(FlowType flow) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insert", flow);
		} catch (Exception e) {
			throw new DBAccessException("FlowTypeDaoImpl", "save", e);
		}
	}

	public int modify(FlowType flow) throws DBAccessException {
		try {
			return sqlSessionTemplate.update(nameSpace + "update", flow);
		} catch (Exception e) {
			throw new DBAccessException("FlowTypeDaoImpl", "modify", e);
		}
	}

	public int delete(List<String> ids) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "delete", ids);
		} catch (Exception e) {
			throw new DBAccessException("FlowTypeDaoImpl", "delete", e);
		}
	}

	public List<FlowType> queryList(Map<String, Object> filter)
			throws DBAccessException {
		try {
			return (List<FlowType>) sqlSessionTemplate.selectList(nameSpace
					+ "queryList", filter);
		} catch (Exception e) {
			throw new DBAccessException("FlowTypeDaoImpl", "queryList", e);
		}
	}

}

