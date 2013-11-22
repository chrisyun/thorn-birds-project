package org.thorn.sailfish.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.thorn.sailfish.core.Page;
import org.thorn.sailfish.entity.Article;
import org.thorn.sailfish.entity.Category;
import org.thorn.sailfish.service.ArticleService;
import org.thorn.sailfish.service.CategoryService;
import org.thorn.sailfish.utils.DateTimeUtils;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-11-21 上午10:34
 * @Version: 1.0
 */
@Controller
@RequestMapping("/am/article")
public class ArticleController {

    static Logger log = LoggerFactory.getLogger(ArticleController.class);

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/index")
    public String index(Long pageIndex, Long pageSize, String title, Integer status, String category,
                        String startTime, String endTime, ModelMap modelMap, HttpSession session) {
        Page<Article> page = new Page<Article>(pageIndex, pageSize);

        Date start = null;
        Date end = null;
        try {
            start = DateTimeUtils.formatDate(startTime);
            end = DateTimeUtils.formatDate(endTime);
        } catch (Exception e) {
            log.warn("Format date exception[startTime:?,endTime:?]", startTime, endTime);
        }

        try {
            articleService.queryPage(page, title, status, category, start, end);
            modelMap.put("page", page);

            List<Category> categories = categoryService.queryAll();
            modelMap.put("categories", categories);

        } catch (Exception e) {
            log.error("Query article page", e);
        }

        return "article";
    }

    @RequestMapping("/index/{id}")
    public String editArticle(@PathVariable("id") Integer id, ModelMap modelMap) {

        try {
            if(id != null) {
                Article article = articleService.queryArticle(id);
                if(article != null) {
                    id = article.getId();
                    modelMap.put("id", id);
                    modelMap.put("article", article);
                }
            }

            List<Category> categories = categoryService.queryAll();
            modelMap.put("categories", categories);

        } catch (Exception e) {
            log.error("editArticle[" + id + "]", e);
        }

        return "articleEditor";
    }

}
