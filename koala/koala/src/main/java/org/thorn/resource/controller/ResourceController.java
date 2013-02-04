package org.thorn.resource.controller;

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
import org.thorn.auth.service.IAuthService;
import org.thorn.dao.core.Configuration;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.resource.cache.ResourceCache;
import org.thorn.resource.entity.Resource;
import org.thorn.resource.service.IResourceService;
import org.thorn.security.SecurityUserUtils;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.FullTree;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Status;
import org.thorn.web.entity.Tree;
import org.thorn.web.util.MenuTreeUtils;

/**
 * @ClassName: ResourceController
 * @Description:
 * @author chenyun
 * @date 2012-5-6 下午10:51:39
 */
@Controller
@RequestMapping("/System/resource")
public class ResourceController extends BaseController {

	static Logger log = LoggerFactory.getLogger(ResourceController.class);

	@Autowired
	@Qualifier("resourceService")
	private IResourceService service;

	@Autowired
	@Qualifier("authService")
	private IAuthService authService;

	@RequestMapping("/queryResourcePage.jhtml")
	public String resourcePage(Long pageIndex, Long pageSize, String sort,
			String dir, String pid, String sourceCode, String sourceName,
			ModelMap model) {
		Page<Resource> page = new Page<Resource>(pageIndex, pageSize);

		try {
			page.setPageData(service.queryPage(pid, sourceCode, sourceName,
					page.getStart(), page.getPageSize(), sort, dir));

			model.put("page", page);
		} catch (DBAccessException e) {
			log.error("resourcePage[Resource] - " + e.getMessage(), e);
		}

		return "system/resource";
	}

	/**
	 * 
	 * @Description：一次性获取整个资源树，无需层级加载
	 * @author：chenyun
	 * @date：2012-5-25 上午11:05:00
	 * @param pid
	 * @return
	 */
	@RequestMapping(value = "/queryResourceTree.jmt", method = RequestMethod.POST)
	@ResponseBody
	public FullTree queryResourceTree(String pid) {
		FullTree tree = new FullTree();

		try {
			List<Resource> allSource = service.queryAllSource();

			tree = MenuTreeUtils.generateSourceTreeOfLeaf(allSource, pid);
		} catch (Exception e) {
			log.error("queryResourceTree[Resource] - " + e.getMessage(), e);
		}

		return tree;
	}

	/**
	 * 
	 * @Description：根据主键批量删除资源
	 * @author：chenyun
	 * @date：2012-5-25 上午11:16:09
	 * @param ids
	 *            主键字符串，格式id1,id2,
	 * @return
	 */
	@RequestMapping(value = "/deleteResource.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status deleteResource(String ids) {
		Status status = new Status();

		try {
			service.delete(ids);
			ResourceCache.refresh();
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteResource[Resource] - " + e.getMessage(), e);
		}

		return status;
	}

	/**
	 * 
	 * @Description：根据资源code获取单个资源对象
	 * @author：chenyun
	 * @date：2012-5-25 上午11:17:25
	 * @param sourceCode
	 * @return
	 */
	@RequestMapping(value = "/queryResource.jmt", method = RequestMethod.POST)
	@ResponseBody
	public JsonResponse<Resource> queryResource(String sourceCode) {
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

	/**
	 * 
	 * @Description：新增或修改资源
	 * @author：chenyun
	 * @date：2012-5-25 上午11:15:10
	 * @param source
	 *            资源对象
	 * @param opType
	 *            操作类型
	 * @return
	 */
	@RequestMapping(value = "/saveOrModifyResource.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyResource(Resource source, String opType) {
		Status status = new Status();

		try {

			if (StringUtils.equals(opType, Configuration.OP_SAVE)) {
				service.save(source);
				status.setMessage("新增资源成功！");
			} else if (StringUtils.equals(opType, Configuration.OP_MODIFY)) {
				service.modify(source);
				status.setMessage("修改资源成功！");
			}
			ResourceCache.refresh();
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyResource[Resource] - " + e.getMessage(), e);
		}

		return status;
	}

	/**
	 * 
	 * @Description：获取系统左边菜单树，带权限控制
	 * @author：chenyun
	 * @date：2012-5-25 上午11:03:59
	 * @param pid
	 *            上级资源ID
	 * @param isSourcePanel
	 *            请求是否来自资源面板 YES
	 * @return
	 */
	public List<Tree> getLeftTree(String pid, String isSourcePanel) {
		List<Tree> tree = new ArrayList<Tree>();

		List<String> userSource = SecurityUserUtils.getSoucrceList();

		try {
			List<Resource> source = service.queryLowerNodes(pid);
			for (Resource res : source) {

				if (!StringUtils.equals("YES", isSourcePanel)) {
					if (!SecurityUserUtils.isSysAdmin()
							&& !userSource.contains(res.getSourceCode())) {
						continue;
					}
				}

				Tree node = new Tree();
				node.setId(res.getSourceCode());
				node.setText(res.getSourceName());
				node.setPid(res.getParentSource());

				node.setTargetUrl(res.getSourceUrl());
				node.setIconCls(res.getIconsCls());

				if (StringUtils.equals(res.getIsleaf(),
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

}
