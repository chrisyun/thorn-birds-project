package org.thorn.cms.controller;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.cms.common.CMSConfiguration;
import org.thorn.cms.common.CMSHelper;
import org.thorn.cms.entity.Channel;
import org.thorn.cms.entity.Template;
import org.thorn.cms.entity.WebSite;
import org.thorn.cms.service.ITemplateService;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;
import org.thorn.web.entity.Tree;

/**
 * @ClassName: TemplateController
 * @Description:
 * @author chenyun
 * @date 2013-2-20 下午2:03:14
 */
@Controller
@RequestMapping("/CMS/tp")
public class TemplateController extends BaseController {

	static Logger log = LoggerFactory.getLogger(TemplateController.class);

	@Autowired
	@Qualifier("tpService")
	private ITemplateService tpService;
	
	
	private FilenameFilter folderFilter = new FilenameFilter() {

		public boolean accept(File dir, String name) {

			if (dir.isDirectory()) {
				return true;
			} else {
				return false;
			}
		}
	};
	
	@RequestMapping("/queryTemplates.jhtml")
	public String queryTemplates(String folder, HttpSession session,
			ModelMap model) {

		try {
			WebSite ws = CMSHelper.getCurrentWebSite(session);

			if (StringUtils.isBlank(folder)) {
				folder = ws.getTemplateFolder();
			}

			StringBuilder path = new StringBuilder(
					CMSHelper.getContextPath(session));

			if (StringUtils.equals("\\", File.separator)) {
				path.append(CMSConfiguration.TEMPLATE_ROOT.replaceAll("/",
						"\\\\"));
				path.append(folder.replaceAll("/", "\\\\"));
			} else {
				path.append(CMSConfiguration.TEMPLATE_ROOT.replaceAll("\\\\",
						"/"));
				path.append(folder.replaceAll("\\\\", "/"));
			}

			File curFolder = new File(path.toString());
			String dbFolder = folder.replaceAll("\\\\", "/");
			model.put("dbFolder", dbFolder);

			List<Template> list = tpService.queryList(ws.getId(), dbFolder);

			String[] folders = curFolder.list(folderFilter);

			for (String dir : folders) {
				Template tp = new Template();

				tp.setSiteId(ws.getId());
				tp.setName(dir);

				list.add(0, tp);
			}

			model.put("list", list);
		} catch (DBAccessException e) {
			log.error("channelPage[Channel] - " + e.getMessage(), e);
		}

		return "cms/tpList";
	}
	
	@RequestMapping(value = "/createFolder.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status createFolder(String pFolder, String folder,
			HttpSession session) {
		Status status = new Status();
		
		StringBuilder path = new StringBuilder(CMSHelper.getContextPath(session));
		
		if (StringUtils.equals("\\", File.separator)) {
			path.append(CMSConfiguration.TEMPLATE_ROOT.replaceAll("/",
					"\\\\"));
			path.append(pFolder.replaceAll("/", "\\\\"));
		} else {
			path.append(CMSConfiguration.TEMPLATE_ROOT.replaceAll("\\\\",
					"/"));
			path.append(pFolder.replaceAll("\\\\", "/"));
		}
		
		path.append(File.separator).append(folder);
		
		File file = new File(path.toString());
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		status.setMessage("目录创建成功！");
		
		return status;
	}
	
	@RequestMapping(value = "/queryTemplateTree.jmt", method = RequestMethod.POST)
	@ResponseBody
	public List<Tree> queryTemplateTree(String folder, HttpSession session) {
		List<Tree> tree = new ArrayList<Tree>();
		
		try {
			WebSite ws = CMSHelper.getCurrentWebSite(session);
			
			if (StringUtils.isBlank(folder)) {
				folder = ws.getTemplateFolder();
			}
			
			StringBuilder path = new StringBuilder(
					CMSHelper.getContextPath(session));

			if (StringUtils.equals("\\", File.separator)) {
				path.append(CMSConfiguration.TEMPLATE_ROOT.replaceAll("/",
						"\\\\"));
				path.append(folder.replaceAll("/", "\\\\"));
			} else {
				path.append(CMSConfiguration.TEMPLATE_ROOT.replaceAll("\\\\",
						"/"));
				path.append(folder.replaceAll("\\\\", "/"));
			}

			File curFolder = new File(path.toString());
			String dbFolder = folder.replaceAll("\\\\", "/");
			
			List<Template> list = tpService.queryList(ws.getId(), dbFolder);

			String[] folders = curFolder.list(folderFilter);

			for (String dir : folders) {
				Tree node = new Tree();
				node.setId(dbFolder + "/" + dir);
				node.setText(dir);
				node.setLeaf(false);
				tree.add(node);
			}
			
			for (Template tp : list) {
				Tree node = new Tree();
				node.setId(String.valueOf(tp.getId()));
				node.setText(tp.getName());
				node.setLeaf(true);
				tree.add(node);
			}
			
		} catch (DBAccessException e) {
			log.error("queryTemplateTree[Template] - " + e.getMessage(), e);
		}

		return tree;
	}
	
}
