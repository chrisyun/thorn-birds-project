package org.thorn.cms.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.thorn.cms.common.CMSConfiguration;
import org.thorn.cms.entity.Template;
import org.thorn.core.util.TextfileUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dao.mybatis.helper.MyBatisDaoSupport;

/**
 * @ClassName: TemplateServiceImpl
 * @Description:
 * @author chenyun
 * @date 2013-2-20 下午1:39:50
 */
public class TemplateServiceImpl implements ITemplateService {

	@Autowired
	@Qualifier("myBatisDaoSupport")
	private MyBatisDaoSupport myBatisDaoSupport;

	public void save(Template tp) throws DBAccessException {

		String path = tp.getAbsolutePath() + tp.getFolder() + File.separator + tp.getName();

		try {
			File file = new File(path);
			File folder = file.getParentFile();
			if (!folder.exists()) {
				folder.mkdirs();
			}
			if (!file.exists()) {
				file.createNewFile();
			} else {
				throw new DBAccessException("文件已经存在！");
			}

			TextfileUtils.writeText(file, tp.getContent(),
					CMSConfiguration.TEMPLATE_ENCODING);
			
			tp.setFolder(tp.getFolder().replaceAll("\\\\", "/"));
			myBatisDaoSupport.save(tp);
		} catch (IOException e) {
			throw new DBAccessException(e);
		}
	}
	
	public void upload(Template tp) throws DBAccessException {
		myBatisDaoSupport.save(tp);
	}

	public void modify(Template tp) throws DBAccessException {

		String path = tp.getAbsolutePath() + tp.getFolder() + File.separator + tp.getName();

		try {
			Map<String, Object> filter = new HashMap<String, Object>();
			filter.put("id", tp.getId());

			Template oldTp = (Template) myBatisDaoSupport.queryOne(filter,
					Template.class);
			String oldPath = tp.getAbsolutePath() + tp.getFolder() + File.separator + oldTp.getName();
			
			File file = new File(path);
			
			if(!StringUtils.equals(path, oldPath)) {
				
				if(file.exists()) {
					throw new DBAccessException("文件已经存在！");
				}
				File oldFile = new File(oldPath);
				oldFile.renameTo(file);
			}
			
			TextfileUtils.writeText(file, tp.getContent(),
					CMSConfiguration.TEMPLATE_ENCODING);
			
			tp.setFolder(tp.getFolder().replaceAll("\\\\", "/"));
			myBatisDaoSupport.modify(tp);
		} catch (IOException e) {
			throw new DBAccessException(e);
		}
	}

	public void delete(Template tp) throws DBAccessException {

		String path = tp.getAbsolutePath() + tp.getFolder() + File.separator + tp.getName();

		File file = new File(path);
		file.delete();

		tp.setIsDisabled(Configuration.DB_YES);
		myBatisDaoSupport.modify(tp);
	}

	public Template queryOne(Integer id, String absolutePath)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("id", id);

		Template tp = (Template) myBatisDaoSupport.queryOne(filter,
				Template.class);

		String path = absolutePath + tp.getFolder() + File.separator + tp.getName();

		try {
			tp.setAbsolutePath(absolutePath);
			tp.setContent(TextfileUtils.readText(path,
					CMSConfiguration.TEMPLATE_ENCODING));

			return tp;
		} catch (IOException e) {
			throw new DBAccessException(e);
		}
	}

	public List<Template> queryList(Integer siteId, String path)
			throws DBAccessException {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("siteId", siteId);
		filter.put("folder", path);
		filter.put("isDisabled", Configuration.DB_NO);
		
		return myBatisDaoSupport.queryList(filter, Template.class);
	}

}
