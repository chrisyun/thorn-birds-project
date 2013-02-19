package org.thorn.cms.controller;

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
import org.thorn.cms.common.CMSHelper;
import org.thorn.cms.entity.Channel;
import org.thorn.cms.entity.WebSite;
import org.thorn.cms.service.IChannelService;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Page;
import org.thorn.web.entity.Status;
import org.thorn.web.entity.Tree;

/**
 * @ClassName: ChannelController
 * @Description:
 * @author chenyun
 * @date 2013-2-19 下午4:44:00
 */
@Controller
@RequestMapping("/CMS/cl")
public class ChannelController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ChannelController.class);

	@Autowired
	@Qualifier("clService")
	private IChannelService clService;

	@RequestMapping("/queryChannelPage.jhtml")
	public String channelPage(Long pageIndex, Long pageSize, String sort,
			String dir, Integer pid, String name, HttpSession session,
			ModelMap model) {
		Page<Channel> page = new Page<Channel>(pageIndex, pageSize);

		try {

			WebSite ws = CMSHelper.getCurrentWebSite(session);
			page.setPageData(clService.queryPage(name, pid, ws.getId(), null,
					page.getStart(), page.getPageSize(), sort, dir));

			model.put("page", page);
		} catch (DBAccessException e) {
			log.error("channelPage[Channel] - " + e.getMessage(), e);
		}

		return "cms/channel";
	}

	@RequestMapping(value = "/queryChannelTree.jmt", method = RequestMethod.POST)
	@ResponseBody
	public List<Tree> queryChannelTree(Integer pid) {
		List<Tree> tree = new ArrayList<Tree>();

		try {
			List<Channel> list = clService.queryList(null, pid, null, null);

			for (Channel cl : list) {
				Tree node = new Tree();
				node.setId(String.valueOf(cl.getId()));
				node.setText(cl.getName());
				node.setLeaf(false);
				node.setPid(String.valueOf(cl.getPid()));
				tree.add(node);
			}
		} catch (Exception e) {
			log.error("queryChannelTree[Channel] - " + e.getMessage(), e);
		}

		return tree;
	}

	@RequestMapping(value = "/queryChannel.jmt", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponse<Channel> queryChannel(Integer id) {
		JsonResponse<Channel> json = new JsonResponse<Channel>();

		try {
			json.setObj(clService.queryOne(id));
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("数据获取失败：" + e.getMessage());
			log.error("queryChannel[Channel] - " + e.getMessage(), e);
		}

		return json;
	}

	@RequestMapping(value = "/deleteChannel.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status deleteChannel(String ids, HttpSession session) {
		Status status = new Status();

		try {
			if (StringUtils.isNotBlank(ids)) {
				clService.delete(ids);
			}

			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteChannel[Channel] - " + e.getMessage(), e);
		}

		return status;
	}

	@RequestMapping(value = "/saveOrModifyChannel.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyChannel(Channel cl, String opType,
			HttpSession session) {
		Status status = new Status();

		try {
			if (StringUtils.equals(opType, Configuration.OP_SAVE)) {
				WebSite ws = CMSHelper.getCurrentWebSite(session);
				cl.setSiteId(ws.getId());

				clService.save(cl);
				status.setMessage("新增栏目成功！");
			} else if (StringUtils.equals(opType, Configuration.OP_MODIFY)) {
				cl.setSiteId(null);

				clService.modify(cl);
				status.setMessage("修改栏目成功！");
			}
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyChannel[Channel] - " + e.getMessage(), e);
		}

		return status;
	}

}
