package org.cy.thorn.dd.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.cy.thorn.core.entity.JSONResponse;
import org.cy.thorn.core.entity.JSONSetResponse;
import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.core.util.CacheUtil;
import org.cy.thorn.core.util.DateUtil;
import org.cy.thorn.core.util.PageAndSortUtil;
import org.cy.thorn.dd.dao.IDataDictDAO;
import org.cy.thorn.dd.entity.Dict;
import org.cy.thorn.dd.entity.DictType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>文件名称: ControllerDD.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-11-3</p>
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
public class ControllerDD {
	
	static Log log = LogFactory.getLog(ControllerDD.class);
	
	@Autowired
	@Qualifier("ddService")
	private IDataDictDAO ddService;
	
	@RequestMapping("/dd/searchDTPage")
	@ResponseBody
	public JSONSetResponse<DictType> searchDTPage(long start, long limit,
			String sort, String dir,
			String filter_ename, String filter_cname) {
		Map<String, Object> filter = new HashMap<String, Object>();
		filter.put("startRow", PageAndSortUtil.getStartRowNum(start, limit));
		filter.put("endRow", PageAndSortUtil.getEndRowNum(start, limit));
		filter.put("sort", PageAndSortUtil.getSort(sort, dir));
		filter.put("ename", filter_ename);
		filter.put("cname", filter_cname);
		
		JSONSetResponse<DictType> jdResponse = ddService.searchDtPage(filter);
		
		return jdResponse;
	}
	
	@RequestMapping("/dd/submitDictType")
	@ResponseBody
	public JSONResponse submitDictType(DictType dictType, String opType) {
		JSONResponse respose = new JSONResponse();
		
		dictType.setCreattime(DateUtil.getNowDate());
		try {
			if(StringUtils.equals("add", opType)) {
				ddService.insertDtType(dictType);
				respose.setMessage("新增数据字典类型成功!");
			} else if(StringUtils.equals("update", opType)) {
				ddService.updateDtType(dictType);
				respose.setMessage("修改数据字典类型成功!");
			}
		} catch (DBAccessException e) {
			respose.setSuccess(false);
			respose.setMessage(e.getMessage());
			log.error("action exception:", e);
		}
		
		return respose;
	}
	
	@RequestMapping("/dd/deleteDictType")
	@ResponseBody
	public JSONResponse deleteDictType(String ids) {
		JSONResponse respose = new JSONResponse();
		
		List<String> list = new ArrayList<String>();
		
		String[] array = ids.split(",");
		for(String id : array) {
			if(StringUtils.isNotEmpty(id)) {
				list.add(id);
			}
		}
		
		try {
			ddService.deleteByTypeId(list);
			respose.setMessage("数据删除成功!");
		} catch (DBAccessException e) {
			respose.setSuccess(false);
			respose.setMessage(e.getMessage());
			log.error("action exception:", e);
		}
		return respose;
	}
	
	@RequestMapping("/dd/searchDdList")
	@ResponseBody
	public JSONSetResponse<Dict> searchDdList(String typeid) {
		JSONSetResponse<Dict> jdResponse = new JSONSetResponse<Dict>();
		jdResponse = ddService.searchDdList(typeid);
		return jdResponse;
	}
	
	@RequestMapping("/dd/submitDictData")
	@ResponseBody
	public JSONResponse submitDictData(Dict dict, String opType) {
		JSONResponse respose = new JSONResponse();
		
		try {
			if(StringUtils.equals("add", opType)) {
				ddService.insertDd(dict);
				respose.setMessage("新增数据字典类型成功!");
			} else if(StringUtils.equals("update", opType)) {
				ddService.updateDd(dict);
				respose.setMessage("修改数据字典类型成功!");
			}
		} catch (DBAccessException e) {
			respose.setSuccess(false);
			respose.setMessage(e.getMessage());
			log.error("action exception:", e);
		}
		
		return respose;
	}
	
	@RequestMapping("/dd/deleteDictData")
	@ResponseBody
	public JSONResponse deleteDictData(String ids, String typeid) {
		JSONResponse respose = new JSONResponse();
		
		List<String> list = new ArrayList<String>();
		
		String[] array = ids.split(",");
		for(String id : array) {
			if(StringUtils.isNotEmpty(id)) {
				list.add(id);
			}
		}
		
		try {
			ddService.deleteDd(list,typeid);
			respose.setMessage("数据删除成功!");
		} catch (DBAccessException e) {
			respose.setSuccess(false);
			respose.setMessage(e.getMessage());
			log.error("action exception:", e);
		}
		return respose;
	}
	
	@RequestMapping("/dd/refreshCache")
	@ResponseBody
	public JSONResponse refreshCache() {
		JSONResponse respose = new JSONResponse();
		CacheUtil.refreshCache();
		respose.setMessage("缓存刷新成功!");
		
		return respose;
	}
	
}

