package org.thorn.security;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.thorn.auth.service.IAuthService;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.resource.entity.Resource;
import org.thorn.resource.service.IResourceService;
import org.thorn.role.entity.Role;
import org.thorn.security.entity.UserSecurity;
import org.thorn.user.entity.User;
import org.thorn.user.service.IUserService;
import org.thorn.web.entity.FullTree;
import org.thorn.web.util.MenuTreeUtils;

/**
 * 
 * @ClassName: UserSecurityDetailsService
 * @Description: 提供查找用户的service服务
 * @author chenyun
 * @date 2012-5-4 下午03:22:18
 * 
 */
public class UserSecurityDetailsService implements UserDetailsService {

	@Autowired
	@Qualifier("userSecurityCache")
	private UserCache userCache;

	@Autowired
	@Qualifier("userService")
	private IUserService userService;

	@Autowired
	@Qualifier("authService")
	private IAuthService authService;

	@Autowired
	@Qualifier("resourceService")
	private IResourceService resourceService;

	public UserDetails loadUserByUsername(String arg0)
			throws UsernameNotFoundException, DataAccessException {
		arg0 = arg0.toUpperCase();

		UserSecurity us = (UserSecurity) userCache.getUserFromCache(arg0);

		try {
			if (us == null) {
				us = new UserSecurity(userService.queryUserByLogin(arg0));
				User user = us.getUser();
				if (user != null && StringUtils.isNotEmpty(user.getUserId())) {
					List<Role> roles = authService.queryRoleByUser(user
							.getUserId());

					us.initUserAuth(roles);

					// 计算出用户的权限菜单树
					List<Resource> allSource = resourceService.queryAllSource();

					FullTree tree = MenuTreeUtils.generateMenuTree(allSource);

					List<String> roleCodes = new ArrayList<String>();
					for (Role r : roles) {
						roleCodes.add(r.getRoleCode());
					}
					List<String> source = authService
							.queryResourceByRole(roleCodes);

					// 递归遍历资源树，将不在权限列表的资源清除
					clearResourceTree(source, tree);

					us.setMenuTree(tree);

					// 将UserSecurity放入cache中
					userCache.putUserInCache(us);
				}
			}
		} catch (DBAccessException e) {
			throw new DataAccessResourceFailureException(
					"User Query Exception", e);
		}

		if (us.getUser() == null
				|| StringUtils.isEmpty(us.getUser().getUserId())) {
			throw new UsernameNotFoundException(
					"User Not Found From DataSource");
		}

		return us;
	}

	private void clearResourceTree(List<String> source, FullTree tree) {

		for (FullTree node : tree.getChildren()) {

			if (!source.contains(node.getId())) {
				tree.getChildren().remove(node);
			} else {
				clearResourceTree(source, node);
			}
		}
	}

}
