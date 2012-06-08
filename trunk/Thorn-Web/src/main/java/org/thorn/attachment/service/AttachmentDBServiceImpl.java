package org.thorn.attachment.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.multipart.MultipartFile;
import org.thorn.attachment.dao.IAttachmentDao;
import org.thorn.attachment.entity.Attachment;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.log.NoLogging;

/**
 * @ClassName: AttachmentServiceImpl
 * @Description:
 * @author chenyun
 * @date 2012-6-7 下午09:20:21
 */
public class AttachmentDBServiceImpl implements IAttachmentService {

	String saveType = "DB";

	@Autowired
	@Qualifier("attDao")
	private IAttachmentDao attDao;

	@NoLogging
	public void uploadAtt(Attachment att, MultipartFile file)
			throws DBAccessException {
		att.setSaveType(saveType);

		String name = att.getFileName();
		if (name.indexOf(".") > 0) {
			int index = name.lastIndexOf(".") + 1;
			att.setFileType(name.substring(index));
		}

		if (LocalStringUtils.equals("DB", saveType)) {
			try {
				att.setFile(file.getBytes());
			} catch (IOException e) {
				throw new DBAccessException(
						"getBytes from multipartFile exception", e);
			}
		}

		attDao.save(att);
	}

	public Attachment downloadAtt(Integer id) throws DBAccessException {
		return attDao.queryAtt(id);
	}

	public List<Attachment> queryAtts(String ids) throws DBAccessException {
		List<String> idsArray = LocalStringUtils.splitStr2Array(ids);

		return attDao.query(idsArray);
	}

	public void delete(String ids) throws DBAccessException {
		List<String> list = LocalStringUtils.splitStr2Array(ids);
		attDao.delete(list);
	}

	public Page<Attachment> queryPage(String uploader, String startTime,
			String endTime, String fileType, long start, long limit,
			String sort, String dir) throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		
		filter.put("uploader", uploader);
		filter.put("fileType", fileType);
		filter.put("startTime", startTime);
		filter.put("endTime", endTime);
		
		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);
		
		if(LocalStringUtils.isEmpty(sort)) {
			filter.put(Configuration.SROT_NAME, "UPLOADTIME");
			filter.put(Configuration.ORDER_NAME, Configuration.ORDER_DESC);
		} else {
			filter.put(Configuration.SROT_NAME, sort);
			filter.put(Configuration.ORDER_NAME, dir);
		}
		
		return attDao.queryPage(filter);
	}

}
