package org.thorn.dao.mybatis.cache;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.apache.ibatis.cache.Cache;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thorn.core.cache.CacheException;
import org.thorn.core.cache.CacheService;
import org.thorn.core.context.SpringContext;

/**
 * @ClassName: MemCache
 * @Description:
 * @author chenyun
 * @date 2012-5-3 下午02:32:49
 */
public class CustomCache implements Cache {

	static Logger log = LoggerFactory.getLogger(CustomCache.class);

	private final ReadWriteLock readWriteLock = new ReentrantReadWriteLock();

	private String id;

	private CacheService cacheService;
	
	private String springBean;
	
	private List<String> cacheKeys = new ArrayList<String>();

	public CustomCache(String id) {
		this.id = id;
	}

	public String getSpringBean() {
		return springBean;
	}

	public void setSpringBean(String springBean) {
		this.springBean = springBean;
		cacheService = SpringContext.getBean(springBean);
	}

	public String getId() {
		return id;
	}

	public int getSize() {
		return cacheKeys.size();
	}

	public void putObject(Object key, Object value) {
		String hashKye = String.valueOf(key.hashCode());

		try {
			cacheService.set(hashKye, value);
			cacheKeys.add(hashKye);
		} catch (CacheException e) {
			log.error("myBatis cache put exception", e);
		}
	}

	public Object getObject(Object key) {
		String hashKye = String.valueOf(key.hashCode());

		if (cacheKeys.contains(hashKye)) {

			try {
				return cacheService.get(hashKye);
			} catch (CacheException e) {
				log.error("myBatis cache get exception", e);
			}
		}

		return null;
	}

	public Object removeObject(Object key) {
		String hashKye = String.valueOf(key.hashCode());

		try {
			cacheService.delete(hashKye);
		} catch (CacheException e) {
			log.error("myBatis cache remove exception", e);
		}

		cacheKeys.remove(hashKye);
		return null;
	}

	public void clear() {
		try {
			cacheService.flush();
		} catch (CacheException e) {
			log.error("myBatis cache clear exception", e);
		}

		cacheKeys.clear();
	}

	public ReadWriteLock getReadWriteLock() {
		return readWriteLock;
	}

}
