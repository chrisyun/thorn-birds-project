package org.cy.thorn.core.cache.ehcach;

import net.sf.ehcache.Ehcache;
import net.sf.ehcache.Element;

import org.cy.thorn.core.cache.ICacheManage;
import org.springframework.util.Assert;

/**
 * <p>文件名称: EhCacheManageImpl.java</p>
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
public class EhCacheManageImpl implements ICacheManage {
	private Ehcache cache;

	public void afterPropertiesSet() throws Exception {
		Assert.notNull(cache, "cache is required");
	}

	public void clearCacheElement(String elementId) throws Exception {
		// TODO Auto-generated method stub
		Assert.hasLength(elementId,"clearCache方法中必须指定elementId");
		Assert.hasText(elementId,"clearCache方法中的elementId参数不能全为空格");
		cache.remove(elementId);
	}

	public Object getCacheElement(String elementId) throws Exception{
		// TODO Auto-generated method stub
		Assert.hasLength(elementId,"getCache方法中必须指定elementId");
		Assert.hasText(elementId,"getCache方法中的elementId参数不能全为空格");
		Object obj = cache.get(elementId);
		if(obj != null){
			Element e = (Element)obj;
			return e.getValue();
		}
		return obj;
	}

	public void putCacheElement(String elementId, Object obj) throws Exception{
		// TODO Auto-generated method stub
		Assert.hasLength(elementId,"putCache方法中必须指定elementId");
		Assert.hasText(elementId,"putCache方法中的elementId参数不能全为空格");
		Element e = new Element(elementId,obj);
		cache.put(e);
	}
	
	public void refreshCache() {
		cache.removeAll();
	}
	

	public Ehcache getCache() {
		return cache;
	}

	public void setCache(Ehcache cache) {
		this.cache = cache;
	}

}

