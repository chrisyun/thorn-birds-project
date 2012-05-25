package org.cy.thorn.core.util;

import org.apache.commons.lang.StringUtils;

/**
 * <p>文件名称: PageAndSortUtil.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-11-8</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class PageAndSortUtil {
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-8
	 * @Description：
	 * @param start	起始行数（从0开始）
	 * @param limit 每页显示数量
	 * @return
	 */
	public static long getStartRowNum(long start, long limit) {
		return start+1;
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-8
	 * @Description：
	 * @param start 起始行数（从0开始）
	 * @param limit 每页显示数量
	 * @return
	 */
	public static long getEndRowNum(long start, long limit) {
		return limit + start;
	}
	
	public static String getSort(String field, String dir) {
		if(StringUtils.isEmpty(field) 
				|| StringUtils.isEmpty(dir)) {
			return "";
		}
		
		return " order by " + field + " " + dir;
	}
}

