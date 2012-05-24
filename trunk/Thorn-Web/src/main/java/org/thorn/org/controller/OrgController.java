package org.thorn.org.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.dao.core.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.org.entity.Org;
import org.thorn.org.service.IOrgService;
import org.thorn.web.BaseController;
import org.thorn.web.JsonResponse;
import org.thorn.web.Status;
import org.thorn.web.Tree;

/**
 * @ClassName: OrgController
 * @Description:
 * @author chenyun
 * @date 2012-5-10 下午02:50:02
 */
@Controller
public class OrgController extends BaseController {

	static Logger log = LoggerFactory.getLogger(OrgController.class);

	@Autowired
	@Qualifier("orgService")
	private IOrgService orgService;

	@RequestMapping("/org/getOrgTree")
	@ResponseBody
	public List<Tree> getOrgTree(String pid) {
		List<Tree> tree = new ArrayList<Tree>();

		try {
			List<Org> list = orgService.queryLeftTree(pid);

			for (Org org : list) {
				Tree node = new Tree();
				node.setId(String.valueOf(org.getOrgId()));
				node.setText(org.getOrgName());
				node.setLeaf(false);
				node.setPid(org.getOrgCode());
				node.getAttributes().put("orgType", org.getOrgType());
				tree.add(node);
			}
		} catch (Exception e) {
			log.error("getOrgTree[Org] - " + e.getMessage(), e);
		}

		return tree;
	}

	@RequestMapping("/org/saveOrModifyOrg")
	@ResponseBody
	public Status saveOrModifyOrg(Org org, String opType) {
		Status status = new Status();

		try {

			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				orgService.save(org);
				status.setMessage("新增组织成功！");
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
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

	@RequestMapping("/org/deleteOrg")
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
	
	@RequestMapping("/org/getOrgPage")
	@ResponseBody
	public Page<Org> getOrgPage(long start, long limit, String sort,
			String dir, String pid, String orgCode, String orgName,
			String orgType) {
		Page<Org> page = new Page<Org>();

		try {
			page = orgService.queryPage(pid, orgCode, orgName, orgType, start,
					limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getOrgPage[org] - " + e.getMessage(), e);
		}

		return page;
	}
	
	@RequestMapping("/org/getOrg")
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
	
}
