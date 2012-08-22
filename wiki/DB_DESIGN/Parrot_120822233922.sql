/*
MySQL Backup
Source Server Version: 5.0.51
Source Database: parrot
Date: 2012/8/22 23:39:22
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `t_cost_budget` VALUES ('14','8','project','传承活动',NULL,'1.3'),  ('15','8','project','展示推广','ioiuyy','2'),  ('16','8','project','民俗活动','uioiiu','1.7'),  ('17','8','project','抢救性记录和保存','再来1W','1'),  ('18','1','resever','其他','2121212','20');
INSERT INTO `t_flow_minds` VALUES ('26','10','FY0030005','河西区挂甲寺街道办事处','11212121212','2012-08-21 23:07:36','起草暂存环节'),  ('27','10','FY0030004','天津市文化厅','rtrtrtrererer','2012-08-21 23:08:38','省厅审批环节'),  ('28','10','FY0030005','河西区挂甲寺街道办事处','揍你','2012-08-21 23:10:20','申报环节'),  ('29','10','FY0030004','天津市文化厅','走你！','2012-08-21 23:11:23','省厅审批环节'),  ('30','10','FY0000000','文化部非遗司','GO','2012-08-21 23:12:33','非遗司审批环节'),  ('31','11','FY0040011','陕西省文化厅','阿萨飒飒','2012-08-22 20:16:01','申报环节'),  ('32','11','FY0040011','陕西省文化厅','qwqwqwqw','2012-08-22 20:17:50','省厅审批环节'),  ('33','11','FY0000000','文化部非遗司','1111','2012-08-22 20:18:50','非遗司审批环节'),  ('34','11','FY0040011','陕西省文化厅',NULL,'2012-08-22 20:19:59','省厅审批环节'),  ('35','11','FY0000000','文化部非遗司',NULL,'2012-08-22 20:21:05','非遗司审批环节');
INSERT INTO `t_heritor` VALUES ('4','测试传承人','420580199909207896',NULL,'2','111','NO',NULL,'4','003');
INSERT INTO `t_incr_seq` VALUES ('25');
INSERT INTO `t_project` VALUES ('4','津门法鼓（挂甲寺庆音法鼓）','Ⅱ-122','003',NULL,'1','1','2',NULL,'天津市河西区','FY0030005','003');
INSERT INTO `t_project_cost` VALUES ('8','4','津门法鼓（挂甲寺庆音法鼓）','2012','FY0030005','河西区挂甲寺街道办事处','003',',2','北京回龙观','10011','张三','18709877890','张三1','招商银行','1111111222222222','国有银行','无理由','补助金使用内容','预期效益是啥','2012','6','狗屁依据','2012-08-21 23:06:46');
INSERT INTO `t_reserve` VALUES ('5','闽南文化生态保护实验区','2007年6月','福建省（厦门市、漳州市、泉州市）','FY0220006','022'),  ('6','徽州文化生态保护实验区','2008年1月','安徽省（黄山市，绩溪县）','FY0070007','007'),  ('7','徽州文化生态保护实验区','2008年1月','江西省（婺源县）','FY0140008','014'),  ('8','热贡文化生态保护实验区','2008年8月','青海省（黄南藏族自治州）','FY0200009','020'),  ('9','羌族文化生态保护实验区','2008年10月','四川省（阿坝藏族羌族自治州茂县、汶川县、理县，绵阳市北川羌族自治县，松潘县、黑水县、平武县）','FY0180010','018'),  ('10','羌族文化生态保护实验区','2008年10月','陕西省（宁强县、略阳县）','FY0040011','004'),  ('11','客家文化（梅州）生态保护实验区','2010年5月','广东省（梅州市）','FY0230012','023'),  ('12','武陵山区（湘西）土家族苗族文化生态保护实验区','2010年5月','湖南省（湘西土家族苗族自治州）','FY0110013','011'),  ('13','海洋渔文化（象山）生态保护实验区','2010年6月','浙江省（象山县）','FY0290014','029'),  ('14','晋中文化生态保护实验区','2010年6月','山西省（晋中市；太原市小店区、晋源区、清徐县、阳曲县；吕梁市交城县、文水县、汾阳市、孝义市）','FY0190015','019'),  ('15','潍水文化生态保护实验区','2010年11月','山东省（潍坊市）','FY0050016','005'),  ('16','迪庆民族文化生态保护实验区','2010年11月','云南省（迪庆藏族自治州）','FY0300017','030'),  ('17','大理文化生态保护实验区','2011年1月','云南省（大理白族自治州）','FY0300017','030'),  ('18','陕北文化生态保护实验区','2012年4月','陕西省（延安市、榆林市）','FY0040011','004');
INSERT INTO `t_resever_cost` VALUES ('1','18','陕北文化生态保护实验区','2012','FY0040011','陕西省文化厅','004',',3','北京昌平','10010','陈云','18909877890','212','121212','1212','10','20','121212','2012-08-22 20:16:01');
INSERT INTO `t_sys_dict` VALUES ('000','非遗司','0','AREA'),  ('001','北京市','1','AREA'),  ('001','传统戏剧','999','PROJECT_TYPE'),  ('002','湖北省','2','AREA'),  ('002','民间文学','999','PROJECT_TYPE'),  ('003','天津市','3','AREA'),  ('003','传统音乐','999','PROJECT_TYPE'),  ('004','陕西省',NULL,'AREA'),  ('004','传统舞蹈','999','PROJECT_TYPE'),  ('005','山东省',NULL,'AREA'),  ('005','曲艺','999','PROJECT_TYPE'),  ('006','内蒙古',NULL,'AREA'),  ('006','传统体育、游艺与杂技','999','PROJECT_TYPE'),  ('007','安徽省',NULL,'AREA'),  ('007','传统美术','999','PROJECT_TYPE'),  ('008','河北省',NULL,'AREA'),  ('008','传统技艺','999','PROJECT_TYPE'),  ('009','河南省',NULL,'AREA'),  ('009','传统医药','999','PROJECT_TYPE'),  ('010','黑龙江',NULL,'AREA'),  ('010','民俗','999','PROJECT_TYPE'),  ('011','湖南省',NULL,'AREA'),  ('012','吉林省',NULL,'AREA'),  ('013','江苏省',NULL,'AREA'),  ('014','江西省',NULL,'AREA'),  ('015','海南省',NULL,'AREA'),  ('016','贵州省',NULL,'AREA'),  ('017','重庆市',NULL,'AREA'),  ('018','四川省',NULL,'AREA'),  ('019','山西省',NULL,'AREA'),  ('020','青海省',NULL,'AREA'),  ('021','宁夏省',NULL,'AREA'),  ('022','福建省',NULL,'AREA'),  ('023','广东省',NULL,'AREA'),  ('024','甘肃省',NULL,'AREA'),  ('025','广西省',NULL,'AREA'),  ('026','辽宁省',NULL,'AREA'),  ('027','上海市',NULL,'AREA'),  ('028','新疆建设兵团',NULL,'AREA'),  ('029','浙江省',NULL,'AREA'),  ('030','云南省',NULL,'AREA'),  ('031','西藏省',NULL,'AREA'),  ('032','新疆省',NULL,'AREA'),  ('2011','2011',NULL,'YEAR'),  ('2012','2012','1','YEAR'),  ('2013','2013','2','YEAR'),  ('2014','2014','3','YEAR'),  ('apply','申报中','2','FLOW_STATUS'),  ('COMMONUSER','普通用户','1','DEFAULTROLE'),  ('COMPANY','公司',NULL,'ORGTYPE'),  ('DEPT','部门','1','ORGTYPE'),  ('failure','审批不通过','1','FLOW_STATUS'),  ('FAILURE','失败','1','HANDLERESULT'),  ('femme','女','1','GENDER'),  ('HAN','汉族',NULL,'MINORITY'),  ('male','男','0','GENDER'),  ('NO','否','1','YESORNO'),  ('ORG','组织','2','ORGTYPE'),  ('project','项目补助费申报',NULL,'FLOW_TYPE'),  ('resever','保护区补助费申报','1','FLOW_TYPE'),  ('success','审批通过',NULL,'FLOW_STATUS'),  ('SUCCESS','成功',NULL,'HANDLERESULT'),  ('SYSADMIN','系统管理员',NULL,'DEFAULTROLE'),  ('tree-appLog','操作日志','6','ICONCLS'),  ('tree-att','文件图标','8','ICONCLS'),  ('tree-auth','授权图标','999','ICONCLS'),  ('tree-config','配置文件图标','9','ICONCLS'),  ('tree-dd','字典图标','2','ICONCLS'),  ('tree-org','组织图标','1','ICONCLS'),  ('tree-pwd','密码修改','3','ICONCLS'),  ('tree-role','角色图标','5','ICONCLS'),  ('tree-source','资源图标','4','ICONCLS'),  ('tree-sysLog','系统日志','7','ICONCLS'),  ('tree-user','用户图标','0','ICONCLS'),  ('YES','是',NULL,'YESORNO'),  ('传承活动','传承活动','999','BUDGET_PROJECT_DETAIL'),  ('其他','其他','999','BUDGET_RESEVER_DETAIL'),  ('其他支出','其他支出','1000','BUDGET_PROJECT_DETAIL'),  ('出版','出版','999','BUDGET_PROJECT_DETAIL'),  ('展示推广','展示推广','999','BUDGET_PROJECT_DETAIL'),  ('抢救性记录和保存','抢救性记录和保存','999','BUDGET_PROJECT_DETAIL'),  ('民俗活动','民俗活动','999','BUDGET_PROJECT_DETAIL'),  ('理论及技艺研究','理论及技艺研究','999','BUDGET_PROJECT_DETAIL'),  ('调查研究','调查研究','999','BUDGET_PROJECT_DETAIL');
INSERT INTO `t_sys_dict_type` VALUES ('AREA','区域',''),  ('BUDGET_PROJECT_DETAIL','项目预算明细内容',NULL),  ('BUDGET_RESEVER_DETAIL','保护区预算明细内容',NULL),  ('DEFAULTROLE','默认角色',''),  ('FLOW_STATUS','审批状态',NULL),  ('FLOW_TYPE','流程类型',NULL),  ('GENDER','性别',NULL),  ('HANDLERESULT','处理结果',NULL),  ('ICONCLS','菜单图标',NULL),  ('MINORITY','民族',NULL),  ('MODULE','日志模块',NULL),  ('ORGTYPE','组织类型',NULL),  ('PROJECT_TYPE','非遗项目类型',NULL),  ('YEAR','年份',NULL),  ('YESORNO','是否',NULL);
INSERT INTO `t_sys_log` VALUES ('27','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"COMMONUSER\",\"HOME,PROCESSCR,WFCOMMON,PROCESSTODO,PROJECT,PROJECTINFO,PROJECTINFO-QUERY,PROJECTCOST,RESEVER,RESEVERINFO,RESINFO-QUERY,RESEVERCOST,MYPWD,MYPWD-CHANGE,LEFTMENU,ATT-DELETE,ATT-UPLOAD,ATT-DOWNLOAD,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:34:21'),  ('28','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"PROVINCEUSER\",\"USERMANAGER,ORG,ORG-QUERY,USER,USER-QUERY,USER-UPDATE,USER-DELETE,USER-PWD,USER-ROLE,USER-DISABLED,PROJECT,PROJECTSUM,PROJECTSUN-EX,HERITOR,HERITORINFO,HERINFO-QUERY,HERINFO-BING,HERINFO-MODIFY,HERINFO-DELETE,HERITORSUM,HERITORSUN-EX,RESEVER,RESEVERINFO,RESINFO-QUERY,RESINFO-MODIFY,RESINFO-DELETE,RESEVERCOST,SUMMARY,SUMMARY-EX,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:35:32'),  ('29','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"CENTRALUSER\",\"USERMANAGER,ORG,ORG-QUERY,ORG-DELETE,ORG-UPDATE,USER,USER-QUERY,USER-UPDATE,USER-DELETE,USER-PWD,USER-ROLE,USER-DISABLED,HOME,PROCESSCR,WFCOMMON,WFMODIFY,PROCESSTODO,PROJECT,PROJECTINFO,PROJECTINFO-QUERY,PROJECTINFO-MODIFY,PROJECTINFO-DELETE,PROJECTCOST,PROJECTSUM,PROJECTSUN-EX,HERITOR,HERITORINFO,HERINFO-QUERY,HERINFO-BING,HERINFO-MODIFY,HERINFO-DELETE,HERITORSUM,HERITORSUN-EX,RESEVER,RESEVERINFO,RESINFO-QUERY,RESINFO-MODIFY,RESINFO-DELETE,RESEVERCOST,SUMMARY,SUMMARY-EX,MYPWD,MYPWD-CHANGE,LEFTMENU,ATT-DELETE,ATT-UPLOAD,ATT-DOWNLOAD,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:35:57'),  ('30','org.thorn.auth.service.AuthServiceImpl','saveRoleByUser','[\"FY0000001\",\"CENTRALUSER,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:37:16'),  ('31','org.thorn.auth.service.AuthServiceImpl','saveRoleByUser','[\"FY0010000\",\"PROVINCEUSER,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:37:28'),  ('32','org.thorn.auth.service.AuthServiceImpl','saveRoleByUser','[\"FY0000000\",\"CENTRALUSER,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:42:59'),  ('33','org.thorn.user.service.UserServiceImpl','changePwd','[\"FY0000000\",\"111www\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:44:56'),  ('34','org.thorn.auth.service.AuthServiceImpl','saveRoleByUser','[\"FY0030004\",\"PROVINCEUSER,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:45:19'),  ('35','org.thorn.user.service.UserServiceImpl','changePwd','[\"FY0030004\",\"111www\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:45:32'),  ('36','org.thorn.user.service.UserServiceImpl','changePwd','[\"FY0030005\",\"111www\"]','ADMIN','SUCCESS',NULL,'2012-08-21 21:45:42'),  ('37','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"福建省文化厅\",\"area\":null,\"userId\":\"FY0220006\",\"orgName\":null,\"orgCode\":\"022\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"01ded7b2a3ce5938f9353326cc8e842a\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"福建省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:48:38'),  ('38','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"安徽省文化厅\",\"area\":null,\"userId\":\"FY0070007\",\"orgName\":null,\"orgCode\":\"007\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"b31ad46b121afc84714ddb60ea6ee9dc\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"安徽省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:49:33'),  ('39','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"江西省文化厅\",\"area\":null,\"userId\":\"FY0140008\",\"orgName\":null,\"orgCode\":\"014\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"92cbb6d627558c67a4a7625eaac38a26\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"江西省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:50:27'),  ('40','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"青海省文化厅\",\"area\":null,\"userId\":\"FY0200009\",\"orgName\":null,\"orgCode\":\"020\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"c85ed5c9a62c27e39d45df613e95bb77\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"青海省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:51:42'),  ('41','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"四川省文化厅\",\"area\":null,\"userId\":\"FY0180010\",\"orgName\":null,\"orgCode\":\"018\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"89531905cec2f9dc5b5c47dd0aa8f9ff\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"四川省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:52:24'),  ('42','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"陕西省文化厅\",\"area\":null,\"userId\":\"FY0040011\",\"orgName\":null,\"orgCode\":\"004\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"7745d0387452c960fabf3bd2f9659f6c\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"陕西省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:53:32'),  ('43','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"广东省文化厅\",\"area\":null,\"userId\":\"FY0230012\",\"orgName\":null,\"orgCode\":\"023\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"8c149cb01131d854cac4bd198993e54f\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"广东省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:54:15'),  ('44','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"湖南省文化厅\",\"area\":null,\"userId\":\"FY0110013\",\"orgName\":null,\"orgCode\":\"011\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"7cf32cfd47eb81b21f3ca371c1a2aa82\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"湖南省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:54:46'),  ('45','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"浙江省文化厅\",\"area\":null,\"userId\":\"FY0290014\",\"orgName\":null,\"orgCode\":\"029\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"72eba3e4b6b1a24155e42029498fc5cb\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"浙江省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:55:25'),  ('46','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"山西省文化厅\",\"area\":null,\"userId\":\"FY0190015\",\"orgName\":null,\"orgCode\":\"019\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"e3d87eb1c2ac277454030c663633abb9\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"山西省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:57:56'),  ('47','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"山东省文化厅\",\"area\":null,\"userId\":\"FY0050016\",\"orgName\":null,\"orgCode\":\"005\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"acb73c77e2b37a2f7f0c09b583a57765\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"山东省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 21:59:24'),  ('48','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"云南省文化厅\",\"area\":null,\"userId\":\"FY0300017\",\"orgName\":null,\"orgCode\":\"030\",\"orgType\":null,\"phone\":\"\",\"userPwd\":\"15df01a0f9586b76b8ca7e2a3b478def\",\"cumail\":\"abc@163.com\",\"gender\":\"\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"云南省文化厅\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:00:01'),  ('49','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"闽南文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"福建省（厦门市、漳州市、泉州市）\",\"userId\":\"FY0220006\",\"province\":\"022\",\"buildTime\":\"2007年6月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:04:37'),  ('50','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"徽州文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"安徽省（黄山市，绩溪县）\",\"userId\":\"FY0070007\",\"province\":\"007\",\"buildTime\":\"2008年1月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:05:40'),  ('51','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"徽州文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"江西省（婺源县）\",\"userId\":\"FY0140008\",\"province\":\"014\",\"buildTime\":\"2008年1月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:06:11'),  ('52','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"热贡文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"青海省（黄南藏族自治州）\",\"userId\":\"FY0200009\",\"province\":\"020\",\"buildTime\":\"2008年8月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:06:41'),  ('53','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"羌族文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"四川省（阿坝藏族羌族自治州茂县、汶川县、理县，绵阳市北川羌族自治县，松潘县、黑水县、平武县）\",\"userId\":\"FY0180010\",\"province\":\"018\",\"buildTime\":\"2008年10月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:07:08'),  ('54','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"羌族文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"陕西省（宁强县、略阳县）\",\"userId\":\"FY0040011\",\"province\":\"004\",\"buildTime\":\"2008年10月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:07:36'),  ('55','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"客家文化（梅州）生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"广东省（梅州市）\",\"userId\":\"FY0230012\",\"province\":\"023\",\"buildTime\":\"2010年5月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:08:02'),  ('56','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"武陵山区（湘西）土家族苗族文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"湖南省（湘西土家族苗族自治州）\",\"userId\":\"FY0110013\",\"province\":\"011\",\"buildTime\":\"2010年5月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:08:29'),  ('57','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"海洋渔文化（象山）生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"浙江省（象山县）\",\"userId\":\"FY0290014\",\"province\":\"029\",\"buildTime\":\"2010年6月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:08:52'),  ('58','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"晋中文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"山西省（晋中市；太原市小店区、晋源区、清徐县、阳曲县；吕梁市交城县、文水县、汾阳市、孝义市）\",\"userId\":\"FY0190015\",\"province\":\"019\",\"buildTime\":\"2010年6月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:09:21'),  ('59','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"潍水文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"山东省（潍坊市）\",\"userId\":\"FY0050016\",\"province\":\"005\",\"buildTime\":\"2010年11月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:09:43'),  ('60','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"迪庆民族文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"云南省（迪庆藏族自治州）\",\"userId\":\"FY0300017\",\"province\":\"030\",\"buildTime\":\"2010年11月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:10:09'),  ('61','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"大理文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"云南省（大理白族自治州）\",\"userId\":\"FY0300017\",\"province\":\"030\",\"buildTime\":\"2011年1月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:10:53'),  ('62','org.thorn.app.service.ReseverServiceImpl','save','[{\"name\":\"陕北文化生态保护实验区\",\"id\":null,\"userName\":null,\"area\":\"陕西省（延安市、榆林市）\",\"userId\":\"FY0040011\",\"province\":\"004\",\"buildTime\":\"2012年4月\"}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:13:49'),  ('63','org.thorn.dd.service.DataDictServiceImpl','deleteDd','[\"033,\",\"AREA\"]','ADMIN','SUCCESS',NULL,'2012-08-21 22:14:34'),  ('64','org.thorn.org.service.OrgServiceImpl','delete','[\"81,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 22:15:01'),  ('65','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"PROVINCEUSER\",\"USERMANAGER,ORG,ORG-QUERY,USER,USER-QUERY,USER-UPDATE,USER-DELETE,USER-PWD,USER-ROLE,USER-DISABLED,PROJECT,PROJECTINFO,PROJECTINFO-QUERY,PROJECTINFO-MODIFY,PROJECTINFO-DELETE,PROJECTCOST,PROJECTSUM,PROJECTSUN-EX,HERITOR,HERITORINFO,HERINFO-QUERY,HERINFO-BING,HERINFO-MODIFY,HERINFO-DELETE,HERITORSUM,HERITORSUN-EX,RESEVER,RESEVERINFO,RESINFO-QUERY,RESINFO-MODIFY,RESINFO-DELETE,RESEVERCOST,SUMMARY,SUMMARY-EX,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 22:23:04'),  ('66','org.thorn.app.service.ProjectServiceImpl','save','[{\"name\":\"津门法鼓（挂甲寺庆音法鼓）\",\"id\":null,\"type\":\"003\",\"userName\":null,\"area\":\"天津市河西区\",\"userId\":\"FY0030005\",\"isUnProject\":\"\",\"province\":\"003\",\"code\":\"Ⅱ-122\",\"bigNo\":1,\"smallNo\":1,\"batchNum\":\"2\",\"minority\":\"\"}]','FY0030004','SUCCESS',NULL,'2012-08-21 22:24:36'),  ('67','org.thorn.app.service.HeritorServiceImpl','save','[{\"name\":\"测试传承人\",\"id\":null,\"projectName\":null,\"province\":\"003\",\"remark\":\"111\",\"batchNum\":\"2\",\"idCard\":\"420580199909207896\",\"gender\":\"\",\"isDie\":\"NO\",\"dieDate\":\"\",\"projectId\":4,\"projectCode\":null}]','FY0030004','SUCCESS',NULL,'2012-08-21 22:46:30'),  ('68','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"SUMMARY-QUERY\",\"sourceName\":\"费用查询\",\"parentSource\":\"SUMMARY\",\"sourceUrl\":\"/heritor/summaryAllCost.jmt\",\"iconsCls\":\"\",\"isleaf\":\"NO\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-21 22:50:48'),  ('69','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"PROVINCEUSER\",\"USERMANAGER,ORG,ORG-QUERY,USER,USER-QUERY,USER-UPDATE,USER-DELETE,USER-PWD,USER-ROLE,USER-DISABLED,PROJECT,PROJECTINFO,PROJECTINFO-QUERY,PROJECTINFO-MODIFY,PROJECTINFO-DELETE,PROJECTCOST,PROJECTSUM,PROJECTSUN-EX,HERITOR,HERITORINFO,HERINFO-QUERY,HERINFO-BING,HERINFO-MODIFY,HERINFO-DELETE,HERITORSUM,HERITORSUN-EX,RESEVER,RESEVERINFO,RESINFO-QUERY,RESINFO-MODIFY,RESINFO-DELETE,RESEVERCOST,SUMMARY,SUMMARY-EX,SUMMARY-QUERY,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 22:53:08'),  ('70','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"CENTRALUSER\",\"USERMANAGER,ORG,ORG-QUERY,ORG-DELETE,ORG-UPDATE,USER,USER-QUERY,USER-UPDATE,USER-DELETE,USER-PWD,USER-ROLE,USER-DISABLED,HOME,PROCESSCR,WFCOMMON,WFMODIFY,PROCESSTODO,PROJECT,PROJECTINFO,PROJECTINFO-QUERY,PROJECTINFO-MODIFY,PROJECTINFO-DELETE,PROJECTCOST,PROJECTSUM,PROJECTSUN-EX,HERITOR,HERITORINFO,HERINFO-QUERY,HERINFO-BING,HERINFO-MODIFY,HERINFO-DELETE,HERITORSUM,HERITORSUN-EX,RESEVER,RESEVERINFO,RESINFO-QUERY,RESINFO-MODIFY,RESINFO-DELETE,RESEVERCOST,SUMMARY,SUMMARY-EX,SUMMARY-QUERY,MYPWD,MYPWD-CHANGE,LEFTMENU,ATT-DELETE,ATT-UPLOAD,ATT-DOWNLOAD,\"]','ADMIN','SUCCESS',NULL,'2012-08-21 22:53:15'),  ('71','org.thorn.attachment.service.AttachmentDBServiceImpl','delete','[\"1\"]','FY0030005','SUCCESS',NULL,'2012-08-21 23:10:12'),  ('72','org.thorn.auth.service.AuthServiceImpl','saveRoleByUser','[\"FY0040011\",\"PROVINCEUSER,\"]','ADMIN','SUCCESS',NULL,'2012-08-22 20:13:51');
INSERT INTO `t_sys_org` VALUES ('1','ROOT','-1','文化部','文化部','COMPANY',NULL,'0','NO','NO',NULL),  ('2','001','ROOT','北京市文化厅','北京市文化厅','COMPANY',NULL,'1','YES','NO','001'),  ('11','002','ROOT','湖北省文化厅','湖北省文化厅','COMPANY','','2','YES','NO','002'),  ('12','003','ROOT','天津市文化厅','天津市文化厅','COMPANY',NULL,'999','YES','NO','003'),  ('13','000','ROOT','文化部非物质文化遗产司','文化部非遗司','COMPANY',NULL,'0','YES','NO','000'),  ('52','004','ROOT','陕西省文化厅','陕西省文化厅','COMPANY',NULL,'999','YES','NO','004'),  ('53','005','ROOT','山东省文化厅','山东省文化厅','COMPANY',NULL,'999','YES','NO','005'),  ('54','006','ROOT','内蒙古文化厅','内蒙古文化厅','COMPANY',NULL,'999','YES','NO','006'),  ('55','007','ROOT','安徽省文化厅','安徽省文化厅','COMPANY',NULL,'999','YES','NO','007'),  ('56','008','ROOT','河北省文化厅','河北省文化厅','COMPANY',NULL,'999','YES','NO','008'),  ('57','009','ROOT','河南省文化厅','河南省文化厅','COMPANY',NULL,'999','YES','NO','009'),  ('58','010','ROOT','黑龙江省文化厅','黑龙江省文化厅','COMPANY',NULL,'999','YES','NO','010'),  ('59','011','ROOT','湖南省文化厅','湖南省文化厅','COMPANY',NULL,'999','YES','NO','011'),  ('60','012','ROOT','吉林省文化厅','吉林省文化厅','COMPANY',NULL,'999','YES','NO','012'),  ('61','013','ROOT','江苏省文化厅','江苏省文化厅','COMPANY',NULL,'999','YES','NO','013'),  ('62','014','ROOT','江西省文化厅','江西省文化厅','COMPANY',NULL,'999','YES','NO','014'),  ('63','015','ROOT','海南省文化厅','海南省文化厅','COMPANY',NULL,'999','YES','NO','015'),  ('64','016','ROOT','贵州省文化厅','贵州省文化厅','COMPANY',NULL,'999','YES','NO','016'),  ('65','017','ROOT','重庆市文化厅','重庆市文化厅','COMPANY',NULL,'999','YES','NO','017'),  ('66','018','ROOT','四川省文化厅','四川省文化厅','COMPANY',NULL,'999','YES','NO','018'),  ('67','019','ROOT','山西省文化厅','山西省文化厅','COMPANY',NULL,'999','YES','NO','019'),  ('68','020','ROOT','青海省文化厅','青海省文化厅','COMPANY',NULL,'999','YES','NO','020'),  ('69','021','ROOT','宁夏省文化厅','宁夏省文化厅','COMPANY',NULL,'999','YES','NO','021'),  ('70','022','ROOT','福建省文化厅','福建省文化厅','COMPANY',NULL,'999','YES','NO','022'),  ('71','023','ROOT','广东省文化厅','广东省文化厅','COMPANY',NULL,'999','YES','NO','023'),  ('72','024','ROOT','甘肃省文化厅','甘肃省文化厅','COMPANY',NULL,'999','YES','NO','024'),  ('73','025','ROOT','广西省文化厅','广西省文化厅','COMPANY',NULL,'999','YES','NO','025'),  ('74','026','ROOT','辽宁省文化厅','辽宁省文化厅','COMPANY',NULL,'999','YES','NO','026'),  ('75','027','ROOT','上海市文化厅','上海市文化厅','COMPANY',NULL,'999','YES','NO','027'),  ('76','028','ROOT','新疆建设兵团文化厅','新疆建设兵团文化厅','COMPANY',NULL,'999','YES','NO','028'),  ('77','029','ROOT','浙江省文化厅','浙江省文化厅','COMPANY',NULL,'999','YES','NO','029'),  ('78','030','ROOT','云南省文化厅','云南省文化厅','COMPANY',NULL,'999','YES','NO','030'),  ('79','031','ROOT','西藏省文化厅','西藏省文化厅','COMPANY',NULL,'999','YES','NO','031'),  ('80','032','ROOT','新疆省文化厅','新疆省文化厅','COMPANY',NULL,'999','YES','NO','032');
INSERT INTO `t_sys_resource` VALUES ('0','ALL','/**','YES','NO','-1','99',''),  ('APPLOG','操作日志','/system/log/appLog.jsp','YES','YES','LOG','1','tree-appLog'),  ('APPLOG-EXCEL','操作日志导出','/log/exportLogExcel.jmt','YES','NO','APPLOG','999',''),  ('APPLOG-QUERY','操作日志查询','/log/getLogPage.jmt','YES','NO','APPLOG','0',''),  ('ATT','文件管理','/system/att/attachment.jsp','YES','YES','CF','9','tree-att'),  ('ATT-DELETE','附件删除','/att/delete.jmt','YES','NO','NAV','999',''),  ('ATT-DOWNLOAD','附件下载','/att/download.jmt','YES','NO','NAV','999',''),  ('ATT-UPLOAD','附件上传','/att/get*.jmt','YES','NO','NAV','999',''),  ('AUTH','用户授权','/system/role/userAuth.jsp','YES','YES','AUTHMANAGER','1','tree-auth'),  ('AUTH-ADD','添加用户','/user/saveUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-DELETE','删除用户','/user/deleteUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-QUERY','授权关系查询','/user/get*.jmt','YES','NO','AUTH','0',''),  ('AUTHMANAGER','权限管理','','NO','YES','SYS','3',''),  ('CF','配置项管理','','NO','YES','SYS','0',''),  ('CF-MODIFY','配置文件修改','/cf/modifyConfig.jmt','YES','NO','CONFIG','1',''),  ('CF-QUERY','配置文件查看','/cf/get*.jmt','YES','NO','CONFIG','0',''),  ('CONFIG','配置文件管理','/system/cf/configurator.jsp','YES','YES','CF','1','tree-config'),  ('DICT','数据字典管理','/system/dd/dd.jsp','YES','YES','CF','0','tree-dd'),  ('DICT-DELETE','数据字典删除','/dd/delete*.jmt','YES','NO','DICT','999',''),  ('DICT-QUERY','数据字典查询','/dd/get*.jmt','YES','NO','DICT','0',''),  ('DICT-UPDATE','数据字典更新','/dd/saveOrModify*.jmt','YES','NO','DICT','999',''),  ('HERINFO-BING','绑定非遗项目','/heritor/bingingProject.jmt','YES','NO','HERITORINFO','1',NULL),  ('HERINFO-DELETE','传承人信息删除','/heritor/deleteHeritor.jmt','YES','NO','HERITORINFO','2',NULL),  ('HERINFO-MODIFY','传承人信息修改','/heritor/saveOrModify*.jmt','YES','NO','HERITORINFO','1',NULL),  ('HERINFO-QUERY','传承人信息查询','/heritor/getHeritor*.jmt','YES','NO','HERITORINFO','0',NULL),  ('HERITOR','传承人库管理',NULL,'NO','YES','NAV','5',NULL),  ('HERITORINFO','传承人信息管理','/app/heritor.jsp','YES','YES','HERITOR','1',NULL),  ('HERITORSUM','传承人补助费报表','/app/heritorCostSummary.jsp','YES','YES','HERITOR','2',NULL),  ('HERITORSUN-EX','费用导出报表','/heritor/exportHeritorCostExcel.jmt','YES','NO','HERITORSUM','0',NULL),  ('HOME','主页','/system/main.jsp','YES','NO','NAV','0',''),  ('LEFTMENU','菜单树','/resource/getLeftTree.jmt','YES','NO','NAV','998',''),  ('LOG','日志管理','','NO','YES','SYS','1',''),  ('MYPWD','修改密码','/system/user/changePwd.jsp','YES','YES','NAV','99','tree-pwd'),  ('MYPWD-CHANGE','密码修改','/user/changeMyPwd.jmt','YES','NO','MYPWD','999',''),  ('NAV','应用菜单','','NO','YES','0','0',''),  ('ORG','组织管理','/system/org/org.jsp','YES','YES','USERMANAGER','0','tree-org'),  ('ORG-DELETE','组织删除','/org/delete*.jmt','YES','NO','ORG','999',''),  ('ORG-QUERY','组织查询','/org/get*.jmt','YES','NO','ORG','0',''),  ('ORG-UPDATE','组织更新','/org/saveOrModify*.jmt','YES','NO','ORG','999',''),  ('PROCESSAPP','流程表单资源','/app/**','YES','NO','WORKFLOW','999',''),  ('PROCESSCR','发起费用申报','/process/processCr.jsp','YES','YES','NAV','0',NULL),  ('PROCESSTODO','我的待办','/process/processTodo.jsp','YES','NO','NAV','3',NULL),  ('PROJECT','非遗项目库管理',NULL,'NO','YES','NAV','4',NULL),  ('PROJECTCOST','项目费用管理','/app/projectCostSearch.jsp','YES','YES','PROJECT','2',NULL),  ('PROJECTINFO','项目信息管理','/app/project.jsp','YES','YES','PROJECT','1',NULL),  ('PROJECTINFO-DELETE','项目信息删除','/project/deleteProject.jmt','YES','NO','PROJECTINFO','3',NULL),  ('PROJECTINFO-MODIFY','项目信息修改','/project/saveOrModify*.jmt','YES','NO','PROJECTINFO','1',NULL),  ('PROJECTINFO-QUERY','项目信息查询','/project/get*.jmt','YES','NO','PROJECTINFO','0',NULL),  ('PROJECTSUM','项目费用报表','/app/projectCostSummary.jsp','YES','YES','PROJECT','3',NULL),  ('PROJECTSUN-EX','费用导出报表','/project/exportProjectCostExcel.jmt','YES','NO','PROJECTSUM','0',NULL),  ('RESEVER','文化生态保护区库管理',NULL,'NO','YES','NAV','5',NULL),  ('RESEVERCOST','保护区费用管理','/app/reseverCostSearch.jsp','YES','YES','RESEVER','2',NULL),  ('RESEVERINFO','保护区信息管理','/app/resever.jsp','YES','YES','RESEVER','1',NULL),  ('RESINFO-DELETE','保护区信息删除','/resever/deleteResever.jmt','YES','NO','RESEVERINFO','3',NULL),  ('RESINFO-MODIFY','保护区信息修改','/resever/saveOrModify*.jmt','YES','NO','RESEVERINFO','2',NULL),  ('RESINFO-QUERY','保护区信息查询','/resever/getResever*.jmt','YES','NO','RESEVERINFO','0',NULL),  ('ROLE','角色管理','/system/role/role.jsp','YES','YES','AUTHMANAGER','0','tree-role'),  ('ROLE-AUTH','角色授权','/role/saveAuth.jmt','YES','NO','ROLE','999',''),  ('ROLE-DELETE','角色删除','/role/delete*.jmt','YES','NO','ROLE','999',''),  ('ROLE-QUERY','角色查询','/role/get*.jmt','YES','NO','ROLE','0',''),  ('ROLE-UPDATE','角色更新','/role/saveOrModify*.jmt','YES','NO','ROLE','999',''),  ('SOURCE','资源管理','/system/resource/source.jsp','YES','YES','CF','2','tree-source'),  ('SOURCE-DELETE','资源删除','/resource/delete*.jmt','YES','NO','SOURCE','999',''),  ('SOURCE-QUERY','资源查询','/resource/get*.jmt','YES','NO','SOURCE','0',''),  ('SOURCE-UPDATE','资源更新','/resource/saveOrModify*.jmt','YES','NO','SOURCE','999',''),  ('SUMMARY','资金申报汇总报表','/app/costSummary.jsp','YES','YES','NAV','6',NULL),  ('SUMMARY-EX','费用导出报表','/heritor/exportHeritorCostExcel.jmt','YES','NO','SUMMARY','0',NULL),  ('SUMMARY-QUERY','费用查询','/heritor/summaryAllCost.jmt','YES','NO','SUMMARY','0',NULL),  ('SYS','系统管理','','NO','YES','0','0',''),  ('SYSLOG','系统日志','/system/log/sysLog.jsp','YES','YES','LOG','0','tree-sysLog'),  ('SYSLOG-LEVEL','修改日志级别','/log/*LogLevel.jmt','YES','NO','SYSLOG','1',''),  ('SYSLOG-QUERY','系统日志查询','/system/log/sysLog*.jsp','YES','NO','SYSLOG','0',''),  ('USER','用户管理','/system/user/user.jsp','YES','YES','USERMANAGER','1','tree-user'),  ('USER-DELETE','用户删除','/user/deleteUser.jmt','YES','NO','USER','2',''),  ('USER-DISABLED','用户启/禁用','/user/disabled*.jmt','YES','NO','USER','999',''),  ('USER-PWD','密码修改','/user/changePwd.jmt','YES','NO','USER','999',''),  ('USER-QUERY','用户查询','/user/get*.jmt','YES','NO','USER','0',''),  ('USER-ROLE','用户角色管理','/user/saveRoleByUser.jmt','YES','NO','USER','999',''),  ('USER-UPDATE','用户更新','/user/saveOrModify*.jmt','YES','NO','USER','1',''),  ('USERMANAGER','用户管理','','NO','YES','SYS','2',''),  ('WFCOMMON','流程通用资源','/wf/cm/**','YES','NO','PROCESSCR','0',NULL),  ('WFMODIFY','修改流程','/wf/modifyProcess.jmt','YES','NO','PROCESSCR','1',NULL);
INSERT INTO `t_sys_role` VALUES ('CENTRALUSER','部委级用户',NULL,'NO'),  ('COMMONUSER','普通用户',NULL,'NO'),  ('PROVINCEUSER','省厅级用户',NULL,'NO');
INSERT INTO `t_sys_role_res` VALUES ('CENTRALUSER','ATT-DELETE','2012-08-21 22:53:15'),  ('CENTRALUSER','ATT-DOWNLOAD','2012-08-21 22:53:15'),  ('CENTRALUSER','ATT-UPLOAD','2012-08-21 22:53:15'),  ('CENTRALUSER','HERINFO-BING','2012-08-21 22:53:14'),  ('CENTRALUSER','HERINFO-DELETE','2012-08-21 22:53:14'),  ('CENTRALUSER','HERINFO-MODIFY','2012-08-21 22:53:14'),  ('CENTRALUSER','HERINFO-QUERY','2012-08-21 22:53:14'),  ('CENTRALUSER','HERITOR','2012-08-21 22:53:14'),  ('CENTRALUSER','HERITORINFO','2012-08-21 22:53:14'),  ('CENTRALUSER','HERITORSUM','2012-08-21 22:53:15'),  ('CENTRALUSER','HERITORSUN-EX','2012-08-21 22:53:15'),  ('CENTRALUSER','HOME','2012-08-21 22:53:14'),  ('CENTRALUSER','LEFTMENU','2012-08-21 22:53:15'),  ('CENTRALUSER','MYPWD','2012-08-21 22:53:15'),  ('CENTRALUSER','MYPWD-CHANGE','2012-08-21 22:53:15'),  ('CENTRALUSER','ORG','2012-08-21 22:53:14'),  ('CENTRALUSER','ORG-DELETE','2012-08-21 22:53:14'),  ('CENTRALUSER','ORG-QUERY','2012-08-21 22:53:14'),  ('CENTRALUSER','ORG-UPDATE','2012-08-21 22:53:14'),  ('CENTRALUSER','PROCESSCR','2012-08-21 22:53:14'),  ('CENTRALUSER','PROCESSTODO','2012-08-21 22:53:14'),  ('CENTRALUSER','PROJECT','2012-08-21 22:53:14'),  ('CENTRALUSER','PROJECTCOST','2012-08-21 22:53:14'),  ('CENTRALUSER','PROJECTINFO','2012-08-21 22:53:14'),  ('CENTRALUSER','PROJECTINFO-DELETE','2012-08-21 22:53:14'),  ('CENTRALUSER','PROJECTINFO-MODIFY','2012-08-21 22:53:14'),  ('CENTRALUSER','PROJECTINFO-QUERY','2012-08-21 22:53:14'),  ('CENTRALUSER','PROJECTSUM','2012-08-21 22:53:14'),  ('CENTRALUSER','PROJECTSUN-EX','2012-08-21 22:53:14'),  ('CENTRALUSER','RESEVER','2012-08-21 22:53:15'),  ('CENTRALUSER','RESEVERCOST','2012-08-21 22:53:15'),  ('CENTRALUSER','RESEVERINFO','2012-08-21 22:53:15'),  ('CENTRALUSER','RESINFO-DELETE','2012-08-21 22:53:15'),  ('CENTRALUSER','RESINFO-MODIFY','2012-08-21 22:53:15'),  ('CENTRALUSER','RESINFO-QUERY','2012-08-21 22:53:15'),  ('CENTRALUSER','SUMMARY','2012-08-21 22:53:15'),  ('CENTRALUSER','SUMMARY-EX','2012-08-21 22:53:15'),  ('CENTRALUSER','SUMMARY-QUERY','2012-08-21 22:53:15'),  ('CENTRALUSER','USER','2012-08-21 22:53:14'),  ('CENTRALUSER','USER-DELETE','2012-08-21 22:53:14'),  ('CENTRALUSER','USER-DISABLED','2012-08-21 22:53:14'),  ('CENTRALUSER','USER-PWD','2012-08-21 22:53:14'),  ('CENTRALUSER','USER-QUERY','2012-08-21 22:53:14'),  ('CENTRALUSER','USER-ROLE','2012-08-21 22:53:14'),  ('CENTRALUSER','USER-UPDATE','2012-08-21 22:53:14'),  ('CENTRALUSER','USERMANAGER','2012-08-21 22:53:14'),  ('CENTRALUSER','WFCOMMON','2012-08-21 22:53:14'),  ('CENTRALUSER','WFMODIFY','2012-08-21 22:53:14'),  ('COMMONUSER','ATT-DELETE','2012-08-21 21:34:21'),  ('COMMONUSER','ATT-DOWNLOAD','2012-08-21 21:34:21'),  ('COMMONUSER','ATT-UPLOAD','2012-08-21 21:34:21'),  ('COMMONUSER','HOME','2012-08-21 21:34:21'),  ('COMMONUSER','LEFTMENU','2012-08-21 21:34:21'),  ('COMMONUSER','MYPWD','2012-08-21 21:34:21'),  ('COMMONUSER','MYPWD-CHANGE','2012-08-21 21:34:21'),  ('COMMONUSER','PROCESSCR','2012-08-21 21:34:21'),  ('COMMONUSER','PROCESSTODO','2012-08-21 21:34:21'),  ('COMMONUSER','PROJECT','2012-08-21 21:34:21'),  ('COMMONUSER','PROJECTCOST','2012-08-21 21:34:21'),  ('COMMONUSER','PROJECTINFO','2012-08-21 21:34:21'),  ('COMMONUSER','PROJECTINFO-QUERY','2012-08-21 21:34:21'),  ('COMMONUSER','RESEVER','2012-08-21 21:34:21'),  ('COMMONUSER','RESEVERCOST','2012-08-21 21:34:21'),  ('COMMONUSER','RESEVERINFO','2012-08-21 21:34:21'),  ('COMMONUSER','RESINFO-QUERY','2012-08-21 21:34:21'),  ('COMMONUSER','WFCOMMON','2012-08-21 21:34:21'),  ('PROVINCEUSER','HERINFO-BING','2012-08-21 22:53:08'),  ('PROVINCEUSER','HERINFO-DELETE','2012-08-21 22:53:08'),  ('PROVINCEUSER','HERINFO-MODIFY','2012-08-21 22:53:08'),  ('PROVINCEUSER','HERINFO-QUERY','2012-08-21 22:53:08'),  ('PROVINCEUSER','HERITOR','2012-08-21 22:53:08'),  ('PROVINCEUSER','HERITORINFO','2012-08-21 22:53:08'),  ('PROVINCEUSER','HERITORSUM','2012-08-21 22:53:08'),  ('PROVINCEUSER','HERITORSUN-EX','2012-08-21 22:53:08'),  ('PROVINCEUSER','ORG','2012-08-21 22:53:08'),  ('PROVINCEUSER','ORG-QUERY','2012-08-21 22:53:08'),  ('PROVINCEUSER','PROJECT','2012-08-21 22:53:08'),  ('PROVINCEUSER','PROJECTCOST','2012-08-21 22:53:08'),  ('PROVINCEUSER','PROJECTINFO','2012-08-21 22:53:08'),  ('PROVINCEUSER','PROJECTINFO-DELETE','2012-08-21 22:53:08'),  ('PROVINCEUSER','PROJECTINFO-MODIFY','2012-08-21 22:53:08'),  ('PROVINCEUSER','PROJECTINFO-QUERY','2012-08-21 22:53:08'),  ('PROVINCEUSER','PROJECTSUM','2012-08-21 22:53:08'),  ('PROVINCEUSER','PROJECTSUN-EX','2012-08-21 22:53:08'),  ('PROVINCEUSER','RESEVER','2012-08-21 22:53:08'),  ('PROVINCEUSER','RESEVERCOST','2012-08-21 22:53:08'),  ('PROVINCEUSER','RESEVERINFO','2012-08-21 22:53:08'),  ('PROVINCEUSER','RESINFO-DELETE','2012-08-21 22:53:08'),  ('PROVINCEUSER','RESINFO-MODIFY','2012-08-21 22:53:08'),  ('PROVINCEUSER','RESINFO-QUERY','2012-08-21 22:53:08'),  ('PROVINCEUSER','SUMMARY','2012-08-21 22:53:08'),  ('PROVINCEUSER','SUMMARY-EX','2012-08-21 22:53:08'),  ('PROVINCEUSER','SUMMARY-QUERY','2012-08-21 22:53:08'),  ('PROVINCEUSER','USER','2012-08-21 22:53:08'),  ('PROVINCEUSER','USER-DELETE','2012-08-21 22:53:08'),  ('PROVINCEUSER','USER-DISABLED','2012-08-21 22:53:08'),  ('PROVINCEUSER','USER-PWD','2012-08-21 22:53:08'),  ('PROVINCEUSER','USER-QUERY','2012-08-21 22:53:08'),  ('PROVINCEUSER','USER-ROLE','2012-08-21 22:53:08'),  ('PROVINCEUSER','USER-UPDATE','2012-08-21 22:53:08'),  ('PROVINCEUSER','USERMANAGER','2012-08-21 22:53:08');
INSERT INTO `t_sys_user` VALUES ('ADMIN','系统管理员','陈','CHENYUN','6994d5fd8501c8576fcfd99c3386f085','male','chenyun313@163.com','18701309727','000','YES','NO','0','SYSADMIN'),  ('FY0000000','文化部非遗司',NULL,'文化部非遗司','b2602869ea81f206d7807395337f5a8b',NULL,'727zz@163.com',NULL,'000','YES','NO','0','COMMONUSER'),  ('FY0010001','北京市文化厅',NULL,'FY0010001','675b501d556c9a31d65b4364ed575e05',NULL,'727zz@163.com',NULL,'001','YES','NO','0','COMMONUSER'),  ('FY0010002','北京市北方昆曲剧院',NULL,'北京市北方昆曲剧院','cdaa9575a6c4e2b4f4fd67c66b55c2a0','male','727zz@163.com',NULL,'001','YES','NO','999','COMMONUSER'),  ('FY0010003','北京印钞厂',NULL,'FY0010003','ddac58a87f43443331f89054b8cb8899','male','727zz@163.com',NULL,'001','YES','NO','999','COMMONUSER'),  ('FY0030004','天津市文化厅',NULL,'天津市文化厅','5b82b92b3c753623fe806df2af2d28f9',NULL,'727zz@163.com',NULL,'003','YES','NO','0','COMMONUSER'),  ('FY0030005','河西区挂甲寺街道办事处',NULL,'河西区挂甲寺街道办事处','2f2e641611502a4d8ced416f92011a43',NULL,'727zz@163.com',NULL,'003','YES','NO','0','COMMONUSER'),  ('FY0040011','陕西省文化厅',NULL,'陕西省文化厅','7745d0387452c960fabf3bd2f9659f6c',NULL,'abc@163.com',NULL,'004','YES','NO','0','COMMONUSER'),  ('FY0050016','山东省文化厅',NULL,'山东省文化厅','acb73c77e2b37a2f7f0c09b583a57765',NULL,'abc@163.com',NULL,'005','YES','NO','0','COMMONUSER'),  ('FY0070007','安徽省文化厅',NULL,'安徽省文化厅','b31ad46b121afc84714ddb60ea6ee9dc',NULL,'abc@163.com',NULL,'007','YES','NO','0','COMMONUSER'),  ('FY0110013','湖南省文化厅',NULL,'湖南省文化厅','7cf32cfd47eb81b21f3ca371c1a2aa82',NULL,'abc@163.com',NULL,'011','YES','NO','0','COMMONUSER'),  ('FY0140008','江西省文化厅',NULL,'江西省文化厅','92cbb6d627558c67a4a7625eaac38a26',NULL,'abc@163.com',NULL,'014','YES','NO','0','COMMONUSER'),  ('FY0180010','四川省文化厅',NULL,'四川省文化厅','89531905cec2f9dc5b5c47dd0aa8f9ff',NULL,'abc@163.com',NULL,'018','YES','NO','0','COMMONUSER'),  ('FY0190015','山西省文化厅',NULL,'山西省文化厅','e3d87eb1c2ac277454030c663633abb9',NULL,'abc@163.com',NULL,'019','YES','NO','0','COMMONUSER'),  ('FY0200009','青海省文化厅',NULL,'青海省文化厅','c85ed5c9a62c27e39d45df613e95bb77',NULL,'abc@163.com',NULL,'020','YES','NO','0','COMMONUSER'),  ('FY0220006','福建省文化厅',NULL,'福建省文化厅','01ded7b2a3ce5938f9353326cc8e842a',NULL,'abc@163.com',NULL,'022','YES','NO','0','COMMONUSER'),  ('FY0230012','广东省文化厅',NULL,'广东省文化厅','8c149cb01131d854cac4bd198993e54f',NULL,'abc@163.com',NULL,'023','YES','NO','0','COMMONUSER'),  ('FY0290014','浙江省文化厅',NULL,'浙江省文化厅','72eba3e4b6b1a24155e42029498fc5cb',NULL,'abc@163.com',NULL,'029','YES','NO','0','COMMONUSER'),  ('FY0300017','云南省文化厅',NULL,'云南省文化厅','15df01a0f9586b76b8ca7e2a3b478def',NULL,'abc@163.com',NULL,'030','YES','NO','0','COMMONUSER');
INSERT INTO `t_sys_user_role` VALUES ('FY0000000','CENTRALUSER','2012-08-21 21:42:59'),  ('FY0030004','PROVINCEUSER','2012-08-21 21:45:19'),  ('FY0040011','PROVINCEUSER','2012-08-22 20:13:51');
INSERT INTO `t_workflow` VALUES ('10','project','审批完成已归档','success','FY0030005','河西区挂甲寺街道办事处','2012-08-21 23:06:46','8','-','003','-'),  ('11','resever','审批完成已归档','success','FY0040011','陕西省文化厅','2012-08-22 20:16:01','1','-','004','-');
