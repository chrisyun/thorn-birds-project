/*
MySQL Backup
Source Server Version: 5.0.51
Source Database: parrot
Date: 2012/8/10 00:27:10
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_flow_minds`
-- ----------------------------
DROP TABLE IF EXISTS `t_flow_minds`;
CREATE TABLE `t_flow_minds` (
  `ID` int(11) NOT NULL auto_increment,
  `FLOWID` int(11) NOT NULL,
  `USERID` varchar(200) NOT NULL,
  `USERNAME` varchar(200) default NULL,
  `MIND` varchar(2000) default NULL,
  `TIME` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `ACTIVITYNAME` varchar(200) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  PRIMARY KEY  (`ID`)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `t_reserve`
-- ----------------------------
DROP TABLE IF EXISTS `t_reserve`;
CREATE TABLE `t_reserve` (
  `ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(500) default NULL,
  `BULIDTIEM` varchar(20) default NULL,
  `AREA` varchar(500) default NULL,
  `USERID` varchar(200) default NULL,
  `PROVINCE` varchar(200) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;

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
  `FLOWTYPE` varchar(200) NOT NULL,
  `ACTIVITY` varchar(200) NOT NULL,
  `FLOWSTATUS` varchar(200) default NULL,
  `CREATER` varchar(200) NOT NULL,
  `CREATERNAME` varchar(200) default NULL,
  `CREATETIME` datetime default NULL,
  `PID` int(11) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `t_sys_dict` VALUES ('COMMONUSER','普通用户','1','DEFAULTROLE'),  ('COMPANY','公司',NULL,'ORGTYPE'),  ('DEPT','部门','1','ORGTYPE'),  ('FAILURE','失败','1','HANDLERESULT'),  ('femme','女','1','GENDER'),  ('male','男','0','GENDER'),  ('NO','否','1','YESORNO'),  ('ORG','组织','2','ORGTYPE'),  ('SUCCESS','成功',NULL,'HANDLERESULT'),  ('SYSADMIN','系统管理员',NULL,'DEFAULTROLE'),  ('tree-appLog','操作日志','6','ICONCLS'),  ('tree-att','文件图标','8','ICONCLS'),  ('tree-auth','授权图标','999','ICONCLS'),  ('tree-config','配置文件图标','9','ICONCLS'),  ('tree-dd','字典图标','2','ICONCLS'),  ('tree-org','组织图标','1','ICONCLS'),  ('tree-pwd','密码修改','3','ICONCLS'),  ('tree-role','角色图标','5','ICONCLS'),  ('tree-source','资源图标','4','ICONCLS'),  ('tree-sysLog','系统日志','7','ICONCLS'),  ('tree-user','用户图标','0','ICONCLS'),  ('YES','是',NULL,'YESORNO');
INSERT INTO `t_sys_dict_type` VALUES ('AREA','区域',''),  ('DEFAULTROLE','默认角色',''),  ('FLOW_TYPE','流程类型',NULL),  ('GENDER','性别',NULL),  ('HANDLERESULT','处理结果',NULL),  ('ICONCLS','菜单图标',NULL),  ('MODULE','日志模块',NULL),  ('ORGTYPE','组织类型',NULL),  ('YESORNO','是否',NULL);
INSERT INTO `t_sys_log` VALUES ('1','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"PP_TYPE\",\"cname\":\"参与者类型\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:48:33'),  ('2','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"PP_LIMIT_TYPE\",\"cname\":\"参与者限制类型\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:48:56'),  ('3','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"org\",\"dvalue\":\"组织\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:50:11'),  ('4','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"user\",\"dvalue\":\"人员\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:50:29'),  ('5','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":2,\"dname\":\"role\",\"dvalue\":\"角色\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:50:37'),  ('6','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":3,\"dname\":\"area\",\"dvalue\":\"区域\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:00'),  ('7','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"company\",\"cname\":\"同公司限制\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:16'),  ('8','org.thorn.dd.service.DataDictServiceImpl','deleteDt','[\"company,\"]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:28'),  ('9','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"company\",\"dvalue\":\"同公司限制\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:55'),  ('10','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"dept\",\"dvalue\":\"同部门限制\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:52:06'),  ('11','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":2,\"dname\":\"org\",\"dvalue\":\"同处室限制\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:52:30'),  ('12','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":3,\"dname\":\"none\",\"dvalue\":\"无限制\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:52:44'),  ('13','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"PARTICIPATOR\",\"sourceName\":\"绑定环节参与者\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/participator/participator.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":2}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:55:01'),  ('14','org.thorn.workflow.service.ParticipatorServiceImpl','save','[{\"id\":null,\"entity\":\"123,1212\",\"variable\":\"dfgr\",\"processDfId\":\"test\",\"activityId\":\"环节1\",\"entityType\":\"org\",\"limitType\":\"org\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:59:59'),  ('15','org.thorn.workflow.service.ParticipatorServiceImpl','queryPage','[\"\",\"\",\"\",\"\",0,20,null,null]','ADMIN','FAILURE','ParticipatorDaoImpl do queryPage exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\r\n### The error may involve ParticipatorMapper.selectPage-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'','2012-06-21 23:59:59'),  ('16','org.thorn.workflow.service.ParticipatorServiceImpl','queryPage','[\"\",\"\",\"\",\"\",0,20,null,null]','ADMIN','FAILURE','ParticipatorDaoImpl do queryPage exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\r\n### The error may involve ParticipatorMapper.selectPage-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'','2012-06-22 00:00:03'),  ('17','org.thorn.workflow.service.ParticipatorServiceImpl','queryPage','[\"\",\"\",\"\",\"\",0,20,null,null]','ADMIN','FAILURE','ParticipatorDaoImpl do queryPage exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\r\n### The error may involve ParticipatorMapper.selectPage-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'','2012-06-22 00:00:10'),  ('18','org.thorn.workflow.service.ParticipatorServiceImpl','delete','[\"1,\"]','ADMIN','SUCCESS',NULL,'2012-06-22 00:04:05'),  ('19','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"participator-query\",\"sourceName\":\"参与者查询\",\"parentSource\":\"PARTICIPATOR\",\"sourceUrl\":\"/wf/pp/get*.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-06-22 00:05:44'),  ('20','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"participator-modify\",\"sourceName\":\"参与者设置修改\",\"parentSource\":\"PARTICIPATOR\",\"sourceUrl\":\"/wf/pp/saveOrModifyParticipator.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-06-22 00:06:22'),  ('21','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"participator-delete\",\"sourceName\":\"参与者设置删除\",\"parentSource\":\"PARTICIPATOR\",\"sourceUrl\":\"/wf/pp/deleteParticipator.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-06-22 00:07:00'),  ('22','org.thorn.workflow.service.ParticipatorServiceImpl','save','[{\"id\":null,\"entity\":\"0011\",\"variable\":\"dfd\",\"processDfId\":\"test\",\"activityId\":\"test\",\"entityType\":\"org\",\"limitType\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 15:28:49'),  ('23','org.thorn.workflow.service.ParticipatorServiceImpl','modify','[{\"id\":1,\"entity\":\"0011,0012\",\"variable\":\"dfd\",\"processDfId\":\"test\",\"activityId\":\"test\",\"entityType\":\"org\",\"limitType\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 15:38:41'),  ('24','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"FLOW_TYPE\",\"cname\":\"流程类型\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:17:41'),  ('25','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"OAFLOW\",\"dvalue\":\"办公审批流程\",\"typeId\":\"FLOW_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:18:04'),  ('26','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"CONTRACTFLOW\",\"dvalue\":\"合同审批流程\",\"typeId\":\"FLOW_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:18:28'),  ('27','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"leave\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程\"}]','ADMIN','FAILURE','FlowTypeDaoImpl do save exception,\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'ID\' doesn\'t have a default value\r\n### The error may involve FlowTypeMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### Cause: java.sql.SQLException: Field \'ID\' doesn\'t have a default value\n; uncategorized SQLException for SQL []; SQL state [HY000]; error code [1364]; Field \'ID\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'ID\' doesn\'t have a default value','2012-06-23 22:25:15'),  ('28','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"请假流程\",\"flowKey\":\"请假流程\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:27:40'),  ('29','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"请假流程\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:40:11'),  ('30','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"请假流程\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:41:39'),  ('31','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"请假流程(新)\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程(新)\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:45:13'),  ('32','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"PROCESSCR\",\"sourceName\":\"新建流程\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/creat/processCr.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":3}]','ADMIN','SUCCESS',NULL,'2012-06-24 02:02:02'),  ('33','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":2,\"flowName\":\"请假流程\",\"flowKey\":null,\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程(新)\"}]','ADMIN','SUCCESS',NULL,'2012-06-24 14:07:29'),  ('34','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":3,\"flowName\":\"合同审批1111\",\"flowKey\":null,\"flowType\":\"CONTRACTFLOW\",\"flowDesc\":\"合同\"}]','ADMIN','SUCCESS',NULL,'2012-06-24 14:08:57'),  ('35','org.thorn.workflow.service.FlowTypeServiceImpl','delete','[\"3,\"]','ADMIN','SUCCESS',NULL,'2012-06-24 14:09:09'),  ('36','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":2,\"flowName\":\"请假流程\",\"flowKey\":null,\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)\"}]','ADMIN','SUCCESS',NULL,'2012-06-24 14:11:53'),  ('37','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":2,\"flowName\":\"请假流程\",\"flowKey\":null,\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)请假流程(新)\"}]','ADMIN','SUCCESS',NULL,'2012-06-24 14:12:03'),  ('38','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"processcr-query\",\"sourceName\":\"新建流程查询\",\"parentSource\":\"PROCESSCR\",\"sourceUrl\":\"/wf/cr/getCreatProcessList.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-06-24 14:25:30'),  ('39','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"processcr-modify\",\"sourceName\":\"流程类型修改\",\"parentSource\":\"PROCESSCR\",\"sourceUrl\":\"/wf/cr/modifyFlowType.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":1}]','ADMIN','SUCCESS',NULL,'2012-06-24 14:25:56'),  ('40','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"processcr-delete\",\"sourceName\":\"流程类型删除\",\"parentSource\":\"PROCESSCR\",\"sourceUrl\":\"/wf/cr/deleteFlowType.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":2}]','ADMIN','SUCCESS',NULL,'2012-06-24 14:26:27'),  ('41','org.thorn.workflow.service.ParticipatorServiceImpl','queryList','[[],\"start\"]','ADMIN','FAILURE','ParticipatorDaoImpl do queryList exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 12\r\n### The error may involve ParticipatorMapper.queryList-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 12\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 12','2012-06-25 21:35:45'),  ('42','org.thorn.workflow.service.ParticipatorServiceImpl','queryList','[[],\"start\"]','ADMIN','FAILURE','ParticipatorDaoImpl do queryList exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 12\r\n### The error may involve ParticipatorMapper.queryList-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 12\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 12','2012-06-25 21:38:14'),  ('43','org.thorn.workflow.service.ParticipatorServiceImpl','queryList','[[],\"start\"]','ADMIN','FAILURE','ParticipatorDaoImpl do queryList exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 12\r\n### The error may involve ParticipatorMapper.queryList-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 12\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 12','2012-06-25 21:41:37'),  ('44','org.thorn.workflow.service.ParticipatorServiceImpl','modify','[{\"id\":1,\"entity\":\"0011,0012\",\"processDfId\":\"leave\",\"entityType\":\"org\",\"variable\":\"creater\",\"activityId\":\"start\",\"limitType\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-25 21:55:16'),  ('45','org.thorn.workflow.service.ParticipatorServiceImpl','modify','[{\"id\":1,\"entity\":\"ADMIN\",\"processDfId\":\"leave\",\"entityType\":\"user\",\"variable\":\"creater\",\"activityId\":\"start\",\"limitType\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-25 22:17:19'),  ('46','org.thorn.workflow.service.ParticipatorServiceImpl','modify','[{\"id\":1,\"entity\":\"001,002\",\"processDfId\":\"leave\",\"entityType\":\"org\",\"variable\":\"creater\",\"activityId\":\"start\",\"limitType\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-25 22:17:45'),  ('47','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"PROCESSCR\",\"sourceName\":\"新建流程\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/create/processCr.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":3}]','ADMIN','SUCCESS',NULL,'2012-06-26 23:28:08'),  ('48','org.thorn.workflow.service.ParticipatorServiceImpl','delete','[\"1,\"]','ADMIN','SUCCESS',NULL,'2012-06-26 23:28:51'),  ('49','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowKey\":\"leave\",\"flowName\":\"请假\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-26 23:33:51'),  ('50','org.thorn.auth.service.AuthServiceImpl','saveUserRole','[\"TESTDD\",\"ZHENGYQ,\"]','ADMIN','SUCCESS',NULL,'2012-07-03 21:02:21'),  ('51','org.thorn.auth.service.AuthServiceImpl','deleteUserRole','[\"TESTDD\",\"AINAN,\"]','ADMIN','SUCCESS',NULL,'2012-07-03 21:02:26'),  ('52','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"PP_VARIABLE_TYPE\",\"cname\":\"参与者变量类型\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-07-10 20:38:07'),  ('53','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"USER\",\"dvalue\":\"USER\",\"typeId\":\"PP_VARIABLE_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-07-10 20:39:07'),  ('54','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":999,\"dname\":\"GROUP\",\"dvalue\":\"GROUP\",\"typeId\":\"PP_VARIABLE_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-07-10 20:39:16'),  ('55','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowKey\":\"leave\",\"flowName\":\"请假流程\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"员工请假\"}]','ADMIN','SUCCESS',NULL,'2012-07-10 21:52:18'),  ('56','org.thorn.org.service.OrgServiceImpl','save','[{\"orgId\":null,\"orgName\":\"MSS应用处\",\"orgCode\":\"00211\",\"orgType\":\"ORG\",\"area\":\"HB\",\"parentOrg\":\"0021\",\"isShow\":\"YES\",\"isDisabled\":\"NO\",\"sortNum\":1,\"showName\":\"MSS应用处\",\"orgMail\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-07-10 21:58:06'),  ('57','org.thorn.org.service.OrgServiceImpl','save','[{\"orgId\":null,\"orgName\":\"MSS应用处\",\"orgCode\":\"00111\",\"orgType\":\"ORG\",\"area\":\"BJ\",\"parentOrg\":\"0011\",\"isShow\":\"YES\",\"isDisabled\":\"NO\",\"sortNum\":1,\"showName\":\"MSS应用处\",\"orgMail\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-07-10 21:59:23'),  ('58','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"王经理\",\"userId\":\"BJ-TEST1\",\"orgName\":null,\"orgCode\":\"0011\",\"orgType\":null,\"area\":null,\"isShow\":\"YES\",\"isDisabled\":\"NO\",\"userPwd\":\"e50c52205a7e2ff991eea8a68459555e\",\"sn\":\"王\",\"userAccount\":\"BJ-TEST1\",\"gender\":\"male\",\"cumail\":\"test01@163.com\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-07-10 22:01:34'),  ('59','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"王处长\",\"userId\":\"BJ-TEST2\",\"orgName\":null,\"orgCode\":\"00111\",\"orgType\":null,\"area\":null,\"isShow\":\"YES\",\"isDisabled\":\"NO\",\"userPwd\":\"cf2f7bbd8a1c3f2852f9012fe058185a\",\"sn\":\"王\",\"userAccount\":\"BJ-TEST2\",\"gender\":\"male\",\"cumail\":\"777@163.com\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-07-10 22:02:30'),  ('60','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"王员工\",\"userId\":\"BJ-TEST3\",\"orgName\":null,\"orgCode\":\"00111\",\"orgType\":null,\"area\":null,\"isShow\":\"YES\",\"isDisabled\":\"NO\",\"userPwd\":\"a2e199ebd85a85d9d998b9ac037a86c0\",\"sn\":\"王\",\"userAccount\":\"BJ-TEST3\",\"gender\":\"male\",\"cumail\":\"4545@163.com\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"sortNum\":1}]','ADMIN','SUCCESS',NULL,'2012-07-10 22:03:19'),  ('61','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"张经理\",\"userId\":\"HB-TEST1\",\"orgName\":null,\"orgCode\":\"0021\",\"orgType\":null,\"area\":null,\"isShow\":\"YES\",\"isDisabled\":\"NO\",\"userPwd\":\"1d8d576173b9ea2d0def99616f1184f2\",\"sn\":\"张\",\"userAccount\":\"HB-TEST1\",\"gender\":\"\",\"cumail\":\"1212@163.com\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-07-10 22:04:11'),  ('62','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"张处长\",\"userId\":\"HB-TEST2\",\"orgName\":null,\"orgCode\":\"00211\",\"orgType\":null,\"area\":null,\"isShow\":\"YES\",\"isDisabled\":\"NO\",\"userPwd\":\"e8336172893935fbd5ef8fbd66760cd6\",\"sn\":\"张\",\"userAccount\":\"HB-TEST2\",\"gender\":\"male\",\"cumail\":\"21212@187.com\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-07-10 22:05:17'),  ('63','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"张员工\",\"userId\":\"HB-TEST3\",\"orgName\":null,\"orgCode\":\"00211\",\"orgType\":null,\"area\":null,\"isShow\":\"YES\",\"isDisabled\":\"NO\",\"userPwd\":\"7b0738aa9805f06905b025da8ac670dc\",\"sn\":\"张\",\"userAccount\":\"HB-TEST2\",\"gender\":\"male\",\"cumail\":\"21212@163.com\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"sortNum\":1}]','ADMIN','SUCCESS',NULL,'2012-07-10 22:05:55'),  ('64','org.thorn.workflow.service.ParticipatorServiceImpl','save','[{\"id\":null,\"entity\":\"BJ-TEST2,HB-TEST2\",\"processDfId\":\"leave\",\"entityType\":\"user\",\"variable\":\"chuzhang\",\"activityId\":\"处长审批\",\"limitType\":\"org\",\"variableType\":\"USER\"}]','ADMIN','SUCCESS',NULL,'2012-07-10 22:07:58'),  ('65','org.thorn.workflow.service.ParticipatorServiceImpl','save','[{\"id\":null,\"entity\":\"BJ-TEST1,HB-TEST1\",\"processDfId\":\"leave\",\"entityType\":\"user\",\"variable\":\"jingli\",\"activityId\":\"经理审批\",\"limitType\":\"dept\",\"variableType\":\"USER\"}]','ADMIN','SUCCESS',NULL,'2012-07-10 22:14:45'),  ('66','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"PROCESSCR\",\"sourceName\":\"新建流程\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/list/processCr.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":3}]','ADMIN','SUCCESS',NULL,'2012-07-16 23:12:46'),  ('67','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"PROCESSTODO\",\"sourceName\":\"待办列表\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/list/processTodo.jsp\",\"iconsCls\":\"\",\"isleaf\":\"NO\",\"isShow\":\"YES\",\"sortNum\":4}]','ADMIN','SUCCESS',NULL,'2012-07-17 22:51:02'),  ('68','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"PROCESSTODO\",\"sourceName\":\"待办列表\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/list/processTodo.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":4}]','ADMIN','SUCCESS',NULL,'2012-07-17 22:51:13'),  ('69','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"COMMONUSER\",\"USERMANAGER,MYPWD,MYPWD-CHANGE,HOME,LEFTMENU,ATT-UPLOAD,ATT-DELETE,ATT-DOWNLOAD,PROCESSMT,PROCESSCR,PROCESSTODO,PROCESSAPP,PROCESSCOMMON,\"]','ADMIN','SUCCESS',NULL,'2012-07-25 20:07:27'),  ('70','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"COMMONUSER\",\"USERMANAGER,MYPWD,MYPWD-CHANGE,HOME,LEFTMENU,ATT-UPLOAD,ATT-DELETE,ATT-DOWNLOAD,PROCESSCR,PROCESSTODO,PROCESSAPP,PROCESSCOMMON,\"]','ADMIN','SUCCESS',NULL,'2012-07-25 20:12:12'),  ('71','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"PROCESSAPP\",\"sourceName\":\"流程表单资源\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/app/**\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-07-25 20:22:33'),  ('72','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"PAGEAUTH\",\"sourceName\":\"绑定表单权限\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/pageAuth/pageAuth.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":4}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:00:23'),  ('73','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"PAGEAUTH\",\"sourceName\":\"绑定表单权限\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/pageAuth/pageAuth.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":2}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:00:36'),  ('74','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"PAGE_AUTH\",\"cname\":\"流程页面权限\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:03:52'),  ('75','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"UPLOAD\",\"dvalue\":\"附件上传\",\"typeId\":\"PAGE_AUTH\"}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:04:18'),  ('76','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":2,\"dname\":\"CANCELPROCESS\",\"dvalue\":\"作废流程\",\"typeId\":\"PAGE_AUTH\"}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:04:59'),  ('77','org.thorn.workflow.service.PageAuthServiceImpl','save','[{\"id\":null,\"processDfId\":\"aaaa\",\"activityId\":\"sasas\",\"auth\":\"UPLOAD\"}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:09:28'),  ('78','org.thorn.workflow.service.PageAuthServiceImpl','delete','[\"1,\"]','ADMIN','SUCCESS',NULL,'2012-07-27 23:11:42'),  ('79','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"pageauth-query\",\"sourceName\":\"表单权限查询\",\"parentSource\":\"PAGEAUTH\",\"sourceUrl\":\"/wf/pa/get*.jmt\",\"iconsCls\":\"\",\"isleaf\":\"NO\",\"isShow\":\"NO\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:12:50'),  ('80','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"pageauth-modify\",\"sourceName\":\"表单权限更新\",\"parentSource\":\"PAGEAUTH\",\"sourceUrl\":\"/wf/pa/saveOrModifyPageAuth.jmt\",\"iconsCls\":\"\",\"isleaf\":\"NO\",\"isShow\":\"NO\",\"sortNum\":1}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:13:49'),  ('81','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"pageauth-delete\",\"sourceName\":\"表单权限删除\",\"parentSource\":\"PAGEAUTH\",\"sourceUrl\":\"/wf/pa/deletePageAuth.jmt\",\"iconsCls\":\"\",\"isleaf\":\"NO\",\"isShow\":\"NO\",\"sortNum\":2}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:14:19'),  ('82','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"pageauth-query\",\"sourceName\":\"表单权限查询\",\"parentSource\":\"PAGEAUTH\",\"sourceUrl\":\"/wf/pa/get*.jmt\",\"iconsCls\":\"\",\"isleaf\":\"NO\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:14:33'),  ('83','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"pageauth-query\",\"sourceName\":\"表单权限查询\",\"parentSource\":\"PAGEAUTH\",\"sourceUrl\":\"/wf/pa/get*.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:14:44'),  ('84','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"pageauth-modify\",\"sourceName\":\"表单权限更新\",\"parentSource\":\"PAGEAUTH\",\"sourceUrl\":\"/wf/pa/saveOrModifyPageAuth.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":1}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:14:51'),  ('85','org.thorn.resource.service.ResourceServiceImpl','modify','[{\"sourceCode\":\"pageauth-delete\",\"sourceName\":\"表单权限删除\",\"parentSource\":\"PAGEAUTH\",\"sourceUrl\":\"/wf/pa/deletePageAuth.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":2}]','ADMIN','SUCCESS',NULL,'2012-07-27 23:14:58'),  ('86','org.thorn.workflow.service.ParticipatorServiceImpl','save','[{\"id\":null,\"entity\":\"HB,HN\",\"processDfId\":\"leave\",\"entityType\":\"area\",\"variable\":\"qqq\",\"limitType\":\"dept\",\"variableType\":\"USER\",\"activityId\":\"asasas\"}]','ADMIN','SUCCESS',NULL,'2012-07-29 16:52:34'),  ('87','org.thorn.workflow.service.ParticipatorServiceImpl','delete','[\"3,\"]','ADMIN','SUCCESS',NULL,'2012-07-29 16:52:49'),  ('88','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"PROCESSENTRUST\",\"sourceName\":\"流程委托\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/entrust/entrust.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":5}]','ADMIN','SUCCESS',NULL,'2012-07-29 17:48:46'),  ('89','org.thorn.workflow.service.EntrustServiceImpl','save','[{\"id\":null,\"userId\":\"ADMIN\",\"entruster\":\"ADMIN\",\"processDfId\":\"leave\",\"entrusterName\":\"系统管理员\",\"beginDate\":\"2012-07-03\",\"endDate\":\"2012-07-30\"}]','ADMIN','SUCCESS',NULL,'2012-07-29 18:10:56'),  ('90','org.thorn.workflow.service.EntrustServiceImpl','delete','[\"1,\"]','ADMIN','SUCCESS',NULL,'2012-07-29 20:03:55'),  ('91','org.thorn.user.service.UserServiceImpl','delete','[\"ZHENGYQ,AINAN,HB-TEST1,\"]','ADMIN','SUCCESS',NULL,'2012-08-08 22:06:47'),  ('92','org.thorn.dd.service.DataDictServiceImpl','deleteDt','[\"PAGE_AUTH,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 20:44:10'),  ('93','org.thorn.dd.service.DataDictServiceImpl','deleteDt','[\"PP_LIMIT_TYPE,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 20:44:17'),  ('94','org.thorn.dd.service.DataDictServiceImpl','deleteDt','[\"PP_VARIABLE_TYPE,PP_TYPE,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 20:44:38'),  ('95','org.thorn.resource.service.ResourceServiceImpl','delete','[\"WORKFLOW,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 20:47:33'),  ('96','org.thorn.role.service.RoleServiceImpl','delete','[\"TESTDD,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 20:51:43'),  ('97','org.thorn.role.service.RoleServiceImpl','save','[{\"roleCode\":\"PROVINCEUSER\",\"roleName\":\"省厅级用户\",\"roleDesc\":\"\",\"isDisabled\":\"NO\"}]','ADMIN','SUCCESS',NULL,'2012-08-09 21:02:03'),  ('98','org.thorn.role.service.RoleServiceImpl','save','[{\"roleCode\":\"CENTRALUSER\",\"roleName\":\"部委级用户\",\"roleDesc\":\"\",\"isDisabled\":\"NO\"}]','ADMIN','SUCCESS',NULL,'2012-08-09 21:02:54'),  ('99','org.thorn.org.service.OrgServiceImpl','delete','[\"16,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:03:14'),  ('100','org.thorn.org.service.OrgServiceImpl','delete','[\"12,14,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:03:25'),  ('101','org.thorn.org.service.OrgServiceImpl','delete','[\"15,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:03:34'),  ('102','org.thorn.org.service.OrgServiceImpl','delete','[\"13,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:03:40'),  ('103','org.thorn.org.service.OrgServiceImpl','save','[{\"orgId\":null,\"orgName\":\"天津市文化厅\",\"orgCode\":\"003\",\"orgType\":\"COMPANY\",\"area\":\"\",\"isDisabled\":\"NO\",\"isShow\":\"YES\",\"sortNum\":999,\"parentOrg\":\"ROOT\",\"showName\":\"天津市文化厅\",\"orgMail\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-08-09 21:09:51'),  ('104','org.thorn.org.service.OrgServiceImpl','save','[{\"orgId\":null,\"orgName\":\"文化部非物质文化遗产司\",\"orgCode\":\"000\",\"orgType\":\"COMPANY\",\"area\":\"\",\"isDisabled\":\"NO\",\"isShow\":\"YES\",\"sortNum\":0,\"parentOrg\":\"ROOT\",\"showName\":\"文化部非遗司\",\"orgMail\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-08-09 21:11:04'),  ('105','org.thorn.org.service.OrgServiceImpl','modify','[{\"orgId\":13,\"orgName\":\"文化部非物质文化遗产司\",\"orgCode\":\"000\",\"orgType\":\"COMPANY\",\"area\":\"\",\"isDisabled\":\"NO\",\"isShow\":\"YES\",\"sortNum\":0,\"parentOrg\":\"ROOT\",\"showName\":\"文化部非遗司\",\"orgMail\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-08-09 21:11:59'),  ('106','org.thorn.org.service.OrgServiceImpl','modify','[{\"orgId\":13,\"orgName\":\"文化部非物质文化遗产司\",\"orgCode\":\"000\",\"orgType\":\"COMPANY\",\"area\":\"\",\"isDisabled\":\"NO\",\"isShow\":\"YES\",\"sortNum\":0,\"parentOrg\":\"ROOT\",\"showName\":\"文化部非遗司\",\"orgMail\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-08-09 21:12:06'),  ('107','org.thorn.user.service.UserServiceImpl','modify','[{\"userName\":\"系统管理员\",\"userId\":\"ADMIN\",\"orgName\":null,\"orgCode\":\"000\",\"orgType\":null,\"area\":null,\"userPwd\":\"\",\"isDisabled\":\"NO\",\"sn\":\"陈\",\"userAccount\":\"CHENYUN\",\"gender\":\"male\",\"cumail\":\"chenyun313@163.com\",\"phone\":\"18701309727\",\"defaultRole\":\"SYSADMIN\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-09 21:12:35'),  ('108','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"北京印钞厂\",\"userId\":\"FY0010001\",\"orgName\":null,\"orgCode\":\"001\",\"orgType\":null,\"area\":null,\"userPwd\":\"ddac58a87f43443331f89054b8cb8899\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"FY0010001\",\"gender\":\"male\",\"cumail\":\"727zz@163.com\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-08-09 21:16:03'),  ('109','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"北京市文化厅\",\"userId\":\"FY0010000\",\"orgName\":null,\"orgCode\":\"001\",\"orgType\":null,\"area\":null,\"userPwd\":\"675b501d556c9a31d65b4364ed575e05\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"FY0010000\",\"gender\":\"\",\"cumail\":\"727zz@163.com\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-08-09 21:18:02'),  ('110','org.thorn.auth.service.AuthServiceImpl','saveUserRole','[\"PROVINCEUSER\",\"FY0010000,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:18:18'),  ('111','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"PROVINCEUSER\",\"USERMANAGER,ORG,ORG-QUERY,ORG-DELETE,ORG-UPDATE,USER,USER-QUERY,USER-UPDATE,USER-DELETE,USER-PWD,USER-ROLE,USER-DISABLED,AUTHMANAGER,ROLE,ROLE-QUERY,ROLE-AUTH,ROLE-DELETE,ROLE-UPDATE,AUTH,AUTH-QUERY,AUTH-ADD,AUTH-DELETE,HOME,LEFTMENU,ATT-UPLOAD,ATT-DELETE,ATT-DOWNLOAD,MYPWD,MYPWD-CHANGE,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:19:05'),  ('112','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"PROVINCEUSER\",\"USERMANAGER,ORG,ORG-QUERY,ORG-DELETE,ORG-UPDATE,USER,USER-QUERY,USER-UPDATE,USER-DELETE,USER-PWD,USER-ROLE,USER-DISABLED,HOME,LEFTMENU,ATT-UPLOAD,ATT-DELETE,ATT-DOWNLOAD,MYPWD,MYPWD-CHANGE,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:33:55'),  ('113','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"COMMONUSER\",\"HOME,LEFTMENU,ATT-UPLOAD,ATT-DELETE,ATT-DOWNLOAD,MYPWD,MYPWD-CHANGE,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:34:04'),  ('114','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"CENTRALUSER\",\"USERMANAGER,ORG,ORG-QUERY,ORG-DELETE,ORG-UPDATE,USER,USER-QUERY,USER-UPDATE,USER-DELETE,USER-PWD,USER-ROLE,USER-DISABLED,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:34:27'),  ('115','org.thorn.auth.service.AuthServiceImpl','saveRoleAuth','[\"CENTRALUSER\",\"USERMANAGER,ORG,ORG-QUERY,ORG-DELETE,ORG-UPDATE,USER,USER-QUERY,USER-UPDATE,USER-DELETE,USER-PWD,USER-ROLE,USER-DISABLED,HOME,LEFTMENU,ATT-UPLOAD,ATT-DELETE,ATT-DOWNLOAD,MYPWD,MYPWD-CHANGE,\"]','ADMIN','SUCCESS',NULL,'2012-08-09 21:34:35'),  ('116','org.thorn.user.service.UserServiceImpl','changePwd','[\"FY0010000\",\"wwwwww\"]','FY0010000','SUCCESS',NULL,'2012-08-10 00:17:00'),  ('117','org.thorn.user.service.UserServiceImpl','save','[{\"userName\":\"北京市北方昆曲剧院\",\"userId\":\"FY0010564\",\"orgCode\":\"001\",\"orgName\":null,\"orgType\":null,\"area\":null,\"userPwd\":\"abd8dbbafd62bc0e617c221a31d5cb2c\",\"cumail\":\"727zz@163.com\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"北京市北方昆曲剧院\",\"gender\":\"male\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":999}]','FY0010000','SUCCESS',NULL,'2012-08-10 00:20:00'),  ('118','org.thorn.user.service.UserServiceImpl','modify','[{\"userName\":\"北京市北方昆曲剧院\",\"userId\":\"FY0010564\",\"orgCode\":\"001\",\"orgName\":null,\"orgType\":null,\"area\":null,\"userPwd\":\"cdaa9575a6c4e2b4f4fd67c66b55c2a0\",\"cumail\":\"727zz@163.com\",\"isDisabled\":\"NO\",\"sn\":\"\",\"userAccount\":\"北京市北方昆曲剧院\",\"gender\":\"male\",\"phone\":\"\",\"defaultRole\":\"COMMONUSER\",\"isShow\":\"YES\",\"sortNum\":999}]','FY0010000','SUCCESS',NULL,'2012-08-10 00:20:55');
INSERT INTO `t_sys_org` VALUES ('1','ROOT','-1','文化部','文化部','COMPANY',NULL,'0','NO','NO',NULL),  ('2','001','ROOT','北京市文化厅','北京市文化厅','COMPANY',NULL,'1','YES','NO',''),  ('11','002','ROOT','湖北省文化厅','湖北省文化厅','COMPANY','','2','YES','NO',''),  ('12','003','ROOT','天津市文化厅','天津市文化厅','COMPANY',NULL,'999','YES','NO',NULL),  ('13','000','ROOT','文化部非物质文化遗产司','文化部非遗司','COMPANY',NULL,'0','YES','NO',NULL);
INSERT INTO `t_sys_resource` VALUES ('0','ALL','/**','YES','NO','-1','99',''),  ('APPLOG','操作日志','/system/log/appLog.jsp','YES','YES','LOG','1','tree-appLog'),  ('APPLOG-EXCEL','操作日志导出','/log/exportLogExcel.jmt','YES','NO','APPLOG','999',''),  ('APPLOG-QUERY','操作日志查询','/log/getLogPage.jmt','YES','NO','APPLOG','0',''),  ('ATT','文件管理','/system/att/attachment.jsp','YES','YES','SYS','9','tree-att'),  ('ATT-DELETE','附件删除','/att/delete.jmt','YES','NO','NAV','3',''),  ('ATT-DOWNLOAD','附件下载','/att/download.jmt','YES','NO','NAV','4',''),  ('ATT-UPLOAD','附件上传','/att/get*.jmt','YES','NO','NAV','2',''),  ('AUTH','用户授权','/system/role/userAuth.jsp','YES','YES','AUTHMANAGER','1','tree-auth'),  ('AUTH-ADD','添加用户','/user/saveUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-DELETE','删除用户','/user/deleteUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-QUERY','授权关系查询','/user/get*.jmt','YES','NO','AUTH','0',''),  ('AUTHMANAGER','权限管理','','NO','YES','SYS','3',''),  ('CF','配置项管理','','NO','YES','SYS','0',''),  ('CF-MODIFY','配置文件修改','/cf/modifyConfig.jmt','YES','NO','CONFIG','1',''),  ('CF-QUERY','配置文件查看','/cf/get*.jmt','YES','NO','CONFIG','0',''),  ('CONFIG','配置文件管理','/system/cf/configurator.jsp','YES','YES','CF','1','tree-config'),  ('DICT','数据字典管理','/system/dd/dd.jsp','YES','YES','CF','0','tree-dd'),  ('DICT-DELETE','数据字典删除','/dd/delete*.jmt','YES','NO','DICT','999',''),  ('DICT-QUERY','数据字典查询','/dd/get*.jmt','YES','NO','DICT','0',''),  ('DICT-UPDATE','数据字典更新','/dd/saveOrModify*.jmt','YES','NO','DICT','999',''),  ('HOME','主页','/system/main.jsp','YES','NO','NAV','0',''),  ('LEFTMENU','菜单树','/resource/getLeftTree.jmt','YES','NO','NAV','1',''),  ('LOG','日志管理','','NO','YES','SYS','1',''),  ('MYPWD','修改密码','/system/user/changePwd.jsp','YES','YES','NAV','99','tree-pwd'),  ('MYPWD-CHANGE','密码修改','/user/changeMyPwd.jmt','YES','NO','MYPWD','999',''),  ('NAV','应用菜单','','NO','YES','0','0',''),  ('ORG','组织管理','/system/org/org.jsp','YES','YES','USERMANAGER','0','tree-org'),  ('ORG-DELETE','组织删除','/org/delete*.jmt','YES','NO','ORG','999',''),  ('ORG-QUERY','组织查询','/org/get*.jmt','YES','NO','ORG','0',''),  ('ORG-UPDATE','组织更新','/org/saveOrModify*.jmt','YES','NO','ORG','999',''),  ('PROCESSAPP','流程表单资源','/app/**','YES','NO','WORKFLOW','999',''),  ('ROLE','角色管理','/system/role/role.jsp','YES','YES','AUTHMANAGER','0','tree-role'),  ('ROLE-AUTH','角色授权','/role/saveAuth.jmt','YES','NO','ROLE','999',''),  ('ROLE-DELETE','角色删除','/role/delete*.jmt','YES','NO','ROLE','999',''),  ('ROLE-QUERY','角色查询','/role/get*.jmt','YES','NO','ROLE','0',''),  ('ROLE-UPDATE','角色更新','/role/saveOrModify*.jmt','YES','NO','ROLE','999',''),  ('SOURCE','资源管理','/system/resource/source.jsp','YES','YES','CF','2','tree-source'),  ('SOURCE-DELETE','资源删除','/resource/delete*.jmt','YES','NO','SOURCE','999',''),  ('SOURCE-QUERY','资源查询','/resource/get*.jmt','YES','NO','SOURCE','0',''),  ('SOURCE-UPDATE','资源更新','/resource/saveOrModify*.jmt','YES','NO','SOURCE','999',''),  ('SYS','系统管理','','NO','YES','0','0',''),  ('SYSLOG','系统日志','/system/log/sysLog.jsp','YES','YES','LOG','0','tree-sysLog'),  ('SYSLOG-LEVEL','修改日志级别','/log/*LogLevel.jmt','YES','NO','SYSLOG','1',''),  ('SYSLOG-QUERY','系统日志查询','/system/log/sysLog*.jsp','YES','NO','SYSLOG','0',''),  ('USER','用户管理','/system/user/user.jsp','YES','YES','USERMANAGER','1','tree-user'),  ('USER-DELETE','用户删除','/user/deleteUser.jmt','YES','NO','USER','2',''),  ('USER-DISABLED','用户启/禁用','/user/disabled*.jmt','YES','NO','USER','999',''),  ('USER-PWD','密码修改','/user/changePwd.jmt','YES','NO','USER','999',''),  ('USER-QUERY','用户查询','/user/get*.jmt','YES','NO','USER','0',''),  ('USER-ROLE','用户角色管理','/user/saveRoleByUser.jmt','YES','NO','USER','999',''),  ('USER-UPDATE','用户更新','/user/saveOrModify*.jmt','YES','NO','USER','1',''),  ('USERMANAGER','用户管理','','NO','YES','SYS','2','');
INSERT INTO `t_sys_role` VALUES ('CENTRALUSER','部委级用户',NULL,'NO'),  ('COMMONUSER','普通用户',NULL,'NO'),  ('PROVINCEUSER','省厅级用户',NULL,'NO');
INSERT INTO `t_sys_role_res` VALUES ('CENTRALUSER','ATT-DELETE','2012-08-09 21:34:35'),  ('CENTRALUSER','ATT-DOWNLOAD','2012-08-09 21:34:35'),  ('CENTRALUSER','ATT-UPLOAD','2012-08-09 21:34:35'),  ('CENTRALUSER','HOME','2012-08-09 21:34:35'),  ('CENTRALUSER','LEFTMENU','2012-08-09 21:34:35'),  ('CENTRALUSER','MYPWD','2012-08-09 21:34:35'),  ('CENTRALUSER','MYPWD-CHANGE','2012-08-09 21:34:35'),  ('CENTRALUSER','ORG','2012-08-09 21:34:35'),  ('CENTRALUSER','ORG-DELETE','2012-08-09 21:34:35'),  ('CENTRALUSER','ORG-QUERY','2012-08-09 21:34:35'),  ('CENTRALUSER','ORG-UPDATE','2012-08-09 21:34:35'),  ('CENTRALUSER','USER','2012-08-09 21:34:35'),  ('CENTRALUSER','USER-DELETE','2012-08-09 21:34:35'),  ('CENTRALUSER','USER-DISABLED','2012-08-09 21:34:35'),  ('CENTRALUSER','USER-PWD','2012-08-09 21:34:35'),  ('CENTRALUSER','USER-QUERY','2012-08-09 21:34:35'),  ('CENTRALUSER','USER-ROLE','2012-08-09 21:34:35'),  ('CENTRALUSER','USER-UPDATE','2012-08-09 21:34:35'),  ('CENTRALUSER','USERMANAGER','2012-08-09 21:34:35'),  ('COMMONUSER','ATT-DELETE','2012-08-09 21:34:04'),  ('COMMONUSER','ATT-DOWNLOAD','2012-08-09 21:34:04'),  ('COMMONUSER','ATT-UPLOAD','2012-08-09 21:34:04'),  ('COMMONUSER','HOME','2012-08-09 21:34:04'),  ('COMMONUSER','LEFTMENU','2012-08-09 21:34:04'),  ('COMMONUSER','MYPWD','2012-08-09 21:34:04'),  ('COMMONUSER','MYPWD-CHANGE','2012-08-09 21:34:04'),  ('PROVINCEUSER','ATT-DELETE','2012-08-09 21:33:55'),  ('PROVINCEUSER','ATT-DOWNLOAD','2012-08-09 21:33:55'),  ('PROVINCEUSER','ATT-UPLOAD','2012-08-09 21:33:55'),  ('PROVINCEUSER','HOME','2012-08-09 21:33:55'),  ('PROVINCEUSER','LEFTMENU','2012-08-09 21:33:55'),  ('PROVINCEUSER','MYPWD','2012-08-09 21:33:55'),  ('PROVINCEUSER','MYPWD-CHANGE','2012-08-09 21:33:55'),  ('PROVINCEUSER','ORG','2012-08-09 21:33:55'),  ('PROVINCEUSER','ORG-DELETE','2012-08-09 21:33:55'),  ('PROVINCEUSER','ORG-QUERY','2012-08-09 21:33:55'),  ('PROVINCEUSER','ORG-UPDATE','2012-08-09 21:33:55'),  ('PROVINCEUSER','USER','2012-08-09 21:33:55'),  ('PROVINCEUSER','USER-DELETE','2012-08-09 21:33:55'),  ('PROVINCEUSER','USER-DISABLED','2012-08-09 21:33:55'),  ('PROVINCEUSER','USER-PWD','2012-08-09 21:33:55'),  ('PROVINCEUSER','USER-QUERY','2012-08-09 21:33:55'),  ('PROVINCEUSER','USER-ROLE','2012-08-09 21:33:55'),  ('PROVINCEUSER','USER-UPDATE','2012-08-09 21:33:55'),  ('PROVINCEUSER','USERMANAGER','2012-08-09 21:33:55');
INSERT INTO `t_sys_user` VALUES ('ADMIN','系统管理员','陈','CHENYUN','6994d5fd8501c8576fcfd99c3386f085','male','chenyun313@163.com','18701309727','000','YES','NO','0','SYSADMIN'),  ('FY0010000','北京市文化厅',NULL,'FY0010000','675b501d556c9a31d65b4364ed575e05',NULL,'727zz@163.com',NULL,'001','YES','NO','0','COMMONUSER'),  ('FY0010001','北京印钞厂',NULL,'FY0010001','ddac58a87f43443331f89054b8cb8899','male','727zz@163.com',NULL,'001','YES','NO','999','COMMONUSER'),  ('FY0010564','北京市北方昆曲剧院',NULL,'北京市北方昆曲剧院','cdaa9575a6c4e2b4f4fd67c66b55c2a0','male','727zz@163.com',NULL,'001','YES','NO','999','COMMONUSER');
INSERT INTO `t_sys_user_role` VALUES ('FY0010000','PROVINCEUSER','2012-08-09 21:18:18');
