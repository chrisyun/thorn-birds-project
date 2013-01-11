package org.thorn.resource.cache;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.web.util.AntUrlPathMatcher;
import org.springframework.security.web.util.UrlMatcher;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.resource.entity.Resource;
import org.thorn.resource.service.IResourceService;

/**
 * @ClassName: ResourceCacheImpl
 * @Description:
 * @author chenyun
 * @date 2012-12-21 上午11:38:23
 */
public class ResourceCache {

	static Logger log = LoggerFactory.getLogger(ResourceCache.class);

	private UrlMatcher urlMatcher = new AntUrlPathMatcher();

	private IResourceService resourceService;
	
	@Autowired
	@Qualifier("resourceCache")
	private static ResourceCache cache;
	
	public static List<String> getCodeByUrl(String url) {
		return cache.getSourceCodeByUrl(url);
	}
	
	public static void refresh() throws DBAccessException {
		cache.refreshSourceCache();
	}
	
	/**
	 * 资源ID与资源URL关系map，key为ID,URL为value
	 */
	private static Map<String, String> resourceMap = null;

	public ResourceCache(IResourceService resourceService)
			throws DBAccessException {

		resourceMap = new Hashtable<String, String>(200);
		this.resourceService = resourceService;

		load();
	}

	private synchronized void load() throws DBAccessException {
		if (resourceMap.size() == 0) {
			List<Resource> sources = this.resourceService.queryAllUrl();

			for (Resource source : sources) {
				if (LocalStringUtils.isNotEmpty(source.getSourceUrl())) {
					resourceMap.put(source.getSourceCode(),
							source.getSourceUrl());
				}
			}
		}

	}

	protected List<String> getSourceCodeByUrl(String url) {

		List<String> source = new ArrayList<String>();
		for (String id : resourceMap.keySet()) {
			if (urlMatcher.pathMatchesUrl(resourceMap.get(id), url)) {
				source.add(id);
			}
		}

		return source;
	}

	protected void refreshSourceCache() throws DBAccessException {

		Map<String, String> tempMap = (Map<String, String>) ((Hashtable) this.resourceMap)
				.clone();

		try {
			resourceMap.clear();
			load();
		} catch (DBAccessException e) {
			resourceMap = tempMap;
			throw e;
		}
	}

}
