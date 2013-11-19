package org.thorn.sailfish.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.thorn.sailfish.service.CategoryService;

/**
 * @Author: yfchenyun
 * @Since: 13-10-30 下午2:01
 * @Version: 1.0
 */
@Controller
@RequestMapping("/am/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;



}
