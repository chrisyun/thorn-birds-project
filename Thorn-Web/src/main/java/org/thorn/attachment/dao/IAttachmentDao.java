package org.thorn.attachment.dao;

import java.util.List;
import java.util.Map;

import org.thorn.attachment.entity.Attachment;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;

/** 
 * @ClassName: IAttachmentDao 
 * @Description: 
 * @author chenyun
 * @date 2012-6-7 下午09:03:23 
 */
public interface IAttachmentDao {
	
	public int save(Attachment att) throws DBAccessException;
	
	public int delete(List<String> ids) throws DBAccessException;
	
	public Page<Attachment> queryPage(Map<String, Object> filter) throws DBAccessException;
	
	public List<Attachment> query(List<String> ids) throws DBAccessException;
	
	public Attachment queryAtt(Integer id) throws DBAccessException; 
}

