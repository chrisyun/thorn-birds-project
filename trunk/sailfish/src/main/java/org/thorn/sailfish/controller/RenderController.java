package org.thorn.sailfish.controller;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.thorn.sailfish.core.Configuration;
import org.thorn.sailfish.core.Page;
import org.thorn.sailfish.entity.Article;
import org.thorn.sailfish.entity.Category;
import org.thorn.sailfish.entity.CategoryNode;
import org.thorn.sailfish.enums.ArticleStatusEnum;
import org.thorn.sailfish.enums.YesOrNoEnum;
import org.thorn.sailfish.service.ArticleService;
import org.thorn.sailfish.service.CategoryService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * @Author: yfchenyun
 * @Since: 13-12-3 下午9:14
 * @Version: 1.0
 */
@Controller
@RequestMapping("/web")
public class RenderController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ArticleService articleService;

    static Logger log = LoggerFactory.getLogger(RenderController.class);

    private List<CategoryNode> sortCategory(List<Category> categories) {
        List<CategoryNode> list = new ArrayList<CategoryNode>();
        Map<String, CategoryNode> map = new HashMap<String, CategoryNode>();

        CategoryNode root = new CategoryNode();
        map.put(Configuration.CATEGORY_ROOT, root);

        for (Category category : categories) {

            if (category.getHidden() - YesOrNoEnum.YES.getCode() == 0) {
                continue;
            }

            CategoryNode node = new CategoryNode();
            node.setRoot(category);

            list.add(node);
            map.put(category.getEnName(), node);
        }

        for (CategoryNode node : list) {
            CategoryNode parent = map.get(node.getRoot().getParent());
            if (parent != null) {
                parent.getLeaves().add(node);
            }
        }

        return root.getLeaves();
    }

    private void sortCategoryLeaves(List<CategoryNode> list) {
        if (list == null || list.size() == 0) {
            return;
        }

        Collections.sort(list);
        for (CategoryNode node : list) {
            sortCategoryLeaves(node.getLeaves());
        }
    }

    private void copyMap(HttpServletRequest request, ModelMap modelMap) {
        Enumeration<String> e = request.getParameterNames();

        while(e.hasMoreElements()) {
            String name = e.nextElement();
            String[] values = request.getParameterValues(name);

            if(values == null || values.length == 0) {
                continue;
            }

            if(values.length == 1) {
                modelMap.put(name, values[0]);
            } else {
                modelMap.put(name, values);
            }
        }
    }

    @RequestMapping("/{categoryPath}/index")
    public String categoryIndex(@PathVariable("categoryPath") String categoryPath,
                                HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        String path = null;

        try {
            Category currentCategory = categoryService.queryByPath(categoryPath);

            if (currentCategory == null) {
                // 路径错误
                return "redirect:/web/page?t=404";
            }

            String ctxPath = request.getContextPath();
            String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + ctxPath + "/";

            modelMap.put("path", ctxPath);
            modelMap.put("basePath", basePath);
            modelMap.put("res", request.getContextPath() + "/cms");
            modelMap.put("category", currentCategory);

            copyMap(request, modelMap);

            path = currentCategory.getIndexTemplate();
        } catch (Exception e) {
            log.error("categoryIndex Exception[" + categoryPath + "]", e);
            request.setAttribute("exception", e);
            path = "forward:/web/page?t=500";
        }

        return StringUtils.removeEnd(path, Configuration.TEMPLATE_SUFFIX);
    }

    @RequestMapping("/{category}")
    public String category(@PathVariable("category") String category) {
        return "redirect:/web/" + category + "/index";
    }

    @RequestMapping("/content/{id}")
    public String article(@PathVariable("id") int id, ModelMap modelMap,
                        HttpServletRequest request, HttpServletResponse response) {
        String path = null;

        try {
            Article article = articleService.queryArticle(id);

            if (article == null) {
                // 路径错误
                return "redirect:/web/page?t=404";
            }

            Category category = categoryService.queryById(article.getCategory());

            String ctxPath = request.getContextPath();
            String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + ctxPath + "/";

            modelMap.put("path", ctxPath);
            modelMap.put("basePath", basePath);
            modelMap.put("res", request.getContextPath() + "/cms");
            modelMap.put("article", article);
            modelMap.put("category", category);

            copyMap(request, modelMap);

            path = category.getArticleTemplate();
        } catch (Exception e) {
            log.error("article Exception[" + id + "]", e);
            request.setAttribute("exception", e);
            path = "forward:/web/page?t=500";
        }

        return StringUtils.removeEnd(path, Configuration.TEMPLATE_SUFFIX);
    }

    @RequestMapping("/page")
    public String alone(String t, HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        String ctxPath = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + ctxPath + "/";

        modelMap.put("path", ctxPath);
        modelMap.put("basePath", basePath);
        modelMap.put("res", request.getContextPath() + "/cms");

        copyMap(request, modelMap);

        return t;
    }

}
