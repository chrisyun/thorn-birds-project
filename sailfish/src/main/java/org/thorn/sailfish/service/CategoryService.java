package org.thorn.sailfish.service;

import org.thorn.sailfish.entity.Category;
import org.thorn.sailfish.dao.CategoryDao;
import org.thorn.sailfish.core.Configuration;

import java.util.HashMap;
import java.util.List;
import java.util.Arrays;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.thorn.sailfish.entity.Page;

/**
 * @Author: yfchenyun
 * @Since: 2013-10-30 13:58:11
 * @Version: 1.0
 */
@Service
public class CategoryService {

    @Autowired
    private CategoryDao categoryDao;

    public void save(Category category) {
        categoryDao.save(category);
    }

    public void modify(Category category) {
        categoryDao.modify(category);
    }

    public void delete(String ids) {
        String[] array = StringUtils.split(ids, ',');
        if(array == null || array.length == 0) {
            return ;
        }

        List<String> list = Arrays.asList(array);
        categoryDao.delete(list);
    }

    public Page<Category> queryPage(long start, long limit, String sort, String dir) {
        Map<String, Object> filter = new HashMap<String, Object>();

		filter.put(Configuration.PAGE_LIMIT, limit);
		filter.put(Configuration.PAGE_START, start);
		filter.put(Configuration.SORT_NAME, sort);
		filter.put(Configuration.ORDER_NAME, dir);

		Page<Category> page = new Page<Category>();

		page.setTotal(categoryDao.count(filter));
		if(page.getTotal() > 0) {
			page.setResultSet(categoryDao.query(filter));
		}

		return page;
    }

}