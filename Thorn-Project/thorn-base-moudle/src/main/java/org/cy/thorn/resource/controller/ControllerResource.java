package org.cy.thorn.resource.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.cy.thorn.core.entity.CommonTree;
import org.cy.thorn.resource.dao.IResourceDAO;
import org.cy.thorn.resource.entity.Resource;
import org.cy.thorn.util.SecurityUserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>文件名称: ControllerResource.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-11-2</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
@Scope("prototype")
@Controller
public class ControllerResource {
	
	static Log log = LogFactory.getLog(ControllerResource.class);
	
	@Autowired
	@Qualifier("resourcesService")
	private IResourceDAO resourcesService;
	
	@RequestMapping("/resource/generateTree")
	@ResponseBody
	public List<CommonTree> generateResourceTree(String parentId) {
		List<CommonTree> treeArray = new ArrayList<CommonTree>();
		
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("parentres", parentId);
		filter.put("isshow", "YES");
		
		if(!SecurityUserUtil.isSysAdmin()) {
			filter.put("roleArray", SecurityUserUtil.getRoleList());
		}
		
		try {
			List<Resource> resArray = resourcesService.searchParent(filter);
			for(Resource res : resArray) {
				boolean leaf = true;
				if(StringUtils.equals("NO", res.getIsleaf())) {
					leaf = false;
				}
				
				CommonTree tree = new CommonTree();
				Map<String, String> map = new HashMap<String, String>();
				tree.setId(res.getResid());
				tree.setText(res.getSname());
				tree.setParentId(res.getParentres());
				tree.setLeaf(leaf);
				
				map.put("url", res.getResurl());
				map.put("isModule", res.getIsmodule());
				tree.setAttributes(map);
				treeArray.add(tree);
			}
		} catch (Exception e) {
			log.error("generateResourceTree happen error", e);
			treeArray = new ArrayList<CommonTree>();
		}
		
		return treeArray;
	}

	
}

