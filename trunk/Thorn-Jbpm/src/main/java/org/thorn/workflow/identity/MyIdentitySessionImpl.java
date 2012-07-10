package org.thorn.workflow.identity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jbpm.api.identity.Group;
import org.jbpm.api.identity.User;
import org.jbpm.pvm.internal.env.EnvironmentImpl;
import org.jbpm.pvm.internal.identity.impl.UserImpl;
import org.jbpm.pvm.internal.identity.spi.IdentitySession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thorn.auth.service.IAuthService;
import org.thorn.core.util.LocalStringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.org.entity.Org;
import org.thorn.org.service.IOrgService;
import org.thorn.role.service.IRoleService;
import org.thorn.user.service.IUserService;
import org.thorn.workflow.WorkflowConfiguration;

/**
 * @ClassName: MyIdentitySession
 * @Description:
 * @author chenyun
 * @date 2012-6-18 下午09:35:48
 */
public class MyIdentitySessionImpl implements IdentitySession {

	static Logger log = LoggerFactory.getLogger(MyIdentitySessionImpl.class);

	private IUserService userService = EnvironmentImpl
			.getFromCurrent(IUserService.class);

	private IRoleService roleService = EnvironmentImpl
			.getFromCurrent(IRoleService.class);

	private IOrgService orgService = EnvironmentImpl
			.getFromCurrent(IOrgService.class);

	private IAuthService authService = EnvironmentImpl
			.getFromCurrent(IAuthService.class);

	public String createUser(String userId, String givenName,
			String familyName, String businessEmail) {
		throw new UnsupportedOperationException("you can't creat user by jbpm");
	}

	public void deleteUser(String userId) {
		throw new UnsupportedOperationException("you can't delete user by jbpm");
	}

	public String createGroup(String groupName, String groupType,
			String parentGroupId) {
		throw new UnsupportedOperationException("you can't creat group by jbpm");
	}

	public void deleteGroup(String groupId) {
		throw new UnsupportedOperationException(
				"you can't delete group by jbpm");
	}

	public void createMembership(String userId, String groupId, String role) {
		throw new UnsupportedOperationException(
				"you can't creat membership by jbpm");
	}

	public void deleteMembership(String userId, String groupId, String role) {
		throw new UnsupportedOperationException(
				"you can't delete membership by jbpm");
	}

	public List<User> findUsers() {
		throw new UnsupportedOperationException(
				"you can't get all users by jbpm");
	}

	public List<Group> findGroupsByUserAndGroupType(String userId,
			String groupType) {
		throw new UnsupportedOperationException(
				"you can't findGroupsByUserAndGroupType by jbpm");
	}

	public List<Group> findGroupsByUser(String userId) {
		throw new UnsupportedOperationException(
				"you can't findGroupsByUser by jbpm");
	}

	public User findUserById(String userId) {
		User user = null;

		try {
			org.thorn.user.entity.User thornUser = userService
					.queryUserByLogin(userId.toUpperCase());
			user = new UserImpl(thornUser.getUserId(), thornUser.getUserName(),
					thornUser.getSn());
		} catch (DBAccessException e) {
			log.error("MyIdentitySessionImpl findUserById DBAccessException:",
					e);
		}

		return user;
	}

	public List<User> findUsersById(String... userIds) {
		List<User> users = new ArrayList<User>();

		List<String> ids = Arrays.asList(userIds);

		try {
			List<org.thorn.user.entity.User> thornUsers = userService
					.queryList(null, null, null, null, null, ids, null);
			for (org.thorn.user.entity.User thornUser : thornUsers) {
				User user = new UserImpl(thornUser.getUserId(),
						thornUser.getUserName(), thornUser.getSn());
				users.add(user);
			}
		} catch (DBAccessException e) {
			log.error("MyIdentitySessionImpl findUsersById DBAccessException:",
					e);
		}

		return users;
	}

