/*
MySQL Backup
Source Server Version: 5.0.51
Source Database: thorn
Date: 2012/5/14 23:29:09
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
  PRIMARY KEY  (`DNAME`)
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
--  Table structure for `t_sys_org`
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_org`;
CREATE TABLE `t_sys_org` (
  `ORGID` int(11) NOT NULL auto_increment,
  `ORGCODE` varchar(200) NOT NULL,
  `PARENTORG` varchar(200) NOT NULL,
  `ORGNAME` varchar(200) NOT NULL,
  `SHOWNAME` varchar(200) default NULL,
  `ORGTYPE` varchar(10) NOT NULL,
  `ORGMAIL` varchar(50) default NULL,
  `SORTNUM` int(11) default NULL,
  `ISSHOW` varchar(10) default NULL,
  `ISDISABLED` varchar(10) default NULL,
  `AREA` varchar(10) default NULL,
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
  `ISLEAF` varchar(10) NOT NULL,
  `ISSHOW` varchar(10) NOT NULL,
  `PARENTSOURCE` varchar(50) NOT NULL,
  `SORTNUM` int(11) default NULL,
  `ICONSCLS` varchar(10) default NULL,
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
  `ISDISABLED` varchar(10) default NULL,
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
  `GENDER` varchar(10) default NULL,
  `CUMAIL` varchar(50) default NULL,
  `PHONE` varchar(20) default NULL,
  `ORGCODE` varchar(200) default NULL,
  `ISSHOW` varchar(10) default NULL,
  `ISDISABLED` varchar(10) default NULL,
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
INSERT INTO `persistent_logins` VALUES ('ADMIN','juyQQqdUNVxsmKQvCavp0Q==','thnxTF/J38oEvlpkOsFhrQ==','2012-05-14 23:20:59');
INSERT INTO `t_sys_dict` VALUES ('BJ','北京','1','AREA'),  ('COMPANY','公司',NULL,'ORGTYPE'),  ('DEPT','部门','1','ORGTYPE'),  ('HB','湖北','2','AREA'),  ('HN','湖南','3','AREA'),  ('NO','否','1','YESORNO'),  ('ORG','组织','2','ORGTYPE'),  ('tree-dd','字典图标','2','ICONCLS'),  ('tree-org','组织图标','1','ICONCLS'),  ('tree-user','用户图标',NULL,'ICONCLS'),  ('YES','是',NULL,'YESORNO');
INSERT INTO `t_sys_dict_type` VALUES ('AREA','区域','组织、人员所属区域'),  ('ICONCLS','菜单图标',NULL),  ('ORGTYPE','组织类型',NULL),  ('YESORNO','是否',NULL);
INSERT INTO `t_sys_org` VALUES ('1','ROOT','-1','组织树','组织树','COMPANY',NULL,'0','NO','NO',NULL),  ('2','001','ROOT','北京市分公司','北京市分公司','COMPANY',NULL,'1','YES','NO','BJ'),  ('11','002','ROOT','湖北省分公司','湖北省分公司','COMPANY','hb@thorn.com','2','YES','NO','HB'),  ('12','0011','001','信息化部','信息化部','DEPT',NULL,'0','YES','NO','BJ'),  ('13','0021','002','信息化部','信息化部','DEPT',NULL,'1','YES','NO','HB'),  ('14','0012','001','北分市场部','市场部','DEPT',NULL,'2','YES','NO','BJ');
INSERT INTO `t_sys_resource` VALUES ('0','ALL','/**','YES','NO','-1','99',NULL),  ('DICT','数据字典管理','system/dd/dd.jsp','YES','YES','SYS','2','tree-dd'),  ('NAV','应用菜单',NULL,'NO','YES','0','0',NULL),  ('ORG','组织管理','system/org/org.jsp','YES','YES','SYS','3','tree-org'),  ('SOURCE','资源管理','system/resource/source.jsp','YES','YES','SYS','4',NULL),  ('SYS','系统管理',NULL,'NO','YES','0','0',NULL),  ('USER','用户管理','12','YES','YES','SYS','1','tree-user');
INSERT INTO `t_sys_role` VALUES ('SYSADMIN','系统管理员',NULL,'NO');
INSERT INTO `t_sys_role_res` VALUES ('SYSADMIN','0','2012-05-07 21:05:35');
INSERT INTO `t_sys_user` VALUES ('ADMIN','系统管理员','陈','CHENYUN','6994d5fd8501c8576fcfd99c3386f085','MALE','chenyun313@163.com','18701309727',NULL,'YES','NO','0','SYSADMIN');
