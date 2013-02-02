package org.thorn.org.controller;

import java.util.ArrayList;
import java.util.List;

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
import org.thorn.dao.core.Configuration;
import org.thorn.security.SecurityUserUtils;
import org.thorn.user.entity.User;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.org.entity.Org;
import org.thorn.org.service.IOrgService;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Status;
import org.thorn.web.entity.Tree;

/**
 * @ClassName: OrgController
 * @Description:
 * @author chenyun
 * @date 2012-5-10 下午02:50:02
 */
@Controller
@RequestMapping("/System/org")
public class OrgController extends BaseController {

	static Logger log = LoggerFactory.getLogger(OrgController.class);

	@Autowired
	@Qualifier("orgService")
	private IOrgService orgService;
	
	@RequestMapping("/queryOrgPage.jhtml")
	public String orgPage(Long pageIndex, Long pageSize, String sort,
			String dir, String pid, String orgCode, String orgName,
			String orgType, ModelMap model) {

		Page<Org> page = new Page<Org>(pageIndex, pageSize);

		String area = null;

		try {
			User user = SecurityUserUtils.getCurrentUser();

			if (!SecurityUserUtils.isSysAdmin()) {
				area = user.getArea();
			}

			page.setPageData(orgService.queryPage(pid, orgCode, orgName,
					orgType, area, page.getStart(), page.getPageSize(), sort,
					dir));
			
			model.put("page", page);
		} catch (DBAccessException e) {
			log.error("orgPage[org] - " + e.getMessage(), e);
		}

		return "system/org";
	}

	/**
	 * 
	 * @Description：获取组织树
	 * @author：chenyun
	 * @date：2012-5-25 上午10:52:02
	 * @param pid
	 *            上级组织code
	 * @return
	 */
	@RequestMapping(value = "/queryOrgTree.jmt", method = RequestMethod.POST)
	@ResponseBody
	public List<Tree> getOrgTree(String pid) {
		List<Tree> tree = new ArrayList<Tree>();

		try {
			User user = SecurityUserUtils.getCurrentUser();

			List<Org> list = orgService.queryLeftTree(pid);

			for (Org org : list) {

				if (SecurityUserUtils.isSysAdmin()
						|| StringUtils.equals(user.getArea(),
								org.getArea())) {
					Tree node = new Tree();
					node.setId(org.getOrgCode());
					node.setText(org.getOrgName());
					node.setLeaf(false);
					node.setPid(org.getParentOrg());
					node.getAttributes().put("orgType", org.getOrgType());
					node.getAttributes().put("area", org.getArea());
					tree.add(node);
				}
			}
		} catch (Exception e) {
			log.error("getOrgTree[Org] - " + e.getMessage(), e);
		}

		return tree;
	}

	/**
	 * 
	 * @Description：新增或修改组织
	 * @author：chenyun
	 * @date：2012-5-25 上午10:53:22
	 * @param org
	 *            组织对象
	 * @param opType
	 *            操作类型
	 * @return
	 */
	@RequestMapping(value = "/saveOrModifyOrg.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyOrg(Org org, String opType) {
		Status status = new Status();

		try {

			if (StringUtils.equals(opType, Configuration.OP_SAVE)) {
				orgService.save(org);
				status.setMessage("新增组织成功！");
			} else if (StringUtils.equals(opType, Configuration.OP_MODIFY)) {
				orgService.modify(org);
				status.setMessage("修改组织成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyOrg[Org] - " + e.getMessage(), e);
		}

		return status;
	}

	/**
	 * 
	 * @Description：根据主键批量删除组织
	 * @author：chenyun
	 * @date：2012-5-25 上午10:54:09
	 * @param ids
	 *            主键字符串，格式id1,id2,
	 * @return
	 */
	@RequestMapping(value = "/deleteOrg.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status deleteOrg(String ids) {
		Status status = new Status();

		try {
			orgService.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteOrg[Org] - " + e.getMessage(), e);
		}

		return status;
	}
	
	/**
	 * 
	 * @Description：根据orgCode或者orgId查询组织
	 * @author：chenyun
	 * @date：2012-5-25 上午10:55:35
	 * @param orgCode
	 *            组织编码
	 * @param orgId
	 *            组织ID
	 * @return
	 */
	@RequestMapping(value = "/queryOrg.jmt", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponse<Org> getOrg(String orgCode, String orgId) {
		JsonResponse<Org> json = new JsonResponse<Org>();

		try {
			Org org = orgService.queryOrg(orgCode, orgId);
			json.setObj(org);
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("组织数据查询失败：" + e.getMessage());
		}

		return json;
	}
	
	@RequestMapping(value = "/saveOrModifyOrgDrag.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyOrgDrag(String ids, String target, String moveType) {
		Status status = new Status();
		
		try {
			Org org = orgService.queryOrg(target, null);
			orgService.modifyOrgByDrag(moveType, org, ids);
			status.setMessage("移动组织机构成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("移动组织机构失败：" + e.getMessage());
		}
		
		return status;
	}
	
	
	public Page<Org> getOrgPage(long start, long limit, String sort,
			String dir, String pid, String orgCode, String orgName,
			String orgType) {
		Page<Org> page = new Page<Org>();
		String area = null;

		try {
			User user = SecurityUserUtils.getCurrentUser();

			if (!SecurityUserUtils.isSysAdmin()) {
				area = user.getArea();
			}

			page = orgService.queryPage(pid, orgCode, orgName, orgType, area,
					start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getOrgPage[org] - " + e.getMessage(), e);
		}

		return page;
	}

}
