INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('0', 'ALL', '/**', 'YES', 'NO', '-1', 99, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('APPLOG', '操作日志', '/system/log/appLog.jsp', 'YES', 'YES', 'LOG', 1, 'tree-appLog');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('APPLOG-EXCEL', '操作日志导出', '/log/exportLogExcel.jmt', 'YES', 'NO', 'APPLOG', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('APPLOG-QUERY', '操作日志查询', '/log/getLogPage.jmt', 'YES', 'NO', 'APPLOG', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ATT', '文件管理', '/system/att/attachment.jsp', 'YES', 'YES', 'SYS', 9, 'tree-att');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ATT-DELETE', '附件删除', '/att/delete.jmt', 'YES', 'NO', 'NAV', 3, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ATT-DOWNLOAD', '附件下载', '/att/download.jmt', 'YES', 'NO', 'NAV', 4, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ATT-UPLOAD', '附件上传', '/att/get*.jmt', 'YES', 'NO', 'NAV', 2, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('AUTH', '用户授权', '/system/role/userAuth.jsp', 'YES', 'YES', 'AUTHMANAGER', 1, 'tree-auth');

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
   ('AUTH-QUERY', '授权关系查询', '/user/get*.jmt', 'YES', 'NO', 'AUTH', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('AUTHMANAGER', '权限管理', '', 'NO', 'YES', 'SYS', 3, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('CF', '配置项管理', '', 'NO', 'YES', 'SYS', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('CF-MODIFY', '配置文件修改', '/cf/modifyConfig.jmt', 'YES', 'NO', 'CONFIG', 1, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('CF-QUERY', '配置文件查看', '/cf/get*.jmt', 'YES', 'NO', 'CONFIG', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('CONFIG', '配置文件管理', '/system/cf/configurator.jsp', 'YES', 'YES', 'CF', 1, 'tree-config');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('DICT', '数据字典管理', '/system/dd/dd.jsp', 'YES', 'YES', 'CF', 0, 'tree-dd');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('DICT-DELETE', '数据字典删除', '/dd/delete*.jmt', 'YES', 'NO', 'DICT', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('DICT-QUERY', '数据字典查询', '/dd/get*.jmt', 'YES', 'NO', 'DICT', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('DICT-UPDATE', '数据字典更新', '/dd/saveOrModify*.jmt', 'YES', 'NO', 'DICT', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('flowtype-delete', '流程类型删除', '/wf/cr/deleteFlowType.jmt', 'YES', 'NO', 'PROCESSDF', 3, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('flowtype-modify', '流程类型修改', '/wf/df/modifyFlowType.jmt', 'YES', 'NO', 'PROCESSDF', 2, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('HOME', '主页', '/system/main.jsp', 'YES', 'NO', 'NAV', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('LEFTMENU', '菜单树', '/resource/getLeftTree.jmt', 'YES', 'NO', 'NAV', 1, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('LOG', '日志管理', '', 'NO', 'YES', 'SYS', 1, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('MYPWD', '修改密码', '/system/user/changePwd.jsp', 'YES', 'YES', 'USERMANAGER', 99, 'tree-pwd');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('MYPWD-CHANGE', '密码修改', '/user/changeMyPwd.jmt', 'YES', 'NO', 'MYPWD', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('NAV', '应用菜单', '', 'NO', 'YES', '0', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ORG', '组织管理', '/system/org/org.jsp', 'YES', 'YES', 'USERMANAGER', 0, 'tree-org');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ORG-DELETE', '组织删除', '/org/delete*.jmt', 'YES', 'NO', 'ORG', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ORG-QUERY', '组织查询', '/org/get*.jmt', 'YES', 'NO', 'ORG', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ORG-UPDATE', '组织更新', '/org/saveOrModify*.jmt', 'YES', 'NO', 'ORG', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('PARTICIPATOR', '绑定环节参与者', '/workflow/participator/participator.jsp', 'YES', 'YES', 'WORKFLOW', 2, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('participator-delete', '参与者设置删除', '/wf/pp/deleteParticipator.jmt', 'YES', 'NO', 'PARTICIPATOR', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('participator-modify', '参与者设置修改', '/wf/pp/saveOrModifyParticipator.jmt', 'YES', 'NO', 'PARTICIPATOR', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('participator-query', '参与者查询', '/wf/pp/get*.jmt', 'YES', 'NO', 'PARTICIPATOR', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('PROCESSAPP', '流程表单资源', '/wf/app/*.*', 'YES', 'NO', 'WORKFLOW', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('PROCESSCOMMON', '流程通用资源', '/wf/cm/*.*', 'YES', 'NO', 'WORKFLOW', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('PROCESSCR', '新建流程', '/workflow/list/processCr.jsp', 'YES', 'YES', 'WORKFLOW', 3, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('PROCESSDF', '流程定义管理', '/workflow/processDf/processDf.jsp', 'YES', 'YES', 'WORKFLOW', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('processdf-delete', '流程定义删除', '/wf/df/deleteProcessDf.jmt', 'YES', 'NO', 'PROCESSDF', 2, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('processdf-deploy', '流程发布', '/wf/df/deployProcess.jmt', 'YES', 'NO', 'PROCESSDF', 1, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('processdf-query', '流程定义查询', '/wf/df/getProcess*.jmt', 'YES', 'NO', 'PROCESSDF', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('PROCESSMT', '流程实例监控', '/workflow/processMt/processMt.jsp', 'YES', 'YES', 'WORKFLOW', 1, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('PROCESSTODO', '待办列表', '/workflow/list/processTodo.jsp', 'YES', 'YES', 'WORKFLOW', 4, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ROLE', '角色管理', '/system/role/role.jsp', 'YES', 'YES', 'AUTHMANAGER', 0, 'tree-role');

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
   ('ROLE-QUERY', '角色查询', '/role/get*.jmt', 'YES', 'NO', 'ROLE', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('ROLE-UPDATE', '角色更新', '/role/saveOrModify*.jmt', 'YES', 'NO', 'ROLE', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SOURCE', '资源管理', '/system/resource/source.jsp', 'YES', 'YES', 'CF', 2, 'tree-source');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SOURCE-DELETE', '资源删除', '/resource/delete*.jmt', 'YES', 'NO', 'SOURCE', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SOURCE-QUERY', '资源查询', '/resource/get*.jmt', 'YES', 'NO', 'SOURCE', 0, '');

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
   ('SYSLOG', '系统日志', '/system/log/sysLog.jsp', 'YES', 'YES', 'LOG', 0, 'tree-sysLog');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SYSLOG-LEVEL', '修改日志级别', '/log/*LogLevel.jmt', 'YES', 'NO', 'SYSLOG', 1, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('SYSLOG-QUERY', '系统日志查询', '/system/log/sysLog*.jsp', 'YES', 'NO', 'SYSLOG', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER', '用户管理', '/system/user/user.jsp', 'YES', 'YES', 'USERMANAGER', 1, 'tree-user');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-DELETE', '用户删除', '/user/deleteUser.jmt', 'YES', 'NO', 'USER', 2, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-DISABLED', '用户启/禁用', '/user/disabled*.jmt', 'YES', 'NO', 'USER', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-PWD', '密码修改', '/user/changePwd.jmt', 'YES', 'NO', 'USER', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-QUERY', '用户查询', '/user/get*.jmt', 'YES', 'NO', 'USER', 0, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-ROLE', '用户角色管理', '/user/saveRoleByUser.jmt', 'YES', 'NO', 'USER', 999, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USER-UPDATE', '用户更新', '/user/saveOrModify*.jmt', 'YES', 'NO', 'USER', 1, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('USERMANAGER', '用户管理', '', 'NO', 'YES', 'SYS', 2, '');

INSERT INTO t_sys_resource
   (`SOURCECODE`, `SOURCENAME`, `SOURCEURL`, `ISLEAF`, `ISSHOW`, `PARENTSOURCE`, `SORTNUM`, `ICONSCLS`)
VALUES
   ('WORKFLOW', '流程菜单', '', 'NO', 'YES', '0', 999, '');

