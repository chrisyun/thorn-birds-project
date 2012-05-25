package org.cy.thorn.core.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.cy.thorn.core.cache.ICacheManage;
import org.cy.thorn.core.util.spring.SpringContextUtils;

/**
 * <p>文件名称: CacheUtil.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-10-18</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public class CacheUtil {
	
	static Log log = LogFactory.getLog(CacheUtil.class);
	
	private static ICacheManage cache = null;
	
	private static void initCache() {
		if(cache == null) {
			cache = SpringContextUtils.getBean("baseCache");
		}
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-18
	 * @Description：从缓存中获取对象
	 * @param elementId
	 * @return
	 */
	public static Object getObject(String elementId) {
		initCache();
		
		Object obj = null;
		try {
			obj = cache.getCacheElement(elementId);
		} catch (Exception e) {
			log.error("get object from cache error:"+elementId, e);
		}
		
		return obj;
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-18
	 * @Description：从缓存中清除对象
	 * @param elementId
	 */
	public static void deleteObject(String elementId) {
		initCache();
		
		try {
			cache.clearCacheElement(elementId);
		} catch (Exception e) {
			log.error("clear cache object error:"+elementId, e);
		}
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-18
	 * @Description：更新缓存中的对象，若无则新增
	 * @param elementId
	 * @param obj
	 */
	public static void updateObject(String elementId, Object obj) {
		initCache();
		
		try {
			cache.putCacheElement(elementId, obj);
		} catch (Exception e) {
			log.error("update cache object error:"+elementId, e);
		}
	}
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-11-24
	 * @Description：刷新全部缓存
	 */
	public static void refreshCache() {
		initCache();
		cache.refreshCache();
	}
}

