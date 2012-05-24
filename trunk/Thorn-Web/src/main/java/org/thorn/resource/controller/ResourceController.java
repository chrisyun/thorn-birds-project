package org.thorn.resource.controller;

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
import org.thorn.resource.entity.Resource;
import org.thorn.resource.service.IResourceService;
import org.thorn.web.FullTree;
import org.thorn.web.JsonResponse;
import org.thorn.web.Status;
import org.thorn.web.BaseController;
import org.thorn.web.Tree;

/**
 * @ClassName: ResourceController
 * @Description:
 * @author chenyun
 * @date 2012-5-6 下午10:51:39
 */
@Controller
public class ResourceController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ResourceController.class);

	@Autowired
	@Qualifier("resourceService")
	private IResourceService service;

	@RequestMapping("/resource/getLeftTree")
	@ResponseBody
	public List<Tree> getLeftTree(String pid) {
		List<Tree> tree = new ArrayList<Tree>();

		try {
			List<Resource> source = service.queryLeftTree(pid);
			for (Resource res : source) {
				Tree node = new Tree();
				node.setId(res.getSourceCode());
				node.setText(res.getSourceName());
				node.setPid(res.getParentSource());

				node.setTargetUrl(res.getSourceUrl());
				node.setIconCls(res.getIconsCls());

				if (LocalStringUtils.equals(res.getIsleaf(),
						Configuration.DB_YES)) {
					node.setLeaf(true);
				} else {
					node.setLeaf(false);
				}
				tree.add(node);
			}
		} catch (Exception e) {
			log.error("getLeftTree[Resource] - " + e.getMessage(), e);
		}

		return tree;
	}
	
	@RequestMapping("/resource/getSourceTree")
	@ResponseBody
	public List<FullTree> getSourceTree(String pid) {
		List<FullTree> ft = new ArrayList<FullTree>();
		
		FullTree tree = new FullTree();

		try {
			List<Resource> allSource = service.queryAllSource();
			
			//第一次遍历，找到当前节点的根
			for (Resource res : allSource) {
				if(LocalStringUtils.equals(res.getSourceCode(), pid)) {
					tree.setId(res.getSourceCode());
					tree.setText(res.getSourceName());
					tree.setPid(res.getParentSource());
					tree.setIconCls(res.getIconsCls());
					tree.setLeaf(false);
					
					tree.setUiProvider("checkBox");
					tree.setExpanded(true);
					break;
				}
			}
			
			//递归向下加子节点
			sortTree(allSource, tree);
			
		} catch (Exception e) {
			log.error("getSourceTree[Resource] - " + e.getMessage(), e);
		}
		
		ft.add(tree);
		return ft;
	}
	
	private void sortTree(List<Resource> source, FullTree tree) {
		
		for(Resource res : source) {
			if(LocalStringUtils.equals(res.getParentSource(), tree.getId())) {
				
				FullTree node = new FullTree();
				
				node.setId(res.getSourceCode());
				node.setText(res.getSourceName());
				node.setPid(res.getParentSource());
				node.setIconCls(res.getIconsCls());
				node.setTargetUrl(res.getSourceUrl());
				
				node.setUiProvider("checkBox");
				node.setExpanded(true);
				
				tree.getChildren().add(node);
				
				sortTree(source, node);
				
				if(node.getChildren().size() == 0) {
					node.setLeaf(true);
				}
				
			}
		}
		
	}
	
	@RequestMapping("/resource/getSourceCodeByRole")
	@ResponseBody
	public JsonResponse<List> getSourceCodeByRole(String roleCode) {
		JsonResponse<List> json = new JsonResponse<List>();
		
		try {
			List<String> list = service.queryResourceByRole(roleCode);
			json.setObj(list);
			
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("获取数据失败：" + e.getMessage());
			log.error("getSourceCodeByRole[String] - " + e.getMessage(), e);
		}
		
		return json;
	}
	
	@RequestMapping("/resource/saveOrModifySource")
	@ResponseBody
	public Status saveOrModifySource(Resource source, String opType) {
		Status status = new Status();

		try {

			if (LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				service.save(source);
				status.setMessage("新增资源成功！");
			} else if (LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				service.modify(source);
				status.setMessage("修改资源成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyOrg[Resource] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/resource/deleteSource")
	@ResponseBody
	public Status deleteSource(String ids) {
		Status status = new Status();

		try {
			service.delete(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteResource[Resource] - " + e.getMessage(), e);
		}

		return status;
	}
	
	@RequestMapping("/resource/getSourcePage")
	@ResponseBody
	public Page<Resource> getSourcePage(long start, long limit, String sort,
			String dir, String pid, String sourceCode, String sourceName) {
		Page<Resource> page = new Page<Resource>();

		try {
			page = service.queryPage(pid, sourceCode, sourceName, start,
					limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getOrgPage[Resource] - " + e.getMessage(), e);
		}

		return page;
	}
	
	@RequestMapping("/resource/getResource")
	@ResponseBody
	public JsonResponse<Resource> getResource(String sourceCode) {
		JsonResponse<Resource> json = new JsonResponse<Resource>();
		
		try {
			Resource source = service.queryResource(sourceCode);
			json.setObj(source);
		} catch (DBAccessException e) {
			json.setSuccess(false);
			json.setMessage("资源数据查询失败：" + e.getMessage());
		}
		
		return json;
	}
	
	
}
