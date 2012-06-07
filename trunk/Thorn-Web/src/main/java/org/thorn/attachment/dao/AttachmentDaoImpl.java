package org.thorn.attachment.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.attachment.entity.Attachment;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;

/** 
 * @ClassName: AttachmentDaoImpl 
 * @Description: 
 * @author chenyun
 * @date 2012-6-7 下午09:06:43 
 */
public class AttachmentDaoImpl implements IAttachmentDao {
	
	private final static String nameSpace = "AttMapper.";

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int save(Attachment att) throws DBAccessException {
		try {
			return sqlSessionTemplate.insert(nameSpace + "insert", att);
		} catch (Exception e) {
			throw new DBAccessException("AttachmentDaoImpl", "save", e);
		}
	}

	public int delete(List<String> ids) throws DBAccessException {
		try {
			return sqlSessionTemplate.delete(nameSpace + "delete", ids);
		} catch (Exception e) {
			throw new DBAccessException("AttachmentDaoImpl", "delete", e);
		}
	}

	public Page<Attachment> queryPage(Map<String, Object> filter)
			throws DBAccessException {
		Page<Attachment> page = new Page<Attachment>();

		try {
			long count = (Long) sqlSessionTemplate.selectOne(nameSpace
					+ "selectPageCount", filter);
			page.setTotal(count);

			if (count > 0) {
				page.setReslutSet((List<Attachment>) sqlSessionTemplate.selectList(
						nameSpace + "selectPage", filter));
			}

			return page;
		} catch (Exception e) {
			throw new DBAccessException("AttachmentDaoImpl", "queryPage", e);
		}
	}

	public List<Attachment> query(List<String> ids)
			throws DBAccessException {
		try {
			return (List<Attachment>) sqlSessionTemplate.selectList(nameSpace
					+ "select", ids);
		} catch (Exception e) {
			throw new DBAccessException("AttachmentDaoImpl", "query", e);
		}
	}

	public Attachment queryAtt(Integer id) throws DBAccessException {
		try {
			return (Attachment) sqlSessionTemplate.selectOne(nameSpace
					+ "selectAtt", id);
		} catch (Exception e) {
			throw new DBAccessException("AttachmentDaoImpl", "queryAtt", e);
		}
	}

}

