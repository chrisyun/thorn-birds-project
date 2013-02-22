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
import org.thorn.cms.entity.Template;
import org.thorn.cms.entity.WebSite;
import org.thorn.cms.service.ITemplateService;
import org.thorn.core.util.DateTimeUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
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

			File file = new File(dir, name);
			if (file.isDirectory()) {
				return true;
			} else {
				return false;
			}
		}
	};

	@RequestMapping("/queryTemplate.jhtml")
	public String queryTemplate(Integer id, String folder, HttpSession session,
			ModelMap model) {

		try {
			if (id != null) {

				StringBuilder path = new StringBuilder(
						CMSHelper.getContextPath(session));

				path.append(CMSConfiguration.TEMPLATE_ROOT);

				Template tp = tpService.queryOne(id,
						CMSHelper.convertLocalPath(path.toString()));

				model.put("template", tp);

				folder = tp.getFolder();
			}
		} catch (DBAccessException e) {
			log.error("queryTemplate[Template] - " + e.getMessage(), e);
		}
		model.put("folder", folder);

		return "cms/tpOne";
	}

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
			path.append(CMSConfiguration.TEMPLATE_ROOT);
			path.append(folder);

			File curFolder = new File(CMSHelper.convertLocalPath(path
					.toString()));
			String dbFolder = CMSHelper.convertLocalPath(folder);
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
			log.error("queryTemplates[Template] - " + e.getMessage(), e);
		}

		return "cms/tpList";
	}

	@RequestMapping(value = "/createFolder.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status createFolder(String pFolder, String folder,
			HttpSession session) {
		Status status = new Status();

		StringBuilder path = new StringBuilder(
				CMSHelper.getContextPath(session));
		path.append(CMSConfiguration.TEMPLATE_ROOT);
		path.append(pFolder);

		path.append(File.separator).append(folder);

		File file = new File(CMSHelper.convertLocalPath(path.toString()));

		if (!file.exists()) {
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
			path.append(CMSConfiguration.TEMPLATE_ROOT);
			path.append(folder);

			File curFolder = new File(CMSHelper.convertLocalPath(path
					.toString()));
			String dbFolder = CMSHelper.convertLocalPath(folder);

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

	@RequestMapping(value = "/deleteTp.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status deleteTp(Integer id, String name, String curFolder,
			HttpSession session) {
		Status status = new Status();

		try {
			Template tp = new Template();
			tp.setName(name);

			tp.setAbsolutePath(CMSHelper.convertLocalPath(CMSHelper
					.getContextPath(session) + CMSConfiguration.TEMPLATE_ROOT));
			tp.setFolder(CMSHelper.convertLocalPath(curFolder));

			if (id == null) {
				File folder = new File(tp.getAbsolutePath() + tp.getFolder()
						+ File.separator + tp.getName());

				String[] children = folder.list();
				if (children == null || children.length == 0) {
					folder.delete();
					status.setMessage("目录删除成功！");
				} else {
					status.setSuccess(false);
					status.setMessage("请先删除目录下的文件！");
				}

			} else {
				tp.setId(id);
				tpService.delete(tp);
				status.setMessage("模板删除成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteTp[Template] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping(value = "/saveOrModifyTemplate.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyTemplate(Template tp, HttpSession session) {
		Status status = new Status();

		try {
			User user = SecurityUserUtils.getCurrentUser();
			tp.setUpdater(user.getUserId());
			tp.setUpdaterName(user.getUserName());
			tp.setUpdateTime(DateTimeUtils.getCurrentTime());
			tp.setIsDisabled(Configuration.DB_NO);
			tp.setSiteId(CMSHelper.getCurrentWebSite(session).getId());

			tp.setAbsolutePath(CMSHelper.convertLocalPath(CMSHelper
					.getContextPath(session) + CMSConfiguration.TEMPLATE_ROOT));
			tp.setFolder(CMSHelper.convertLocalPath(tp.getFolder()));

			if (tp.getId() == null) {
				tpService.save(tp);
				status.setMessage("模板新增成功！");
			} else {
				tpService.modify(tp);
				status.setMessage("模板修改成功！");
			}
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyTemplate[Template] - " + e.getMessage(), e);
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
		path.append(CMSConfiguration.TEMPLATE_ROOT);
		path.append(pFolder);

		if (!StringUtils.equals(folder, oldFolder)) {

			File file = new File(CMSHelper.convertLocalPath(path.toString())
					+ File.separator + folder);
			File oldFile = new File(CMSHelper.convertLocalPath(path.toString()) + File.separator
					+ oldFolder);
			
			if (file.exists()) {
				status.setSuccess(false);
				status.setMessage("该目录已经存在！");
			} else if (oldFile.list().length > 0) {
				status.setSuccess(false);
				status.setMessage("目录下有文件，不允许重命名！");
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
