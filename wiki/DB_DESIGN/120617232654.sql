/*
MySQL Backup
Source Server Version: 5.0.51
Source Database: thorn
Date: 2012/6/17 23:26:54
*/


-- ----------------------------
--  Table structure for `persistent_logins`
-- ----------------------------
DROP TABLE IF EXISTS `persistent_logins`;
CREATE TABLE `persistent_logins` (
  `USERNAME` varchar(200) NOT NULL,
  `SERIES` varchar(200) NOT NULL,
  `TOKEN` varchar(200) NOT NULL,
  `LAST_USED` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`SERIES`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_common_att`
-- ----------------------------
DROP TABLE IF EXISTS `t_common_att`;
CREATE TABLE `t_common_att` (
  `ID` int(11) NOT NULL auto_increment,
  `FILENAME` varchar(200) NOT NULL,
  `FILEPATH` varchar(2000) default NULL,
  `SAVETYPE` varchar(100) NOT NULL,
  `FILE` blob,
  `FILETYPE` varchar(100) NOT NULL,
  `UPLOADTIME` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `UPLOADER` varchar(200) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_dict`;
CREATE TABLE `t_sys_dict` (
  `DNAME` varchar(50) NOT NULL,
  `DVALUE` varchar(200) NOT NULL,
  `SORTNUM` int(11) default NULL,
  `TYPEID` varchar(50) NOT NULL,
  PRIMARY KEY  (`DNAME`,`TYPEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_sys_dict_type`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_dict_type`;
CREATE TABLE `t_sys_dict_type` (
  `ENAME` varchar(50) NOT NULL,
  `CNAME` varchar(50) NOT NULL,
  `TYPEDESC` varchar(200) default NULL,
  PRIMARY KEY  (`ENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_log`;
CREATE TABLE `t_sys_log` (
  `ID` int(11) NOT NULL auto_increment,
  `MODULENAME` varchar(100) default NULL,
  `METHODNAME` varchar(200) default NULL,
  `PARAMETERS` varchar(2000) default NULL,
  `USERID` varchar(50) default NULL,
  `HANDLERESULT` varchar(50) default NULL,
  `ERRORMSG` varchar(2000) default NULL,
  `EXECUTETIME` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_sys_org`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_org`;
CREATE TABLE `t_sys_org` (
  `ORGID` int(11) NOT NULL auto_increment,
  `ORGCODE` varchar(200) NOT NULL,
  `PARENTORG` varchar(200) NOT NULL,
  `ORGNAME` varchar(200) NOT NULL,
  `SHOWNAME` varchar(200) default NULL,
  `ORGTYPE` varchar(20) NOT NULL,
  `ORGMAIL` varchar(50) default NULL,
  `SORTNUM` int(11) default NULL,
  `ISSHOW` varchar(20) default NULL,
  `ISDISABLED` varchar(20) default NULL,
  `AREA` varchar(20) default NULL,
  PRIMARY KEY  (`ORGID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_sys_resource`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_resource`;
CREATE TABLE `t_sys_resource` (
  `SOURCECODE` varchar(50) NOT NULL,
  `SOURCENAME` varchar(50) NOT NULL,
  `SOURCEURL` varchar(200) default NULL,
  `ISLEAF` varchar(20) NOT NULL,
  `ISSHOW` varchar(20) NOT NULL,
  `PARENTSOURCE` varchar(50) NOT NULL,
  `SORTNUM` int(11) default NULL,
  `ICONSCLS` varchar(20) default NULL,
  PRIMARY KEY  (`SOURCECODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role`;
CREATE TABLE `t_sys_role` (
  `ROLECODE` varchar(50) NOT NULL,
  `ROLENAME` varchar(50) default NULL,
  `ROLEDESC` varchar(200) default NULL,
  `ISDISABLED` varchar(20) default NULL,
  PRIMARY KEY  (`ROLECODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_sys_role_res`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role_res`;
CREATE TABLE `t_sys_role_res` (
  `ROLECODE` varchar(50) NOT NULL,
  `SOURCECODE` varchar(50) NOT NULL,
  `CREATTIME` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ROLECODE`,`SOURCECODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE `t_sys_user` (
  `USERID` varchar(50) NOT NULL,
  `UNAME` varchar(50) NOT NULL,
  `SN` varchar(50) default NULL,
  `USERACCOUNT` varchar(50) NOT NULL,
  `USERPWD` varchar(200) default NULL,
  `GENDER` varchar(20) default NULL,
  `CUMAIL` varchar(50) default NULL,
  `PHONE` varchar(20) default NULL,
  `ORGCODE` varchar(200) default NULL,
  `ISSHOW` varchar(20) default NULL,
  `ISDISABLED` varchar(20) default NULL,
  `SORTNUM` int(11) default NULL,
  `DEFAULTROLE` varchar(50) default NULL,
  PRIMARY KEY  (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user_role`;
CREATE TABLE `t_sys_user_role` (
  `USERID` varchar(50) NOT NULL,
  `ROLECODE` varchar(50) NOT NULL,
  `CREATTIME` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`USERID`,`ROLECODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `thorn_test`
-- ----------------------------
DROP TABLE IF EXISTS `thorn_test`;
CREATE TABLE `thorn_test` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `code` varchar(200) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `persistent_logins` VALUES ('ADMIN','hTIgoUNpSD1dfb2mB7Q8VA==','oJigz8yAZlf5e/HoEnGMmg==','2012-06-17 22:02:07');
INSERT INTO `t_common_att` VALUES ('9','barney.txt','\\2012-06-08\\ADMIN\\barney_1.txt','Local',NULL,'txt','2012-06-08 20:56:44','ADMIN'),  ('10','barney.txt','\\2012-06-08\\ADMIN\\barney_2.txt','Local',NULL,'txt','2012-06-08 23:21:00','ADMIN');
INSERT INTO `t_sys_dict` VALUES ('BJ','北京','1','AREA'),  ('COMMONUSER','普通用户','1','DEFAULTROLE'),  ('COMPANY','公司',NULL,'ORGTYPE'),  ('DEPT','部门','1','ORGTYPE'),  ('FAILURE','失败','1','HANDLERESULT'),  ('femme','女','1','GENDER'),  ('HB','湖北','2','AREA'),  ('HN','湖南','3','AREA'),  ('male','男','0','GENDER'),  ('NO','否','1','YESORNO'),  ('ORG','组织','2','ORGTYPE'),  ('SUCCESS','成功',NULL,'HANDLERESULT'),  ('SYSADMIN','系统管理员',NULL,'DEFAULTROLE'),  ('tree-appLog','操作日志','6','ICONCLS'),  ('tree-att','文件图标','8','ICONCLS'),  ('tree-auth','授权图标','999','ICONCLS'),  ('tree-config','配置文件图标','9','ICONCLS'),  ('tree-dd','字典图标','2','ICONCLS'),  ('tree-org','组织图标','1','ICONCLS'),  ('tree-pwd','密码修改','3','ICONCLS'),  ('tree-role','角色图标','5','ICONCLS'),  ('tree-source','资源图标','4','ICONCLS'),  ('tree-sysLog','系统日志','7','ICONCLS'),  ('tree-user','用户图标','0','ICONCLS'),  ('YES','是',NULL,'YESORNO');
INSERT INTO `t_sys_dict_type` VALUES ('AREA','区域','组织、人员所属区域'),  ('DEFAULTROLE','默认角色',''),  ('GENDER','性别',NULL),  ('HANDLERESULT','处理结果',NULL),  ('ICONCLS','菜单图标',NULL),  ('MODULE','日志模块',NULL),  ('ORGTYPE','组织类型',NULL),  ('YESORNO','是否',NULL);
INSERT INTO `t_sys_org` VALUES ('1','ROOT','-1','组织树','组织树','COMPANY',NULL,'0','NO','NO',NULL),  ('2','001','ROOT','北京市分公司','北京市分公司','COMPANY',NULL,'1','YES','NO','BJ'),  ('11','002','ROOT','湖北省分公司','湖北省分公司','COMPANY','hb@thorn.com','2','YES','NO','HB'),  ('12','0011','001','信息化部','信息化部','DEPT',NULL,'0','YES','NO','BJ'),  ('13','0021','002','信息化部','信息化部','DEPT',NULL,'1','YES','NO','HB'),  ('14','0012','001','北分市场部','市场部','DEPT',NULL,'2','YES','NO','BJ');
INSERT INTO `t_sys_resource` VALUES ('0','ALL','/**','YES','NO','-1','99',''),  ('APPLOG','操作日志','/system/log/appLog.jsp','YES','YES','LOG','1','tree-appLog'),  ('APPLOG-EXCEL','操作日志导出','/log/exportLogExcel.jmt','YES','NO','APPLOG','999',NULL),  ('APPLOG-QUERY','操作日志查询','/log/getLogPage.jmt','YES','NO','APPLOG','0',NULL),  ('ATT','文件管理','/system/att/attachment.jsp','YES','YES','SYS','9','tree-att'),  ('ATT-DELETE','附件删除','/att/delete.jmt','YES','NO','NAV','3',NULL),  ('ATT-DOWNLOAD','附件下载','/att/download.jmt','YES','NO','NAV','4',NULL),  ('ATT-UPLOAD','附件上传','/att/get*.jmt','YES','NO','NAV','2',NULL),  ('AUTH','用户授权','/system/role/userAuth.jsp','YES','YES','AUTHMANAGER','1','tree-auth'),  ('AUTH-ADD','添加用户','/user/saveUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-DELETE','删除用户','/user/deleteUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-QUERY','授权关系查询','/user/get*.jmt','YES','NO','AUTH','0',''),  ('AUTHMANAGER','权限管理',NULL,'NO','YES','SYS','3',NULL),  ('CF','配置项管理',NULL,'NO','YES','SYS','0',NULL),  ('CF-MODIFY','配置文件修改','/cf/modifyConfig.jmt','YES','NO','CONFIG','1',NULL),  ('CF-QUERY','配置文件查看','/cf/get*.jmt','YES','NO','CONFIG','0',NULL),  ('CONFIG','配置文件管理','/system/cf/configurator.jsp','YES','YES','CF','1','tree-config'),  ('DICT','数据字典管理','/system/dd/dd.jsp','YES','YES','CF','0','tree-dd'),  ('DICT-DELETE','数据字典删除','/dd/delete*.jmt','YES','NO','DICT','999',''),  ('DICT-QUERY','数据字典查询','/dd/get*.jmt','YES','NO','DICT','0',''),  ('DICT-UPDATE','数据字典更新','/dd/saveOrModify*.jmt','YES','NO','DICT','999',''),  ('HOME','主页','/system/main.jsp','YES','NO','NAV','0',NULL),  ('LEFTMENU','菜单树','/resource/getLeftTree.jmt','YES','NO','NAV','1',NULL),  ('LOG','日志管理',NULL,'NO','YES','SYS','1',NULL),  ('MYPWD','修改密码','/system/user/changePwd.jsp','YES','YES','USERMANAGER','99','tree-pwd'),  ('MYPWD-CHANGE','密码修改','/user/changeMyPwd.jmt','YES','NO','MYPWD','999',''),  ('NAV','应用菜单','','NO','YES','0','0',''),  ('ORG','组织管理','/system/org/org.jsp','YES','YES','USERMANAGER','0','tree-org'),  ('ORG-DELETE','组织删除','/org/delete*.jmt','YES','NO','ORG','999',''),  ('ORG-QUERY','组织查询','/org/get*.jmt','YES','NO','ORG','0',''),  ('ORG-UPDATE','组织更新','/org/saveOrModify*.jmt','YES','NO','ORG','999',''),  ('PROCESSDF','流程定义管理','/workflow/processDf/processDf.jsp','YES','YES','WORKFLOW','0',NULL),  ('processdf-delete','流程定义删除','/wf/deleteProcessDf.jmt','YES','NO','PROCESSDF','2',NULL),  ('processdf-deploy','流程发布','/wf/deployProcess.jmt','YES','NO','PROCESSDF','1',NULL),  ('processdf-query','流程定义查询','/wf/getProcessDf*.jmt','YES','NO','PROCESSDF','0',NULL),  ('PROCESSMT','流程实例监控','/workflow/processMt/processMt.jsp','YES','YES','WORKFLOW','1',NULL),  ('processmt-cancel','流程实例结束','/wf/cancelProcessInst.jmt','YES','NO','PROCESSMT','1',NULL),  ('processmt-delete','流程实例删除','/wf/deleteProcessInst.jmt','NO','NO','PROCESSMT','2',NULL),  ('processmt-query','流程实例查询','/wf/getProcessInst*.jmt','YES','NO','PROCESSMT','0',NULL),  ('ROLE','角色管理','/system/role/role.jsp','YES','YES','AUTHMANAGER','0','tree-role'),  ('ROLE-AUTH','角色授权','/role/saveAuth.jmt','YES','NO','ROLE','999',''),  ('ROLE-DELETE','角色删除','/role/delete*.jmt','YES','NO','ROLE','999',''),  ('ROLE-QUERY','角色查询','/role/get*.jmt','YES','NO','ROLE','0',''),  ('ROLE-UPDATE','角色更新','/role/saveOrModify*.jmt','YES','NO','ROLE','999',''),  ('SOURCE','资源管理','/system/resource/source.jsp','YES','YES','CF','2','tree-source'),  ('SOURCE-DELETE','资源删除','/resource/delete*.jmt','YES','NO','SOURCE','999',''),  ('SOURCE-QUERY','资源查询','/resource/get*.jmt','YES','NO','SOURCE','0',''),  ('SOURCE-UPDATE','资源更新','/resource/saveOrModify*.jmt','YES','NO','SOURCE','999',''),  ('SYS','系统管理','','NO','YES','0','0',''),  ('SYSLOG','系统日志','/system/log/sysLog.jsp','YES','YES','LOG','0','tree-sysLog'),  ('SYSLOG-LEVEL','修改日志级别','/log/*LogLevel.jmt','YES','NO','SYSLOG','1',NULL),  ('SYSLOG-QUERY','系统日志查询','/system/log/sysLog*.jsp','YES','NO','SYSLOG','0',NULL),  ('USER','用户管理','/system/user/user.jsp','YES','YES','USERMANAGER','1','tree-user'),  ('USER-DELETE','用户删除','/user/deleteUser.jmt','YES','NO','USER','2',''),  ('USER-DISABLED','用户启/禁用','/user/disabled*.jmt','YES','NO','USER','999',''),  ('USER-PWD','密码修改','/user/changePwd.jmt','YES','NO','USER','999',''),  ('USER-QUERY','用户查询','/user/get*.jmt','YES','NO','USER','0',''),  ('USER-ROLE','用户角色管理','/user/saveRoleByUser.jmt','YES','NO','USER','999',''),  ('USER-UPDATE','用户更新','/user/saveOrModify*.jmt','YES','NO','USER','1',''),  ('USERMANAGER','用户管理',NULL,'NO','YES','SYS','2',NULL),  ('WORKFLOW','流程菜单',NULL,'NO','YES','0','999',NULL);
INSERT INTO `t_sys_role` VALUES ('COMMONUSER','普通用户',NULL,'NO'),  ('TESTDD','数据字典测试角色',NULL,'NO');
INSERT INTO `t_sys_role_res` VALUES ('COMMONUSER','ATT-DELETE','2012-06-11 21:27:13'),  ('COMMONUSER','ATT-DOWNLOAD','2012-06-11 21:27:13'),  ('COMMONUSER','ATT-UPLOAD','2012-06-11 21:27:13'),  ('COMMONUSER','HOME','2012-06-11 21:27:13'),  ('COMMONUSER','LEFTMENU','2012-06-11 21:27:13'),  ('COMMONUSER','MYPWD','2012-06-11 21:27:13'),  ('COMMONUSER','MYPWD-CHANGE','2012-06-11 21:27:13'),  ('COMMONUSER','USERMANAGER','2012-06-11 21:27:13'),  ('TESTDD','APPLOG','2012-06-11 21:34:10'),  ('TESTDD','APPLOG-QUERY','2012-06-11 21:34:10'),  ('TESTDD','ATT','2012-06-11 21:34:10'),  ('TESTDD','AUTH','2012-06-11 21:34:10'),  ('TESTDD','AUTH-QUERY','2012-06-11 21:34:10'),  ('TESTDD','AUTHMANAGER','2012-06-11 21:34:10'),  ('TESTDD','CF','2012-06-11 21:34:10'),  ('TESTDD','CF-QUERY','2012-06-11 21:34:10'),  ('TESTDD','CONFIG','2012-06-11 21:34:10'),  ('TESTDD','DICT','2012-06-11 21:34:10'),  ('TESTDD','DICT-QUERY','2012-06-11 21:34:10'),  ('TESTDD','LOG','2012-06-11 21:34:10'),  ('TESTDD','ORG','2012-06-11 21:34:10'),  ('TESTDD','ORG-QUERY','2012-06-11 21:34:10'),  ('TESTDD','ROLE','2012-06-11 21:34:10'),  ('TESTDD','ROLE-QUERY','2012-06-11 21:34:10'),  ('TESTDD','SOURCE','2012-06-11 21:34:10'),  ('TESTDD','SOURCE-QUERY','2012-06-11 21:34:10'),  ('TESTDD','SYSLOG','2012-06-11 21:34:10'),  ('TESTDD','SYSLOG-QUERY','2012-06-11 21:34:10'),  ('TESTDD','USER','2012-06-11 21:34:10'),  ('TESTDD','USER-QUERY','2012-06-11 21:34:10'),  ('TESTDD','USERMANAGER','2012-06-11 21:34:10');
INSERT INTO `t_sys_user` VALUES ('ADMIN','系统管理员','陈','CHENYUN','6994d5fd8501c8576fcfd99c3386f085','male','chenyun313@163.com','18701309727','ROOT','YES','NO','0','SYSADMIN'),  ('AINAN','艾楠','艾','ainan','67de2274915e33d54ae338ffdabeee76',NULL,'ainan@163.com',NULL,'0021','YES','NO','0','COMMONUSER'),  ('ZHENGYQ','张亚奇','张','zhangyq','77b01f654f188c182c6b6b28dffe8df8','male','zhengyq@163.com',NULL,'0021','YES','NO',NULL,'COMMONUSER');
INSERT INTO `t_sys_user_role` VALUES ('AINAN','TESTDD','2012-06-01 15:13:51');
