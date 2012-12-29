package org.thorn.security.resource;

import java.util.List;

import org.thorn.dao.exception.DBAccessException;

/**
 * @ClassName: IResourceCache
 * @Description:
 * @author chenyun
 * @date 2012-12-21 上午11:26:45
 */
public interface IResourceCache {

	/**
	 * 
	 * @Description：根据URL获取对应的资源code
	 * @author：chenyun
	 * @date：2012-12-21 上午11:29:28
	 * @param url
	 * @return
	 */
	public List<String> getSourceCodeByUrl(String url);

	/**
	 * 
	 * @Description：刷新资源缓存
	 * @author：chenyun
	 * @date：2012-12-21 上午11:29:32
	 */
	public void refreshSourceCache() throws DBAccessException;

}
