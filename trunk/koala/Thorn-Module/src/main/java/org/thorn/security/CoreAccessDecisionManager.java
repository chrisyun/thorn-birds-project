package org.thorn.security;

import java.util.Collection;

import org.apache.commons.lang.StringUtils;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

/**
 * 判定资源是否能访问
 * @ClassName: CoreAccessDecisionManager
 * @Description:
 * @author chenyun
 * @date 2012-12-21 上午11:33:55
 * 
 */
public class CoreAccessDecisionManager implements AccessDecisionManager {

	/**
	 * authentication 当前用户的权限（角色） configAttributes 访问资源需要的权限（角色）
	 * AccessDeniedException 访问被拒绝异常 InsufficientAuthenticationException 用户未认证异常
	 */
	public void decide(Authentication authentication, Object object,
			Collection<ConfigAttribute> configAttributes)
			throws AccessDeniedException, InsufficientAuthenticationException {

		StringBuilder needRoles = new StringBuilder();
		int scaler = 0;

		// 资源未定义访问权限则不判断
		if (configAttributes.size() == 0) {
			return;
		}

		for (GrantedAuthority ga : authentication.getAuthorities()) {
			String userRole = ga.getAuthority().trim();

			if (StringUtils.equals(userRole,
					SecurityConfiguration.SYS_ADMIN_ROLE)) {
				return;
			}

			for (ConfigAttribute ca : configAttributes) {
				String needRole = ((SecurityConfig) ca).getAttribute().trim();

				if (StringUtils.equals(needRole, userRole)) {
					return;
				}

				needRoles.append(needRole).append(" ");
			}

			// 匿名访问用户需要登录才能访问资源
			if (StringUtils.equals(SecurityConfiguration.ANONY_MOUS_ROLE,
					userRole) && configAttributes.size() == 1) {
				throw new InsufficientAuthenticationException("用户未登录！");
			}

			scaler++;
		}

		throw new AccessDeniedException("访问该资源所需要的权限为：" + needRoles.toString());
	}

	public boolean supports(ConfigAttribute attribute) {

		return true;

	}

	public boolean supports(Class<?> clazz) {
		return true;
	}

}
