package org.cy.thorn.core.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * <p>文件名称: DateUtil.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-11-22</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class DateUtil {
	
	private final static String TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	private final static String DATE_FORMAT = "yyyy-MM-dd";
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-22
	 * @Description：获取当前时间
	 * @return 返回时间格式 yyyy-MM-dd HH:mm:ss
	 */
	public static String getNowTime() {
		SimpleDateFormat df = new SimpleDateFormat(TIME_FORMAT);
		return df.format(new Date());
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-22
	 * @Description：获取当前日期
	 * @return 返回时间格式 yyyy-MM-dd
	 */
	public static String getNowDate() {
		SimpleDateFormat df = new SimpleDateFormat(DATE_FORMAT);
		return df.format(new Date());
	}
	
}

