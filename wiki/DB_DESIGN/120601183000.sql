/*
MySQL Backup
Source Server Version: 5.0.51
Source Database: thorn
Date: 2012/6/1 18:30:00
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

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
INSERT INTO `t_sys_dict` VALUES ('BJ','北京','1','AREA'),  ('COMMONUSER','普通用户','1','DEFAULTROLE'),  ('COMPANY','公司',NULL,'ORGTYPE'),  ('DEPT','部门','1','ORGTYPE'),  ('FAILURE','失败','1','HANDLERESULT'),  ('femme','女','1','GENDER'),  ('HB','湖北','2','AREA'),  ('HN','湖南','3','AREA'),  ('male','男','0','GENDER'),  ('NO','否','1','YESORNO'),  ('ORG','组织','2','ORGTYPE'),  ('SUCCESS','成功',NULL,'HANDLERESULT'),  ('SYSADMIN','系统管理员',NULL,'DEFAULTROLE'),  ('tree-auth','授权图标','999','ICONCLS'),  ('tree-dd','字典图标','2','ICONCLS'),  ('tree-org','组织图标','1','ICONCLS'),  ('tree-pwd','密码修改','3','ICONCLS'),  ('tree-role','角色图标','5','ICONCLS'),  ('tree-source','资源图标','4','ICONCLS'),  ('tree-user','用户图标','0','ICONCLS'),  ('YES','是',NULL,'YESORNO');
INSERT INTO `t_sys_dict_type` VALUES ('AREA','区域','组织、人员所属区域'),  ('DEFAULTROLE','默认角色',NULL),  ('GENDER','性别',NULL),  ('HANDLERESULT','处理结果',NULL),  ('ICONCLS','菜单图标',NULL),  ('MODULE','日志模块',NULL),  ('ORGTYPE','组织类型',NULL),  ('YESORNO','是否',NULL);
INSERT INTO `t_sys_log` VALUES ('2','org.thorn.user.service.UserServiceImpl','changePwd','[\"ADMIN\",\"wwwwww\"]','ADMIN','Y',NULL,'2012-05-27 00:43:08'),  ('3','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"MODULE\",\"cname\":\"日志模块\",\"typeDesc\":\"\"}]','ADMIN','Y',NULL,'2012-05-27 00:43:12'),  ('4','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"LOGRESULT\",\"cname\":\"日志结果\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:32'),  ('5','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"true\",\"dvalue\":\"成功\",\"typeId\":\"LOGRESULT\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:32'),  ('6','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"false\",\"dvalue\":\"失败\",\"typeId\":\"LOGRESULT\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:33'),  ('7','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"APPLOG\",\"sourceName\":\"操作日志\",\"parentSource\":\"SYS\",\"sourceUrl\":\"system/log/appLog.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":7}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:34'),  ('8','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"YES\",\"dvalue\":\"成功\",\"typeId\":\"LOGRESULT\"}]','ADMIN','N','DataDictImpl do saveDd exception,\r\n### Error updating database.  Cause: com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException: Duplicate entry \'YES\' for key 1\r\n### The error may involve DictMapper.insertDict-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException: Duplicate entry \'YES\' for key 1\n; SQL []; Duplicate entry \'YES\' for key 1; nested exception is com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException: Duplicate entry \'YES\' for key 1','2012-05-27 00:43:14'),  ('9','org.thorn.dd.service.DataDictServiceImpl','deleteDt','[\"LOGRESULT,\"]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:35'),  ('10','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"HANDLERESULT\",\"cname\":\"处理结果\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:35'),  ('11','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"success\",\"dvalue\":\"成功\",\"typeId\":\"HANDLERESULT\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:36'),  ('12','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"failure\",\"dvalue\":\"失败\",\"typeId\":\"HANDLERESULT\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:37'),  ('13','org.thorn.dd.service.DataDictServiceImpl','modifyDt','[{\"ename\":\"GENDER\",\"cname\":\"性别\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:38'),  ('14','org.thorn.dd.service.DataDictServiceImpl','modifyDd','[{\"sortNum\":0,\"dname\":\"success\",\"dvalue\":\"成功\",\"typeId\":\"HANDLERESULT\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:40'),  ('15','org.thorn.dd.service.DataDictServiceImpl','modifyDt','[{\"ename\":\"ICONCLS\",\"cname\":\"菜单图标\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:42'),  ('16','org.thorn.dd.service.DataDictServiceImpl','modifyDt','[{\"ename\":\"DEFAULTROLE\",\"cname\":\"默认角色\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:42'),  ('17','org.thorn.dd.service.DataDictServiceImpl','modifyDd','[{\"sortNum\":1,\"dname\":\"COMMONUSER\",\"dvalue\":\"普通用户\",\"typeId\":\"DEFAULTROLE\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:43'),  ('18','org.thorn.dd.service.DataDictServiceImpl','deleteDd','[\"failure,\"]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:44'),  ('19','org.thorn.dd.service.DataDictServiceImpl','deleteDd','[\"success,\"]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:46'),  ('20','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"SUCCESS\",\"dvalue\":\"成功\",\"typeId\":\"HANDLERESULT\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:47'),  ('21','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"FAILURE\",\"dvalue\":\"失败\",\"typeId\":\"HANDLERESULT\"}]','ADMIN','SUCCESS',NULL,'2012-05-27 00:39:48'),  ('22','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"APPLOG\",\"sourceName\":\"操作日志\",\"parentSource\":\"SYS\",\"sourceUrl\":\"system/log/appLog.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":6}]','ADMIN','SUCCESS',NULL,'2012-05-29 18:30:32'),  ('23','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":999,\"dname\":\"tree-auth\",\"dvalue\":\"授权图标\",\"typeId\":\"ICONCLS\"}]','ADMIN','SUCCESS',NULL,'2012-05-29 18:31:19'),  ('24','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"APPLOG-QUERY\",\"sourceName\":\"操作日志查询\",\"parentSource\":\"APPLOG\",\"sourceUrl\":\"/log/getLogPage.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-05-29 23:11:12'),  ('25','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"APPLOG-EXCEL\",\"sourceName\":\"操作日志导出\",\"parentSource\":\"APPLOG\",\"sourceUrl\":\"/log/exportLogExcel.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-05-29 23:12:04'),  ('26','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"HOME\",\"sourceName\":\"主页\",\"parentSource\":\"NAV\",\"sourceUrl\":\"system/main.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-06-01 11:02:49'),  ('27','org.thorn.role.service.RoleServiceImpl','save','[{\"roleCode\":\"COMMONUSER\",\"roleName\":\"普通用户\",\"roleDesc\":\"\",\"isDisabled\":\"NO\"}]','ADMIN','SUCCESS',NULL,'2012-06-01 11:04:12'),  ('28','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"LEFTMENU\",\"sourceName\":\"菜单树\",\"parentSource\":\"NAV\",\"sourceUrl\":\"resource/getLeftTree.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":1}]','ADMIN','SUCCESS',NULL,'2012-06-01 11:06:07'),  ('29','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"COMMONUSER\",\"HOME,LEFTMENU,MYPWD,MYPWD-CHANGE,\"]','ADMIN','SUCCESS',NULL,'2012-06-01 11:06:35'),  ('30','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"MYPWD-CHANGE\",\"sourceName\":\"密码修改\",\"parentSource\":\"MYPWD\",\"sourceUrl\":\"/user/changeMyPwd.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-06-01 16:07:58'),  ('31','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"USER-PWD\",\"sourceName\":\"密码修改\",\"parentSource\":\"USER\",\"sourceUrl\":\"/user/changePwd.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-06-01 16:08:15'),  ('32','org.thorn.user.service.UserServiceImpl','changePwd','[\"AINAN\",\"123456\"]','AINAN','SUCCESS',NULL,'2012-06-01 16:10:27');
INSERT INTO `t_sys_org` VALUES ('1','ROOT','-1','组织树','组织树','COMPANY',NULL,'0','NO','NO',NULL),  ('2','001','ROOT','北京市分公司','北京市分公司','COMPANY',NULL,'1','YES','NO','BJ'),  ('11','002','ROOT','湖北省分公司','湖北省分公司','COMPANY','hb@thorn.com','2','YES','NO','HB'),  ('12','0011','001','信息化部','信息化部','DEPT',NULL,'0','YES','NO','BJ'),  ('13','0021','002','信息化部','信息化部','DEPT',NULL,'1','YES','NO','HB'),  ('14','0012','001','北分市场部','市场部','DEPT',NULL,'2','YES','NO','BJ');
INSERT INTO `t_sys_resource` VALUES ('0','ALL','/**','YES','NO','-1','99',''),  ('APPLOG','操作日志','/system/log/appLog.jsp','YES','YES','SYS','6','tree-appLog'),  ('APPLOG-EXCEL','操作日志导出','/log/exportLogExcel.jmt','YES','NO','APPLOG','999',NULL),  ('APPLOG-QUERY','操作日志查询','/log/getLogPage.jmt','YES','NO','APPLOG','999',NULL),  ('AUTH','用户授权','/system/role/userAuth.jsp','YES','YES','SYS','5','tree-auth'),  ('AUTH-ADD','添加用户','/user/saveUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-DELETE','删除用户','/user/deleteUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-QUERY','授权关系查询','/user/get*.jmt','YES','NO','AUTH','999',''),  ('DICT','数据字典管理','/system/dd/dd.jsp','YES','YES','SYS','0','tree-dd'),  ('DICT-DELETE','数据字典删除','/dd/delete*.jmt','YES','NO','DICT','999',''),  ('DICT-QUERY','数据字典查询','/dd/get*.jmt','YES','NO','DICT','999',''),  ('DICT-UPDATE','数据字典更新','/dd/saveOrModify*.jmt','YES','NO','DICT','999',''),  ('HOME','主页','/system/main.jsp','YES','NO','NAV','0',NULL),  ('LEFTMENU','菜单树','/resource/getLeftTree.jmt','YES','NO','NAV','1',NULL),  ('MYPWD','修改密码','/system/user/changePwd.jsp','YES','YES','NAV','99','tree-pwd'),  ('MYPWD-CHANGE','密码修改','/user/changeMyPwd.jmt','YES','NO','MYPWD','999',''),  ('NAV','应用菜单','','NO','YES','0','0',''),  ('ORG','组织管理','/system/org/org.jsp','YES','YES','SYS','2','tree-org'),  ('ORG-DELETE','组织删除','/org/delete*.jmt','YES','NO','ORG','999',''),  ('ORG-QUERY','组织查询','/org/get*.jmt','YES','NO','ORG','999',''),  ('ORG-UPDATE','组织更新','/org/saveOrModify*.jmt','YES','NO','ORG','999',''),  ('ROLE','角色管理','system/role/role.jsp','YES','YES','SYS','4','tree-role'),  ('ROLE-AUTH','角色授权','/role/saveAuth.jmt','YES','NO','ROLE','999',''),  ('ROLE-DELETE','角色删除','/role/delete*.jmt','YES','NO','ROLE','999',''),  ('ROLE-QUERY','角色查询','/role/get*.jmt','YES','NO','ROLE','999',''),  ('ROLE-UPDATE','角色更新','/role/saveOrModify*.jmt','YES','NO','ROLE','999',''),  ('SOURCE','资源管理','/system/resource/source.jsp','YES','YES','SYS','1','tree-source'),  ('SOURCE-DELETE','资源删除','/resource/delete*.jmt','YES','NO','SOURCE','999',''),  ('SOURCE-QUERY','资源查询','/resource/get*.jmt','YES','NO','SOURCE','999',''),  ('SOURCE-UPDATE','资源更新','/resource/saveOrModify*.jmt','YES','NO','SOURCE','999',''),  ('SYS','系统管理','','NO','YES','0','0',''),  ('USER','用户管理','/system/user/user.jsp','YES','YES','SYS','3','tree-user'),  ('USER-DELETE','用户删除','/user/deleteUser.jmt','YES','NO','USER','999',''),  ('USER-DISABLED','用户启/禁用','/user/disabled*.jmt','YES','NO','USER','999',''),  ('USER-PWD','密码修改','/user/changePwd.jmt','YES','NO','USER','999',''),  ('USER-QUERY','用户查询','/user/get*.jmt','YES','NO','USER','999',''),  ('USER-ROLE','用户角色管理','/user/saveRoleByUser.jmt','YES','NO','USER','999',''),  ('USER-UPDATE','用户更新','/user/saveOrModify*.jmt','YES','NO','USER','999','');
INSERT INTO `t_sys_role` VALUES ('COMMONUSER','普通用户',NULL,'NO');
INSERT INTO `t_sys_role_res` VALUES ('COMMONUSER','HOME','2012-06-01 11:06:35'),  ('COMMONUSER','LEFTMENU','2012-06-01 11:06:35'),  ('COMMONUSER','MYPWD','2012-06-01 11:06:35'),  ('COMMONUSER','MYPWD-CHANGE','2012-06-01 11:06:35');
INSERT INTO `t_sys_user` VALUES ('ADMIN','系统管理员','陈','CHENYUN','6994d5fd8501c8576fcfd99c3386f085','male','chenyun313@163.com','18701309727','ROOT','YES','NO','0','SYSADMIN'),  ('AINAN','艾楠','艾','ainan','67de2274915e33d54ae338ffdabeee76',NULL,'ainan@163.com',NULL,'0021','YES','NO','0','COMMONUSER'),  ('ZHENGYQ','张亚奇','张','zhangyq','77b01f654f188c182c6b6b28dffe8df8','male','zhengyq@163.com',NULL,'0021','YES','NO',NULL,'COMMONUSER');
