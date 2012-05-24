package org.thorn.web;

import java.util.List;

import org.thorn.core.context.SpringContext;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.dd.entity.Dict;
import org.thorn.dd.service.IDataDictService;

/**
 * @ClassName: DDUtils
 * @Description:
 * @author chenyun
 * @date 2012-5-8 下午04:48:50
 */
public class DDUtils {

	public static List<Dict> queryDd(String typeId) throws DBAccessException {
		IDataDictService service = SpringContext.getBean("ddService");
		List<Dict> list = service.queryDdList(typeId);

		return list;
	}

}
