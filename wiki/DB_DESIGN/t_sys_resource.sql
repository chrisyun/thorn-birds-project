INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('0', 'ALL', '/**', 'YES', 'NO', '-1', 99, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('AUTH', '用户授权', 'system/role/userAuth.jsp', 'YES', 'YES', 'SYS', 5, 'tree-auth');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('AUTH-ADD', '添加用户', '/user/saveUserRole.jmt', 'YES', 'NO', 'AUTH', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('AUTH-DELETE', '删除用户', '/user/deleteUserRole.jmt', 'YES', 'NO', 'AUTH', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('AUTH-QUERY', '授权关系查询', '/user/get*.jmt', 'YES', 'NO', 'AUTH', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('DICT', '数据字典管理', 'system/dd/dd.jsp', 'YES', 'YES', 'SYS', 0, 'tree-dd');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('DICT-DELETE', '数据字典删除', '/dd/delete*.jmt', 'YES', 'NO', 'DICT', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('DICT-QUERY', '数据字典查询', '/dd/get*.jmt', 'YES', 'NO', 'DICT', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('DICT-UPDATE', '数据字典更新', '/dd/saveOrModify*.jmt', 'YES', 'NO', 'DICT', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('MYPWD', '修改密码', 'system/user/changePwd.jsp', 'YES', 'YES', 'NAV', 99, 'tree-pwd');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('MYPWD-CHANGE', '密码修改', '/user/changePwd.jmt', 'YES', 'NO', 'MYPWD', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('NAV', '应用菜单', '', 'NO', 'YES', '0', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ORG', '组织管理', 'system/org/org.jsp', 'YES', 'YES', 'SYS', 2, 'tree-org');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ORG-DELETE', '组织删除', '/org/delete*.jmt', 'YES', 'NO', 'ORG', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ORG-QUERY', '组织查询', '/org/get*.jmt', 'YES', 'NO', 'ORG', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ORG-UPDATE', '组织更新', '/org/saveOrModify*.jmt', 'YES', 'NO', 'ORG', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ROLE', '角色管理', 'system/role/role.jsp', 'YES', 'YES', 'SYS', 4, 'tree-role');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ROLE-AUTH', '角色授权', '/role/saveAuth.jmt', 'YES', 'NO', 'ROLE', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ROLE-DELETE', '角色删除', '/role/delete*.jmt', 'YES', 'NO', 'ROLE', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ROLE-QUERY', '角色查询', '/role/get*.jmt', 'YES', 'NO', 'ROLE', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ROLE-UPDATE', '角色更新', '/role/saveOrModify*.jmt', 'YES', 'NO', 'ROLE', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SOURCE', '资源管理', 'system/resource/source.jsp', 'YES', 'YES', 'SYS', 1, 'tree-source');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SOURCE-DELETE', '资源删除', '/resource/delete*.jmt', 'YES', 'NO', 'SOURCE', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SOURCE-QUERY', '资源查询', '/resource/get*.jmt', 'YES', 'NO', 'SOURCE', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SOURCE-UPDATE', '资源更新', '/resource/saveOrModify*.jmt', 'YES', 'NO', 'SOURCE', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SYS', '系统管理', '', 'NO', 'YES', '0', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER', '用户管理', 'system/user/user.jsp', 'YES', 'YES', 'SYS', 3, 'tree-user');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-DELETE', '用户删除', '/user/deleteUser.jmt', 'YES', 'NO', 'USER', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-DISABLED', '用户启/禁用', '/user/disabled*.jmt', 'YES', 'NO', 'USER', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-PWD', '密码修改', '/user/changeMyPwd.jmt', 'YES', 'NO', 'USER', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-QUERY', '用户查询', '/user/get*.jmt', 'YES', 'NO', 'USER', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-ROLE', '用户角色管理', '/user/saveRoleByUser.jmt', 'YES', 'NO', 'USER', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-UPDATE', '用户更新', '/user/saveOrModify*.jmt', 'YES', 'NO', 'USER', 999, '');

