package org.thorn.cms.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.cms.common.CMSConfiguration;
import org.thorn.cms.common.CMSHelper;
import org.thorn.cms.entity.Resource;
import org.thorn.core.util.DateTimeUtils;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;

/**
 * @ClassName: ResourceController
 * @Description:
 * @author chenyun
 * @date 2013-2-22 上午10:18:51
 */
@Controller
@RequestMapping("/CMS/rs")
public class CMSResourceController extends BaseController {

	static Logger log = LoggerFactory.getLogger(CMSResourceController.class);

	@RequestMapping("/queryResource.jhtml")
	public String queryResource(String pFolder, String toParent, HttpSession session,
			ModelMap model) {
		StringBuilder path = new StringBuilder(
				CMSHelper.getContextPath(session));
		path.append(CMSConfiguration.FOLDER_CSS);
		if (StringUtils.isNotBlank(pFolder)) {
			
			if(StringUtils.startsWith(pFolder, "/")) {
				pFolder = pFolder.substring(1);
			}
			
			path.append(pFolder);
		}

		File root = new File(CMSHelper.convertLocalPath(path.toString()));
		
		if(StringUtils.equals("..", toParent) && StringUtils.isNotBlank(pFolder)) {
			String name = root.getName();
			
			int index = StringUtils.lastIndexOf(pFolder, name);
			pFolder = pFolder.substring(0, index);
			root = root.getParentFile();
		}
		
		if (root.exists() && root.isDirectory()) {
			File[] files = root.listFiles();
			
			List<Resource> list = new ArrayList<Resource>();
			
			for(File file : files) {
				Resource rs = new Resource();
				
				rs.setName(file.getName());
				rs.setLastModifyTime(DateTimeUtils.formatTime(file.lastModified()));
				rs.setSize((file.length() / 1024) + "KB");
				
				if(file.isDirectory()) {
					rs.setType("folder");
				} else if(StringUtils.endsWithIgnoreCase(rs.getName(), ".png")
					|| StringUtils.endsWithIgnoreCase(rs.getName(), ".jpg")
					|| StringUtils.endsWithIgnoreCase(rs.getName(), ".jpeg")
					|| StringUtils.endsWithIgnoreCase(rs.getName(), ".gif")) {
					rs.setType("image");
				} else {
					rs.setType("file");
				}
				
				list.add(rs);
			}
			
			model.put("list", list);
		}
		
		if(StringUtils.isNotBlank(pFolder) && !StringUtils.endsWith(pFolder, "/")) {
			pFolder += "/";
		}
		
		model.put("pFolder", pFolder);
		return "cms/resource";
	}

	@RequestMapping(value = "/createFolder.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status createFolder(String pFolder, String folder,
			HttpSession session) {
		Status status = new Status();

		StringBuilder path = new StringBuilder(
				CMSHelper.getContextPath(session));
		path.append(CMSConfiguration.FOLDER_CSS);
		path.append(pFolder);

		path.append(File.separator).append(folder);

		File file = new File(CMSHelper.convertLocalPath(path.toString()));

		if (!file.exists()) {
			file.mkdirs();
		}

		status.setMessage("目录创建成功！");

		return status;
	}
	
	@RequestMapping(value = "/deleteFile.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status deleteFile(String folder, String file, HttpSession session) {
		Status status = new Status();
		
		StringBuilder path = new StringBuilder(
				CMSHelper.getContextPath(session));
		path.append(CMSConfiguration.FOLDER_CSS);
		path.append(folder);

		path.append(File.separator).append(file);

		File rs = new File(CMSHelper.convertLocalPath(path.toString()));
		
		if(!rs.exists()) {
			status.setSuccess(false);
			status.setMessage("文件或目录不存在！");
		} else if(rs.isDirectory() && rs.list().length > 0) {
			status.setSuccess(false);
			status.setMessage("请先删除目录下的文件！");
		} else {
			rs.delete();
			status.setMessage("文件或目录删除成功！");
		}
		
		return status;
	}
	
	@RequestMapping(value = "/saveOrModifyFolder.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyFolder(String folder, String pFolder,
			String oldFolder, HttpSession session) {
		Status status = new Status();

		StringBuilder path = new StringBuilder(
				CMSHelper.getContextPath(session));
		path.append(CMSConfiguration.FOLDER_CSS);
		path.append(pFolder);

		if (!StringUtils.equals(folder, oldFolder)) {

			File file = new File(CMSHelper.convertLocalPath(path.toString())
					+ File.separator + folder);
			File oldFile = new File(CMSHelper.convertLocalPath(path.toString()) + File.separator
					+ oldFolder);
			
			if (file.exists()) {
				status.setSuccess(false);
				status.setMessage("该目录已经存在！");
			} else {
				oldFile.renameTo(file);
			}
		}

		if (status.isSuccess()) {
			status.setMessage("目录重命名成功！");
		}

		return status;
	}
	
	

}