	public List<User> findUsersByGroup(String groupId) {

		List<User> users = new ArrayList<User>();

		try {
			MyGroupDefine define = MyGroupDefine.getInstance(groupId);
			if (define.isLimited()) {

				Set<String> orgs = new HashSet<String>();

				if (LocalStringUtils.equals(define.getLimit(),
						WorkflowConfiguration.LIMIT_CURORG)) {

					orgs.add(define.getLimitCode());
				} else if (LocalStringUtils.equals(define.getLimit(),
						WorkflowConfiguration.LIMIT_SUBORG)) {

					// 递归查找所有的子组织
					orgs.addAll(findSubOrg(orgs));
				} else {
					throw new IllegalStateException("Unrecognized field '"
							+ define.getLimit() + "'!");
				}

				if (LocalStringUtils.equals(define.getGroupType(),
						WorkflowConfiguration.GROUP_ORG)) {
					orgs.addAll(define.getGroupId());

					users = findUsersByOrg(orgs);

				} else if (LocalStringUtils.equals(define.getGroupType(),
						WorkflowConfiguration.GROUP_ROLE)) {

					users = findUsersByRole(define.getGroupId(), orgs);
				} else if (LocalStringUtils.equals(define.getGroupType(),
						WorkflowConfiguration.GROUP_AREA)) {

					users = findUsersByArea(define.getGroupId(), orgs);
				} else if (LocalStringUtils.equals(define.getGroupType(),
						WorkflowConfiguration.GROUP_USER)) {

					users = findUsersByIds(define.getGroupId(), orgs);
				}

			} else {

				if (LocalStringUtils.equals(define.getGroupType(),
						WorkflowConfiguration.GROUP_ORG)) {
					Set<String> orgs = new HashSet<String>();
					orgs.addAll(define.getGroupId());

					users = findUsersByOrg(orgs);

				} else if (LocalStringUtils.equals(define.getGroupType(),
						WorkflowConfiguration.GROUP_ROLE)) {

					users = findUsersByRole(define.getGroupId(), null);
				} else if (LocalStringUtils.equals(define.getGroupType(),
						WorkflowConfiguration.GROUP_AREA)) {

					users = findUsersByArea(define.getGroupId(), null);
				} else if (LocalStringUtils.equals(define.getGroupType(),
						WorkflowConfiguration.GROUP_USER)) {

					users = findUsersByIds(define.getGroupId(), null);
				}
			}

		} catch (IOException e) {
			log.error(
					"MyIdentitySessionImpl findUsersById IOException by json resolving",
					e);
		} catch (DBAccessException e) {
			log.error("MyIdentitySessionImpl findUsersById DBAccessException",
					e);
		}

		return users;
	}

	public Group findGroupById(String groupId) {
		// Group group = null;
		//
		// try {
		// MyGroupDefine define = MyGroupDefine.getInstance(groupId);
		// String name = "";
		// if (LocalStringUtils.equals(define.getGroupType(),
		// WorkflowConfiguration.GROUP_AREA)) {
		//
		// name = DDUtils.queryDdById("", define.getGroupId());
		// } else if (LocalStringUtils.equals(define.getGroupType(),
		// WorkflowConfiguration.GROUP_ROLE)) {
		//
		//
		//
		// } else if (LocalStringUtils.equals(define.getGroupType(),
		// WorkflowConfiguration.GROUP_ORG)) {
		//
		// Org org = orgService.queryOrg(define.getGroupId(), null);
		// name = org.getOrgName();
		// }
		//
		// group = new GroupImpl();
		// } catch (IOException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// } catch (DBAccessException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		//
		return null;
	}

	private List<User> findUsersByIds(Set<String> userIds, Set<String> orgIds)
			throws DBAccessException {
		List<User> users = new ArrayList<User>();

		List<org.thorn.user.entity.User> thornUsers = userService.queryList(
				null, null, null, null, null, userIds, orgIds);
		for (org.thorn.user.entity.User thornUser : thornUsers) {
			User user = new UserImpl(thornUser.getUserId(),
					thornUser.getUserName(), thornUser.getSn());
			users.add(user);
		}

		return users;
	}

	private List<User> findUsersByRole(Set<String> roleCode, Set<String> orgIds)
			throws DBAccessException {
		List<User> users = new ArrayList<User>();

		List<org.thorn.user.entity.User> thornUsers = authService
				.queryListByRole(roleCode, orgIds);
		for (org.thorn.user.entity.User thornUser : thornUsers) {
			User user = new UserImpl(thornUser.getUserId(),
					thornUser.getUserName(), thornUser.getSn());
			users.add(user);
		}

		return users;
	}

	private List<User> findUsersByOrg(Set<String> orgIds)
			throws DBAccessException {
		List<User> users = new ArrayList<User>();

		List<org.thorn.user.entity.User> thornUsers = userService.queryList(
				null, null, null, null, null, null, orgIds);
		for (org.thorn.user.entity.User thornUser : thornUsers) {
			User user = new UserImpl(thornUser.getUserId(),
					thornUser.getUserName(), thornUser.getSn());
			users.add(user);
		}

		return users;
	}

	private List<User> findUsersByArea(Set<String> area, Set<String> orgIds)
			throws DBAccessException {
		List<User> users = new ArrayList<User>();

		List<org.thorn.user.entity.User> thornUsers = userService.queryList(
				null, null, null, area, null, null, orgIds);
		for (org.thorn.user.entity.User thornUser : thornUsers) {
			User user = new UserImpl(thornUser.getUserId(),
					thornUser.getUserName(), thornUser.getSn());
			users.add(user);
		}

		return users;
	}

	/**
	 * 查找子组织，递归查找
	 * 
	 * @Description：
	 * @author：chenyun
	 * @date：2012-7-2 下午04:28:05
	 * @param pids
	 * @return
	 * @throws DBAccessException
	 */
	private Set<String> findSubOrg(Set<String> pids) throws DBAccessException {

		Set<String> orgIds = new HashSet<String>();

		List<Org> orgs = orgService.queryList(null, pids);
		for (Org org : orgs) {
			orgIds.add(org.getOrgCode());
		}

		if (orgIds.size() > 0) {
			Set<String> allIds = findSubOrg(orgIds);
			allIds.containsAll(orgIds);
			return allIds;
		}

		return orgIds;
	}

}
