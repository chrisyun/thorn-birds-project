package org.thorn.dd.controller;

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
import org.thorn.dd.entity.Dict;
import org.thorn.dd.entity.DictType;
import org.thorn.dd.service.IDataDictService;
import org.thorn.web.BaseController;
import org.thorn.web.Status;

/**
 * @ClassName: DDController
 * @Description:
 * @author chenyun
 * @date 2012-5-7 上午11:45:31
 */
@Controller
public class DDController extends BaseController {
	
	static Logger log = LoggerFactory.getLogger(DDController.class);
	
	@Autowired
	@Qualifier("ddService")
	private IDataDictService ddService;

	@RequestMapping("/dd/getDtPage")
	@ResponseBody
	public Page<DictType> getDtPage(long start, long limit, String sort,
			String dir, String ename, String cname) {

		Page<DictType> page = new Page<DictType>();
		try {
			page = ddService.queryDtPage(ename, cname,
					start, limit, sort, dir);
		} catch (DBAccessException e) {
			log.error("getDtPage[DD] - " + e.getMessage(), e);
		}

		return page;
	}
	
	@RequestMapping("/dd/getDdList")
	@ResponseBody
	public Page<Dict> getDdList(String typeId) {
		List<Dict> list = new ArrayList<Dict>();
		try {
			list = ddService.queryDdList(typeId);
		} catch (DBAccessException e) {
			log.error("getDdList[DD] - " + e.getMessage(), e);
		}
		
		Page<Dict> page = new Page<Dict>();
		page.setReslutSet(list);
		page.setTotal(list.size());
		
		return page;
	}
	
	@RequestMapping("/dd/saveOrModifyDd")
	@ResponseBody
	public Status saveOrModifyDd(Dict dd, String opType) {
		Status status = new Status();
		
		try {
			
			if(LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				ddService.saveDd(dd);
				status.setMessage("新增字典项成功！");
			} else if(LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				ddService.modifyDd(dd);
				status.setMessage("修改字典项成功！");
			}
			
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyDd[DD] - " + e.getMessage(), e);
		}
		
		return status;
	}
	
	@RequestMapping("/dd/saveOrModifyDt")
	@ResponseBody
	public Status saveOrModifyDt(DictType dt, String opType) {
		Status status = new Status();
		
		try {
			
			if(LocalStringUtils.equals(opType, Configuration.OP_SAVE)) {
				ddService.saveDt(dt);
				status.setMessage("新增字典类型成功！");
			} else if(LocalStringUtils.equals(opType, Configuration.OP_MODIFY)) {
				ddService.modifyDt(dt);
				status.setMessage("修改字典类型成功！");
			}
			
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyDt[DD] - " + e.getMessage(), e);
		}
		
		return status;
	}
	
	@RequestMapping("/dd/deleteDd")
	@ResponseBody
	public Status deleteDd(String ids) {
		Status status = new Status();
		
		try {
			ddService.deleteDd(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteDd[DD] - " + e.getMessage(), e);
		}
		
		return status;
	}
	
	@RequestMapping("/dd/deleteDt")
	@ResponseBody
	public Status deleteDt(String ids) {
		Status status = new Status();

		try {
			ddService.deleteDt(ids);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteDt[DD] - " + e.getMessage(), e);
		}
		
		return status;
	}

}
