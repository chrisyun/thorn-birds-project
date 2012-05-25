package org.cy.thorn.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.cy.thorn.core.exceptions.DBAccessException;
import org.cy.thorn.resource.dao.IResourceDAO;
import org.cy.thorn.resource.entity.Resource;
import org.cy.thorn.role.dao.IRoleDAO;
import org.cy.thorn.role.entity.Authority;
import org.cy.thorn.util.SecurityEncoderUtil;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.AntUrlPathMatcher;
import org.springframework.security.web.util.UrlMatcher;
import org.springframework.stereotype.Service;

/**
 * 最核心的地方，就是提供某个资源对应的权限定义，即getAttributes方法返回的结果。 
 * 此类在初始化时，应该取到所有资源及其对应角色的定义。
 * 
 */
@Service
public class CustomInvocationSecurityMetadataSourceService implements
		FilterInvocationSecurityMetadataSource {
	
	static Log log = LogFactory.getLog(CustomInvocationSecurityMetadataSourceService.class);
	
	private UrlMatcher urlMatcher = new AntUrlPathMatcher();
	
	/**
	 * 资源ID与资源URL关系map，key为ID,URL为value
	 */
	private static Map<String, String> resourceMap = null;
	
	private IResourceDAO resourceService;
	
	private IRoleDAO roleService;
	
	/**
	 * 初始化该类时，加载资源列表URL与资源ID
	 * @throws DBAccessException 
	 */
	public CustomInvocationSecurityMetadataSourceService(
			IResourceDAO resourceService, IRoleDAO roleService) throws DBAccessException {
		//由于资源匹配时要注意匹配顺序，最高级别的放在最后
		resourceMap = new LinkedHashMap<String, String>();
		
		this.resourceService = resourceService;
		this.roleService = roleService;
		
//		System.out.println(SecurityEncoderUtil.encodeUserPassword("000000", "ADMIN"));
		
//		//执行构造函数时，属性spring木有初始化，NND
//		ApplicationContext context = new ClassPathXmlApplicationContext(new String[]{
//			"classpath:applicationContext-mybatis.xml",
//			"classpath:applicationContext-sys-business.xml",
//			"classpath:applicationContext-security-service.xml"});
//		resourceService = (IResourcesService) context.getBean("resourcesService");
//		roleService = (IRoleService) context.getBean("roleService");
		
		List<Resource> sources = this.resourceService.searchResource(null);
		
		for (Resource source : sources) {
			resourceMap.put(source.getResid(), source.getResurl());
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
        
        String sourceId = "";
        for(String id : resourceMap.keySet()) {
        	if(urlMatcher.pathMatchesUrl(resourceMap.get(id), url)) {
        		sourceId = id;
        		break;
        	}
        }
        
        Collection<ConfigAttribute> collection = new ArrayList<ConfigAttribute>();
        
        if(StringUtils.isNotEmpty(sourceId)) {
        	List<Authority> au = new ArrayList<Authority>();
    		try {
    			au = roleService.searchRoleByResorce(sourceId);
    		} catch (DBAccessException e) {
    			log.error("search authority from db error", e);
    		}
            
            
            for(Authority auth : au) {
            	ConfigAttribute ca = new SecurityConfig(auth.getRid());
            	collection.add(ca);
            }
        } else {
        	ConfigAttribute ca = new SecurityConfig("NONROLE");
        	collection.add(ca);
        }
        
		return collection;
	}

	public boolean supports(Class<?> arg0) {

		return true;
	}
		
	public static void main(String[] args) {
		String a = "/amk/cddlk/kl.jsp";
		String b = "/**";
		
		UrlMatcher urlMatcher = new AntUrlPathMatcher();
		System.out.println(urlMatcher.pathMatchesUrl(b, a));
		
		
	}
	
	
}
