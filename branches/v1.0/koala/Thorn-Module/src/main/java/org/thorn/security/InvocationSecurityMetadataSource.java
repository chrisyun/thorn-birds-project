package org.thorn.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.thorn.auth.service.IAuthService;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.role.entity.Role;
import org.thorn.security.resource.IResourceCache;

/**
 * 
 * @ClassName: InvocationSecurityMetadataSource
 * @Description: 最核心的地方，就是提供某个资源对应的权限定义，即getAttributes方法返回的结果。
 *               此类在初始化时，应该取到所有资源及其对应角色的定义。
 * @author chenyun
 * @date 2012-5-5 下午08:40:08
 * 
 */
public class InvocationSecurityMetadataSource implements
		FilterInvocationSecurityMetadataSource {

	static Logger log = LoggerFactory
			.getLogger(InvocationSecurityMetadataSource.class);
	
	private IAuthService authService;

	private IResourceCache resourceCache;

	/**
	 * 初始化该类时，加载资源列表URL与资源ID
	 * 
	 * @throws DBAccessException
	 */
	public InvocationSecurityMetadataSource(IResourceCache resourceCache,
			IAuthService authService) throws DBAccessException {
		this.resourceCache = resourceCache;
		this.authService = authService;
	}
	
	public Collection<ConfigAttribute> getAllConfigAttributes() {
		return null;
	}

	/**
	 * 根据URL，找到相关的角色。
	 */
	public Collection<ConfigAttribute> getAttributes(Object object)
			throws IllegalArgumentException {

		// object 是一个URL，被用户请求的url。
		String url = ((FilterInvocation) object).getRequestUrl();

		int firstQuestionMarkIndex = url.indexOf("?");

		if (firstQuestionMarkIndex != -1) {
			url = url.substring(0, firstQuestionMarkIndex);
		}
		
		Collection<ConfigAttribute> collection = new ArrayList<ConfigAttribute>();
		List<String> source = resourceCache.getSourceCodeByUrl(url);
		
		if (source.size() > 0) {
			try {
				List<Role> roles = authService.queryRoleBySource(source);

				for (Role role : roles) {
					ConfigAttribute ca = new SecurityConfig(role.getRoleCode());
					collection.add(ca);
				}
			} catch (DBAccessException e) {
				log.error("Role Query Exception", e);
			}
		}

		return collection;
	}
	
	public boolean supports(Class<?> arg0) {
		return true;
	}
}
