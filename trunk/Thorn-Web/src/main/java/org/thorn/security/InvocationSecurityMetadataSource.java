package org.thorn.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.AntUrlPathMatcher;
import org.springframework.security.web.util.UrlMatcher;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.resource.entity.Resource;
import org.thorn.resource.service.IResourceService;
import org.thorn.role.entity.Role;
import org.thorn.role.service.IRoleService;

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

	private UrlMatcher urlMatcher = new AntUrlPathMatcher();

	/**
	 * 资源ID与资源URL关系map，key为ID,URL为value
	 */
	private static Map<String, String> resourceMap = null;

	private IResourceService resourceService;

	private IRoleService roleService;

	/**
	 * 初始化该类时，加载资源列表URL与资源ID
	 * 
	 * @throws DBAccessException
	 */
	public InvocationSecurityMetadataSource(IResourceService resourceService,
			IRoleService roleService) throws DBAccessException {
		
//		System.out.println(SecurityEncoderUtils.encodeUserPassword("wwwwww", "ADMIN"));
		
		resourceMap = new HashMap<String, String>();

		this.resourceService = resourceService;
		this.roleService = roleService;

		List<Resource> sources = this.resourceService.queryAllLeaf();

		for (Resource source : sources) {
			resourceMap.put(source.getSourceCode(), source.getSourceUrl());
		}
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

		List<String> source = new ArrayList<String>();
		for (String id : resourceMap.keySet()) {
			if (urlMatcher.pathMatchesUrl(resourceMap.get(id), url)) {
				source.add(id);
			}
		}

		Collection<ConfigAttribute> collection = new ArrayList<ConfigAttribute>();

		if (source.size() > 0) {
			try {
				List<Role> roles = roleService.queryRolesByResource(source);

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
	
//	public static void main(String[] args) {
//		String a = "/amk/cddlk/kl.jsp";
//		String b = "/**";
//
//		UrlMatcher urlMatcher = new AntUrlPathMatcher();
//		System.out.println(urlMatcher.pathMatchesUrl(b, a));
//
//	}

}
