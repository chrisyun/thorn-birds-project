package org.cy.thorn.util;

import java.io.IOException;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.cy.thorn.core.util.spring.SpringContextUtils;
import org.cy.thorn.dd.dao.IDataDictDAO;
import org.cy.thorn.dd.entity.Dict;

/**
 * <p>文件名称: DDUtil.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-11-24</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class DDUtil {
	
	static Log log = LogFactory.getLog(DDUtil.class);
	
	private static IDataDictDAO service = null;
	
	private static void initService() {
		if(service == null) {
			service = SpringContextUtils.getBean("ddService");
		}
	}
	
	public static String getDictJsonById(String typeid) throws JsonGenerationException, JsonMappingException, IOException {
		initService();
		
		List<Dict> ls = service.searchDdList(typeid).getResultSet();
		
		ObjectMapper om = new ObjectMapper();
		
		return om.writeValueAsString(ls);
	}
}

