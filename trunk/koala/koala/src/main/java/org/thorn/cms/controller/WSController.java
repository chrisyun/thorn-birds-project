package org.thorn.cms.controller;

import java.io.File;
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
import org.thorn.cms.entity.WebSite;
import org.thorn.cms.service.IWebSiteService;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Status;

/**
 * @ClassName: WSController
 * @Description:
 * @author chenyun
 * @date 2013-2-19 上午9:32:18
 */
@Controller
@RequestMapping("/CMS/WS")
public class WSController extends BaseController {

	static Logger log = LoggerFactory.getLogger(WSController.class);

	@Autowired
	@Qualifier("wsService")
	private IWebSiteService wsService;

	@RequestMapping("/queryWebSites.jhtml")
	public String queryWebSites(String name, ModelMap model) {

		try {
			List<WebSite> list = wsService.queryList(name);
			model.put("list", list);
		} catch (DBAccessException e) {
			log.error("queryWebSites[WebSite] - " + e.getMessage(), e);
		}

		return "cms/webSite";
	}

	@RequestMapping(value = "/queryWebSite.jmt", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponse<WebSite> queryWebSite(Integer id) {
		JsonResponse<WebSite> json = new JsonResponse<WebSite>();

		try {
			json.setObj(wsService.queryOne(id));
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("数据获取失败：" + e.getMessage());
			log.error("queryWebSite[WebSite] - " + e.getMessage(), e);
		}

		return json;
	}

	@RequestMapping(value = "/deleteWebSite.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status deleteWebSite(String ids, HttpSession session) {
		if(!ids.endsWith(",")) {
			ids += ",";
		}
		
		Status status = new Status();

		try {
			if(StringUtils.isNotBlank(ids)) {
				wsService.delete(ids);
			}

			// 更新Session
			WebSite wsSession = (WebSite) session
					.getAttribute(CMSConfiguration.SESSION_WS);

			if (wsSession != null && ids.indexOf(wsSession.getId() + ",") >= 0) {
				session.removeAttribute(CMSConfiguration.SESSION_WS);
			}

			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteWebSite[WebSite] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping(value = "/saveOrModifyWebSite.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyWebSite(WebSite ws, String opType,
			HttpSession session) {
		Status status = new Status();

		try {

			if (StringUtils.equals(opType, Configuration.OP_SAVE)) {

				// 检查站点目录是否已经存在
				StringBuilder path = new StringBuilder(session
						.getServletContext().getRealPath(""));

				if (StringUtils.equals("\\", File.separator)) {
					path.append(CMSConfiguration.TEMPLATE_ROOT.replaceAll("/",
							"\\\\"));
				} else {
					path.append(CMSConfiguration.TEMPLATE_ROOT);
				}
				path.append(ws.getTemplateFolder());

				File folder = new File(path.toString());

				if (folder.exists()) {
					status.setSuccess(false);
					status.setMessage("模板文件夹已经存在！");
				} else {
					folder.mkdirs();

					wsService.save(ws);
					status.setMessage("新增站点成功！");
				}
			} else if (StringUtils.equals(opType, Configuration.OP_MODIFY)) {
				ws.setTemplateFolder(null);
				wsService.modify(ws);
				status.setMessage("修改站点成功！");

				// 更新Session
				WebSite wsSession = (WebSite) session
						.getAttribute(CMSConfiguration.SESSION_WS);

				if (wsSession != null && ws.getId() - wsSession.getId() == 0) {
					ws.setTemplateFolder(wsSession.getTemplateFolder());
					session.setAttribute(CMSConfiguration.SESSION_WS, ws);
				}
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyWebSite[WebSite] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping(value = "/querySwitchWebSite.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status switchWebSite(Integer id, HttpSession session) {
		Status status = new Status();

		try {
			WebSite ws = wsService.queryOne(id);
			session.setAttribute(CMSConfiguration.SESSION_WS, ws);

			status.setMessage("切换站点成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("切换站点失败：" + e.getMessage());
			log.error("switchWebSite[WebSite] - " + e.getMessage(), e);
		}

		return status;
	}

}
