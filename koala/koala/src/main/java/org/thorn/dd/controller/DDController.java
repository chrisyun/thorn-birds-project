package org.thorn.dd.controller;

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
import org.thorn.dao.core.Configuration;
import org.thorn.web.entity.JsonResponse;
import org.thorn.web.entity.Page;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dd.entity.Dict;
import org.thorn.dd.entity.DictType;
import org.thorn.dd.service.IDataDictService;
import org.thorn.web.controller.BaseController;
import org.thorn.web.entity.Status;

/**
 * @ClassName: DDController
 * @Description:
 * @author chenyun
 * @date 2012-5-7 上午11:45:31
 */
@Controller
@RequestMapping("/System/dd")
public class DDController extends BaseController {

	static Logger log = LoggerFactory.getLogger(DDController.class);

	@Autowired
	@Qualifier("ddService")
	private IDataDictService ddService;
	
	
	/**
	 * 
	 * @Description：分页获取字典类型
	 * @author：chenyun
	 * @date：2012-5-25 上午10:04:07
	 * @param start
	 *            开始页（0开始）
	 * @param limit
	 *            页数
	 * @param sort
	 *            排序字段
	 * @param dir
	 *            降序/升序
	 * @param ename
	 *            类型英文名
	 * @param cname
	 *            类型中文名
	 * @return
	 */
	@RequestMapping("/queryDtPage.jhtml")
	public String dtPage(Long pageIndex, Long pageSize, String sort, String dir,
			String ename, String cname, ModelMap model) {

		Page<DictType> page = new Page<DictType>(pageIndex, pageSize);

		try {
			page.setPageData(ddService.queryDtPage(ename, cname, page.getStart(),
					page.getPageSize(), sort, dir));

			model.put("page", page);
		} catch (DBAccessException e) {
			log.error("queryDtPage[DD] - " + e.getMessage(), e);
		}

		return "system/dd";
	}
	
	/**
	 * 
	 * @Description：根据主键批量删除字典类型项
	 * @author：chenyun
	 * @date：2012-5-25 上午10:09:06
	 * @param ids
	 *            主键字符串，格式id1,id2,
	 * @return
	 */
	@RequestMapping(value = "/deleteDt.jmt", method = RequestMethod.POST)
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
	
	/**
	 * 
	 * @Description：新增或修改字典类型
	 * @author：chenyun
	 * @date：2012-5-25 上午10:07:28
	 * @param dt
	 *            新增或修改的对象
	 * @param opType
	 *            操作类型
	 * @return
	 */
	@RequestMapping(value = "/saveOrModifyDt.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyDt(DictType dt, String opType) {
		Status status = new Status();

		try {

			if (StringUtils.equals(opType, Configuration.OP_SAVE)) {
				ddService.saveDt(dt);
				status.setMessage("新增字典成功！");
			} else if (StringUtils.equals(opType, Configuration.OP_MODIFY)) {
				ddService.modifyDt(dt);
				status.setMessage("修改字典成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyDt[DD] - " + e.getMessage(), e);
		}

		return status;
	}
	
	/**
	 * 
	 * @Description：新增或修改字典数据项
	 * @author：chenyun
	 * @date：2012-5-25 上午10:06:28
	 * @param dd
	 *            新增或修改的对象
	 * @param opType
	 *            操作类型
	 * @return
	 */
	@RequestMapping(value = "/saveOrModifyDd.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status saveOrModifyDd(Dict dd, String opType) {
		Status status = new Status();

		try {

			if (StringUtils.equals(opType, Configuration.OP_SAVE)) {
				ddService.saveDd(dd);
				status.setMessage("新增数据成功！");
			} else if (StringUtils.equals(opType, Configuration.OP_MODIFY)) {
				ddService.modifyDd(dd);
				status.setMessage("修改数据成功！");
			}

		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据保存失败：" + e.getMessage());
			log.error("saveOrModifyDd[DD] - " + e.getMessage(), e);
		}

		return status;
	}
	
	/**
	 * 
	 * @Description：根据类型ID获取所有的字典数据项
	 * @author：chenyun
	 * @date：2012-5-25 上午10:05:53
	 * @param typeId
	 *            类型ID
	 * @return
	 */
	@RequestMapping("/queryDdList.jmt")
	@ResponseBody
	public JsonResponse<List<Dict>> getDdList(String typeId) {
		JsonResponse<List<Dict>> json = new JsonResponse<List<Dict>>();
		try {
			json.setObj(ddService.queryDdList(typeId));
		} catch (DBAccessException e) {
			log.error("queryDdList[DD] - " + e.getMessage(), e);
		}

		return json;
	}

	/**
	 * 
	 * @Description：根据主键批量删除字典数据项
	 * @author：chenyun
	 * @date：2012-5-25 上午10:08:09
	 * @param ids
	 *            主键字符串，格式id1,id2,
	 * @param typeId
	 * @return
	 */
	@RequestMapping(value = "/deleteDd.jmt", method = RequestMethod.POST)
	@ResponseBody
	public Status deleteDd(String ids, String typeId) {
		Status status = new Status();

		try {
			ddService.deleteDd(ids, typeId);
			status.setMessage("数据删除成功！");
		} catch (DBAccessException e) {
			status.setSuccess(false);
			status.setMessage("数据删除失败：" + e.getMessage());
			log.error("deleteDd[DD] - " + e.getMessage(), e);
		}

		return status;
	}



}
