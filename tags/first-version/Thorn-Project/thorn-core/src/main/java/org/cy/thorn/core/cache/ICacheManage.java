package org.cy.thorn.core.cache;
/**
 * <p>文件名称: ICacheManage.java</p>
 * <p>文件描述: 本类描述</p>
 * <p>版权所有: 版权所有(C)2010</p>
 * <p>内容摘要: 简要描述本文件的内容，包括主要模块、函数及能的说明</p>
 * <p>其他说明: 其它内容的说明</p>
 * <p>完成日期: 2011-9-29</p>
 * <p>修改记录1:</p>
 * <pre>
 *    修改日期:
 *    修 改 人:
 *    修改内容:
 * </pre>
 * <p>修改记录2：…</p>
 * @author  chenyun
 */
public interface ICacheManage {

	/**
	 * @author：Wuqingming
	 * @date：2010-9-25
	 * @Description： 清除缓存中以elementId作为key的元素
	 * @param elementId
	 * @return
	 */
	void clearCacheElement(String elementId) throws Exception;
	
	/**
	 * @author：Wuqingming
	 * @date：2010-9-25
	 * @Description： 获取缓存中以elementId作为key的元素
	 * @param elementId
	 * @return
	 */
	Object getCacheElement(String elementId) throws Exception;
	
	/**
	 * @author：Wuqingming
	 * @date：2010-9-25
	 * @Description： 将obj放入缓存，并以elementId作为标志它的key
	 * @param elementId
	 * @return
	 */
	void putCacheElement(String elementId, Object obj) throws Exception;
	
	/**
	 * 
	 * @author：chenyun 	        
	 * @date：2011-10-18
	 * @Description：刷新缓存，即将缓存清理掉
	 */
	public void refreshCache();
	
}

