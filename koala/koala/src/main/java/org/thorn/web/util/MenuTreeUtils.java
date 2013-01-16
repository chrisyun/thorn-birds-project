package org.thorn.web.util;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.core.Configuration;
import org.thorn.resource.entity.Resource;
import org.thorn.web.entity.FullTree;

/**
 * @ClassName: MenuTreeUtils
 * @Description:
 * @author chenyun
 * @date 2013-1-16 下午4:17:05
 */
public class MenuTreeUtils {

	public static final String RESOURCE_ROOT = "root";

	/**
	 * 
	 * @Description：生成一个菜单树，去掉不显示的节点
	 * @author：chenyun
	 * @date：2013-1-16 下午4:18:45
	 * @param allSource
	 *            所有的资源集合
	 * @return
	 */
	public static FullTree generateMenuTree(List<Resource> allSource) {
		FullTree tree = new FullTree();

		tree.setId(RESOURCE_ROOT);

		sortTree(tree, allSource, true);

		return tree;
	}

	/**
	 * 
	 * @Description：生成一颗完整的资源树
	 * @author：chenyun
	 * @date：2013-1-16 下午4:19:53
	 * @param allSource
	 *            所有的资源集合
	 * @return
	 */
	public static FullTree generateSourceTree(List<Resource> allSource) {
		FullTree tree = new FullTree();

		tree.setId(RESOURCE_ROOT);

		sortTree(tree, allSource, false);

		return tree;
	}

	/**
	 * 
	 * @Description：根据节点ID生成该节点的节点树
	 * @author：chenyun
	 * @date：2013-1-16 下午4:56:55
	 * @param allSource
	 * @param pid
	 * @return
	 */
	public static FullTree generateSourceTreeOfLeaf(List<Resource> allSource,
			String pid) {
		FullTree tree = new FullTree();

		// 第一次遍历，找到当前节点的根
		for (Resource res : allSource) {
			if (LocalStringUtils.equals(res.getSourceCode(), pid)) {
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

		sortTree(tree, allSource, false);

		return tree;
	}

	/**
	 * 
	 * @Description：对资源进行递归排序，按照顺序放到fullTree上
	 * @author：chenyun
	 * @date：2012-5-25 上午11:05:56
	 * @param source
	 *            待排序的资源
	 * @param tree
	 *            非叶子节点树
	 */
	private static void sortTree(FullTree tree, List<Resource> resources,
			boolean rmNotShow) {

		for (Resource res : resources) {

			// 去掉不显示的
			if (rmNotShow
					&& StringUtils.equals(res.getIsShow(), Configuration.DB_NO)) {
				continue;
			}

			if (StringUtils.equals(res.getParentSource(), tree.getId())) {

				FullTree node = new FullTree();

				node.setId(res.getSourceCode());
				node.setText(res.getSourceName());
				node.setPid(res.getParentSource());
				node.setIconCls(res.getIconsCls());
				node.setTargetUrl(res.getSourceUrl());

				node.setUiProvider("checkBox");
				node.setExpanded(true);

				tree.getChildren().add(node);

				// 不为叶子节点，继续向下递归
				if (StringUtils.equals(res.getIsleaf(), Configuration.DB_NO)) {
					sortTree(node, resources, rmNotShow);
					node.setLeaf(false);
				} else {
					node.setLeaf(true);
				}

				// 再次进行检查
				if (node.getChildren().size() == 0) {
					node.setLeaf(true);
				}
			}
		}

	}

}
