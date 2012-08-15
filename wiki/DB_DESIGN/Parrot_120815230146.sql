/*
MySQL Backup
Source Server Version: 5.0.51
Source Database: parrot
Date: 2012/8/15 23:01:46
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_cost_budget`
-- ----------------------------
DROP TABLE IF EXISTS `t_cost_budget`;
CREATE TABLE `t_cost_budget` (
  `ID` int(11) NOT NULL auto_increment,
  `PID` int(11) default NULL,
  `TYPE` varchar(200) default NULL,
  `DETAIL` varchar(200) default NULL,
  `REMARK` varchar(200) default NULL,
  `MONEY` double default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_flow_minds`
-- ----------------------------
DROP TABLE IF EXISTS `t_flow_minds`;
CREATE TABLE `t_flow_minds` (
  `ID` int(11) NOT NULL auto_increment,
  `FLOWID` int(11) default NULL,
  `USERID` varchar(200) default NULL,
  `USERNAME` varchar(200) default NULL,
  `MIND` varchar(2000) default NULL,
  `TIME` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `ACTIVITYNAME` varchar(200) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_heritor`
-- ----------------------------
DROP TABLE IF EXISTS `t_heritor`;
CREATE TABLE `t_heritor` (
  `ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(200) default NULL,
  `IDCARD` varchar(200) default NULL,
  `GENDER` varchar(50) default NULL,
  `BATCHNUM` varchar(200) default NULL,
  `REMARK` varchar(500) default NULL,
  `ISDIE` varchar(50) default NULL,
  `DIEDATE` date default NULL,
  `PROJECTID` int(11) default NULL,
  `PROVINCE` varchar(200) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_incr_seq`
-- ----------------------------
DROP TABLE IF EXISTS `t_incr_seq`;
CREATE TABLE `t_incr_seq` (
  `ACCOUNTSEQ` int(11) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_project`
-- ----------------------------
DROP TABLE IF EXISTS `t_project`;
CREATE TABLE `t_project` (
  `ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(500) default NULL,
  `CODE` varchar(200) default NULL,
  `TYPE` varchar(200) default NULL,
  `ISUNPROJECT` varchar(50) default NULL,
  `BIGNO` varchar(50) default NULL,
  `SMALLNO` varchar(50) default NULL,
  `BATCHNUM` varchar(50) default NULL,
  `MINORITY` varchar(100) default NULL,
  `AREA` varchar(500) default NULL,
  `USERID` varchar(200) default NULL,
  `PROVINCE` varchar(200) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_project_cost`
-- ----------------------------
DROP TABLE IF EXISTS `t_project_cost`;
CREATE TABLE `t_project_cost` (
  `ID` int(11) NOT NULL auto_increment,
  `PROJECTID` int(11) default NULL,
  `PROJECTNAME` varchar(500) default NULL,
  `YEAR` varchar(100) default NULL,
  `CREATER` varchar(200) default NULL,
  `CREATERNAME` varchar(200) default NULL,
  `PROVINCE` varchar(200) default NULL,
  `ATTIDS` varchar(2000) default NULL,
  `ADDRESS` varchar(500) default NULL,
  `POSTALCODE` varchar(200) default NULL,
  `CONTACTS` varchar(200) default NULL,
  `PHONE` varchar(200) default NULL,
  `BANKNAME` varchar(200) default NULL,
  `BANK` varchar(200) default NULL,
  `BANKACCOUNT` varchar(200) default NULL,
  `COMPANYCTF` varchar(500) default NULL,
  `APPREASON` varchar(2000) default NULL,
  `CONTENT` varchar(2000) default NULL,
  `TARGET` varchar(2000) default NULL,
  `USEDYEAR` varchar(200) default NULL,
  `MONEY` double default NULL,
  `BUDGET` varchar(2000) default NULL,
  `APPLYTIME` datetime default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_reserve`
-- ----------------------------
DROP TABLE IF EXISTS `t_reserve`;
CREATE TABLE `t_reserve` (
  `ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(500) default NULL,
  `BULIDTIME` varchar(200) default NULL,
  `AREA` varchar(500) default NULL,
  `USERID` varchar(200) default NULL,
  `PROVINCE` varchar(200) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_resever_cost`
-- ----------------------------
DROP TABLE IF EXISTS `t_resever_cost`;
CREATE TABLE `t_resever_cost` (
  `ID` int(11) NOT NULL auto_increment,
  `RESEVERID` int(11) default NULL,
  `RESEVERNAME` varchar(500) default NULL,
  `YEAR` varchar(100) default NULL,
  `CREATER` varchar(200) default NULL,
  `CREATERNAME` varchar(200) default NULL,
  `PROVINCE` varchar(200) default NULL,
  `ATTIDS` varchar(2000) default NULL,
  `ADDRESS` varchar(500) default NULL,
  `POSTALCODE` varchar(200) default NULL,
  `CONTACTS` varchar(200) default NULL,
  `PHONE` varchar(200) default NULL,
  `APPREASON` varchar(2000) default NULL,
  `CONTENT` varchar(2000) default NULL,
  `TARGET` varchar(2000) default NULL,
  `APPLYMONEY` double default NULL,
  `GIVENMONEY` double default NULL,
  `BUDGET` varchar(2000) default NULL,
  `APPLYTIME` datetime default NULL,
  PRIMARY KEY  (`ID`)
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
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
--  Table structure for `t_workflow`
-- ----------------------------
DROP TABLE IF EXISTS `t_workflow`;
CREATE TABLE `t_workflow` (
  `ID` int(11) NOT NULL auto_increment,
  `FLOWTYPE` varchar(200) default NULL,
  `ACTIVITY` varchar(200) default NULL,
  `FLOWSTATUS` varchar(200) default NULL,
  `CREATER` varchar(200) default NULL,
  `CREATERNAME` varchar(200) default NULL,
  `CREATETIME` datetime default NULL,
  `PID` int(11) default NULL,
  `HANDLER` varchar(200) default NULL,
  `PROVINCE` varchar(200) default NULL,
  `HANDLERTYPE` varchar(200) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `t_cost_budget` VALUES ('5','6','project','传承活动','无话可说','20'),  ('6','6','project','传承活动','无话可说','1');
INSERT INTO `t_flow_minds` VALUES ('1','1','ADMIN','系统管理员','2222','2012-08-14 21:59:23','申报环节'),  ('2','1','FY0000021','文化部非遗司','2222','2012-08-14 23:01:04','非遗司审批环节'),  ('3','1','ADMIN','系统管理员',NULL,'2012-08-14 23:08:18','申报环节'),  ('4','1','FY0000021','文化部非遗司','222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222','2012-08-14 23:09:29','非遗司审批环节'),  ('5','1','ADMIN','系统管理员','11111222','2012-08-14 23:28:05','申报环节'),  ('6','1','FY0000021','文化部非遗司','2221212','2012-08-14 23:28:48','非遗司审批环节'),  ('7','1','ADMIN','系统管理员','222','2012-08-14 23:36:53','申报环节'),  ('8','1','FY0000021','文化部非遗司','22222','2012-08-14 23:43:09','非遗司审批环节'),  ('9','1','ADMIN','系统管理员','22','2012-08-14 23:44:44','申报环节'),  ('10','1','FY0000021','文化部非遗司',NULL,'2012-08-14 23:45:47','非遗司审批环节'),  ('11','2','ADMIN','系统管理员','2222212112','2012-08-14 23:47:45','起草暂存环节'),  ('12','3','ADMIN','系统管理员','22dsdsdsd','2012-08-14 23:50:24','申报环节'),  ('15','5','ADMIN','系统管理员','tytytyty','2012-08-15 22:12:39','申报环节'),  ('16','6','ADMIN','系统管理员','1222222222121212','2012-08-15 22:24:07','申报环节'),  ('17','6','FY0000021','文化部非遗司','再来次','2012-08-15 22:26:15','非遗司审批环节'),  ('18','6','ADMIN','系统管理员',NULL,'2012-08-15 22:27:27','申报环节'),  ('19','7','ADMIN','系统管理员','111','2012-08-15 22:29:37','申报环节'),  ('20','7','FY0000021','文化部非遗司','1212121212','2012-08-15 22:36:20','非遗司审批环节');
INSERT INTO `t_heritor` VALUES ('2','11111','11111','male','111111','111','NO',NULL,'1','003'),  ('3','2222','222222222222','male','1','1111','NO',NULL,'1','003');
INSERT INTO `t_incr_seq` VALUES ('30');
INSERT INTO `t_project` VALUES ('1','津门法鼓（挂甲寺庆音法鼓）','Ⅱ-122','003',NULL,'1','1','（1）',NULL,'天津市河西区','FY0030002','003'),  ('2','津门法鼓（杨家庄永音法鼓）','Ⅱ-122','003',NULL,'1','2','（2）',NULL,'天津市河西区','FY0030002','003'),  ('3','古琴艺术','Ⅱ-34','003',NULL,'1','1','（1）',NULL,'中国艺术研究院','ADMIN','000');
INSERT INTO `t_project_cost` VALUES ('1','3','古琴艺术','2012','ADMIN','系统管理员','000',NULL,'11111','111','111','1111','1111','1111','1111','1111','111111','111','1111','2090','3','121212','2012-08-14 21:59:16'),  ('2','3','古琴艺术','2013','ADMIN','系统管理员','000',NULL,'21212',NULL,'212','21','2222','1212','22222222','1212','12','12','1212','1212','3','211212','2012-08-14 23:46:56'),  ('5','3','古琴艺术',NULL,'ADMIN','系统管理员','000',',6,7undefined,8',NULL,'1111','111',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-08-15 22:12:39'),  ('6','3','古琴艺术','2012','ADMIN','系统管理员','000','undefined,13,15','121212121','10011','陈云','1898765211','121212','1212','12121','212121221121212','1212221212','2122','12121','20192','10','12121212去你NN的依据','2012-08-15 22:24:07'),  ('7','3','古琴艺术','2012','ADMIN','系统管理员','000',',18','qqq',NULL,'qq','qqq','qqqq','qqqq','qq','qqq','qq','q','qqq','qq','20.9','1212','2012-08-15 22:29:37');
INSERT INTO `t_reserve` VALUES ('3','121','1212','212','ADMIN','000'),  ('4','33','2323','222','FY0010001','001');
INSERT INTO `t_sys_dict` VALUES ('000','非遗司','0','AREA'),  ('001','北京市','1','AREA'),  ('001','传统戏剧','999','PROJECT_TYPE'),  ('002','湖北省','2','AREA'),  ('002','民间文学','999','PROJECT_TYPE'),  ('003','天津市','3','AREA'),  ('003','传统音乐','999','PROJECT_TYPE'),  ('004','传统舞蹈','999','PROJECT_TYPE'),  ('005','曲艺','999','PROJECT_TYPE'),  ('006','传统体育、游艺与杂技','999','PROJECT_TYPE'),  ('007','传统美术','999','PROJECT_TYPE'),  ('008','传统技艺','999','PROJECT_TYPE'),  ('009','传统医药','999','PROJECT_TYPE'),  ('010','民俗','999','PROJECT_TYPE'),  ('2011','2011',NULL,'YEAR'),  ('2012','2012','1','YEAR'),  ('2013','2013','2','YEAR'),  ('2014','2014','3','YEAR'),  ('apply','申报中','2','FLOW_STATUS'),  ('COMMONUSER','普通用户','1','DEFAULTROLE'),  ('COMPANY','公司',NULL,'ORGTYPE'),  ('DEPT','部门','1','ORGTYPE'),  ('failure','审批不通过','1','FLOW_STATUS'),  ('FAILURE','失败','1','HANDLERESULT'),  ('femme','女','1','GENDER'),  ('HAN','汉族',NULL,'MINORITY'),  ('male','男','0','GENDER'),  ('NO','否','1','YESORNO'),  ('ORG','组织','2','ORGTYPE'),  ('project','项目补助费申报',NULL,'FLOW_TYPE'),  ('resever','保护区补助费申报','1','FLOW_TYPE'),  ('success','审批通过',NULL,'FLOW_STATUS'),  ('SUCCESS','成功',NULL,'HANDLERESULT'),  ('SYSADMIN','系统管理员',NULL,'DEFAULTROLE'),  ('tree-appLog','操作日志','6','ICONCLS'),  ('tree-att','文件图标','8','ICONCLS'),  ('tree-auth','授权图标','999','ICONCLS'),  ('tree-config','配置文件图标','9','ICONCLS'),  ('tree-dd','字典图标','2','ICONCLS'),  ('tree-org','组织图标','1','ICONCLS'),  ('tree-pwd','密码修改','3','ICONCLS'),  ('tree-role','角色图标','5','ICONCLS'),  ('tree-source','资源图标','4','ICONCLS'),  ('tree-sysLog','系统日志','7','ICONCLS'),  ('tree-user','用户图标','0','ICONCLS'),  ('YES','是',NULL,'YESORNO'),  ('传承活动','传承活动','999','BUDGET_DETAIL'),  ('其他支出','其他支出','1000','BUDGET_DETAIL'),  ('出版','出版','999','BUDGET_DETAIL'),  ('展示推广','展示推广','999','BUDGET_DETAIL'),  ('抢救性记录和保存','抢救性记录和保存','999','BUDGET_DETAIL'),  ('民俗活动','民俗活动','999','BUDGET_DETAIL'),  ('理论及技艺研究','理论及技艺研究','999','BUDGET_DETAIL'),  ('调查研究','调查研究','999','BUDGET_DETAIL');
INSERT INTO `t_sys_dict_type` VALUES ('AREA','区域',''),  ('BUDGET_DETAIL','预算明细内容',NULL),  ('DEFAULTROLE','默认角色',''),  ('FLOW_STATUS','审批状态',NULL),  ('FLOW_TYPE','流程类型',NULL),  ('GENDER','性别',NULL),  ('HANDLERESULT','处理结果',NULL),  ('ICONCLS','菜单图标',NULL),  ('MINORITY','民族',NULL),  ('MODULE','日志模块',NULL),  ('ORGTYPE','组织类型',NULL),  ('PROJECT_TYPE','非遗项目类型',NULL),  ('YEAR','年份',NULL),  ('YESORNO','是否',NULL);
INSERT INTO `t_sys_org` VALUES ('1','ROOT','-1','文化部','文化部','COMPANY',NULL,'0','NO','NO',NULL),  ('2','001','ROOT','北京市文化厅','北京市文化厅','COMPANY',NULL,'1','YES','NO','001'),  ('11','002','ROOT','湖北省文化厅','湖北省文化厅','COMPANY','','2','YES','NO','002'),  ('12','003','ROOT','天津市文化厅','天津市文化厅','COMPANY',NULL,'999','YES','NO','003'),  ('13','000','ROOT','文化部非物质文化遗产司','文化部非遗司','COMPANY',NULL,'0','YES','NO','000');
INSERT INTO `t_sys_resource` VALUES ('0','ALL','/**','YES','NO','-1','99',''),  ('APPLOG','操作日志','/system/log/appLog.jsp','YES','YES','LOG','1','tree-appLog'),  ('APPLOG-EXCEL','操作日志导出','/log/exportLogExcel.jmt','YES','NO','APPLOG','999',''),  ('APPLOG-QUERY','操作日志查询','/log/getLogPage.jmt','YES','NO','APPLOG','0',''),  ('ATT','文件管理','/system/att/attachment.jsp','YES','YES','SYS','9','tree-att'),  ('ATT-DELETE','附件删除','/att/delete.jmt','YES','NO','NAV','3',''),  ('ATT-DOWNLOAD','附件下载','/att/download.jmt','YES','NO','NAV','4',''),  ('ATT-UPLOAD','附件上传','/att/get*.jmt','YES','NO','NAV','2',''),  ('AUTH','用户授权','/system/role/userAuth.jsp','YES','YES','AUTHMANAGER','1','tree-auth'),  ('AUTH-ADD','添加用户','/user/saveUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-DELETE','删除用户','/user/deleteUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-QUERY','授权关系查询','/user/get*.jmt','YES','NO','AUTH','0',''),  ('AUTHMANAGER','权限管理','','NO','YES','SYS','3',''),  ('CF','配置项管理','','NO','YES','SYS','0',''),  ('CF-MODIFY','配置文件修改','/cf/modifyConfig.jmt','YES','NO','CONFIG','1',''),  ('CF-QUERY','配置文件查看','/cf/get*.jmt','YES','NO','CONFIG','0',''),  ('CONFIG','配置文件管理','/system/cf/configurator.jsp','YES','YES','CF','1','tree-config'),  ('DICT','数据字典管理','/system/dd/dd.jsp','YES','YES','CF','0','tree-dd'),  ('DICT-DELETE','数据字典删除','/dd/delete*.jmt','YES','NO','DICT','999',''),  ('DICT-QUERY','数据字典查询','/dd/get*.jmt','YES','NO','DICT','0',''),  ('DICT-UPDATE','数据字典更新','/dd/saveOrModify*.jmt','YES','NO','DICT','999',''),  ('HERINFO-BING','绑定非遗项目','/heritor/bingingProject.jmt','YES','NO','HERITORINFO','1',NULL),  ('HERINFO-DELETE','传承人信息删除','/heritor/deleteHeritor.jmt','YES','NO','HERITORINFO','2',NULL),  ('HERINFO-MODIFY','传承人信息修改','/heritor/saveOrModifyHeritor.jmt','YES','NO','HERITORINFO','1',NULL),  ('HERINFO-QUERY','传承人信息查询','/heritor/getHeritor*.jmt','YES','NO','HERITORINFO','0',NULL),  ('HERITOR','传承人库管理',NULL,'NO','YES','NAV','4',NULL),  ('HERITORINFO','传承人信息管理','/app/heritor.jsp','YES','YES','HERITOR','1',NULL),  ('HOME','主页','/system/main.jsp','YES','NO','NAV','0',''),  ('LEFTMENU','菜单树','/resource/getLeftTree.jmt','YES','NO','NAV','1',''),  ('LOG','日志管理','','NO','YES','SYS','1',''),  ('MYPWD','修改密码','/system/user/changePwd.jsp','YES','YES','NAV','99','tree-pwd'),  ('MYPWD-CHANGE','密码修改','/user/changeMyPwd.jmt','YES','NO','MYPWD','999',''),  ('NAV','应用菜单','','NO','YES','0','0',''),  ('ORG','组织管理','/system/org/org.jsp','YES','YES','USERMANAGER','0','tree-org'),  ('ORG-DELETE','组织删除','/org/delete*.jmt','YES','NO','ORG','999',''),  ('ORG-QUERY','组织查询','/org/get*.jmt','YES','NO','ORG','0',''),  ('ORG-UPDATE','组织更新','/org/saveOrModify*.jmt','YES','NO','ORG','999',''),  ('PROCESSAPP','流程表单资源','/app/**','YES','NO','WORKFLOW','999',''),  ('PROCESSCR','发起费用申报','/process/processCr.jsp','YES','YES','NAV','0',NULL),  ('PROJECT','非遗项目库管理',NULL,'NO','YES','NAV','3',NULL),  ('PROJECTINFO','项目信息管理','/app/project.jsp','YES','YES','PROJECT','1',NULL),  ('PROJECTINFO-DELETE','项目信息删除','/project/deleteProject.jmt','YES','NO','PROJECTINFO','3',NULL),  ('PROJECTINFO-MODIFY','项目信息修改','/project/saveOrModify*.jmt','YES','NO','PROJECTINFO','1',NULL),  ('PROJECTINFO-QUERY','项目信息查询','/project/get*.jmt','YES','NO','PROJECTINFO','0',NULL),  ('RESEVER','文化生态保护区库管理',NULL,'NO','YES','NAV','5',NULL),  ('RESEVERINFO','保护区信息管理','/app/resever.jsp','YES','YES','RESEVER','1',NULL),  ('RESINFO-DELETE','保护区信息删除','/resever/deleteResever.jmt','YES','NO','RESEVERINFO','3',NULL),  ('RESINFO-MODIFY','保护区信息修改','/resever/saveOrModifyResever.jmt','YES','NO','RESEVERINFO','2',NULL),  ('RESINFO-QUERY','保护区信息查询','/resever/getResever*.jmt','YES','NO','RESEVERINFO','0',NULL),  ('ROLE','角色管理','/system/role/role.jsp','YES','YES','AUTHMANAGER','0','tree-role'),  ('ROLE-AUTH','角色授权','/role/saveAuth.jmt','YES','NO','ROLE','999',''),  ('ROLE-DELETE','角色删除','/role/delete*.jmt','YES','NO','ROLE','999',''),  ('ROLE-QUERY','角色查询','/role/get*.jmt','YES','NO','ROLE','0',''),  ('ROLE-UPDATE','角色更新','/role/saveOrModify*.jmt','YES','NO','ROLE','999',''),  ('SOURCE','资源管理','/system/resource/source.jsp','YES','YES','CF','2','tree-source'),  ('SOURCE-DELETE','资源删除','/resource/delete*.jmt','YES','NO','SOURCE','999',''),  ('SOURCE-QUERY','资源查询','/resource/get*.jmt','YES','NO','SOURCE','0',''),  ('SOURCE-UPDATE','资源更新','/resource/saveOrModify*.jmt','YES','NO','SOURCE','999',''),  ('SYS','系统管理','','NO','YES','0','0',''),  ('SYSLOG','系统日志','/system/log/sysLog.jsp','YES','YES','LOG','0','tree-sysLog'),  ('SYSLOG-LEVEL','修改日志级别','/log/*LogLevel.jmt','YES','NO','SYSLOG','1',''),  ('SYSLOG-QUERY','系统日志查询','/system/log/sysLog*.jsp','YES','NO','SYSLOG','0',''),  ('USER','用户管理','/system/user/user.jsp','YES','YES','USERMANAGER','1','tree-user'),  ('USER-DELETE','用户删除','/user/deleteUser.jmt','YES','NO','USER','2',''),  ('USER-DISABLED','用户启/禁用','/user/disabled*.jmt','YES','NO','USER','999',''),  ('USER-PWD','密码修改','/user/changePwd.jmt','YES','NO','USER','999',''),  ('USER-QUERY','用户查询','/user/get*.jmt','YES','NO','USER','0',''),  ('USER-ROLE','用户角色管理','/user/saveRoleByUser.jmt','YES','NO','USER','999',''),  ('USER-UPDATE','用户更新','/user/saveOrModify*.jmt','YES','NO','USER','1',''),  ('USERMANAGER','用户管理','','NO','YES','SYS','2',''),  ('WFCOMMON','流程通用资源','/wf/cm/**','YES','NO','PROCESSCR','0',NULL);
INSERT INTO `t_sys_role` VALUES ('CENTRALUSER','部委级用户',NULL,'NO'),  ('COMMONUSER','普通用户',NULL,'NO'),  ('PROVINCEUSER','省厅级用户',NULL,'NO');
INSERT INTO `t_sys_role_res` VALUES ('CENTRALUSER','ATT-DELETE','2012-08-14 22:10:25'),  ('CENTRALUSER','ATT-DOWNLOAD','2012-08-14 22:10:25'),  ('CENTRALUSER','ATT-UPLOAD','2012-08-14 22:10:25'),  ('CENTRALUSER','HERINFO-BING','2012-08-14 22:10:25'),  ('CENTRALUSER','HERINFO-DELETE','2012-08-14 22:10:25'),  ('CENTRALUSER','HERINFO-MODIFY','2012-08-14 22:10:25'),  ('CENTRALUSER','HERINFO-QUERY','2012-08-14 22:10:25'),  ('CENTRALUSER','HERITOR','2012-08-14 22:10:25'),  ('CENTRALUSER','HERITORINFO','2012-08-14 22:10:25'),  ('CENTRALUSER','HOME','2012-08-14 22:10:25'),  ('CENTRALUSER','LEFTMENU','2012-08-14 22:10:25'),  ('CENTRALUSER','MYPWD','2012-08-14 22:10:25'),  ('CENTRALUSER','MYPWD-CHANGE','2012-08-14 22:10:25'),  ('CENTRALUSER','ORG','2012-08-14 22:10:25'),  ('CENTRALUSER','ORG-DELETE','2012-08-14 22:10:25'),  ('CENTRALUSER','ORG-QUERY','2012-08-14 22:10:25'),  ('CENTRALUSER','ORG-UPDATE','2012-08-14 22:10:25'),  ('CENTRALUSER','PROCESSCR','2012-08-14 22:10:25'),  ('CENTRALUSER','PROCESSTODO','2012-08-14 22:10:25'),  ('CENTRALUSER','PROJECT','2012-08-14 22:10:25'),  ('CENTRALUSER','PROJECTINFO','2012-08-14 22:10:25'),  ('CENTRALUSER','PROJECTINFO-DELETE','2012-08-14 22:10:25'),  ('CENTRALUSER','PROJECTINFO-MODIFY','2012-08-14 22:10:25'),  ('CENTRALUSER','PROJECTINFO-QUERY','2012-08-14 22:10:25'),  ('CENTRALUSER','RESEVER','2012-08-14 22:10:25'),  ('CENTRALUSER','RESEVERINFO','2012-08-14 22:10:25'),  ('CENTRALUSER','RESINFO-DELETE','2012-08-14 22:10:25'),  ('CENTRALUSER','RESINFO-MODIFY','2012-08-14 22:10:25'),  ('CENTRALUSER','RESINFO-QUERY','2012-08-14 22:10:25'),  ('CENTRALUSER','USER','2012-08-14 22:10:25'),  ('CENTRALUSER','USER-DELETE','2012-08-14 22:10:25'),  ('CENTRALUSER','USER-DISABLED','2012-08-14 22:10:25'),  ('CENTRALUSER','USER-PWD','2012-08-14 22:10:25'),  ('CENTRALUSER','USER-QUERY','2012-08-14 22:10:25'),  ('CENTRALUSER','USER-ROLE','2012-08-14 22:10:25'),  ('CENTRALUSER','USER-UPDATE','2012-08-14 22:10:25'),  ('CENTRALUSER','USERMANAGER','2012-08-14 22:10:25'),  ('CENTRALUSER','WFCOMMON','2012-08-14 22:10:25'),  ('COMMONUSER','ATT-DELETE','2012-08-09 21:34:04'),  ('COMMONUSER','ATT-DOWNLOAD','2012-08-09 21:34:04'),  ('COMMONUSER','ATT-UPLOAD','2012-08-09 21:34:04'),  ('COMMONUSER','HOME','2012-08-09 21:34:04'),  ('COMMONUSER','LEFTMENU','2012-08-09 21:34:04'),  ('COMMONUSER','MYPWD','2012-08-09 21:34:04'),  ('COMMONUSER','MYPWD-CHANGE','2012-08-09 21:34:04'),  ('PROVINCEUSER','ATT-DELETE','2012-08-10 23:07:20'),  ('PROVINCEUSER','ATT-DOWNLOAD','2012-08-10 23:07:20'),  ('PROVINCEUSER','ATT-UPLOAD','2012-08-10 23:07:20'),  ('PROVINCEUSER','HOME','2012-08-10 23:07:20'),  ('PROVINCEUSER','LEFTMENU','2012-08-10 23:07:20'),  ('PROVINCEUSER','MYPWD','2012-08-10 23:07:20'),  ('PROVINCEUSER','MYPWD-CHANGE','2012-08-10 23:07:20'),  ('PROVINCEUSER','ORG','2012-08-10 23:07:20'),  ('PROVINCEUSER','ORG-QUERY','2012-08-10 23:07:20'),  ('PROVINCEUSER','USER','2012-08-10 23:07:20'),  ('PROVINCEUSER','USER-DELETE','2012-08-10 23:07:20'),  ('PROVINCEUSER','USER-DISABLED','2012-08-10 23:07:20'),  ('PROVINCEUSER','USER-PWD','2012-08-10 23:07:20'),  ('PROVINCEUSER','USER-QUERY','2012-08-10 23:07:20'),  ('PROVINCEUSER','USER-ROLE','2012-08-10 23:07:20'),  ('PROVINCEUSER','USER-UPDATE','2012-08-10 23:07:20'),  ('PROVINCEUSER','USERMANAGER','2012-08-10 23:07:20');
INSERT INTO `t_sys_user` VALUES ('ADMIN','系统管理员','陈','CHENYUN','6994d5fd8501c8576fcfd99c3386f085','male','chenyun313@163.com','18701309727','000','YES','NO','0','SYSADMIN'),  ('FY0000021','文化部非遗司',NULL,'文化部非遗司','2e4350447b14de1a6f178c7f2a79fd3b',NULL,'727zz@163.com',NULL,'000','YES','NO','0','COMMONUSER'),  ('FY0010000','北京市文化厅',NULL,'FY0010000','675b501d556c9a31d65b4364ed575e05',NULL,'727zz@163.com',NULL,'001','YES','NO','0','COMMONUSER'),  ('FY0010001','北京印钞厂',NULL,'FY0010001','ddac58a87f43443331f89054b8cb8899','male','727zz@163.com',NULL,'001','YES','NO','999','COMMONUSER'),  ('FY0010564','北京市北方昆曲剧院',NULL,'北京市北方昆曲剧院','cdaa9575a6c4e2b4f4fd67c66b55c2a0','male','727zz@163.com',NULL,'001','YES','NO','999','COMMONUSER'),  ('FY0030002','河西区挂甲寺街道办事处',NULL,'河西区挂甲寺街道办事处','6fe343fed530e351b842516e91aea227',NULL,'727zz@163.com',NULL,'003','YES','NO','999','COMMONUSER'),  ('FY0030011','天津市文化厅',NULL,'天津市文化厅','653ea85ccc5e1e512cb795ef4baac698',NULL,'727zz@163.com',NULL,'003','YES','NO','0','COMMONUSER');
INSERT INTO `t_sys_user_role` VALUES ('FY0000021','CENTRALUSER','2012-08-14 22:04:18'),  ('FY0010000','PROVINCEUSER','2012-08-09 21:18:18'),  ('FY0030011','PROVINCEUSER','2012-08-10 23:01:04');
INSERT INTO `t_workflow` VALUES ('1','project','审批完成已归档','success','ADMIN','系统管理员','2012-08-14 21:59:18','1','-','000','-'),  ('2','project','非遗司审批环节','apply','ADMIN','系统管理员','2012-08-14 23:46:56','2','CENTRALUSER','000','role'),  ('3','project','起草暂存环节','apply','ADMIN','系统管理员','2012-08-14 23:50:23','3','ADMIN','000','user'),  ('5','project','起草暂存环节','apply','ADMIN','系统管理员','2012-08-15 22:12:39','5','ADMIN','000','user'),  ('6','project','非遗司审批环节','apply','ADMIN','系统管理员','2012-08-15 22:24:07','6','CENTRALUSER','000','role'),  ('7','project','审批完成已归档','success','ADMIN','系统管理员','2012-08-15 22:29:37','7','-','000','-');
