/*
MySQL Backup
Source Server Version: 5.0.51
Source Database: thorn
Date: 2012/6/23 22:47:19
*/


-- ----------------------------
--  Table structure for `jbpm4_deployment`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_deployment`;
CREATE TABLE `jbpm4_deployment` (
  `DBID_` bigint(20) NOT NULL,
  `NAME_` longtext,
  `TIMESTAMP_` bigint(20) default NULL,
  `STATE_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_deployprop`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_deployprop`;
CREATE TABLE `jbpm4_deployprop` (
  `DBID_` bigint(20) NOT NULL,
  `DEPLOYMENT_` bigint(20) default NULL,
  `OBJNAME_` varchar(255) default NULL,
  `KEY_` varchar(255) default NULL,
  `STRINGVAL_` varchar(255) default NULL,
  `LONGVAL_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_DEPLPROP_DEPL` (`DEPLOYMENT_`),
  KEY `FK_DEPLPROP_DEPL` (`DEPLOYMENT_`),
  CONSTRAINT `FK_DEPLPROP_DEPL` FOREIGN KEY (`DEPLOYMENT_`) REFERENCES `jbpm4_deployment` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_execution`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_execution`;
CREATE TABLE `jbpm4_execution` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ACTIVITYNAME_` varchar(255) default NULL,
  `PROCDEFID_` varchar(255) default NULL,
  `HASVARS_` bit(1) default NULL,
  `NAME_` varchar(255) default NULL,
  `KEY_` varchar(255) default NULL,
  `ID_` varchar(255) default NULL,
  `STATE_` varchar(255) default NULL,
  `SUSPHISTSTATE_` varchar(255) default NULL,
  `PRIORITY_` int(11) default NULL,
  `HISACTINST_` bigint(20) default NULL,
  `PARENT_` bigint(20) default NULL,
  `INSTANCE_` bigint(20) default NULL,
  `SUPEREXEC_` bigint(20) default NULL,
  `SUBPROCINST_` bigint(20) default NULL,
  `PARENT_IDX_` int(11) default NULL,
  PRIMARY KEY  (`DBID_`),
  UNIQUE KEY `ID_` (`ID_`),
  KEY `IDX_EXEC_SUPEREXEC` (`SUPEREXEC_`),
  KEY `IDX_EXEC_INSTANCE` (`INSTANCE_`),
  KEY `IDX_EXEC_SUBPI` (`SUBPROCINST_`),
  KEY `IDX_EXEC_PARENT` (`PARENT_`),
  KEY `FK_EXEC_PARENT` (`PARENT_`),
  KEY `FK_EXEC_SUBPI` (`SUBPROCINST_`),
  KEY `FK_EXEC_INSTANCE` (`INSTANCE_`),
  KEY `FK_EXEC_SUPEREXEC` (`SUPEREXEC_`),
  CONSTRAINT `FK_EXEC_INSTANCE` FOREIGN KEY (`INSTANCE_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_PARENT` FOREIGN KEY (`PARENT_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_SUBPI` FOREIGN KEY (`SUBPROCINST_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_SUPEREXEC` FOREIGN KEY (`SUPEREXEC_`) REFERENCES `jbpm4_execution` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_extend_flowtype`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_extend_flowtype`;
CREATE TABLE `jbpm4_extend_flowtype` (
  `ID` int(11) NOT NULL auto_increment,
  `FLOWNAME` varchar(200) NOT NULL,
  `FLOWKEY` varchar(200) NOT NULL,
  `FLOWTYPE` varchar(50) NOT NULL,
  `CREATTIME` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `FLOWDESC` varchar(500) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_extend_participator`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_extend_participator`;
CREATE TABLE `jbpm4_extend_participator` (
  `ID` int(11) NOT NULL auto_increment,
  `PRCESSDFID` varchar(500) NOT NULL,
  `ACTIVITYID` varchar(500) NOT NULL,
  `ENTITYTYPE` varchar(50) NOT NULL,
  `ENTITY` varchar(200) NOT NULL,
  `LIMITTYPE` varchar(50) default NULL,
  `VARIABLE` varchar(50) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_hist_actinst`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_actinst`;
CREATE TABLE `jbpm4_hist_actinst` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `HPROCI_` bigint(20) default NULL,
  `TYPE_` varchar(255) default NULL,
  `EXECUTION_` varchar(255) default NULL,
  `ACTIVITY_NAME_` varchar(255) default NULL,
  `START_` datetime default NULL,
  `END_` datetime default NULL,
  `DURATION_` bigint(20) default NULL,
  `TRANSITION_` varchar(255) default NULL,
  `NEXTIDX_` int(11) default NULL,
  `HTASK_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_HACTI_HPROCI` (`HPROCI_`),
  KEY `IDX_HTI_HTASK` (`HTASK_`),
  KEY `FK_HACTI_HPROCI` (`HPROCI_`),
  KEY `FK_HTI_HTASK` (`HTASK_`),
  CONSTRAINT `FK_HACTI_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HTI_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_hist_detail`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_detail`;
CREATE TABLE `jbpm4_hist_detail` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `USERID_` varchar(255) default NULL,
  `TIME_` datetime default NULL,
  `HPROCI_` bigint(20) default NULL,
  `HPROCIIDX_` int(11) default NULL,
  `HACTI_` bigint(20) default NULL,
  `HACTIIDX_` int(11) default NULL,
  `HTASK_` bigint(20) default NULL,
  `HTASKIDX_` int(11) default NULL,
  `HVAR_` bigint(20) default NULL,
  `HVARIDX_` int(11) default NULL,
  `MESSAGE_` longtext,
  `OLD_STR_` varchar(255) default NULL,
  `NEW_STR_` varchar(255) default NULL,
  `OLD_INT_` int(11) default NULL,
  `NEW_INT_` int(11) default NULL,
  `OLD_TIME_` datetime default NULL,
  `NEW_TIME_` datetime default NULL,
  `PARENT_` bigint(20) default NULL,
  `PARENT_IDX_` int(11) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_HDET_HACTI` (`HACTI_`),
  KEY `IDX_HDET_HPROCI` (`HPROCI_`),
  KEY `IDX_HDET_HVAR` (`HVAR_`),
  KEY `IDX_HDET_HTASK` (`HTASK_`),
  KEY `FK_HDETAIL_HPROCI` (`HPROCI_`),
  KEY `FK_HDETAIL_HACTI` (`HACTI_`),
  KEY `FK_HDETAIL_HTASK` (`HTASK_`),
  KEY `FK_HDETAIL_HVAR` (`HVAR_`),
  CONSTRAINT `FK_HDETAIL_HACTI` FOREIGN KEY (`HACTI_`) REFERENCES `jbpm4_hist_actinst` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HVAR` FOREIGN KEY (`HVAR_`) REFERENCES `jbpm4_hist_var` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_hist_procinst`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_procinst`;
CREATE TABLE `jbpm4_hist_procinst` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) default NULL,
  `PROCDEFID_` varchar(255) default NULL,
  `KEY_` varchar(255) default NULL,
  `START_` datetime default NULL,
  `END_` datetime default NULL,
  `DURATION_` bigint(20) default NULL,
  `STATE_` varchar(255) default NULL,
  `ENDACTIVITY_` varchar(255) default NULL,
  `NEXTIDX_` int(11) default NULL,
  PRIMARY KEY  (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_hist_task`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_task`;
CREATE TABLE `jbpm4_hist_task` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `EXECUTION_` varchar(255) default NULL,
  `OUTCOME_` varchar(255) default NULL,
  `ASSIGNEE_` varchar(255) default NULL,
  `PRIORITY_` int(11) default NULL,
  `STATE_` varchar(255) default NULL,
  `CREATE_` datetime default NULL,
  `END_` datetime default NULL,
  `DURATION_` bigint(20) default NULL,
  `NEXTIDX_` int(11) default NULL,
  `SUPERTASK_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_HSUPERT_SUB` (`SUPERTASK_`),
  KEY `FK_HSUPERT_SUB` (`SUPERTASK_`),
  CONSTRAINT `FK_HSUPERT_SUB` FOREIGN KEY (`SUPERTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_hist_var`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_hist_var`;
CREATE TABLE `jbpm4_hist_var` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `PROCINSTID_` varchar(255) default NULL,
  `EXECUTIONID_` varchar(255) default NULL,
  `VARNAME_` varchar(255) default NULL,
  `VALUE_` varchar(255) default NULL,
  `HPROCI_` bigint(20) default NULL,
  `HTASK_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_HVAR_HPROCI` (`HPROCI_`),
  KEY `IDX_HVAR_HTASK` (`HTASK_`),
  KEY `FK_HVAR_HPROCI` (`HPROCI_`),
  KEY `FK_HVAR_HTASK` (`HTASK_`),
  CONSTRAINT `FK_HVAR_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HVAR_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_id_group`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_id_group`;
CREATE TABLE `jbpm4_id_group` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) default NULL,
  `NAME_` varchar(255) default NULL,
  `TYPE_` varchar(255) default NULL,
  `PARENT_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_GROUP_PARENT` (`PARENT_`),
  KEY `FK_GROUP_PARENT` (`PARENT_`),
  CONSTRAINT `FK_GROUP_PARENT` FOREIGN KEY (`PARENT_`) REFERENCES `jbpm4_id_group` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_id_membership`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_id_membership`;
CREATE TABLE `jbpm4_id_membership` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `USER_` bigint(20) default NULL,
  `GROUP_` bigint(20) default NULL,
  `NAME_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_MEM_USER` (`USER_`),
  KEY `IDX_MEM_GROUP` (`GROUP_`),
  KEY `FK_MEM_GROUP` (`GROUP_`),
  KEY `FK_MEM_USER` (`USER_`),
  CONSTRAINT `FK_MEM_GROUP` FOREIGN KEY (`GROUP_`) REFERENCES `jbpm4_id_group` (`DBID_`),
  CONSTRAINT `FK_MEM_USER` FOREIGN KEY (`USER_`) REFERENCES `jbpm4_id_user` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_id_user`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_id_user`;
CREATE TABLE `jbpm4_id_user` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) default NULL,
  `PASSWORD_` varchar(255) default NULL,
  `GIVENNAME_` varchar(255) default NULL,
  `FAMILYNAME_` varchar(255) default NULL,
  `BUSINESSEMAIL_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_job`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_job`;
CREATE TABLE `jbpm4_job` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `DUEDATE_` datetime default NULL,
  `STATE_` varchar(255) default NULL,
  `ISEXCLUSIVE_` bit(1) default NULL,
  `LOCKOWNER_` varchar(255) default NULL,
  `LOCKEXPTIME_` datetime default NULL,
  `EXCEPTION_` longtext,
  `RETRIES_` int(11) default NULL,
  `PROCESSINSTANCE_` bigint(20) default NULL,
  `EXECUTION_` bigint(20) default NULL,
  `CFG_` bigint(20) default NULL,
  `SIGNAL_` varchar(255) default NULL,
  `EVENT_` varchar(255) default NULL,
  `REPEAT_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_JOBRETRIES` (`RETRIES_`),
  KEY `IDX_JOB_CFG` (`CFG_`),
  KEY `IDX_JOB_PRINST` (`PROCESSINSTANCE_`),
  KEY `IDX_JOB_EXE` (`EXECUTION_`),
  KEY `IDX_JOBLOCKEXP` (`LOCKEXPTIME_`),
  KEY `IDX_JOBDUEDATE` (`DUEDATE_`),
  KEY `FK_JOB_CFG` (`CFG_`),
  CONSTRAINT `FK_JOB_CFG` FOREIGN KEY (`CFG_`) REFERENCES `jbpm4_lob` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_lob`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_lob`;
CREATE TABLE `jbpm4_lob` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `BLOB_VALUE_` longblob,
  `DEPLOYMENT_` bigint(20) default NULL,
  `NAME_` longtext,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_LOB_DEPLOYMENT` (`DEPLOYMENT_`),
  KEY `FK_LOB_DEPLOYMENT` (`DEPLOYMENT_`),
  CONSTRAINT `FK_LOB_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_`) REFERENCES `jbpm4_deployment` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_participation`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_participation`;
CREATE TABLE `jbpm4_participation` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `GROUPID_` varchar(255) default NULL,
  `USERID_` varchar(255) default NULL,
  `TYPE_` varchar(255) default NULL,
  `TASK_` bigint(20) default NULL,
  `SWIMLANE_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_PART_TASK` (`TASK_`),
  KEY `FK_PART_SWIMLANE` (`SWIMLANE_`),
  KEY `FK_PART_TASK` (`TASK_`),
  CONSTRAINT `FK_PART_SWIMLANE` FOREIGN KEY (`SWIMLANE_`) REFERENCES `jbpm4_swimlane` (`DBID_`),
  CONSTRAINT `FK_PART_TASK` FOREIGN KEY (`TASK_`) REFERENCES `jbpm4_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_property`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_property`;
CREATE TABLE `jbpm4_property` (
  `KEY_` varchar(255) NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `VALUE_` varchar(255) default NULL,
  PRIMARY KEY  (`KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_swimlane`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_swimlane`;
CREATE TABLE `jbpm4_swimlane` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `NAME_` varchar(255) default NULL,
  `ASSIGNEE_` varchar(255) default NULL,
  `EXECUTION_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_SWIMLANE_EXEC` (`EXECUTION_`),
  KEY `FK_SWIMLANE_EXEC` (`EXECUTION_`),
  CONSTRAINT `FK_SWIMLANE_EXEC` FOREIGN KEY (`EXECUTION_`) REFERENCES `jbpm4_execution` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_task`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_task`;
CREATE TABLE `jbpm4_task` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` char(1) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `NAME_` varchar(255) default NULL,
  `DESCR_` longtext,
  `STATE_` varchar(255) default NULL,
  `SUSPHISTSTATE_` varchar(255) default NULL,
  `ASSIGNEE_` varchar(255) default NULL,
  `FORM_` varchar(255) default NULL,
  `PRIORITY_` int(11) default NULL,
  `CREATE_` datetime default NULL,
  `DUEDATE_` datetime default NULL,
  `PROGRESS_` int(11) default NULL,
  `SIGNALLING_` bit(1) default NULL,
  `EXECUTION_ID_` varchar(255) default NULL,
  `ACTIVITY_NAME_` varchar(255) default NULL,
  `HASVARS_` bit(1) default NULL,
  `SUPERTASK_` bigint(20) default NULL,
  `EXECUTION_` bigint(20) default NULL,
  `PROCINST_` bigint(20) default NULL,
  `SWIMLANE_` bigint(20) default NULL,
  `TASKDEFNAME_` varchar(255) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_TASK_SUPERTASK` (`SUPERTASK_`),
  KEY `FK_TASK_SWIML` (`SWIMLANE_`),
  KEY `FK_TASK_SUPERTASK` (`SUPERTASK_`),
  CONSTRAINT `FK_TASK_SUPERTASK` FOREIGN KEY (`SUPERTASK_`) REFERENCES `jbpm4_task` (`DBID_`),
  CONSTRAINT `FK_TASK_SWIML` FOREIGN KEY (`SWIMLANE_`) REFERENCES `jbpm4_swimlane` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `jbpm4_variable`
-- ----------------------------
DROP TABLE IF EXISTS `jbpm4_variable`;
CREATE TABLE `jbpm4_variable` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `KEY_` varchar(255) default NULL,
  `CONVERTER_` varchar(255) default NULL,
  `HIST_` bit(1) default NULL,
  `EXECUTION_` bigint(20) default NULL,
  `TASK_` bigint(20) default NULL,
  `LOB_` bigint(20) default NULL,
  `DATE_VALUE_` datetime default NULL,
  `DOUBLE_VALUE_` double default NULL,
  `CLASSNAME_` varchar(255) default NULL,
  `LONG_VALUE_` bigint(20) default NULL,
  `STRING_VALUE_` varchar(255) default NULL,
  `TEXT_VALUE_` longtext,
  `EXESYS_` bigint(20) default NULL,
  PRIMARY KEY  (`DBID_`),
  KEY `IDX_VAR_EXESYS` (`EXESYS_`),
  KEY `IDX_VAR_TASK` (`TASK_`),
  KEY `IDX_VAR_EXECUTION` (`EXECUTION_`),
  KEY `IDX_VAR_LOB` (`LOB_`),
  KEY `FK_VAR_LOB` (`LOB_`),
  KEY `FK_VAR_EXECUTION` (`EXECUTION_`),
  KEY `FK_VAR_EXESYS` (`EXESYS_`),
  KEY `FK_VAR_TASK` (`TASK_`),
  CONSTRAINT `FK_VAR_EXECUTION` FOREIGN KEY (`EXECUTION_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_VAR_EXESYS` FOREIGN KEY (`EXESYS_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_VAR_LOB` FOREIGN KEY (`LOB_`) REFERENCES `jbpm4_lob` (`DBID_`),
  CONSTRAINT `FK_VAR_TASK` FOREIGN KEY (`TASK_`) REFERENCES `jbpm4_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

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
INSERT INTO `jbpm4_deployment` VALUES ('10001',NULL,'0','active'),  ('10008',NULL,'0','active'),  ('20001',NULL,'0','active');
INSERT INTO `jbpm4_deployprop` VALUES ('10004','10001','leave','langid','jpdl-4.3',NULL),  ('10005','10001','leave','pdid','leave-1',NULL),  ('10006','10001','leave','pdkey','leave',NULL),  ('10007','10001','leave','pdversion',NULL,'1'),  ('10011','10008','leave','langid','jpdl-4.3',NULL),  ('10012','10008','leave','pdid','leave-2',NULL),  ('10013','10008','leave','pdkey','leave',NULL),  ('10014','10008','leave','pdversion',NULL,'2'),  ('20004','20001','leave','langid','jpdl-4.3',NULL),  ('20005','20001','leave','pdid','leave-3',NULL),  ('20006','20001','leave','pdkey','leave',NULL),  ('20007','20001','leave','pdversion',NULL,'3');
INSERT INTO `jbpm4_extend_flowtype` VALUES ('2','è¯·å‡æµç¨‹(æ–°)','leave','OAFLOW','2012-06-23 22:45:13','è¯·å‡æµç¨‹(æ–°)');
INSERT INTO `jbpm4_extend_participator` VALUES ('1','test','test','org','0011,0012',NULL,'dfd');
INSERT INTO `jbpm4_lob` VALUES ('10002','0','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process name=\"leave\" xmlns=\"http://jbpm.org/4.3/jpdl\">\r\n   <start g=\"196,25,48,48\" name=\"start1\">\r\n      <transition to=\"ç”³è¯·\"/>\r\n   </start>\r\n   <task assignee=\"#{owner}\" form=\"request.jsp\" g=\"172,118,92,52\" name=\"ç”³è¯·\">\r\n      <transition to=\"ç»ç†å®¡æ‰¹\"/>\r\n   </task>\r\n   <task assignee=\"manager\" form=\"manager.jsp\" g=\"175,217,92,52\" name=\"ç»ç†å®¡æ‰¹\">\r\n      <transition g=\"-32,-8\" name=\"æ‰¹å‡†\" to=\"exclusive1\"/>\r\n      <transition g=\"128,221;124,165:-42,-18\" name=\"é©³å›\" to=\"ç”³è¯·\"/>\r\n   </task>\r\n   <decision expr=\"#{day > 3 ? \'è€æ¿å®¡æ‰¹\' : \'ç»“æŸ\'}\" g=\"200,308,48,48\" name=\"exclusive1\">\r\n      <transition g=\"-39,-10\" name=\"ç»“æŸ\" to=\"end1\"/>\r\n      <transition g=\"339,342:-71,-17\" name=\"è€æ¿å®¡æ‰¹\" to=\"è€æ¿å®¡æ‰¹\"/>\r\n   </decision>\r\n   <task assignee=\"boss\" form=\"boss.jsp\" g=\"294,375,92,52\" name=\"è€æ¿å®¡æ‰¹\">\r\n      <transition g=\"339,457:\" to=\"end1\"/>\r\n   </task>\r\n   <end g=\"199,445,48,48\" name=\"end1\"/>\r\n</process>','10001','leave.jpdl.xml'),  ('10003','0','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0]\0\0í\0\0\0mLƒT\0\0>oIDATxœíİP[w~ğûg¦æ¿tv¦×íôÙ»wú<wÓ›§é<óìdïô¹ãÎ³wòìÌmÓtw›íööÙ´icß§Iw³]oÒİÍdC¥Á1IL,\'ÂÈ6ÙÆkÌâ`#Û`–mŒFXLd~jA\"ø~¾BÀü:úĞû5ßq¤£sGÊ?ïù£w\0\0\0¸ÿßé>\0\0\0\0Ø]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]fff¾ˆ™.B^RëÈÊº\0€ÍŒ.„ª%û&\'\'\'&&ÆÆÆîŞ½1‘…ò’¬ «ÉÊÔ!\0\0Ö¡‘n‰\"¼wïdß±úÂ]ûşúÿ{í?ÿõË¿ÿ—?úÒ_üğ·eÈy*å¥£ç‡††FFFdeÙ„:\0À\"t!Ò\'¹G##…eÏÿcöú«[şgŞùå\'ÿ£¼®àRğÄçwı2ä<•…ò’¬ «ÉÊwúBáp˜:\0À\"t!ÒDEáÔÔÔøø¸ëdÖs9ôw¯>òÎÁmí}çÃÓİKYAV“•e“ONfõ÷÷ŒŒÈNdW¤!\0\0ëˆ.D:¨(œœœËıè¯¾÷¯_v¸Ÿ[:ÍC6‘\reóŞŞŞááaÙ•ì4\0`½Ğ…°\\\"\nCƒÁŸüÛÿıüë{¯\\iª!Êæ²“Á–ÁÁÁH$B\Z\0°^èBX+…ÒpÒs/¿ûDßÄÕE¡\Z²¹ìDvuëÖ­Ò\0€õBÂZê;…ccc9ÅßyşõÇ×…‰4”]É%\reçê»†ºß+\0\0]ÍÌÌD£ÑñññıU?ÿŞ¿~yÕ§SP–:Oü¼»»{xxXş„ü!¦\0Xºúâ‹/îİ»şÍĞ?æüÑr/4‰®à2ÙíuÿµŞŞŞ‘‘ùCL\0°t!¬¢&ïŞ½ë8´íï^ıêàdçàäÍ©NƒòïäMãé¤ñÀx<¥†¼t3¶ÄXY6§SjcCcùÔìÂ©›²[Ùy èïï—?Ä”!\0\0kAÂ*ñÉÂpøvşo–>\Z÷4äih,ö¯z:[®–Œµ…ÆÛB³«Í­?_\'ñTv+;oiiééé‘?Ä”!\0\0kAÂ‰ÉÂCµ¿üÎ-M]¿ê\ZñÅÆeù÷–z<j<Poúâ+Œ^VëtK.ß2ÆÜÊ‰nÅ6i\n——Êëèè`Ê\0€5¢a	uoš‘‘‘¬ŸÚ¶ëÛÏ·ÕßPcğ¼\ZíƒòX-©o7FláPìqlÍØ¿çcËcO¯ª§òÒĞyÙù«>uíÚµÛ·oËŸS÷¬Ñıî\0ØèBXBâlbbbhÈ¸âDÒ°åÎg-¡Ø¸óÙÕÙ[xJ^\r}_áÎ©µ\\=ÅV‹­`l2û enóÏ$\nåO477ƒAùsòGéB\0\0V‡.„%¦§§ÇÆÆ~é÷Šı¨©çWM=Çcÿ\Z£Y=èN,”7Ç–4Ëcµ¼[­“ØjvIÒBYYv.âÂ…@@şœüQùÓºß=\0\0]K¨/öõõ=õâ—>mxëüÍOÏ+Îß¬¨Î\rcIğÓúà§êÁùøÂOeåØ\nê%õTøj‰5e¡ì\\şÄ¹sçÚÛÛåÏ©¯ê~÷\0\0lHt!,!q‰DB¡Ğ_üğ·k®ï¯”áıĞ¡Š==äí84ÿUYn,Q½‰ÍÅŸ\Zë+œjİ/Âëõúı~ùsòGéB\0\0V‡.„%’»ğ××>:}£ôô³£tŞÓãé™ÎtPNw0ª…ñõg_í8¼Y§úÚ>ùuuut!\0\0kDÂ‰.|êÅ/:—oô\\Gi<ò:TíIê©@,-ÂRõªzÂÙ<3›ŒñuâÛ8x6_ş„táõë×éB\0\0Ö‚.„%]øôO~ïİŠR§€½ÄÙáøY`u¹.0w9±BİÜjj…Ä8˜ôà ì\\ş]\0ÀÚÑ…°D¢ÿ!ûÑŸı?É—›ÔwÍ»ú$õ’¥—\'\rÙ¹ü	Î#\0°vt!,‘èÂWŠşìsşSâ5ê&5Í‰[Õ$ß[Ş¼pµÍÆøÕÂÛDv.‚ëN\0\0X;º–HÜ§æ“ê¬ïüø9ÓVÚr§vöÕñq-éßÙWk¯%VÕÎm2{OìÙÛ_×ª%uşRÙ¹óÄ/¸O\r\0\0kGÂ‰ûZ¿ÏúÃüOşßøOŞÅ\n/>æ~ohş«¦§ñ_ÆKzI–Èneç\'Nœà¾Ö\0\0¬]K$~/ø»g~ñ¿w^¾5â»5z¹Kşñu\\6cöiìÕøBY2ª†±$¾¡ñà²ÚCl\'—e·²óšš\Z~\0€µ£a	‰³ÉÉÉ‘‘‘Û·o·´\\ù‡ìG%à>÷‡Æı‰??n‹?kS/…â+´Í>n›[G-3–Ëe·Ç*ÖÕÕ]»vMşü9ù£t!\0\0«CÂ333ê+†ıııÛñ½ıò™–“ƒS7&oÊ˜ê4şì˜R;§:ã¯NŞˆ­il¢V6ÆÍØè<sí€ìğƒ£;N<yñâEùò‡Ô—åOë~÷\0\0lHt!¬òÅ_Ü»w/÷ôô´´´ìÜû­ç_¼oâFxº{Cv\"»’;v¬®®Nv.Bşü9&\0X5ºVI2MMM;Şùo/¿ûDª4¼µ¢(”È®***N:%»•3Y\0ÀÚÑ…°š2éííõûıŞ‹5ÒsÏ¿ş¸÷úÁÕÌF»eCÙ\\vräÄÁêêê††Ù­ì\\ş“…\0\0¬]©)ÃñññáááîîîÖÖÖóçÏgïıÖ÷şõË÷s+íBÙD6”Í?ıôÓ“\'OÊ®d‡²[Ù¹ü	&\0X#ºÖúâ‹/¦¦¦ÆÆÆoİºuíÚ5é¹âÊ—ş1çşîÕGŞ9¸­½ïüÒ9(+Èj²²l²÷ØKÕÕÕ²Ù•ìPv+;—?Ád!\0\0kDÂZ333ê5‘Hd``@J®µµµ¡¡áÔg5ƒÛş!ûÑ¿Ú±åæı—_~ò?Êë\n.O|~×/CÈSY(/É\n²š¬\\şiÙ±cÇN:%›ËNdW²CÙ­º7\r“…\0\0¬]Ë%§áàà`ww·ßïojjª««;yòdiÍk9Åµ}×şë—ÿ/ô¥¿øáoËòTÊK²Byy¹¡¬,›È†²¹ìDvE\0°èB¤C\"\rÇÆÆ†‡‡{{{@KKËÅ‹%õjjjNœ8QYY)ñwôèÑ#1ò@ÊByIVÕdeÙD6”Íe\'²+¢\0€uD\"MT\ZNMMŒŒô÷÷÷ôôttt\\»v­¹¹ùÂ…çÎóz½uIä©,”—dYMV–MdCÙ\\v¢¾SH\0°^èB¤JÃh4zïŞ½»wï†Ãa‰¼Û·oƒÁ@ ĞŞŞî¹£ËByIVÕdeÙD6”Íe\'D!\0\0ë‹.Dº-¨Ã‘‘‘¡¡¡¾¾¾‰,”—dY\"\0ÀRt!ôHÔáäääÄÄÄØØ˜d_ÄDÊK²‚¬F\0`)º:©:ÓÓÓÑEÈKjŠ\0\0KÑ…°Ç£û\0\0ÈPt!ì%++K÷!\0\0¡èBØ]\0€.t!ì….\0@ºöB\0 ]{¡\0Ğ….„D\"‘‚‚İG\0@†¢a#ápØápè>\n\0\02]¡\0Ğˆ.„Ğ…\0\0hDÂFèB\0\04¢a#………º\0€EÂF‚Á ÓéÔ}\0\0d(º6B\0 ]¡\0Ğˆ.„Ğ…\0\0hDÂFèB\0\04¢a#~¿ßívë>\n\0\02]ñù|G÷Q\0\0¡èBØ]\0€Ft!l„.\0@#º6B\0 ]¡\0Ğˆ.„ÔÆè>\n\0\02]¡\0Ğˆ.„Ğ…\0\0hDÂFèB\0\04¢a#t!\0\0\ZÑ…°‘šš\Z¯×«û(\0\0ÈPt!lÄãñø|>İG\0@†¢a#t!\0\0\ZÑ…°º\0\0èBØ]\0€Ft!l„.\0@#º6âr¹:::t\0\0Š.„8Î`0¨û(\0\0ÈPt!l„.\0@#º6B\0 ]ıvíÚ•5_QQ‘îƒ\0 ãĞ…Ğ¯¤¤$9\n9âv»u\0\0‡.„~wîÜÉÎÎVQ˜““S\\\\ÌÙd\0\0Ò.„-ª.t¹\\œD\0@º¶àóùvîÜ)]XRRÒØØ¨ûp\0\0ÈDt!ì\"///\'\'ç­·ŞŠF£º\0€LDÂ.ª««wîÜyäÈİ\0@†¢aÑh4\'\'gppP÷\0\0¡èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB¬ÀÌÌıãWºáiÚZP)ã·¶`óñxGóîú’†ÀØä´îÏ\0\0[£±,Cw\'_*»øğ‹Ní©·–ñı}§}£º?K\0\0lŠ.Äƒ¹\Z[v¸TZ=–SşJEÓÉ–ÏeNOÜ·óPÇùÆÉ«‰ÙÍ‡^(ş…§ifF÷g\n\0€ıĞ…XŠôÓÜõª¨xç„¯+¬=õV=ü½£O¿J½—\'ß«º;©ûÓ\0À^èB,EEáC/¿[s]{Ø­×¢:¾µ ’YC\0\0’Ñ…X”«! ¢PZJ{Ï­ãğu…Õiñ—Ê.êşŒ\0°º©İSñôÁ™ví%·îãL[Ÿô®¼»æ®AİŸ4\0\0vA\"5uùÉİÕÚÎ¢ñJE“:›¬û“\0À.èB¤069­¦Ó6ô…&KáÑi5!zéS†\0\0èB¤PŞTsiÚëÍÒñÜ\'^y›¯iÒıy\0`t!RØî2‚)§Ò§=İ,G/uËÛüãÜrİŸ7\0\0¶@\"uèMv²y„Â“ò6·ìpéş¼\0°º)|å§¥LşŞQíéfõP_£Ôıy\0`t!RP?\n¢ãgî\Zòòæ/é=°­ .\0Àzt!RP]hiJ·?WÚ»Ørùwk*)7YËPïT÷ç\r\0€-Ğ…HAc\Z„ù‡éš/¤\0H ‘‚5](…—r0f[rŞ¿yø¹TkåyéB\0\0¬B\"Ëºpû›©æ¥.Œ‡ãüyDæ\0Hº)hêÂØcoÁs¥\r‹Î,.˜V¤\0X?t!RĞyÙèB£ëòœ5nÈ[ï(¤\0HF\"İó…ñ.´z².\0 ]ˆlÒ…Ì\0Nt!RĞ}ùpŞÖ‚<æ\0H/º)hœ/ŒİÑÚ¸\0™ùB\0\0ÒŒ.D\nZïks]è-PÓ…ëşc\'t!\0\0ÉèB¤†.´É \0H ‘]\0@¢‘Â–.©%ï¨ön³z¨wªûó\0ÀèB¤ğxGjéL[Ÿön³zÈÛ|øE§îÏ\0\0[ 3ÈÛo¿ıË_şrïŞ½¥¥¥õõõ·nİZlÍï~pJ‚éƒ3íÚ»ÍÒq¡sPŞæ#¯Jçÿ\0\0l‹.Ì yyyY&æ5w×^—`zúıSÚÓÍÒñJE“¼Íí.oúÿ_\0\0`Ctayûí·“‹ğı÷ß—%7nÜ0¯ÙÙ?*ÁôĞÅÁş1íõfİx,§\\Şæñ«İéÿ\0€\rÑ…›ÙÄÄDGGGmm­Óé”ÌÏÏWE˜——÷ÙgŸíİ»7‰,¶í“ïUK3ısi½öz³h||> opË×øät:ÿ§\0\0`[táf‡[ZZ*++‹ŠŠ$].—ta0”—Î=+QXXXxüøñ²²²h4ºÄ~š»Õ”á…ÎAí\r·î#TW\"ï®½¦ÿ1\0\0Ø]¸„B¡ÆÆFI=GŒ<§²pÁj·oßÎÍÍ=xğ ”ârvûıNK9}å§¥›ìlòğèôÖ‚JykçyffÖÿ\0\0]¸QƒAÉ;—Ë•ŸŸ_TTTYYÙÒÒ‡—Şª  @V[æŸ›œV7¬yäÕC¾®°ö[—\nOª(Ü²ÃÕÙ?ºæÿ\0\0ltá†111á÷ûkjjöîİ›••åt:¥;::d¹u4Ğ7úXn¹ºÉß»5×µWİ\ZÇ¡Æ :},o§ùÖ uŸ\0\0]hkápØçóUVVæçç»İn¯×ÛÓÓ“Îc»7ıtìv†jâğ•Š¦\r÷Cïè\'¯ª«eHé2S\0€]h;’}õõõ’€‡Ããñ466h<¤™™û•Wº%\nUW©¡&Şl>ÌÇüæ¯¯òB\0\0R¢õ‹F£êË‚N§377wïŞ½UUU~¿‰›Èh!9U~)¸İåİE˜<~ÑùÌ¾Ó%\rnI\0ÀèB=¤ù¤ü¤ÿ¤¥Õ—¥—¾w\0\0€uèB\r¤\n\nÜnw}}}š¿,\0\0°ºP‡ÃñÀÊ\0\0\0¤]¨AQQ‘ù¦Ó\0\0\0zÑ…\Z8NõÃt\0\0\0öAjPVV¶ü\0\0HºPÇãóùt…UVVrE6\0\0ºĞ…\ZÔÆè>\n;âŠ\0\04¢5ğz½555ºÂèB\0\04¢5ğù|G÷QØWj\0 ]¨ßïw»İºÂ¸R\0\0èB\r$}$€t…Ñ…\0\0hDj000PXX¨û(ìÈívûı~İG\0@†¢5‡Ã‡C÷QØwğ\0@#ºğAÏîÉZBEÛªö*[®óqn\nt!\0\0\Zet&\'ŸôñtÏÙÁø‹mê‰,[hŞÁ*»077—8›ÕÔÔx½^İG\0@†Êè.L4ºppĞx´`\"Ğš.äF})qÇo\0\04Êğ.l«ˆ5_ü?±³]8»d¶œO]¶Ê.äF})Ñ…\0\0hDJßÅÒ¯-Ö}s™g¢ñ,©/¦Z¶2Ü%¥ÆÆÆÊÊJİG\0@†Êì.Œw]\"ïæÎÏŸ5]XVVÖÒÒ²oasá—`\0\0Ğ(ã»Ğtb8~bÙôıÂõ=Ì…·)Ñ…\0\0h”Ñ]˜ø2áŠŠäéAy6w©‰5ó…|‘.%~	\0\02ºç$Şìç^²àzd¯×[SS³ªM73º\0\0èÂ˜øyãØ¹b©ÀØç&-¸¯5\'LS¢\0Ğ(Ó»0q*¹¢¢\"+kŞÄ`[Ål#Z0_è÷ûİn÷ª6İÌø…@\0\04Êô.Ô…‰±”èB\0\04¢õ(,,Ô}¶‰D\n\n\nt\0\0Š.Ôƒ‰±Ådeeé>\0\02]¨\r”\0\0ºĞ…ÚäææF£QİGa;|,\0\0èBjãp8Âá°î£°>\0\0t¡µ)**\n…BºÂvèB\0\0t¡µq:Á`P÷QØ¹\0€.t¡6eee---ºÂvÈe\0\0t¡µñx<>ŸO÷QØ]\0€.t¡6µ1ºÂvÜn·ßï×}\0\0d\"ºP¯×[SS£û(l‡iT\0\0t¡µ‘ú‘Ò}¶C\0 ]¨ßïw»İºÂvjjj¼^¯î£\0\0 Ñ…ÚƒA§Ó©û(l‡¯]\0 ]¨ÍÀÀ@aa¡î£°º\0\0]èBmÂá°ÃáĞ}¶ÓØØXYY©û(\0\0ÈDt¡NYYYºÁv¸\0\0]èBrss£Ñ¨î£°º\0\0]èBG8Ö}öÂå8\0\0èBêTTT\n…t…]ìÚµ+k>ù|t\0\0„.Ô‰ßNVRR’…Gáş\0\0¤]¨SYYYKK‹î£°‹;wîdgg«(ÌÍÍ-..&š\0H\'ºP\'~ómÂÂBÕ…‡â$2\0\0iFêÄ=œJŞ¹s§êÂÆÆFİ‡\0@f¡uòz½555ºÂ^òòò¤wğ\0 ÍèB¸WŸYuuµtaUU•î\0 ãĞ…:ùı~.¹] \ZfggG\"İ\0@Æ¡uâÎ\0\0À>èB\nu\0\0€.Ô);İG\0\0` 5ËÊÊÒ}\0\0\0ºP³üüü²²²ÆÆF~(\0\0èEj‡[ZZ*++‹ŠŠ¤İn·×ëíééÑ}\\\0\0 ãĞ…6211á÷ûkjjöîİ›››ët:kkkíùÁ33÷_éş…§ikA¥ŒßÚşÍÇãy9Î¸ëK\Zc“Óº??\0\0ìˆ.´©h4*E(](u˜••%¥(½(Õ(í¨÷À†îN¾TvñáÚSo-ãûûNúFõ~’\0\0Ø\r]¸1ôôôx½^·ÛŸŸ_TTTYYÙÒÒ’ş›?»\Z[v¸TZ=–SşJEÓÉ–ÏeNOÜ·óPÇùÆÉ«‰ÙÍ‡^(ş…§if&Í!\0\0öEn<¡P¨±±±¬¬¬  Àápx<ŸÏ700`é•~ú»^Õïœğu…µ§Şª‡¿wôé÷O©÷òä{ÕCw\'-ıè\0\0Ø(èÂ-«Y.,,”Lt»İõõõV\\Ú¬¢ğ¡Šß­¹®=ìÖkQ\rßZPÉ¬!\0\0÷éÂÍ$‰øışªªª¢¢¢ÜÜ\\—Ëåõz×å²WC@E¡´”ö[Çáë\n«Óâ/•]\\û§\0ÀFGnNÑh´£££¦¦F]¶¢.m–%²|¥»º=<¦âéƒ3íÚKnİÇ™¶>é]ywÍ]ƒVü\0\0`¡3‚º´ÙåråææUUUùışe^¶¢Î ?¹»Z{ÃY4^©hRg“­ş¿\0\0€ÍÑ…\'\nÕ××»İî‚‚‚ÂÂÂÊÊJŸÏ‡S®<69­¦Ó6ô…&KáÑi5!zéS†\0€ŒFf´ÆÆFÇãp8œN§y…òæ šKÓ^o–ç>ñÊÛ|õHSúÿ\0\0`t!–²İeSN¥O{ºY:^ê–·ùÇ¹åº?o\0\0t¢±uèMv²y„Â“ò6·ìpéş¼\0Ğ‰.ÄR¾òÓR	&ï¨öt³z¨¯Qêş¼\0Ğ‰.ÄRÔ‚ØÿgîèB\0\0Ö.ÄRT®°±zlÛ~àæ¯nMÈË/Øºy[c“<oª½İ<ü\\~ƒ<”n®´×Xâ-Ø\Z[²Ò¡Ş©îÏ\0\0èB,e5]˜(3ïÂæ‹§[RÏ%V–°‹•ßlSš¶] ‰t!\0\0ë‡.ÄRVŞ…vu)\'ö¶&-OîÂ”ó…Ş‚¹ˆ4\r‘uù‰M\n˜»p…H\0@b)+íÂ¤i¿¤3¿FüÍÅÎšv›:“æãS’Û¶;”İn;`¾\0€• ±”váÜwãgLnİšX-W¥˜4Ï·ı@éâß/\\üTò\\q¦<lüÅŸJ¦\0 ±”Õ¿PáüI;£U±-g¾0éTrò|áìš‰ÓÓ‹œG¦\0X!ºKYq.ón¢“Î/¼âøAó…ñyG®;\0`Ğ…XÊªÏ#uh»D2š¾˜â4ñ2çíÂ†¼•|Å.\0€.ÄRVuÿÂ…£.ßt)IüüïÜòUÌ¦èBIIuİ‰z‰.\0`%èB,e5]hj¾ù]Ø›|\rJb¤ìÂÍÎMRrŸ\Z\0\0V….ÄRVsYÍÒÅëp¡y·›Ydó7SŞ§Fµ Z^—ŸÍ†<ó´\"]\0À2Ğ…XÊºœGŞƒ.\0€.ÄRèB\0\02]ˆ¥lÙá’Zò÷jï6«‡z§º?o\0\0t¢±”Çó<RKgÚú´w›ÕCŞæÃ/:uŞ\0\0èDb)ßıà”ÓgÚµw›¥ãBç ¼ÍG^=¤ûó\0@\'ºKÙ]{]‚éé÷OiO7KÇ+Mò6·»¼º?o\0\0t¢±”ÎşQ	¦‡^(öi¯7ëÆc9åò6_íÖıy\0 ]ˆxò½ji¦.­×^oÏä\rnÙá\ZŸœÖıa\0 ]ˆhî\ZTS†:µ7ÜºPxR]‰¼»öºîO\Z\0\0ÍèB<Ø÷?:-åô•Ÿ–n²³ÉÃ£Ó[*å­=ç™™Ñı)\0 ]ˆ›œV7¬yäÕC¾®°ö[—\nOª(Ü²ÃÕÙ?ªû3\0@?ºËè},·\\İäïİšëÚ«nãPcP>–·Ó|kP÷§\0€-Ğ…X®±{ÓOÇng¨&_©hÚpß8ô÷¾qòªºúX†”.3…\0\0$Ğ…X™™û•Wº%\nUW©¡&Şl>ÌÇüæ¯¯òB\0\0’Ñ…X1É©òKÁí.ï†(Âäñğ‹Îgö.ipK\Z\0\0ÌèB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èBØTeee4\ZÕ}\0\0dº6åp8Âá°î£\0\0 ƒĞ…°)º\0€4£aSt!\0\0iFÂ¦èB\0\0ÒŒ.„M…B!İG\0@¡aSN§3ê>\n\0\02]›¢\0H3º6E\0ft!lŠ.\0 ÍèBØ”Ûíöûıº\0€BÂ¦<ÏçÓ}\0\0dº6E\0ft!lŠ.\0 ÍèB¬ÁàÙ=mê¿{Î\ZKÚ*²bKYÛXknå%Ñ…\0\0¤]ˆ5xPÊ³¹§s/-«kjj¼^¯\r\0\0R£±JFóÅUœ5wáìiÀØƒ¤Õ“í9»ØşkcÒó^\0\0À}ºk’4_Ï¼=±\n”œ7!}vêp©“Í	t!\0\0iFb\rRGN\nÀ¸X¦œ0\\ât2]\0@šÑ…XƒÙyÀç‘M’^a¾\0\0;¢±Jñù¿^<{Ny¥ó…•••Ö¾\0\0„.Ä\Z,u=r[ÅlÎ¿åş2ç}>ŸÇã±êÈ\0€	]ˆ5XĞ…’‚êº“Ä¢¤;ÒĞ…\0\0Ø]ˆ5Xp=²$àüéÁä\0\\äF5‹í›.\0 ÍèB¬’jA58.p¶øR\\”¼‚ıÓ…\0\0¤]›\nƒN§S÷Q\0\0AèBØ]\0@šÑ…°)º\0€4£aSt!\0\0iFÂ¦èB\0\0ÒŒ.„M…Ãa‡Ã¡û(\0\0È t!lŠ.\0 ÍèBØÎ®]»Üüº¨¨H÷A\0°ùÑ…°’’’ä(<räˆÛíÖ}P\0\0l~t!lçÎ;ÙÙÙ*\nsss‹‹‹ƒÁ îƒ\0`ó£aG………ª:ÄId\0\0Òƒ.„ù|¾;wª.lllÔ}8\0\0dº6•——\']èp8¢Ñ¨îc\0 #Ğ…°©êêjéÂªª*İ\0@¦ aSÑh4;;;‰è>\0\02]\0\0\0]\0\0\0];š‰ùÂD-×}t\0\0lNt!lGáğpph(Ğß×)c2&\ZNOO«:Ô}Œ\0\0lBt!ìe6\n;?zï«‰q»Ç‰DÆÇÇ¥IC\0\0,BÂFT\r¤÷íş½âwÿ½yğÑÿØ¸‡¥\'&&¢Ñ(i\0Àº£aæ(¼ìs\\¾äH¤áöÆÑÑQÒ\0\0+Ğ…°…QxÉ1<r6ü›sF\Zî6Ò°x÷hó_4!\r\0Xwt!ôK…R„Ò…æ4ô_o \r\0°]Í›)şÍ¹‘»Mwï6\rÇ‘4\0Àjt!tZl¦PÆİXª¡&IC\0\0,EB›EOÇ¢pdv¨Çê´òei\0€UèBè‘\"\n¯¼|úønR&ÒĞø®á•·IC\0\0¬@Bsú.¿54|f8|f4Ò`ŒÑ‹2Â£ÔÓÄYA†¬L\Z\0°îèB¤›9\n›/½>0ø™ŒáğycŒœ?H5Ôš²	i\0Àú¢‘Væ(¼p1ÿó¾“2îÜ9şiÉÿ)k~õ7Cƒ§û‡æ\rY(/É\n²Z(¶¾lH\Z\0°èB¤9\n/6äÜî®¼İ{¬ûö…jTZâ/1äiâ%YMVîùÜØJ6\'\r\0X/t!ÒÄ…çvöÜ.v—Käşäë‰ò‹§aåwdù­Û•ò`ÁK²²¼¤¶•†\0\0¬ºé`Â³ç~v3è–!m\'cAù©qòø·e¤|©ëVEWwEÇÍƒ²Ùi\0ÀÚÑ…°œ9\nÏœ~¹½Ãu£½DÂNGş2eÿ¥²rbÃ.Ù•ì0MiØV±çìà*^3<»\'«¢m‘Wb/Èãûk«XdU\0\0Ö]k©(îLŠÂ­mÉh%]b÷<¹œ(”ÕÚÛÌmØ~@íÍœ†£££’†ÓÓÓr\0ëö~–Ó…Fò™HØIŞ-)Ş~t!\0@ºÖ’.&GaËµd´¶9e\\kÛßÚ¾ïzÛşëíÆ8^ñgˆÂŠ?ó·ï7¶mß\'ÿÊ†Æ¿íûÕ>?«Ù‘HÃ6ÿIÃH$299)i¸Ö·‘*éŒh‹·Û¼ÜSQ±\'e<.9Ÿ¨j0éïTœ5w!\0°]kÅÏ ïù…Òm-×öÈ¸~ı#-×÷ÊPO+Ëÿ|±(”—’W^°¡Ú³JÃ½…pår]ooo8F£ëö~æÚ.Ö‚É¡—˜ß››è[Ê¢k%ÍÆCsÏøtã\nÎS\0°bt!¬%]Øß×©ºğÌé—ÕÄŞõöıj¦P†¿}|\n°Íé_rÊP^’\rÕVj¾PÍ5\ZÿÎNª³ÉÒ…M§ºººS†ky)O/œ8œ[­¢-Å³A·ø©ä¹yÀ”ç‘ç­\0€%èBX+Ñ…‰ËÕ×ot¸Ô%#7VòCãË…±MnÌßPí3qa²táÅ‹¿îìììëë]cÎ§¢ÏÜhm{ö\'ÿG>;wÒx6ôîÏ;•œ<_˜´F\"0SG\0ÀJt!¬%](Yv»Ç_¼û?Ä¾ù÷ïÏUÅ\\âšâ]’œ|1rò%É²ÛDÖ9ÖÒÒ¢ºğğáÃ}ô‘Óéôx<µ1òR0fbbbï$>Õ7w*×vI×¨@4Wİƒæã¯sİ	\0@ºÖR]‰D:—ix¾açÍ Û¸û`·qÂ`wùb÷)\\ì¾†]·*ŒmåßØM?|\"QX[ëinnnmmUç‘{{{;::¤}>ŸêÂ²²2gL~~¾j²½{÷ª%555j===÷çZílÒ÷gÏÆ»°í¬¼2[‚ñŒSßœÿ5ÂeÎ.Ú…Æö–ÿ?\0d*ºÖ’.ŒF£ãããápøF{c\"\r/\\Ìï¾]Şs»üÖmãGMRö_uåwÌ?v¢†ñ{\'³?y’ø¡d‰ÂÏ>«¸páBKK‹´àò¯;‘şS!èõzUªL”^Tá(ét~èØ¥½±ÿxmcc£±Áå£»İÍ³»‰Gß\\ÏÅrŞLß*¾_;A9¶h=ÿ÷\0\0„.„µfff¦§§Õ”áÀÀ@›ÿB\"\r›/½®ò.Ôw2ùÇ‘÷Íÿ‰ääGŞ7ûÉŸ÷¼İ{L†ìdA^¹råÆ’zëxŸš‰‰	£ßyçÓ‹~•••ÎX*æä¿¥Â®°ğ­7v9>üĞñzÖ¿–5ï;+ëã£GßÉÊ*o\rÓÎÆO\\sŸ\Z\0@ZĞ…°–º¯µ”™¤Õèè¨´šÿzC\"\r}—Ş”Â“qçÎñä4¬ùÕßô\Z<\Z¬•ò49\neeµ•lnÂöööîîn+îkêÂä¹sÄ?~çèÑ³>¨¬|/6«ø±Û›vü0{g|mç¬X7¾QğI•š§…BÉbŞéèû÷“§ÉB\0€uèBXN¥a4\Z•JY˜†Ío~&£¿¿Z¥¡Tàpøü‚¡ÒPVÕÔú²áQhÏŸHÎR“555*‹ŠŠTö¨%eeejŸÏ§6‰D\"º\0°ÉÑ…H‡¥ÓğÊ•Ÿ‘½ c4Ò #şxô¢zjŒØã¡á32d“\r…Ë!ñ§*°¥¥Eu¡ÇãQ¥(É¨ÚQ\"R-©ªªRë¨k„îÃ\0llt!Òdé4¼zõİá‘³2Fî6©qwöß»³e„sNÖ‘•7e.S(RX__¯ºĞår©RTá˜››«Êrµ‚¬©6‘ÏG÷á\0ì‹.Dú,?\r!˜üx˜(\\yûª;::TVUU©R,,,LL:ê>L\0€íĞ…H«¦¡1#ø›swçÏ\ZQ8rV^\"\n×‹¤¡îC\0\0Ø]ˆt[Î¬¡$`ò|¡šG$\n×]\00£¡ÁŠÒ(´]\00£¡Ç2ÓÓÇ¡\0ft!´YÎw\r‰B‹Ğ…\0\03º:=0\r‰B‹Ğ…\0\03ºš-†‰(¬­õ…ëˆ.\0˜Ñ…Ğo±4”T£îÌ±æææ–––7n…ë‚.\0˜Ñ…°s\Z¶ù/\\¹\\×ÔxêâÅ_K¶¶¶vttôôô…ë‚.\0˜Ñ…°‹ä4•şëíííêêêŒ‘òTÊKDáÚÑ…\0\03º6’œ†‘H$KöÅÈy*‰ÂuA\0ÌèBØ‹JÃéééÉÉÉññq	ÁÑy Oe¡¼D®]\00£a;‰4ŒF£“Iä)Q¸^èB\0€][óx<ºas¢\0ft!l|±,\0ÀŒ.„­‘/áƒ\0˜Ñ…°5òÅ\"|°\0\03º¶F¾X„\0`FÂÖÈ‹ğÁ\0ÌèBØW8v8ºbs¢\0ft!ì‹.´]\00£a_t¡uèB\0€]û¢­C\0ÌèBØ]hº\0`FÂ¾B¡PQQ‘î£ØTvíÚ•5Ÿ0\0 .„}ƒA§Ó©û(6•’’’ä(<räˆÛíÖ}P\0\0» a_táº»sçNvv¶ŠÂÜÜÜââbùu\0À.èBØ]h…ÂÂBÕ…‡â$2\0 ]û¢­àóùvîÜ©º°±±Q÷á\0\0l„.„}Ñ…ÉËË“.t8ÑhT÷±\0\0l„.„}ù|>Ç£û(6¡êêjéÂªª*İ\0°ºöEZ$\ZfggG\"İ\0°ºöE\0Nt!ì‹.\0 èBØ]\0@:Ñ…°¯úúz®\0\0 mèBØWmŒî£\0\0 SĞ…°/º\0€t¢a_Ş…33÷_éş…§ikA¥ŒßÚşÍÇãy9Î¸ëK\Zc“Óº??\0ÀŠÑ…°¯ŒíÂ¡»“/•]|øE§öÔ[Ëøş¾Ó¾QİŸ%\0`èBØWfv¡«!°e‡K¥Õc9å¯T4lù\\ÆğèôøÄ};uœoœ¼š˜İ|è…â_xšfft¦\0€å¡a_Ççóé>Šô‘~ú»^Õïœğu…µ§Şª‡¿wôé÷O©÷òä{ÕCw\'uº\0€£a_™Ö…*\nz¡øİšëÚÃn½fÕÙğ­•Ì\Z€ıÑ…°¯ŒêBWC@E¡´”ö[Çáë\n«Óâ/•]Ôı\0€.„}eNŞSñôÁ™ví%·îãL[Ÿô®¼»æ®AİŸ4\0`)t!ì+sºPA~rwµö†³h¼RÑ¤Î&ëş¤\0K¡a_n·Ûï÷ë>\nËMN«é´\r}¡ÉÒcxtZMˆ^ºÅ”!\0Ø]ûr:Á`P÷QX®¼9¨æÒ´×›¥ã¹O¼ò6_=Ò¤ûó\0,Š.„}eHnwÁ”SéÓn–£—ºåmşqn¹îÏ\0°(ºö•!]¨î½É.C6PxRŞæ–.İŸ7\0`Qt!–¯­\"«¢-éùàÙ=ó›VßsvM_&Ë.üÊOK%˜ü½£ÚÓÍê¡¾F©ûó\0,Š.ÄrI.è¼](Ùø\0KUd\nÒ…êGAìÿ3wt!\0lzt!–)1Y(5˜ªùÌsƒk/t8ápx-{ØT®2¶¼Ï•ö.òjCŞ¶Ãåîª÷À¶­yŞT/İ<ü\\~ƒ<”nÿ-oÁÖØ’•õNuŞ\0€EÑ…X–Ù©Áy“†æóÈ‹4cên| ºp}ºPÂn«‰„äİ’â™H@Æ ±,Iu—2şs‰s¥˜<_¸ª¹Cºp‰4gœmÒpF\Z“sËóK9q¸TS\Z(]X—ŸØMÁs®0éB\0°9ºË5xöì¿H®Â:ÍÆZ0¹ÿâ˜ô`É17¸`$ÍÆCsÛöøtã\nÎSÓ…\0°Ğ…X–¤)ÂŠ¶†ñ\Zä<ò*¬´}¶•w³«Ô¥8¼ıÀÍEççDXä<òÖ­«8•L€ÍÑ…X¹…ß+Lq¿\Zã{ˆ1+½9Y~~şÄÄÄª7ß(Ö4_?e\\P·pyCŞ¶íÆ4¡·@G>?Û‚Æ&³ë\'JN/T\'‘çºp±óÈt!\0l.t!–mv2°âìR]¨îVcÌªsÇ±ç«»0Y6\\ûQÛß*»0>Õ—¨=sØ%]w¢Ñ\\uš/Œ¿ëN\0 3Ğ…X–yq·ÈydU„)¿_ßb…s‡taÊ1Ûj‡lSQ8{•I~Càf¼ëJ¥g»0q\ryFDöÎnµ’ùÂE»pE·Â¡ÀîèB¬Ü2Î#Ö|ÿBºpÉ‘¸è8©óf.9Úæz.vFxŞM\nWñıBIIuİÉÄr¯h¡`£ a_táƒº0©Ms~ñ.4Z0ömB…¥óÓp…ó…F0ÆNIsŸ\Z\0Ø”èBØ]¸ôHuarr)\Z]x «ñEÃ­É·°‰M4šz.å}jÔŸPËëòAÛá‚iEº\06>º6‡‡î£H‡µ]¼‘]\06GÂ¦èÂÍ7èB\0°9º6•9]¸e‡KjÉß;ª½Û¬êêş¼\0‹¢aS™Ó…çy¤–Î´õiï6«‡¼Í‡_têş¼\0‹¢aS™Ó…ßıà”ÓgÚµw›¥ãBç ¼ÍG^=¤ûó\0,Š.„M…B¡¢¢\"İG‘»k¯K0=ış)íéféx¥¢IŞæv—W÷ç\r\0X]›\nƒNgFœsìì•`zè…â`ÿ˜öz³n<–S.oóøÕnİŸ7\0`Qt!l*sºP<ù^µ4Ó?—Ök¯7‹ÆÇçò·ìpONëş°\0‹¢aSÕ…Í]ƒjÊğBç ö†[÷\nOª+‘w×^×ıI\0–BÂ¦2ªÅ÷?:-åô•Ÿ–n²³ÉÃ£Ó[*å­=ç™™Ñı)\0–DÂ¦2­Ç&§Õ\rkyõ¯+¬½çÖe„Â“*\n·ìpuöêşŒ\0@Â¦|>ŸÇãÑ}iè},·\\İäïİšëÚ«nãPcP>–·Ó|kP÷§\0x0º6•](ÆîM?»¡š8|¥¢iÃ}ãĞß;úÆÉ«êêcRºÌÀFAÂ¦2³ÅÌÌıÊ+İ…ª«ÔPo6æc~ó×WùN!\0l t!l*c»P‘œ*¿Üîònˆ\"L¿è|fßé’†\0·¤€\r‡.„Mex\0~t!lª¾¾¾ªªJ÷Q\0\0AèBØTmŒî£\0\0 ƒĞ…°)º\0€4£aSt!\0\0iFÂ¦èB\0\0ÒŒ.„MÑ…–âZo\0€]›’pñù|ºbÓÊÊÊÒ}\0\0Û¡aSt¡¥èB\0€]›¢-E\0ÌèBØ]h)º\0`FÂ¦èBKÑ…\0\03º6åv»ı~¿î£Ø´èB\0€]›r:Á`P÷QlZt!\0ÀŒ.„MÑ…–¢\0ft!lŠ.´]\00£a/»víÊš¯¨¨H÷AmBt!\0ÀŒ.„½”””$Gá‘#GÜn·îƒÚ„èB\0€]{¹sçNvv¶ŠÂœœœââbÎ&[.\0˜Ñ…°ÂÂBÕ….—‹“È¡\0ft!lÇçóíÜ¹SÂ¥¤¤¤±±Q÷álNt!\0ÀŒ.„ååååää¼õÖ[ÑhT÷±lNt!\0ÀŒ.„UWWïÜ¹óÈ‘#ºdÓ¢\0ft!ì(\Zæääê>M‹.\0˜Ñ…@&¢\0ft!‰èB\0€]d\"º\0`F™ˆ.\0˜Ñ…°£™Eè>®Íƒ.\0˜Ñ…°•}_ÄLOOG£Ñ)Y(/©uÈÄ5¢\0ft!4K¡dßØÈhçÅæ–_×şpíûûÔ§7Î_MLLÜ»wO5\"u¸t!\0ÀŒ.„6‰\"”<÷qéŞï=ûãßıêûM9ä¥÷¿ı·Ò‹}½½‘HD\ZQ‘:\\5º\0`FBU„Òvµïï{å‘¯%÷ßëÿõ¿;¾ù-×³ÏËò4¹eåªwöö˜ëP÷{ÚHèB\0€]\rTö¶¶íúú7Tíıä÷ÿpß3Û®|\\2ÑÑ1İİ½`ÈÂKûÈ\n‰@ÌùÚŸ¶Ö\Z\Z’:œ˜˜˜šš\"\rW„.\0˜Ñ…H7…—U©È{ñKÿ›ûŸş%ì»lÎAóÕ\\Ï>/›¨™ÅÓ%ûûûGFFÆÆÆHÃ¡\0ft!Ò*…ªív}ı½g¼Ë)ÂäÑS{&çkªšòÔş’P(‡IÃ¡\0ft!ÒGEaË¯kU¾ÿí¿MyÖx9C6,|ò»*\rO—$\r311Œill¬qÆäççë>4\0€íĞ…H“Äw\n_şò£Òso~kª«kuQ¨†lşæO©ï&^:]—±i(ïZ•ŸÊ¾ÊÊÊDùeeeÉ¿ê©,W+¨•e+İ\0°ºi\"¡611¡Îÿf=ö\'w[[SÖ^ÃÅÚ¼7ßÿöß¾ûÄSj¸}şBaQÊ•e\'Y~]í°½­­¯¯oddDşJ4\ZİL]ØÓÓ#%ç÷ûUØ¹İné¼½{÷fÅ8U~êÕÆÆFU~ò9è>p\0ÀC\"ÔdáÉ7ß•†ûÑïüAÊïJäI.vÿÂ—¿ü¨ô¢y+Ù•ìPVøøçÙCııı‘HäŞ½{hÊp±S½|ªü$å©ä zUQV–XÔ}à\0€Í†.D:¨›W«3ÈGü3sŞu×ÔªW—ïûoÍ?ø‰:›|õÒ%ÙÓĞñË(ê¦†ºßw§z\0]Ë©ÉÂÓîWõ6z¥e²³3yUµœ(Tã—_ÿÆ‚Íe‡ê–7‡_{#„B¡‘‘‘Å¦\'&&ÜnwYYÙú¾GNõ\06º–“8‹F£o~KÒÍõìów[[Œ_ÎŞİz™ãè6o×Z÷=³Í¸ëÍÿõÍk×®%O.èÂšššììlÕj+zœê\0dº–S\'‘Õ½i®¸„›šÂM±›Â\'_ÉYQªüU•lßOcÓ•KÔ=kš\Z.¾¾¾H$¢.LVÇĞÚÚúúë¯g%Ypœê\0€.„å$Înœ¿ ~¡¤ÿÌ™#ùÇ‘—?\\Ï>¿`?êê“cû]ímm½½½‰SÉ………Y&œê\0`º–›>°\\¢íõÿúßoW0Æ‰*5.­\"\neHMö?nìdv‡ê§–İäSÉò§_{í5s\nNõ\0°\0]k©/Ö¾¿O]M|óÓO“ÇÑÿlu](cÁ®Ô÷?şyö•+W$ø_1nllt»İ999»wï~ï½÷ä¿\0€]kINMMÚS,Ñ¶÷{ÏŞ8p y¸şæïWİ…çò’w%Ñ©ºğÒ¥K@ ¿¿_ıöIò¥\'UUU………ü\n\0\0ft!¬µ ıû÷\'5vaò®taâÒ“rwk\0\0´£a­ä.,|ò»æÕ-©W7ì*q™.\0`uèBXKuaâº“_\n\\Ëu\'v¥~yùğkoĞ…\0\0¬]k©.l­;÷ÃØ}jŒ‹ˆÕÄ³c•÷©ù›¿_Ô»Yv›¸O\r]\0ÀêĞ…°–êÂğàº¯õ…Â¢÷\\İ}­o~úiòNÔ¼£ü‰ÚS§–¸î\0\0,.„µÔ}j$ÑŞ|â)I·}Ïl7\Z¿Pò›¤óc§€—?*~ğ“Ø/4ÎştJãŞï=+Ëw}ıçÎ[pŸ\Zº\0€e¢a¹ééiI´ªwöHºıä÷ÿp ¾aÁï#<Ç^şò£ËŒÂwşÛŸß½6osÙá÷«òRñO~.]¸à¾Öºß=\0\0]Ë}ñÅ÷îİëëí•(”zsÿÓ¿Lvv.Á_Ue=úõF¡1İè»¼`[×³Ï«â¬©ªºxñ¢ßïOş<İï\0€\rƒ.„åTŒ~í\r	¸ıÎt×ÔNww/w[[—¸mTã…Â\"óV²+uÅIÑóÿrîÜ¹ä‹NèB\0\0V„.„å_1ì¿sGİM&ë±?¹{­ÕyªkóŞt=ûü»O<¥†Äâ¥ıR¯|­UÍ2¾òÈ×jOºxñbòId¾\\\0ÀŠĞ…°œÄ™š2i­¿ Î&¿ùÄSS]])ko™C6ı®Î ÛïRWœP(”8‰L\0°|t!ÒAmjjjlllhhèüÁruÏ\ZÇ7¿u·5õ¬á‡l¨.p–]¹…ê›…‰ÉBùsœD\0`EèB¤CbÊ0‰ô÷÷Ÿ.9¨Ò0ëÑ¯÷ñ®4\neu7l…uuuêr0”\'¾YÈd!\0\0+B\"MÔ·\'&&FFFúúú$\rÕ	åıÎì{fÛb_7\\0F¯´ÈÊêBÙ<9\nÕå&²sù|³\0€U ‘&jÊPM‡Ã¡PèÒéº¬ÇşD]nüãßıêŞï={iÿÉÎNsÊByIVP÷)TÇö»’£Pv(»MœA¦\0X)ºécNÃö¶¶Ã¯½‘|Sk)¿œ¯ıé›O<µï™m2ä<Mä š&,şÉÏkORw¥!\n\0X/t!ÒjA\Zöõõuuu]½tÉ]àT\'ˆSyéõoüùÇ?Ï®©ªRW™\\¹rÅï÷Ëæ²¢\0€µ£‘nÉi822Òßßßİİ®]»ÖXßPSrğÓw÷Hÿ%†<=¶ß¥&eU„jšP6”Íe\'D!\0\0kGBƒD\ZNLLD\"‘¡¡¡¾¾>U‡ímmÒ|Wb.%QKä%YA¡l\"Êæ²¢\0€µ£¡‡JÃh4jüDŞØX¢{{{¥ùººº‚Á` ‰<•…ò’¬ ŠPMÊæ²¢\0€µ£¡ÍLÌ‚:”Ú–ìëé‹Qe¡¼$+ÈjŠ(\0`íèBh–\\‡SSS*•H’ÄBYAV£\0Xwt!l!Q‡bzzZ5â²P^RëP„\0\0¬;ºv4³İÇ\0Àföÿûš¶â§Sü)\0\0\0\0IEND®B`‚','10001','leave.png'),  ('10009','0','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process name=\"leave\" xmlns=\"http://jbpm.org/4.3/jpdl\">\r\n   <start g=\"196,25,48,48\" name=\"start1\">\r\n      <transition to=\"ç”³è¯·\"/>\r\n   </start>\r\n   <task assignee=\"#{owner}\" form=\"request.jsp\" g=\"172,118,92,52\" name=\"ç”³è¯·\">\r\n      <transition to=\"ç»ç†å®¡æ‰¹\"/>\r\n   </task>\r\n   <task assignee=\"manager\" form=\"manager.jsp\" g=\"175,217,92,52\" name=\"ç»ç†å®¡æ‰¹\">\r\n      <transition g=\"-32,-8\" name=\"æ‰¹å‡†\" to=\"exclusive1\"/>\r\n      <transition g=\"128,221;124,165:-42,-18\" name=\"é©³å›\" to=\"ç”³è¯·\"/>\r\n   </task>\r\n   <decision expr=\"#{day > 3 ? \'è€æ¿å®¡æ‰¹\' : \'ç»“æŸ\'}\" g=\"200,308,48,48\" name=\"exclusive1\">\r\n      <transition g=\"-39,-10\" name=\"ç»“æŸ\" to=\"end1\"/>\r\n      <transition g=\"339,342:-71,-17\" name=\"è€æ¿å®¡æ‰¹\" to=\"è€æ¿å®¡æ‰¹\"/>\r\n   </decision>\r\n   <task assignee=\"boss\" form=\"boss.jsp\" g=\"294,375,92,52\" name=\"è€æ¿å®¡æ‰¹\">\r\n      <transition g=\"339,457:\" to=\"end1\"/>\r\n   </task>\r\n   <end g=\"199,445,48,48\" name=\"end1\"/>\r\n</process>','10008','leave.jpdl.xml'),  ('10010','0','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0]\0\0í\0\0\0mLƒT\0\0>oIDATxœíİP[w~ğûg¦æ¿tv¦×íôÙ»wú<wÓ›§é<óìdïô¹ãÎ³wòìÌmÓtw›íööÙ´icß§Iw³]oÒİÍdC¥Á1IL,\'ÂÈ6ÙÆkÌâ`#Û`–mŒFXLd~jA\"ø~¾BÀü:úĞû5ßq¤£sGÊ?ïù£w\0\0\0¸ÿßé>\0\0\0\0Ø]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]fff¾ˆ™.B^RëÈÊº\0€ÍŒ.„ª%û&\'\'\'&&ÆÆÆîŞ½1‘…ò’¬ «ÉÊÔ!\0\0Ö¡‘n‰\"¼wïdß±úÂ]ûşúÿ{í?ÿõË¿ÿ—?úÒ_üğ·eÈy*å¥£ç‡††FFFdeÙ„:\0À\"t!Ò\'¹G##…eÏÿcöú«[şgŞùå\'ÿ£¼®àRğÄçwı2ä<•…ò’¬ «ÉÊwúBáp˜:\0À\"t!ÒDEáÔÔÔøø¸ëdÖs9ôw¯>òÎÁmí}çÃÓİKYAV“•e“ONfõ÷÷ŒŒÈNdW¤!\0\0ëˆ.D:¨(œœœËıè¯¾÷¯_v¸Ÿ[:ÍC6‘\reóŞŞŞááaÙ•ì4\0`½Ğ…°\\\"\nCƒÁŸüÛÿıüë{¯\\iª!Êæ²“Á–ÁÁÁH$B\Z\0°^èBX+…ÒpÒs/¿ûDßÄÕE¡\Z²¹ìDvuëÖ­Ò\0€õBÂZê;…ccc9ÅßyşõÇ×…‰4”]É%\reçê»†ºß+\0\0]ÍÌÌD£ÑñññıU?ÿŞ¿~yÕ§SP–:Oü¼»»{xxXş„ü!¦\0Xºúâ‹/îİ»şÍĞ?æüÑr/4‰®à2ÙíuÿµŞŞŞ‘‘ùCL\0°t!¬¢&ïŞ½ë8´íï^ıêàdçàäÍ©NƒòïäMãé¤ñÀx<¥†¼t3¶ÄXY6§SjcCcùÔìÂ©›²[Ùy èïï—?Ä”!\0\0kAÂ*ñÉÂpøvşo–>\Z÷4äih,ö¯z:[®–Œµ…ÆÛB³«Í­?_\'ñTv+;oiiééé‘?Ä”!\0\0kAÂ‰ÉÂCµ¿üÎ-M]¿ê\ZñÅÆeù÷–z<j<Poúâ+Œ^VëtK.ß2ÆÜÊ‰nÅ6i\n——Êëèè`Ê\0€5¢a	uoš‘‘‘¬ŸÚ¶ëÛÏ·ÕßPcğ¼\ZíƒòX-©o7FláPìqlÍØ¿çcËcO¯ª§òÒĞyÙù«>uíÚµÛ·oËŸS÷¬Ñıî\0ØèBXBâlbbbhÈ¸âDÒ°åÎg-¡Ø¸óÙÕÙ[xJ^\r}_áÎ©µ\\=ÅV‹­`l2û enóÏ$\nåO477ƒAùsòGéB\0\0V‡.„%¦§§ÇÆÆ~é÷Šı¨©çWM=Çcÿ\Z£Y=èN,”7Ç–4Ëcµ¼[­“ØjvIÒBYYv.âÂ…@@şœüQùÓºß=\0\0]K¨/öõõ=õâ—>mxëüÍOÏ+Îß¬¨Î\rcIğÓúà§êÁùøÂOeåØ\nê%õTøj‰5e¡ì\\şÄ¹sçÚÛÛåÏ©¯ê~÷\0\0lHt!,!q‰DB¡Ğ_üğ·k®ï¯”áıĞ¡Š==äí84ÿUYn,Q½‰ÍÅŸ\Zë+œjİ/Âëõúı~ùsòGéB\0\0V‡.„%’»ğ××>:}£ôô³£tŞÓãé™ÎtPNw0ª…ñõg_í8¼Y§úÚ>ùuuut!\0\0kDÂ‰.|êÅ/:—oô\\Gi<ò:TíIê©@,-ÂRõªzÂÙ<3›ŒñuâÛ8x6_ş„táõë×éB\0\0Ö‚.„%]øôO~ïİŠR§€½ÄÙáøY`u¹.0w9±BİÜjj…Ä8˜ôà ì\\ş]\0ÀÚÑ…°D¢ÿ!ûÑŸı?É—›ÔwÍ»ú$õ’¥—\'\rÙ¹ü	Î#\0°vt!,‘èÂWŠşìsşSâ5ê&5Í‰[Õ$ß[Ş¼pµÍÆøÕÂÛDv.‚ëN\0\0X;º–HÜ§æ“ê¬ïüø9ÓVÚr§vöÕñq-éßÙWk¯%VÕÎm2{OìÙÛ_×ª%uşRÙ¹óÄ/¸O\r\0\0kGÂ‰ûZ¿ÏúÃüOşßøOŞÅ\n/>æ~ohş«¦§ñ_ÆKzI–Èneç\'Nœà¾Ö\0\0¬]K$~/ø»g~ñ¿w^¾5â»5z¹Kşñu\\6cöiìÕøBY2ª†±$¾¡ñà²ÚCl\'—e·²óšš\Z~\0€µ£a	‰³ÉÉÉ‘‘‘Û·o·´\\ù‡ìG%à>÷‡Æı‰??n‹?kS/…â+´Í>n›[G-3–Ëe·Ç*ÖÕÕ]»vMşü9ù£t!\0\0«CÂ333ê+†ıııÛñ½ıò™–“ƒS7&oÊ˜ê4şì˜R;§:ã¯NŞˆ­il¢V6ÆÍØè<sí€ìğƒ£;N<yñâEùò‡Ô—åOë~÷\0\0lHt!¬òÅ_Ü»w/÷ôô´´´ìÜû­ç_¼oâFxº{Cv\"»’;v¬®®Nv.Bşü9&\0X5ºVI2MMM;Şùo/¿ûDª4¼µ¢(”È®***N:%»•3Y\0ÀÚÑ…°š2éííõûıŞ‹5ÒsÏ¿ş¸÷úÁÕÌF»eCÙ\\vräÄÁêêê††Ù­ì\\ş“…\0\0¬]©)ÃñññáááîîîÖÖÖóçÏgïıÖ÷şõË÷s+íBÙD6”Í?ıôÓ“\'OÊ®d‡²[Ù¹ü	&\0X#ºÖúâ‹/¦¦¦ÆÆÆoİºuíÚ5é¹âÊ—ş1çşîÕGŞ9¸­½ïüÒ9(+Èj²²l²÷ØKÕÕÕ²Ù•ìPv+;—?Ád!\0\0kDÂZ333ê5‘Hd``@J®µµµ¡¡áÔg5ƒÛş!ûÑ¿Ú±åæı—_~ò?Êë\n.O|~×/CÈSY(/É\n²š¬\\şiÙ±cÇN:%›ËNdW²CÙ­º7\r“…\0\0¬]Ë%§áàà`ww·ßïojjª««;yòdiÍk9Åµ}×şë—ÿ/ô¥¿øáoËòTÊK²Byy¹¡¬,›È†²¹ìDvE\0°èB¤C\"\rÇÆÆ†‡‡{{{@KKËÅ‹%õjjjNœ8QYY)ñwôèÑ#1ò@ÊByIVÕdeÙD6”Íe\'²+¢\0€uD\"MT\ZNMMŒŒô÷÷÷ôôttt\\»v­¹¹ùÂ…çÎóz½uIä©,”—dYMV–MdCÙ\\v¢¾SH\0°^èB¤JÃh4zïŞ½»wï†Ãa‰¼Û·oƒÁ@ ĞŞŞî¹£ËByIVÕdeÙD6”Íe\'D!\0\0ë‹.Dº-¨Ã‘‘‘¡¡¡¾¾¾‰,”—dY\"\0ÀRt!ôHÔáäääÄÄÄØØ˜d_ÄDÊK²‚¬F\0`)º:©:ÓÓÓÑEÈKjŠ\0\0KÑ…°Ç£û\0\0ÈPt!ì%++K÷!\0\0¡èBØ]\0€.t!ì….\0@ºöB\0 ]{¡\0Ğ….„D\"‘‚‚İG\0@†¢a#ápØápè>\n\0\02]¡\0Ğˆ.„Ğ…\0\0hDÂFèB\0\04¢a#………º\0€EÂF‚Á ÓéÔ}\0\0d(º6B\0 ]¡\0Ğˆ.„Ğ…\0\0hDÂFèB\0\04¢a#~¿ßívë>\n\0\02]ñù|G÷Q\0\0¡èBØ]\0€Ft!l„.\0@#º6B\0 ]¡\0Ğˆ.„ÔÆè>\n\0\02]¡\0Ğˆ.„Ğ…\0\0hDÂFèB\0\04¢a#t!\0\0\ZÑ…°‘šš\Z¯×«û(\0\0ÈPt!lÄãñø|>İG\0@†¢a#t!\0\0\ZÑ…°º\0\0èBØ]\0€Ft!l„.\0@#º6âr¹:::t\0\0Š.„8Î`0¨û(\0\0ÈPt!l„.\0@#º6B\0 ]ıvíÚ•5_QQ‘îƒ\0 ãĞ…Ğ¯¤¤$9\n9âv»u\0\0‡.„~wîÜÉÎÎVQ˜““S\\\\ÌÙd\0\0Ò.„-ª.t¹\\œD\0@º¶àóùvîÜ)]XRRÒØØ¨ûp\0\0ÈDt!ì\"///\'\'ç­·ŞŠF£º\0€LDÂ.ª««wîÜyäÈİ\0@†¢aÑh4\'\'gppP÷\0\0¡èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB¬ÀÌÌıãWºáiÚZP)ã·¶`óñxGóîú’†ÀØä´îÏ\0\0[£±,Cw\'_*»øğ‹Ní©·–ñı}§}£º?K\0\0lŠ.Äƒ¹\Z[v¸TZ=–SşJEÓÉ–ÏeNOÜ·óPÇùÆÉ«‰ÙÍ‡^(ş…§ifF÷g\n\0€ıĞ…XŠôÓÜõª¨xç„¯+¬=õV=ü½£O¿J½—\'ß«º;©ûÓ\0À^èB,EEáC/¿[s]{Ø­×¢:¾µ ’YC\0\0’Ñ…X”«! ¢PZJ{Ï­ãğu…Õiñ—Ê.êşŒ\0°º©İSñôÁ™ví%·îãL[Ÿô®¼»æ®AİŸ4\0\0vA\"5uùÉİÕÚÎ¢ñJE“:›¬û“\0À.èB¤069­¦Ó6ô…&KáÑi5!zéS†\0\0èB¤PŞTsiÚëÍÒñÜ\'^y›¯iÒıy\0`t!RØî2‚)§Ò§=İ,G/uËÛüãÜrİŸ7\0\0¶@\"uèMv²y„Â“ò6·ìpéş¼\0°º)|å§¥LşŞQíéfõP_£Ôıy\0`t!RP?\n¢ãgî\Zòòæ/é=°­ .\0Àzt!RP]hiJ·?WÚ»Ørùwk*)7YËPïT÷ç\r\0€-Ğ…HAc\Z„ù‡éš/¤\0H ‘‚5](…—r0f[rŞ¿yø¹TkåyéB\0\0¬B\"Ëºpû›©æ¥.Œ‡ãüyDæ\0Hº)hêÂØcoÁs¥\r‹Î,.˜V¤\0X?t!RĞyÙèB£ëòœ5nÈ[ï(¤\0HF\"İó…ñ.´z².\0 ]ˆlÒ…Ì\0Nt!RĞ}ùpŞÖ‚<æ\0H/º)hœ/ŒİÑÚ¸\0™ùB\0\0ÒŒ.D\nZïks]è-PÓ…ëşc\'t!\0\0ÉèB¤†.´É \0H ‘]\0@¢‘Â–.©%ï¨ön³z¨wªûó\0ÀèB¤ğxGjéL[Ÿön³zÈÛ|øE§îÏ\0\0[ 3ÈÛo¿ıË_şrïŞ½¥¥¥õõõ·nİZlÍï~pJ‚éƒ3íÚ»ÍÒq¡sPŞæ#¯Jçÿ\0\0l‹.Ì yyyY&æ5w×^—`zúıSÚÓÍÒñJE“¼Íí.oúÿ_\0\0`Ctayûí·“‹ğı÷ß—%7nÜ0¯ÙÙ?*ÁôĞÅÁş1íõfİx,§\\Şæñ«İéÿ\0€\rÑ…›ÙÄÄDGGGmm­Óé”ÌÏÏWE˜——÷ÙgŸíİ»7‰,¶í“ïUK3ısi½öz³h||> opË×øät:ÿ§\0\0`[táf‡[ZZ*++‹ŠŠ$].—ta0”—Î=+QXXXxüøñ²²²h4ºÄ~š»Õ”á…ÎAí\r·î#TW\"ï®½¦ÿ1\0\0Ø]¸„B¡ÆÆFI=GŒ<§²pÁj·oßÎÍÍ=xğ ”ârvûıNK9}å§¥›ìlòğèôÖ‚JykçyffÖÿ\0\0]¸QƒAÉ;—Ë•ŸŸ_TTTYYÙÒÒ‡—Şª  @V[æŸ›œV7¬yäÕC¾®°ö[—\nOª(Ü²ÃÕÙ?ºæÿ\0\0ltá†111á÷ûkjjöîİ›••åt:¥;::d¹u4Ğ7úXn¹ºÉß»5×µWİ\ZÇ¡Æ :},o§ùÖ uŸ\0\0]hkápØçóUVVæçç»İn¯×ÛÓÓ“Îc»7ıtìv†jâğ•Š¦\r÷Cïè\'¯ª«eHé2S\0€]h;’}õõõ’€‡Ããñ466h<¤™™û•Wº%\nUW©¡&Şl>ÌÇüæ¯¯òB\0\0R¢õ‹F£êË‚N§377wïŞ½UUU~¿‰›Èh!9U~)¸İåİE˜<~ÑùÌ¾Ó%\rnI\0ÀèB=¤ù¤ü¤ÿ¤¥Õ—¥—¾w\0\0€uèB\r¤\n\nÜnw}}}š¿,\0\0°ºP‡ÃñÀÊ\0\0\0¤]¨AQQ‘ù¦Ó\0\0\0zÑ…\Z8NõÃt\0\0\0öAjPVV¶ü\0\0HºPÇãóùt…UVVrE6\0\0ºĞ…\ZÔÆè>\n;âŠ\0\04¢5ğz½555ºÂèB\0\04¢5ğù|G÷QØWj\0 ]¨ßïw»İºÂ¸R\0\0èB\r$}$€t…Ñ…\0\0hDj000PXX¨û(ìÈívûı~İG\0@†¢5‡Ã‡C÷QØwğ\0@#ºğAÏîÉZBEÛªö*[®óqn\nt!\0\0\Zet&\'ŸôñtÏÙÁø‹mê‰,[hŞÁ*»077—8›ÕÔÔx½^İG\0@†Êè.L4ºppĞx´`\"Ğš.äF})qÇo\0\04Êğ.l«ˆ5_ü?±³]8»d¶œO]¶Ê.äF})Ñ…\0\0hDJßÅÒ¯-Ö}s™g¢ñ,©/¦Z¶2Ü%¥ÆÆÆÊÊJİG\0@†Êì.Œw]\"ïæÎÏŸ5]XVVÖÒÒ²oasá—`\0\0Ğ(ã»Ğtb8~bÙôıÂõ=Ì…·)Ñ…\0\0h”Ñ]˜ø2áŠŠäéAy6w©‰5ó…|‘.%~	\0\02ºç$Şìç^²àzd¯×[SS³ªM73º\0\0èÂ˜øyãØ¹b©ÀØç&-¸¯5\'LS¢\0Ğ(Ó»0q*¹¢¢\"+kŞÄ`[Ål#Z0_è÷ûİn÷ª6İÌø…@\0\04Êô.Ô…‰±”èB\0\04¢õ(,,Ô}¶‰D\n\n\nt\0\0Š.Ôƒ‰±Ådeeé>\0\02]¨\r”\0\0ºĞ…ÚäææF£QİGa;|,\0\0èBjãp8Âá°î£°>\0\0t¡µ)**\n…BºÂvèB\0\0t¡µq:Á`P÷QØ¹\0€.t¡6eee---ºÂvÈe\0\0t¡µñx<>ŸO÷QØ]\0€.t¡6µ1ºÂvÜn·ßï×}\0\0d\"ºP¯×[SS£û(l‡iT\0\0t¡µ‘ú‘Ò}¶C\0 ]¨ßïw»İºÂvjjj¼^¯î£\0\0 Ñ…ÚƒA§Ó©û(l‡¯]\0 ]¨ÍÀÀ@aa¡î£°º\0\0]èBmÂá°ÃáĞ}¶ÓØØXYY©û(\0\0ÈDt¡NYYYºÁv¸\0\0]èBrss£Ñ¨î£°º\0\0]èBG8Ö}öÂå8\0\0èBêTTT\n…t…]ìÚµ+k>ù|t\0\0„.Ô‰ßNVRR’…Gáş\0\0¤]¨SYYYKK‹î£°‹;wîdgg«(ÌÍÍ-..&š\0H\'ºP\'~ómÂÂBÕ…‡â$2\0\0iFêÄ=œJŞ¹s§êÂÆÆFİ‡\0@f¡uòz½555ºÂ^òòò¤wğ\0 ÍèB¸WŸYuuµtaUU•î\0 ãĞ…:ùı~.¹] \ZfggG\"İ\0@Æ¡uâÎ\0\0À>èB\nu\0\0€.Ô);İG\0\0` 5ËÊÊÒ}\0\0\0ºP³üüü²²²ÆÆF~(\0\0èEj‡[ZZ*++‹ŠŠ¤İn·×ëíééÑ}\\\0\0 ãĞ…6211á÷ûkjjöîİ›››ët:kkkíùÁ33÷_éş…§ikA¥ŒßÚşÍÇãy9Î¸ëK\Zc“Óº??\0\0ìˆ.´©h4*E(](u˜••%¥(½(Õ(í¨÷À†îN¾TvñáÚSo-ãûûNúFõ~’\0\0Ø\r]¸1ôôôx½^·ÛŸŸ_TTTYYÙÒÒ’ş›?»\Z[v¸TZ=–SşJEÓÉ–ÏeNOÜ·óPÇùÆÉ«‰ÙÍ‡^(ş…§if&Í!\0\0öEn<¡P¨±±±¬¬¬  Àápx<ŸÏ700`é•~ú»^Õïœğu…µ§Şª‡¿wôé÷O©÷òä{ÕCw\'-ıè\0\0Ø(èÂ-«Y.,,”Lt»İõõõV\\Ú¬¢ğ¡Šß­¹®=ìÖkQ\rßZPÉ¬!\0\0÷éÂÍ$‰øışªªª¢¢¢ÜÜ\\—Ëåõz×å²WC@E¡´”ö[Çáë\n«Óâ/•]\\û§\0ÀFGnNÑh´£££¦¦F]¶¢.m–%²|¥»º=<¦âéƒ3íÚKnİÇ™¶>é]ywÍ]ƒVü\0\0`¡3‚º´ÙåråææUUUùışe^¶¢Î ?¹»Z{ÃY4^©hRg“­ş¿\0\0€ÍÑ…\'\nÕ××»İî‚‚‚ÂÂÂÊÊJŸÏ‡S®<69­¦Ó6ô…&KáÑi5!zéS†\0€ŒFf´ÆÆFÇãp8œN§y…òæ šKÓ^o–ç>ñÊÛ|õHSúÿ\0\0`t!–²İeSN¥O{ºY:^ê–·ùÇ¹åº?o\0\0t¢±uèMv²y„Â“ò6·ìpéş¼\0Ğ‰.ÄR¾òÓR	&ï¨öt³z¨¯Qêş¼\0Ğ‰.ÄRÔ‚ØÿgîèB\0\0Ö.ÄRT®°±zlÛ~àæ¯nMÈË/Øºy[c“<oª½İ<ü\\~ƒ<”n®´×Xâ-Ø\Z[²Ò¡Ş©îÏ\0\0èB,e5]˜(3ïÂæ‹§[RÏ%V–°‹•ßlSš¶] ‰t!\0\0ë‡.ÄRVŞ…vu)\'ö¶&-OîÂ”ó…Ş‚¹ˆ4\r‘uù‰M\n˜»p…H\0@b)+íÂ¤i¿¤3¿FüÍÅÎšv›:“æãS’Û¶;”İn;`¾\0€• ±”váÜwãgLnİšX-W¥˜4Ï·ı@éâß/\\üTò\\q¦<lüÅŸJ¦\0 ±”Õ¿PáüI;£U±-g¾0éTrò|áìš‰ÓÓ‹œG¦\0X!ºKYq.ón¢“Î/¼âøAó…ñyG®;\0`Ğ…XÊªÏ#uh»D2š¾˜â4ñ2çíÂ†¼•|Å.\0€.ÄRVuÿÂ…£.ßt)IüüïÜòUÌ¦èBIIuİ‰z‰.\0`%èB,e5]hj¾ù]Ø›|\rJb¤ìÂÍÎMRrŸ\Z\0\0V….ÄRVsYÍÒÅëp¡y·›Ydó7SŞ§Fµ Z^—ŸÍ†<ó´\"]\0À2Ğ…XÊºœGŞƒ.\0€.ÄRèB\0\02]ˆ¥lÙá’Zò÷jï6«‡z§º?o\0\0t¢±”Çó<RKgÚú´w›ÕCŞæÃ/:uŞ\0\0èDb)ßıà”ÓgÚµw›¥ãBç ¼ÍG^=¤ûó\0@\'ºKÙ]{]‚éé÷OiO7KÇ+Mò6·»¼º?o\0\0t¢±”ÎşQ	¦‡^(öi¯7ëÆc9åò6_íÖıy\0 ]ˆxò½ji¦.­×^oÏä\rnÙá\ZŸœÖıa\0 ]ˆhî\ZTS†:µ7ÜºPxR]‰¼»öºîO\Z\0\0ÍèB<Ø÷?:-åô•Ÿ–n²³ÉÃ£Ó[*å­=ç™™Ñı)\0 ]ˆ›œV7¬yäÕC¾®°ö[—\nOª(Ü²ÃÕÙ?ªû3\0@?ºËè},·\\İäïİšëÚ«nãPcP>–·Ó|kP÷§\0€-Ğ…X®±{ÓOÇng¨&_©hÚpß8ô÷¾qòªºúX†”.3…\0\0$Ğ…X™™û•Wº%\nUW©¡&Şl>ÌÇüæ¯¯òB\0\0’Ñ…X1É©òKÁí.ï†(Âäñğ‹Îgö.ipK\Z\0\0ÌèB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èBØTeee4\ZÕ}\0\0dº6åp8Âá°î£\0\0 ƒĞ…°)º\0€4£aSt!\0\0iFÂ¦èB\0\0ÒŒ.„M…B!İG\0@¡aSN§3ê>\n\0\02]›¢\0H3º6E\0ft!lŠ.\0 ÍèBØ”Ûíöûıº\0€BÂ¦<ÏçÓ}\0\0dº6E\0ft!lŠ.\0 ÍèB¬ÁàÙ=mê¿{Î\ZKÚ*²bKYÛXknå%Ñ…\0\0¤]ˆ5xPÊ³¹§s/-«kjj¼^¯\r\0\0R£±JFóÅUœ5wáìiÀØƒ¤Õ“í9»ØşkcÒó^\0\0À}ºk’4_Ï¼=±\n”œ7!}vêp©“Í	t!\0\0iFb\rRGN\nÀ¸X¦œ0\\ât2]\0@šÑ…XƒÙyÀç‘M’^a¾\0\0;¢±Jñù¿^<{Ny¥ó…•••Ö¾\0\0„.Ä\Z,u=r[ÅlÎ¿åş2ç}>ŸÇã±êÈ\0€	]ˆ5XĞ…’‚êº“Ä¢¤;ÒĞ…\0\0Ø]ˆ5Xp=²$àüéÁä\0\\äF5‹í›.\0 ÍèB¬’jA58.p¶øR\\”¼‚ıÓ…\0\0¤]›\nƒN§S÷Q\0\0AèBØ]\0@šÑ…°)º\0€4£aSt!\0\0iFÂ¦èB\0\0ÒŒ.„M…Ãa‡Ã¡û(\0\0È t!lŠ.\0 ÍèBØÎ®]»Üüº¨¨H÷A\0°ùÑ…°’’’ä(<räˆÛíÖ}P\0\0l~t!lçÎ;ÙÙÙ*\nsss‹‹‹ƒÁ îƒ\0`ó£aG………ª:ÄId\0\0Òƒ.„ù|¾;wª.lllÔ}8\0\0dº6•——\']èp8¢Ñ¨îc\0 #Ğ…°©êêjéÂªª*İ\0@¦ aSÑh4;;;‰è>\0\02]\0\0\0]\0\0\0];š‰ùÂD-×}t\0\0lNt!lGáğpph(Ğß×)c2&\ZNOO«:Ô}Œ\0\0lBt!ìe6\n;?zï«‰q»Ç‰DÆÇÇ¥IC\0\0,BÂFT\r¤÷íş½âwÿ½yğÑÿØ¸‡¥\'&&¢Ñ(i\0Àº£aæ(¼ìs\\¾äH¤áöÆÑÑQÒ\0\0+Ğ…°…QxÉ1<r6ü›sF\Zî6Ò°x÷hó_4!\r\0Xwt!ôK…R„Ò…æ4ô_o \r\0°]Í›)şÍ¹‘»Mwï6\rÇ‘4\0Àjt!tZl¦PÆİXª¡&IC\0\0,EB›EOÇ¢pdv¨Çê´òei\0€UèBè‘\"\n¯¼|úønR&ÒĞø®á•·IC\0\0¬@Bsú.¿54|f8|f4Ò`ŒÑ‹2Â£ÔÓÄYA†¬L\Z\0°îèB¤›9\n›/½>0ø™ŒáğycŒœ?H5Ôš²	i\0Àú¢‘Væ(¼p1ÿó¾“2îÜ9şiÉÿ)k~õ7Cƒ§û‡æ\rY(/É\n²Z(¶¾lH\Z\0°èB¤9\n/6äÜî®¼İ{¬ûö…jTZâ/1äiâ%YMVîùÜØJ6\'\r\0X/t!ÒÄ…çvöÜ.v—Käşäë‰ò‹§aåwdù­Û•ò`ÁK²²¼¤¶•†\0\0¬ºé`Â³ç~v3è–!m\'cAù©qòø·e¤|©ëVEWwEÇÍƒ²Ùi\0ÀÚÑ…°œ9\nÏœ~¹½Ãu£½DÂNGş2eÿ¥²rbÃ.Ù•ì0MiØV±çìà*^3<»\'«¢m‘Wb/Èãûk«XdU\0\0Ö]k©(îLŠÂ­mÉh%]b÷<¹œ(”ÕÚÛÌmØ~@íÍœ†£££’†ÓÓÓr\0ëö~–Ó…Fò™HØIŞ-)Ş~t!\0@ºÖ’.&GaËµd´¶9e\\kÛßÚ¾ïzÛşëíÆ8^ñgˆÂŠ?ó·ï7¶mß\'ÿÊ†Æ¿íûÕ>?«Ù‘HÃ6ÿIÃH$299)i¸Ö·‘*éŒh‹·Û¼ÜSQ±\'e<.9Ÿ¨j0éïTœ5w!\0°]kÅÏ ïù…Òm-×öÈ¸~ı#-×÷ÊPO+Ëÿ|±(”—’W^°¡Ú³JÃ½…pår]ooo8F£ëö~æÚ.Ö‚É¡—˜ß››è[Ê¢k%ÍÆCsÏøtã\nÎS\0°bt!¬%]Øß×©ºğÌé—ÕÄŞõöıj¦P†¿}|\n°Íé_rÊP^’\rÕVj¾PÍ5\ZÿÎNª³ÉÒ…M§ºººS†ky)O/œ8œ[­¢-Å³A·ø©ä¹yÀ”ç‘ç­\0€%èBX+Ñ…‰ËÕ×ot¸Ô%#7VòCãË…±MnÌßPí3qa²táÅ‹¿îìììëë]cÎ§¢ÏÜhm{ö\'ÿG>;wÒx6ôîÏ;•œ<_˜´F\"0SG\0ÀJt!¬%](Yv»Ç_¼û?Ä¾ù÷ïÏUÅ\\âšâ]’œ|1rò%É²ÛDÖ9ÖÒÒ¢ºğğáÃ}ô‘Óéôx<µ1òR0fbbbï$>Õ7w*×vI×¨@4Wİƒæã¯sİ	\0@ºÖR]‰D:—ix¾açÍ Û¸û`·qÂ`wùb÷)\\ì¾†]·*ŒmåßØM?|\"QX[ëinnnmmUç‘{{{;::¤}>ŸêÂ²²2gL~~¾j²½{÷ª%555j===÷çZílÒ÷gÏÆ»°í¬¼2[‚ñŒSßœÿ5ÂeÎ.Ú…Æö–ÿ?\0d*ºÖ’.ŒF£ãããápøF{c\"\r/\\Ìï¾]Şs»üÖmãGMRö_uåwÌ?v¢†ñ{\'³?y’ø¡d‰ÂÏ>«¸páBKK‹´àò¯;‘şS!èõzUªL”^Tá(ét~èØ¥½±ÿxmcc£±Áå£»İÍ³»‰Gß\\ÏÅrŞLß*¾_;A9¶h=ÿ÷\0\0„.„µfff¦§§Õ”áÀÀ@›ÿB\"\r›/½®ò.Ôw2ùÇ‘÷Íÿ‰ääGŞ7ûÉŸ÷¼İ{L†ìdA^¹råÆ’zëxŸš‰‰	£ßyçÓ‹~•••ÎX*æä¿¥Â®°ğ­7v9>üĞñzÖ¿–5ï;+ëã£GßÉÊ*o\rÓÎÆO\\sŸ\Z\0@ZĞ…°–º¯µ”™¤Õèè¨´šÿzC\"\r}—Ş”Â“qçÎñä4¬ùÕßô\Z<\Z¬•ò49\neeµ•lnÂöööîîn+îkêÂä¹sÄ?~çèÑ³>¨¬|/6«ø±Û›vü0{g|mç¬X7¾QğI•š§…BÉbŞéèû÷“§ÉB\0€uèBXN¥a4\Z•JY˜†Ío~&£¿¿Z¥¡Tàpøü‚¡ÒPVÕÔú²áQhÏŸHÎR“555*‹ŠŠTö¨%eeejŸÏ§6‰D\"º\0°ÉÑ…H‡¥ÓğÊ•Ÿ‘½ c4Ò #şxô¢zjŒØã¡á32d“\r…Ë!ñ§*°¥¥Eu¡ÇãQ¥(É¨ÚQ\"R-©ªªRë¨k„îÃ\0llt!Òdé4¼zõİá‘³2Fî6©qwöß»³e„sNÖ‘•7e.S(RX__¯ºĞår©RTá˜››«Êrµ‚¬©6‘ÏG÷á\0ì‹.Dú,?\r!˜üx˜(\\yûª;::TVUU©R,,,LL:ê>L\0€íĞ…H«¦¡1#ø›swçÏ\ZQ8rV^\"\n×‹¤¡îC\0\0Ø]ˆt[Î¬¡$`ò|¡šG$\n×]\00£¡ÁŠÒ(´]\00£¡Ç2ÓÓÇ¡\0ft!´YÎw\r‰B‹Ğ…\0\03º:=0\r‰B‹Ğ…\0\03ºš-†‰(¬­õ…ëˆ.\0˜Ñ…Ğo±4”T£îÌ±æææ–––7n…ë‚.\0˜Ñ…°s\Z¶ù/\\¹\\×ÔxêâÅ_K¶¶¶vttôôô…ë‚.\0˜Ñ…°‹ä4•şëíííêêêŒ‘òTÊKDáÚÑ…\0\03º6’œ†‘H$KöÅÈy*‰ÂuA\0ÌèBØ‹JÃéééÉÉÉññq	ÁÑy Oe¡¼D®]\00£a;‰4ŒF£“Iä)Q¸^èB\0€][óx<ºas¢\0ft!l|±,\0ÀŒ.„­‘/áƒ\0˜Ñ…°5òÅ\"|°\0\03º¶F¾X„\0`FÂÖÈ‹ğÁ\0ÌèBØW8v8ºbs¢\0ft!ì‹.´]\00£a_t¡uèB\0€]û¢­C\0ÌèBØ]hº\0`FÂ¾B¡PQQ‘î£ØTvíÚ•5Ÿ0\0 .„}ƒA§Ó©û(6•’’’ä(<räˆÛíÖ}P\0\0» a_táº»sçNvv¶ŠÂÜÜÜââbùu\0À.èBØ]h…ÂÂBÕ…‡â$2\0 ]û¢­àóùvîÜ©º°±±Q÷á\0\0l„.„}Ñ…ÉËË“.t8ÑhT÷±\0\0l„.„}ù|>Ç£û(6¡êêjéÂªª*İ\0°ºöEZ$\ZfggG\"İ\0°ºöE\0Nt!ì‹.\0 èBØ]\0@:Ñ…°¯úúz®\0\0 mèBØWmŒî£\0\0 SĞ…°/º\0€t¢a_Ş…33÷_éş…§ikA¥ŒßÚşÍÇãy9Î¸ëK\Zc“Óº??\0ÀŠÑ…°¯ŒíÂ¡»“/•]|øE§öÔ[Ëøş¾Ó¾QİŸ%\0`èBØWfv¡«!°e‡K¥Õc9å¯T4lù\\ÆğèôøÄ};uœoœ¼š˜İ|è…â_xšfft¦\0€å¡a_Ççóé>Šô‘~ú»^Õïœğu…µ§Şª‡¿wôé÷O©÷òä{ÕCw\'uº\0€£a_™Ö…*\nz¡øİšëÚÃn½fÕÙğ­•Ì\Z€ıÑ…°¯ŒêBWC@E¡´”ö[Çáë\n«Óâ/•]Ôı\0€.„}eNŞSñôÁ™ví%·îãL[Ÿô®¼»æ®AİŸ4\0`)t!ì+sºPA~rwµö†³h¼RÑ¤Î&ëş¤\0K¡a_n·Ûï÷ë>\nËMN«é´\r}¡ÉÒcxtZMˆ^ºÅ”!\0Ø]ûr:Á`P÷QX®¼9¨æÒ´×›¥ã¹O¼ò6_=Ò¤ûó\0,Š.„}eHnwÁ”SéÓn–£—ºåmşqn¹îÏ\0°(ºö•!]¨î½É.C6PxRŞæ–.İŸ7\0`Qt!–¯­\"«¢-éùàÙ=ó›VßsvM_&Ë.üÊOK%˜ü½£ÚÓÍê¡¾F©ûó\0,Š.ÄrI.è¼](Ùø\0KUd\nÒ…êGAìÿ3wt!\0lzt!–)1Y(5˜ªùÌsƒk/t8ápx-{ØT®2¶¼Ï•ö.òjCŞ¶Ãåîª÷À¶­yŞT/İ<ü\\~ƒ<”nÿ-oÁÖØ’•õNuŞ\0€EÑ…X–Ù©Áy“†æóÈ‹4cên| ºp}ºPÂn«‰„äİ’â™H@Æ ±,Iu—2şs‰s¥˜<_¸ª¹Cºp‰4gœmÒpF\Z“sËóK9q¸TS\Z(]X—ŸØMÁs®0éB\0°9ºË5xöì¿H®Â:ÍÆZ0¹ÿâ˜ô`É17¸`$ÍÆCsÛöøtã\nÎSÓ…\0°Ğ…X–¤)ÂŠ¶†ñ\Zä<ò*¬´}¶•w³«Ô¥8¼ıÀÍEççDXä<òÖ­«8•L€ÍÑ…X¹…ß+Lq¿\Zã{ˆ1+½9Y~~şÄÄÄª7ß(Ö4_?e\\P·pyCŞ¶íÆ4¡·@G>?Û‚Æ&³ë\'JN/T\'‘çºp±óÈt!\0l.t!–mv2°âìR]¨îVcÌªsÇ±ç«»0Y6\\ûQÛß*»0>Õ—¨=sØ%]w¢Ñ\\uš/Œ¿ëN\0 3Ğ…X–yq·ÈydU„)¿_ßb…s‡taÊ1Ûj‡lSQ8{•I~Càf¼ëJ¥g»0q\ryFDöÎnµ’ùÂE»pE·Â¡ÀîèB¬Ü2Î#Ö|ÿBºpÉ‘¸è8©óf.9Úæz.vFxŞM\nWñıBIIuİÉÄr¯h¡`£ a_táƒº0©Ms~ñ.4Z0ömB…¥óÓp…ó…F0ÆNIsŸ\Z\0Ø”èBØ]¸ôHuarr)\Z]x «ñEÃ­É·°‰M4šz.å}jÔŸPËëòAÛá‚iEº\06>º6‡‡î£H‡µ]¼‘]\06GÂ¦èÂÍ7èB\0°9º6•9]¸e‡KjÉß;ª½Û¬êêş¼\0‹¢aS™Ó…çy¤–Î´õiï6«‡¼Í‡_têş¼\0‹¢aS™Ó…ßıà”ÓgÚµw›¥ãBç ¼ÍG^=¤ûó\0,Š.„M…B¡¢¢\"İG‘»k¯K0=ış)íéféx¥¢IŞæv—W÷ç\r\0X]›\nƒNgFœsìì•`zè…â`ÿ˜öz³n<–S.oóøÕnİŸ7\0`Qt!l*sºP<ù^µ4Ó?—Ök¯7‹ÆÇçò·ìpONëş°\0‹¢aSÕ…Í]ƒjÊğBç ö†[÷\nOª+‘w×^×ıI\0–BÂ¦2ªÅ÷?:-åô•Ÿ–n²³ÉÃ£Ó[*å­=ç™™Ñı)\0–DÂ¦2­Ç&§Õ\rkyõ¯+¬½çÖe„Â“*\n·ìpuöêşŒ\0@Â¦|>ŸÇãÑ}iè},·\\İäïİšëÚ«nãPcP>–·Ó|kP÷§\0x0º6•](ÆîM?»¡š8|¥¢iÃ}ãĞß;úÆÉ«êêcRºÌÀFAÂ¦2³ÅÌÌıÊ+İ…ª«ÔPo6æc~ó×WùN!\0l t!l*c»P‘œ*¿Üîònˆ\"L¿è|fßé’†\0·¤€\r‡.„Mex\0~t!lª¾¾¾ªªJ÷Q\0\0AèBØTmŒî£\0\0 ƒĞ…°)º\0€4£aSt!\0\0iFÂ¦èB\0\0ÒŒ.„MÑ…–âZo\0€]›’pñù|ºbÓÊÊÊÒ}\0\0Û¡aSt¡¥èB\0€]›¢-E\0ÌèBØ]h)º\0`FÂ¦èBKÑ…\0\03º6åv»ı~¿î£Ø´èB\0€]›r:Á`P÷QlZt!\0ÀŒ.„MÑ…–¢\0ft!lŠ.´]\00£a/»víÊš¯¨¨H÷AmBt!\0ÀŒ.„½”””$Gá‘#GÜn·îƒÚ„èB\0€]{¹sçNvv¶ŠÂœœœââbÎ&[.\0˜Ñ…°ÂÂBÕ….—‹“È¡\0ft!lÇçóíÜ¹SÂ¥¤¤¤±±Q÷álNt!\0ÀŒ.„ååååää¼õÖ[ÑhT÷±lNt!\0ÀŒ.„UWWïÜ¹óÈ‘#ºdÓ¢\0ft!ì(\Zæääê>M‹.\0˜Ñ…@&¢\0ft!‰èB\0€]d\"º\0`F™ˆ.\0˜Ñ…°£™Eè>®Íƒ.\0˜Ñ…°•}_ÄLOOG£Ñ)Y(/©uÈÄ5¢\0ft!4K¡dßØÈhçÅæ–_×şpíûûÔ§7Î_MLLÜ»wO5\"u¸t!\0ÀŒ.„6‰\"”<÷qéŞï=ûãßıêûM9ä¥÷¿ı·Ò‹}½½‘HD\ZQ‘:\\5º\0`FBU„Òvµïï{å‘¯%÷ßëÿõ¿;¾ù-×³ÏËò4¹eåªwöö˜ëP÷{ÚHèB\0€]\rTö¶¶íúú7Tíıä÷ÿpß3Û®|\\2ÑÑ1İİ½`ÈÂKûÈ\n‰@ÌùÚŸ¶Ö\Z\Z’:œ˜˜˜šš\"\rW„.\0˜Ñ…H7…—U©È{ñKÿ›ûŸş%ì»lÎAóÕ\\Ï>/›¨™ÅÓ%ûûûGFFÆÆÆHÃ¡\0ft!Ò*…ªív}ı½g¼Ë)ÂäÑS{&çkªšòÔş’P(‡IÃ¡\0ft!ÒGEaË¯kU¾ÿí¿MyÖx9C6,|ò»*\rO—$\r311Œill¬qÆäççë>4\0€íĞ…H“Äw\n_şò£Òso~kª«kuQ¨†lşæO©ï&^:]—±i(ïZ•ŸÊ¾ÊÊÊDùeeeÉ¿ê©,W+¨•e+İ\0°ºi\"¡611¡Îÿf=ö\'w[[SÖ^ÃÅÚ¼7ßÿöß¾ûÄSj¸}şBaQÊ•e\'Y~]í°½­­¯¯oddDşJ4\ZİL]ØÓÓ#%ç÷ûUØ¹İné¼½{÷fÅ8U~êÕÆÆFU~ò9è>p\0ÀC\"ÔdáÉ7ß•†ûÑïüAÊïJäI.vÿÂ—¿ü¨ô¢y+Ù•ìPVøøçÙCııı‘HäŞ½{hÊp±S½|ªü$å©ä zUQV–XÔ}à\0€Í†.D:¨›W«3ÈGü3sŞu×ÔªW—ïûoÍ?ø‰:›|õÒ%ÙÓĞñË(ê¦†ºßw§z\0]Ë©ÉÂÓîWõ6z¥e²³3yUµœ(Tã—_ÿÆ‚Íe‡ê–7‡_{#„B¡‘‘‘Å¦\'&&ÜnwYYÙú¾GNõ\06º–“8‹F£o~KÒÍõìów[[Œ_ÎŞİz™ãè6o×Z÷=³Í¸ëÍÿõÍk×®%O.èÂšššììlÕj+zœê\0dº–S\'‘Õ½i®¸„›šÂM±›Â\'_ÉYQªüU•lßOcÓ•KÔ=kš\Z.¾¾¾H$¢.LVÇĞÚÚúúë¯g%Ypœê\0€.„å$Înœ¿ ~¡¤ÿÌ™#ùÇ‘—?\\Ï>¿`?êê“cû]ímm½½½‰SÉ………Y&œê\0`º–›>°\\¢íõÿúßoW0Æ‰*5.­\"\neHMö?nìdv‡ê§–İäSÉò§_{í5s\nNõ\0°\0]k©/Ö¾¿O]M|óÓO“ÇÑÿlu](cÁ®Ô÷?şyö•+W$ø_1nllt»İ999»wï~ï½÷ä¿\0€]kINMMÚS,Ñ¶÷{ÏŞ8p y¸şæïWİ…çò’w%Ñ©ºğÒ¥K@ ¿¿_ıöIò¥\'UUU………ü\n\0\0ft!¬µ ıû÷\'5vaò®taâÒ“rwk\0\0´£a­ä.,|ò»æÕ-©W7ì*q™.\0`uèBXKuaâº“_\n\\Ëu\'v¥~yùğkoĞ…\0\0¬]k©.l­;÷ÃØ}jŒ‹ˆÕÄ³c•÷©ù›¿_Ô»Yv›¸O\r]\0ÀêĞ…°–êÂğàº¯õ…Â¢÷\\İ}­o~úiòNÔ¼£ü‰ÚS§–¸î\0\0,.„µÔ}j$ÑŞ|â)I·}Ïl7\Z¿Pò›¤óc§€—?*~ğ“Ø/4ÎştJãŞï=+Ëw}ıçÎ[pŸ\Zº\0€e¢a¹ééiI´ªwöHºıä÷ÿp ¾aÁï#<Ç^şò£ËŒÂwşÛŸß½6osÙá÷«òRñO~.]¸à¾Öºß=\0\0]Ë}ñÅ÷îİëëí•(”zsÿÓ¿Lvv.Á_Ue=úõF¡1İè»¼`[×³Ï«â¬©ªºxñ¢ßïOş<İï\0€\rƒ.„åTŒ~í\r	¸ıÎt×ÔNww/w[[—¸mTã…Â\"óV²+uÅIÑóÿrîÜ¹ä‹NèB\0\0V„.„å_1ì¿sGİM&ë±?¹{­ÕyªkóŞt=ûü»O<¥†Äâ¥ıR¯|­UÍ2¾òÈ×jOºxñbòId¾\\\0ÀŠĞ…°œÄ™š2i­¿ Î&¿ùÄSS]])ko™C6ı®Î ÛïRWœP(”8‰L\0°|t!ÒAmjjjlllhhèüÁruÏ\ZÇ7¿u·5õ¬á‡l¨.p–]¹…ê›…‰ÉBùsœD\0`EèB¤CbÊ0‰ô÷÷Ÿ.9¨Ò0ëÑ¯÷ñ®4\neu7l…uuuêr0”\'¾YÈd!\0\0+B\"MÔ·\'&&FFFúúú$\rÕ	åıÎì{fÛb_7\\0F¯´ÈÊêBÙ<9\nÕå&²sù|³\0€U ‘&jÊPM‡Ã¡PèÒéº¬ÇşD]nüãßıêŞï={iÿÉÎNsÊByIVP÷)TÇö»’£Pv(»MœA¦\0X)ºécNÃö¶¶Ã¯½‘|Sk)¿œ¯ıé›O<µï™m2ä<Mä š&,şÉÏkORw¥!\n\0X/t!ÒjA\Zöõõuuu]½tÉ]àT\'ˆSyéõoüùÇ?Ï®©ªRW™\\¹rÅï÷Ëæ²¢\0€µ£‘nÉi822Òßßßİİ®]»ÖXßPSrğÓw÷Hÿ%†<=¶ß¥&eU„jšP6”Íe\'D!\0\0kGBƒD\ZNLLD\"‘¡¡¡¾¾>U‡ímmÒ|Wb.%QKä%YA¡l\"Êæ²¢\0€µ£¡‡JÃh4jüDŞØX¢{{{¥ùººº‚Á` ‰<•…ò’¬ ŠPMÊæ²¢\0€µ£¡ÍLÌ‚:”Ú–ìëé‹Qe¡¼$+ÈjŠ(\0`íèBh–\\‡SSS*•H’ÄBYAV£\0Xwt!l!Q‡bzzZ5â²P^RëP„\0\0¬;ºv4³İÇ\0Àföÿûš¶â§Sü)\0\0\0\0IEND®B`‚','10008','leave.png'),  ('20002','0','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process name=\"leave\" xmlns=\"http://jbpm.org/4.3/jpdl\">\r\n   <start g=\"196,25,48,48\" name=\"start1\">\r\n      <transition to=\"ç”³è¯·\"/>\r\n   </start>\r\n   <task assignee=\"#{owner}\" form=\"request.jsp\" g=\"172,118,92,52\" name=\"ç”³è¯·\">\r\n      <transition to=\"ç»ç†å®¡æ‰¹\"/>\r\n   </task>\r\n   <task assignee=\"manager\" form=\"manager.jsp\" g=\"175,217,92,52\" name=\"ç»ç†å®¡æ‰¹\">\r\n      <transition g=\"-32,-8\" name=\"æ‰¹å‡†\" to=\"exclusive1\"/>\r\n      <transition g=\"128,221;124,165:-42,-18\" name=\"é©³å›\" to=\"ç”³è¯·\"/>\r\n   </task>\r\n   <decision expr=\"#{day > 3 ? \'è€æ¿å®¡æ‰¹\' : \'ç»“æŸ\'}\" g=\"200,308,48,48\" name=\"exclusive1\">\r\n      <transition g=\"-39,-10\" name=\"ç»“æŸ\" to=\"end1\"/>\r\n      <transition g=\"339,342:-71,-17\" name=\"è€æ¿å®¡æ‰¹\" to=\"è€æ¿å®¡æ‰¹\"/>\r\n   </decision>\r\n   <task assignee=\"boss\" form=\"boss.jsp\" g=\"294,375,92,52\" name=\"è€æ¿å®¡æ‰¹\">\r\n      <transition g=\"339,457:\" to=\"end1\"/>\r\n   </task>\r\n   <end g=\"199,445,48,48\" name=\"end1\"/>\r\n</process>','20001','leave.jpdl.xml'),  ('20003','0','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0]\0\0í\0\0\0mLƒT\0\0>oIDATxœíİP[w~ğûg¦æ¿tv¦×íôÙ»wú<wÓ›§é<óìdïô¹ãÎ³wòìÌmÓtw›íööÙ´icß§Iw³]oÒİÍdC¥Á1IL,\'ÂÈ6ÙÆkÌâ`#Û`–mŒFXLd~jA\"ø~¾BÀü:úĞû5ßq¤£sGÊ?ïù£w\0\0\0¸ÿßé>\0\0\0\0Ø]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]fff¾ˆ™.B^RëÈÊº\0€ÍŒ.„ª%û&\'\'\'&&ÆÆÆîŞ½1‘…ò’¬ «ÉÊÔ!\0\0Ö¡‘n‰\"¼wïdß±úÂ]ûşúÿ{í?ÿõË¿ÿ—?úÒ_üğ·eÈy*å¥£ç‡††FFFdeÙ„:\0À\"t!Ò\'¹G##…eÏÿcöú«[şgŞùå\'ÿ£¼®àRğÄçwı2ä<•…ò’¬ «ÉÊwúBáp˜:\0À\"t!ÒDEáÔÔÔøø¸ëdÖs9ôw¯>òÎÁmí}çÃÓİKYAV“•e“ONfõ÷÷ŒŒÈNdW¤!\0\0ëˆ.D:¨(œœœËıè¯¾÷¯_v¸Ÿ[:ÍC6‘\reóŞŞŞááaÙ•ì4\0`½Ğ…°\\\"\nCƒÁŸüÛÿıüë{¯\\iª!Êæ²“Á–ÁÁÁH$B\Z\0°^èBX+…ÒpÒs/¿ûDßÄÕE¡\Z²¹ìDvuëÖ­Ò\0€õBÂZê;…ccc9ÅßyşõÇ×…‰4”]É%\reçê»†ºß+\0\0]ÍÌÌD£ÑñññıU?ÿŞ¿~yÕ§SP–:Oü¼»»{xxXş„ü!¦\0Xºúâ‹/îİ»şÍĞ?æüÑr/4‰®à2ÙíuÿµŞŞŞ‘‘ùCL\0°t!¬¢&ïŞ½ë8´íï^ıêàdçàäÍ©NƒòïäMãé¤ñÀx<¥†¼t3¶ÄXY6§SjcCcùÔìÂ©›²[Ùy èïï—?Ä”!\0\0kAÂ*ñÉÂpøvşo–>\Z÷4äih,ö¯z:[®–Œµ…ÆÛB³«Í­?_\'ñTv+;oiiééé‘?Ä”!\0\0kAÂ‰ÉÂCµ¿üÎ-M]¿ê\ZñÅÆeù÷–z<j<Poúâ+Œ^VëtK.ß2ÆÜÊ‰nÅ6i\n——Êëèè`Ê\0€5¢a	uoš‘‘‘¬ŸÚ¶ëÛÏ·ÕßPcğ¼\ZíƒòX-©o7FláPìqlÍØ¿çcËcO¯ª§òÒĞyÙù«>uíÚµÛ·oËŸS÷¬Ñıî\0ØèBXBâlbbbhÈ¸âDÒ°åÎg-¡Ø¸óÙÕÙ[xJ^\r}_áÎ©µ\\=ÅV‹­`l2û enóÏ$\nåO477ƒAùsòGéB\0\0V‡.„%¦§§ÇÆÆ~é÷Šı¨©çWM=Çcÿ\Z£Y=èN,”7Ç–4Ëcµ¼[­“ØjvIÒBYYv.âÂ…@@şœüQùÓºß=\0\0]K¨/öõõ=õâ—>mxëüÍOÏ+Îß¬¨Î\rcIğÓúà§êÁùøÂOeåØ\nê%õTøj‰5e¡ì\\şÄ¹sçÚÛÛåÏ©¯ê~÷\0\0lHt!,!q‰DB¡Ğ_üğ·k®ï¯”áıĞ¡Š==äí84ÿUYn,Q½‰ÍÅŸ\Zë+œjİ/Âëõúı~ùsòGéB\0\0V‡.„%’»ğ××>:}£ôô³£tŞÓãé™ÎtPNw0ª…ñõg_í8¼Y§úÚ>ùuuut!\0\0kDÂ‰.|êÅ/:—oô\\Gi<ò:TíIê©@,-ÂRõªzÂÙ<3›ŒñuâÛ8x6_ş„táõë×éB\0\0Ö‚.„%]øôO~ïİŠR§€½ÄÙáøY`u¹.0w9±BİÜjj…Ä8˜ôà ì\\ş]\0ÀÚÑ…°D¢ÿ!ûÑŸı?É—›ÔwÍ»ú$õ’¥—\'\rÙ¹ü	Î#\0°vt!,‘èÂWŠşìsşSâ5ê&5Í‰[Õ$ß[Ş¼pµÍÆøÕÂÛDv.‚ëN\0\0X;º–HÜ§æ“ê¬ïüø9ÓVÚr§vöÕñq-éßÙWk¯%VÕÎm2{OìÙÛ_×ª%uşRÙ¹óÄ/¸O\r\0\0kGÂ‰ûZ¿ÏúÃüOşßøOŞÅ\n/>æ~ohş«¦§ñ_ÆKzI–Èneç\'Nœà¾Ö\0\0¬]K$~/ø»g~ñ¿w^¾5â»5z¹Kşñu\\6cöiìÕøBY2ª†±$¾¡ñà²ÚCl\'—e·²óšš\Z~\0€µ£a	‰³ÉÉÉ‘‘‘Û·o·´\\ù‡ìG%à>÷‡Æı‰??n‹?kS/…â+´Í>n›[G-3–Ëe·Ç*ÖÕÕ]»vMşü9ù£t!\0\0«CÂ333ê+†ıııÛñ½ıò™–“ƒS7&oÊ˜ê4şì˜R;§:ã¯NŞˆ­il¢V6ÆÍØè<sí€ìğƒ£;N<yñâEùò‡Ô—åOë~÷\0\0lHt!¬òÅ_Ü»w/÷ôô´´´ìÜû­ç_¼oâFxº{Cv\"»’;v¬®®Nv.Bşü9&\0X5ºVI2MMM;Şùo/¿ûDª4¼µ¢(”È®***N:%»•3Y\0ÀÚÑ…°š2éííõûıŞ‹5ÒsÏ¿ş¸÷úÁÕÌF»eCÙ\\vräÄÁêêê††Ù­ì\\ş“…\0\0¬]©)ÃñññáááîîîÖÖÖóçÏgïıÖ÷şõË÷s+íBÙD6”Í?ıôÓ“\'OÊ®d‡²[Ù¹ü	&\0X#ºÖúâ‹/¦¦¦ÆÆÆoİºuíÚ5é¹âÊ—ş1çşîÕGŞ9¸­½ïüÒ9(+Èj²²l²÷ØKÕÕÕ²Ù•ìPv+;—?Ád!\0\0kDÂZ333ê5‘Hd``@J®µµµ¡¡áÔg5ƒÛş!ûÑ¿Ú±åæı—_~ò?Êë\n.O|~×/CÈSY(/É\n²š¬\\şiÙ±cÇN:%›ËNdW²CÙ­º7\r“…\0\0¬]Ë%§áàà`ww·ßïojjª««;yòdiÍk9Åµ}×şë—ÿ/ô¥¿øáoËòTÊK²Byy¹¡¬,›È†²¹ìDvE\0°èB¤C\"\rÇÆÆ†‡‡{{{@KKËÅ‹%õjjjNœ8QYY)ñwôèÑ#1ò@ÊByIVÕdeÙD6”Íe\'²+¢\0€uD\"MT\ZNMMŒŒô÷÷÷ôôttt\\»v­¹¹ùÂ…çÎóz½uIä©,”—dYMV–MdCÙ\\v¢¾SH\0°^èB¤JÃh4zïŞ½»wï†Ãa‰¼Û·oƒÁ@ ĞŞŞî¹£ËByIVÕdeÙD6”Íe\'D!\0\0ë‹.Dº-¨Ã‘‘‘¡¡¡¾¾¾‰,”—dY\"\0ÀRt!ôHÔáäääÄÄÄØØ˜d_ÄDÊK²‚¬F\0`)º:©:ÓÓÓÑEÈKjŠ\0\0KÑ…°Ç£û\0\0ÈPt!ì%++K÷!\0\0¡èBØ]\0€.t!ì….\0@ºöB\0 ]{¡\0Ğ….„D\"‘‚‚İG\0@†¢a#ápØápè>\n\0\02]¡\0Ğˆ.„Ğ…\0\0hDÂFèB\0\04¢a#………º\0€EÂF‚Á ÓéÔ}\0\0d(º6B\0 ]¡\0Ğˆ.„Ğ…\0\0hDÂFèB\0\04¢a#~¿ßívë>\n\0\02]ñù|G÷Q\0\0¡èBØ]\0€Ft!l„.\0@#º6B\0 ]¡\0Ğˆ.„ÔÆè>\n\0\02]¡\0Ğˆ.„Ğ…\0\0hDÂFèB\0\04¢a#t!\0\0\ZÑ…°‘šš\Z¯×«û(\0\0ÈPt!lÄãñø|>İG\0@†¢a#t!\0\0\ZÑ…°º\0\0èBØ]\0€Ft!l„.\0@#º6âr¹:::t\0\0Š.„8Î`0¨û(\0\0ÈPt!l„.\0@#º6B\0 ]ıvíÚ•5_QQ‘îƒ\0 ãĞ…Ğ¯¤¤$9\n9âv»u\0\0‡.„~wîÜÉÎÎVQ˜““S\\\\ÌÙd\0\0Ò.„-ª.t¹\\œD\0@º¶àóùvîÜ)]XRRÒØØ¨ûp\0\0ÈDt!ì\"///\'\'ç­·ŞŠF£º\0€LDÂ.ª««wîÜyäÈİ\0@†¢aÑh4\'\'gppP÷\0\0¡èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB¬ÀÌÌıãWºáiÚZP)ã·¶`óñxGóîú’†ÀØä´îÏ\0\0[£±,Cw\'_*»øğ‹Ní©·–ñı}§}£º?K\0\0lŠ.Äƒ¹\Z[v¸TZ=–SşJEÓÉ–ÏeNOÜ·óPÇùÆÉ«‰ÙÍ‡^(ş…§ifF÷g\n\0€ıĞ…XŠôÓÜõª¨xç„¯+¬=õV=ü½£O¿J½—\'ß«º;©ûÓ\0À^èB,EEáC/¿[s]{Ø­×¢:¾µ ’YC\0\0’Ñ…X”«! ¢PZJ{Ï­ãğu…Õiñ—Ê.êşŒ\0°º©İSñôÁ™ví%·îãL[Ÿô®¼»æ®AİŸ4\0\0vA\"5uùÉİÕÚÎ¢ñJE“:›¬û“\0À.èB¤069­¦Ó6ô…&KáÑi5!zéS†\0\0èB¤PŞTsiÚëÍÒñÜ\'^y›¯iÒıy\0`t!RØî2‚)§Ò§=İ,G/uËÛüãÜrİŸ7\0\0¶@\"uèMv²y„Â“ò6·ìpéş¼\0°º)|å§¥LşŞQíéfõP_£Ôıy\0`t!RP?\n¢ãgî\Zòòæ/é=°­ .\0Àzt!RP]hiJ·?WÚ»Ørùwk*)7YËPïT÷ç\r\0€-Ğ…HAc\Z„ù‡éš/¤\0H ‘‚5](…—r0f[rŞ¿yø¹TkåyéB\0\0¬B\"Ëºpû›©æ¥.Œ‡ãüyDæ\0Hº)hêÂØcoÁs¥\r‹Î,.˜V¤\0X?t!RĞyÙèB£ëòœ5nÈ[ï(¤\0HF\"İó…ñ.´z².\0 ]ˆlÒ…Ì\0Nt!RĞ}ùpŞÖ‚<æ\0H/º)hœ/ŒİÑÚ¸\0™ùB\0\0ÒŒ.D\nZïks]è-PÓ…ëşc\'t!\0\0ÉèB¤†.´É \0H ‘]\0@¢‘Â–.©%ï¨ön³z¨wªûó\0ÀèB¤ğxGjéL[Ÿön³zÈÛ|øE§îÏ\0\0[ 3ÈÛo¿ıË_şrïŞ½¥¥¥õõõ·nİZlÍï~pJ‚éƒ3íÚ»ÍÒq¡sPŞæ#¯Jçÿ\0\0l‹.Ì yyyY&æ5w×^—`zúıSÚÓÍÒñJE“¼Íí.oúÿ_\0\0`Ctayûí·“‹ğı÷ß—%7nÜ0¯ÙÙ?*ÁôĞÅÁş1íõfİx,§\\Şæñ«İéÿ\0€\rÑ…›ÙÄÄDGGGmm­Óé”ÌÏÏWE˜——÷ÙgŸíİ»7‰,¶í“ïUK3ısi½öz³h||> opË×øät:ÿ§\0\0`[táf‡[ZZ*++‹ŠŠ$].—ta0”—Î=+QXXXxüøñ²²²h4ºÄ~š»Õ”á…ÎAí\r·î#TW\"ï®½¦ÿ1\0\0Ø]¸„B¡ÆÆFI=GŒ<§²pÁj·oßÎÍÍ=xğ ”ârvûıNK9}å§¥›ìlòğèôÖ‚JykçyffÖÿ\0\0]¸QƒAÉ;—Ë•ŸŸ_TTTYYÙÒÒ‡—Şª  @V[æŸ›œV7¬yäÕC¾®°ö[—\nOª(Ü²ÃÕÙ?ºæÿ\0\0ltá†111á÷ûkjjöîİ›••åt:¥;::d¹u4Ğ7úXn¹ºÉß»5×µWİ\ZÇ¡Æ :},o§ùÖ uŸ\0\0]hkápØçóUVVæçç»İn¯×ÛÓÓ“Îc»7ıtìv†jâğ•Š¦\r÷Cïè\'¯ª«eHé2S\0€]h;’}õõõ’€‡Ããñ466h<¤™™û•Wº%\nUW©¡&Şl>ÌÇüæ¯¯òB\0\0R¢õ‹F£êË‚N§377wïŞ½UUU~¿‰›Èh!9U~)¸İåİE˜<~ÑùÌ¾Ó%\rnI\0ÀèB=¤ù¤ü¤ÿ¤¥Õ—¥—¾w\0\0€uèB\r¤\n\nÜnw}}}š¿,\0\0°ºP‡ÃñÀÊ\0\0\0¤]¨AQQ‘ù¦Ó\0\0\0zÑ…\Z8NõÃt\0\0\0öAjPVV¶ü\0\0HºPÇãóùt…UVVrE6\0\0ºĞ…\ZÔÆè>\n;âŠ\0\04¢5ğz½555ºÂèB\0\04¢5ğù|G÷QØWj\0 ]¨ßïw»İºÂ¸R\0\0èB\r$}$€t…Ñ…\0\0hDj000PXX¨û(ìÈívûı~İG\0@†¢5‡Ã‡C÷QØwğ\0@#ºğAÏîÉZBEÛªö*[®óqn\nt!\0\0\Zet&\'ŸôñtÏÙÁø‹mê‰,[hŞÁ*»077—8›ÕÔÔx½^İG\0@†Êè.L4ºppĞx´`\"Ğš.äF})qÇo\0\04Êğ.l«ˆ5_ü?±³]8»d¶œO]¶Ê.äF})Ñ…\0\0hDJßÅÒ¯-Ö}s™g¢ñ,©/¦Z¶2Ü%¥ÆÆÆÊÊJİG\0@†Êì.Œw]\"ïæÎÏŸ5]XVVÖÒÒ²oasá—`\0\0Ğ(ã»Ğtb8~bÙôıÂõ=Ì…·)Ñ…\0\0h”Ñ]˜ø2áŠŠäéAy6w©‰5ó…|‘.%~	\0\02ºç$Şìç^²àzd¯×[SS³ªM73º\0\0èÂ˜øyãØ¹b©ÀØç&-¸¯5\'LS¢\0Ğ(Ó»0q*¹¢¢\"+kŞÄ`[Ål#Z0_è÷ûİn÷ª6İÌø…@\0\04Êô.Ô…‰±”èB\0\04¢õ(,,Ô}¶‰D\n\n\nt\0\0Š.Ôƒ‰±Ådeeé>\0\02]¨\r”\0\0ºĞ…ÚäææF£QİGa;|,\0\0èBjãp8Âá°î£°>\0\0t¡µ)**\n…BºÂvèB\0\0t¡µq:Á`P÷QØ¹\0€.t¡6eee---ºÂvÈe\0\0t¡µñx<>ŸO÷QØ]\0€.t¡6µ1ºÂvÜn·ßï×}\0\0d\"ºP¯×[SS£û(l‡iT\0\0t¡µ‘ú‘Ò}¶C\0 ]¨ßïw»İºÂvjjj¼^¯î£\0\0 Ñ…ÚƒA§Ó©û(l‡¯]\0 ]¨ÍÀÀ@aa¡î£°º\0\0]èBmÂá°ÃáĞ}¶ÓØØXYY©û(\0\0ÈDt¡NYYYºÁv¸\0\0]èBrss£Ñ¨î£°º\0\0]èBG8Ö}öÂå8\0\0èBêTTT\n…t…]ìÚµ+k>ù|t\0\0„.Ô‰ßNVRR’…Gáş\0\0¤]¨SYYYKK‹î£°‹;wîdgg«(ÌÍÍ-..&š\0H\'ºP\'~ómÂÂBÕ…‡â$2\0\0iFêÄ=œJŞ¹s§êÂÆÆFİ‡\0@f¡uòz½555ºÂ^òòò¤wğ\0 ÍèB¸WŸYuuµtaUU•î\0 ãĞ…:ùı~.¹] \ZfggG\"İ\0@Æ¡uâÎ\0\0À>èB\nu\0\0€.Ô);İG\0\0` 5ËÊÊÒ}\0\0\0ºP³üüü²²²ÆÆF~(\0\0èEj‡[ZZ*++‹ŠŠ¤İn·×ëíééÑ}\\\0\0 ãĞ…6211á÷ûkjjöîİ›››ët:kkkíùÁ33÷_éş…§ikA¥ŒßÚşÍÇãy9Î¸ëK\Zc“Óº??\0\0ìˆ.´©h4*E(](u˜••%¥(½(Õ(í¨÷À†îN¾TvñáÚSo-ãûûNúFõ~’\0\0Ø\r]¸1ôôôx½^·ÛŸŸ_TTTYYÙÒÒ’ş›?»\Z[v¸TZ=–SşJEÓÉ–ÏeNOÜ·óPÇùÆÉ«‰ÙÍ‡^(ş…§if&Í!\0\0öEn<¡P¨±±±¬¬¬  Àápx<ŸÏ700`é•~ú»^Õïœğu…µ§Şª‡¿wôé÷O©÷òä{ÕCw\'-ıè\0\0Ø(èÂ-«Y.,,”Lt»İõõõV\\Ú¬¢ğ¡Šß­¹®=ìÖkQ\rßZPÉ¬!\0\0÷éÂÍ$‰øışªªª¢¢¢ÜÜ\\—Ëåõz×å²WC@E¡´”ö[Çáë\n«Óâ/•]\\û§\0ÀFGnNÑh´£££¦¦F]¶¢.m–%²|¥»º=<¦âéƒ3íÚKnİÇ™¶>é]ywÍ]ƒVü\0\0`¡3‚º´ÙåråææUUUùışe^¶¢Î ?¹»Z{ÃY4^©hRg“­ş¿\0\0€ÍÑ…\'\nÕ××»İî‚‚‚ÂÂÂÊÊJŸÏ‡S®<69­¦Ó6ô…&KáÑi5!zéS†\0€ŒFf´ÆÆFÇãp8œN§y…òæ šKÓ^o–ç>ñÊÛ|õHSúÿ\0\0`t!–²İeSN¥O{ºY:^ê–·ùÇ¹åº?o\0\0t¢±uèMv²y„Â“ò6·ìpéş¼\0Ğ‰.ÄR¾òÓR	&ï¨öt³z¨¯Qêş¼\0Ğ‰.ÄRÔ‚ØÿgîèB\0\0Ö.ÄRT®°±zlÛ~àæ¯nMÈË/Øºy[c“<oª½İ<ü\\~ƒ<”n®´×Xâ-Ø\Z[²Ò¡Ş©îÏ\0\0èB,e5]˜(3ïÂæ‹§[RÏ%V–°‹•ßlSš¶] ‰t!\0\0ë‡.ÄRVŞ…vu)\'ö¶&-OîÂ”ó…Ş‚¹ˆ4\r‘uù‰M\n˜»p…H\0@b)+íÂ¤i¿¤3¿FüÍÅÎšv›:“æãS’Û¶;”İn;`¾\0€• ±”váÜwãgLnİšX-W¥˜4Ï·ı@éâß/\\üTò\\q¦<lüÅŸJ¦\0 ±”Õ¿PáüI;£U±-g¾0éTrò|áìš‰ÓÓ‹œG¦\0X!ºKYq.ón¢“Î/¼âøAó…ñyG®;\0`Ğ…XÊªÏ#uh»D2š¾˜â4ñ2çíÂ†¼•|Å.\0€.ÄRVuÿÂ…£.ßt)IüüïÜòUÌ¦èBIIuİ‰z‰.\0`%èB,e5]hj¾ù]Ø›|\rJb¤ìÂÍÎMRrŸ\Z\0\0V….ÄRVsYÍÒÅëp¡y·›Ydó7SŞ§Fµ Z^—ŸÍ†<ó´\"]\0À2Ğ…XÊºœGŞƒ.\0€.ÄRèB\0\02]ˆ¥lÙá’Zò÷jï6«‡z§º?o\0\0t¢±”Çó<RKgÚú´w›ÕCŞæÃ/:uŞ\0\0èDb)ßıà”ÓgÚµw›¥ãBç ¼ÍG^=¤ûó\0@\'ºKÙ]{]‚éé÷OiO7KÇ+Mò6·»¼º?o\0\0t¢±”ÎşQ	¦‡^(öi¯7ëÆc9åò6_íÖıy\0 ]ˆxò½ji¦.­×^oÏä\rnÙá\ZŸœÖıa\0 ]ˆhî\ZTS†:µ7ÜºPxR]‰¼»öºîO\Z\0\0ÍèB<Ø÷?:-åô•Ÿ–n²³ÉÃ£Ó[*å­=ç™™Ñı)\0 ]ˆ›œV7¬yäÕC¾®°ö[—\nOª(Ü²ÃÕÙ?ªû3\0@?ºËè},·\\İäïİšëÚ«nãPcP>–·Ó|kP÷§\0€-Ğ…X®±{ÓOÇng¨&_©hÚpß8ô÷¾qòªºúX†”.3…\0\0$Ğ…X™™û•Wº%\nUW©¡&Şl>ÌÇüæ¯¯òB\0\0’Ñ…X1É©òKÁí.ï†(Âäñğ‹Îgö.ipK\Z\0\0ÌèB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èB\0\0\0èBØTeee4\ZÕ}\0\0dº6åp8Âá°î£\0\0 ƒĞ…°)º\0€4£aSt!\0\0iFÂ¦èB\0\0ÒŒ.„M…B!İG\0@¡aSN§3ê>\n\0\02]›¢\0H3º6E\0ft!lŠ.\0 ÍèBØ”Ûíöûıº\0€BÂ¦<ÏçÓ}\0\0dº6E\0ft!lŠ.\0 ÍèB¬ÁàÙ=mê¿{Î\ZKÚ*²bKYÛXknå%Ñ…\0\0¤]ˆ5xPÊ³¹§s/-«kjj¼^¯\r\0\0R£±JFóÅUœ5wáìiÀØƒ¤Õ“í9»ØşkcÒó^\0\0À}ºk’4_Ï¼=±\n”œ7!}vêp©“Í	t!\0\0iFb\rRGN\nÀ¸X¦œ0\\ât2]\0@šÑ…XƒÙyÀç‘M’^a¾\0\0;¢±Jñù¿^<{Ny¥ó…•••Ö¾\0\0„.Ä\Z,u=r[ÅlÎ¿åş2ç}>ŸÇã±êÈ\0€	]ˆ5XĞ…’‚êº“Ä¢¤;ÒĞ…\0\0Ø]ˆ5Xp=²$àüéÁä\0\\äF5‹í›.\0 ÍèB¬’jA58.p¶øR\\”¼‚ıÓ…\0\0¤]›\nƒN§S÷Q\0\0AèBØ]\0@šÑ…°)º\0€4£aSt!\0\0iFÂ¦èB\0\0ÒŒ.„M…Ãa‡Ã¡û(\0\0È t!lŠ.\0 ÍèBØÎ®]»Üüº¨¨H÷A\0°ùÑ…°’’’ä(<räˆÛíÖ}P\0\0l~t!lçÎ;ÙÙÙ*\nsss‹‹‹ƒÁ îƒ\0`ó£aG………ª:ÄId\0\0Òƒ.„ù|¾;wª.lllÔ}8\0\0dº6•——\']èp8¢Ñ¨îc\0 #Ğ…°©êêjéÂªª*İ\0@¦ aSÑh4;;;‰è>\0\02]\0\0\0]\0\0\0];š‰ùÂD-×}t\0\0lNt!lGáğpph(Ğß×)c2&\ZNOO«:Ô}Œ\0\0lBt!ìe6\n;?zï«‰q»Ç‰DÆÇÇ¥IC\0\0,BÂFT\r¤÷íş½âwÿ½yğÑÿØ¸‡¥\'&&¢Ñ(i\0Àº£aæ(¼ìs\\¾äH¤áöÆÑÑQÒ\0\0+Ğ…°…QxÉ1<r6ü›sF\Zî6Ò°x÷hó_4!\r\0Xwt!ôK…R„Ò…æ4ô_o \r\0°]Í›)şÍ¹‘»Mwï6\rÇ‘4\0Àjt!tZl¦PÆİXª¡&IC\0\0,EB›EOÇ¢pdv¨Çê´òei\0€UèBè‘\"\n¯¼|úønR&ÒĞø®á•·IC\0\0¬@Bsú.¿54|f8|f4Ò`ŒÑ‹2Â£ÔÓÄYA†¬L\Z\0°îèB¤›9\n›/½>0ø™ŒáğycŒœ?H5Ôš²	i\0Àú¢‘Væ(¼p1ÿó¾“2îÜ9şiÉÿ)k~õ7Cƒ§û‡æ\rY(/É\n²Z(¶¾lH\Z\0°èB¤9\n/6äÜî®¼İ{¬ûö…jTZâ/1äiâ%YMVîùÜØJ6\'\r\0X/t!ÒÄ…çvöÜ.v—Käşäë‰ò‹§aåwdù­Û•ò`ÁK²²¼¤¶•†\0\0¬ºé`Â³ç~v3è–!m\'cAù©qòø·e¤|©ëVEWwEÇÍƒ²Ùi\0ÀÚÑ…°œ9\nÏœ~¹½Ãu£½DÂNGş2eÿ¥²rbÃ.Ù•ì0MiØV±çìà*^3<»\'«¢m‘Wb/Èãûk«XdU\0\0Ö]k©(îLŠÂ­mÉh%]b÷<¹œ(”ÕÚÛÌmØ~@íÍœ†£££’†ÓÓÓr\0ëö~–Ó…Fò™HØIŞ-)Ş~t!\0@ºÖ’.&GaËµd´¶9e\\kÛßÚ¾ïzÛşëíÆ8^ñgˆÂŠ?ó·ï7¶mß\'ÿÊ†Æ¿íûÕ>?«Ù‘HÃ6ÿIÃH$299)i¸Ö·‘*éŒh‹·Û¼ÜSQ±\'e<.9Ÿ¨j0éïTœ5w!\0°]kÅÏ ïù…Òm-×öÈ¸~ı#-×÷ÊPO+Ëÿ|±(”—’W^°¡Ú³JÃ½…pår]ooo8F£ëö~æÚ.Ö‚É¡—˜ß››è[Ê¢k%ÍÆCsÏøtã\nÎS\0°bt!¬%]Øß×©ºğÌé—ÕÄŞõöıj¦P†¿}|\n°Íé_rÊP^’\rÕVj¾PÍ5\ZÿÎNª³ÉÒ…M§ºººS†ky)O/œ8œ[­¢-Å³A·ø©ä¹yÀ”ç‘ç­\0€%èBX+Ñ…‰ËÕ×ot¸Ô%#7VòCãË…±MnÌßPí3qa²táÅ‹¿îìììëë]cÎ§¢ÏÜhm{ö\'ÿG>;wÒx6ôîÏ;•œ<_˜´F\"0SG\0ÀJt!¬%](Yv»Ç_¼û?Ä¾ù÷ïÏUÅ\\âšâ]’œ|1rò%É²ÛDÖ9ÖÒÒ¢ºğğáÃ}ô‘Óéôx<µ1òR0fbbbï$>Õ7w*×vI×¨@4Wİƒæã¯sİ	\0@ºÖR]‰D:—ix¾açÍ Û¸û`·qÂ`wùb÷)\\ì¾†]·*ŒmåßØM?|\"QX[ëinnnmmUç‘{{{;::¤}>ŸêÂ²²2gL~~¾j²½{÷ª%555j===÷çZílÒ÷gÏÆ»°í¬¼2[‚ñŒSßœÿ5ÂeÎ.Ú…Æö–ÿ?\0d*ºÖ’.ŒF£ãããápøF{c\"\r/\\Ìï¾]Şs»üÖmãGMRö_uåwÌ?v¢†ñ{\'³?y’ø¡d‰ÂÏ>«¸páBKK‹´àò¯;‘şS!èõzUªL”^Tá(ét~èØ¥½±ÿxmcc£±Áå£»İÍ³»‰Gß\\ÏÅrŞLß*¾_;A9¶h=ÿ÷\0\0„.„µfff¦§§Õ”áÀÀ@›ÿB\"\r›/½®ò.Ôw2ùÇ‘÷Íÿ‰ääGŞ7ûÉŸ÷¼İ{L†ìdA^¹råÆ’zëxŸš‰‰	£ßyçÓ‹~•••ÎX*æä¿¥Â®°ğ­7v9>üĞñzÖ¿–5ï;+ëã£GßÉÊ*o\rÓÎÆO\\sŸ\Z\0@ZĞ…°–º¯µ”™¤Õèè¨´šÿzC\"\r}—Ş”Â“qçÎñä4¬ùÕßô\Z<\Z¬•ò49\neeµ•lnÂöööîîn+îkêÂä¹sÄ?~çèÑ³>¨¬|/6«ø±Û›vü0{g|mç¬X7¾QğI•š§…BÉbŞéèû÷“§ÉB\0€uèBXN¥a4\Z•JY˜†Ío~&£¿¿Z¥¡Tàpøü‚¡ÒPVÕÔú²áQhÏŸHÎR“555*‹ŠŠTö¨%eeejŸÏ§6‰D\"º\0°ÉÑ…H‡¥ÓğÊ•Ÿ‘½ c4Ò #şxô¢zjŒØã¡á32d“\r…Ë!ñ§*°¥¥Eu¡ÇãQ¥(É¨ÚQ\"R-©ªªRë¨k„îÃ\0llt!Òdé4¼zõİá‘³2Fî6©qwöß»³e„sNÖ‘•7e.S(RX__¯ºĞår©RTá˜››«Êrµ‚¬©6‘ÏG÷á\0ì‹.Dú,?\r!˜üx˜(\\yûª;::TVUU©R,,,LL:ê>L\0€íĞ…H«¦¡1#ø›swçÏ\ZQ8rV^\"\n×‹¤¡îC\0\0Ø]ˆt[Î¬¡$`ò|¡šG$\n×]\00£¡ÁŠÒ(´]\00£¡Ç2ÓÓÇ¡\0ft!´YÎw\r‰B‹Ğ…\0\03º:=0\r‰B‹Ğ…\0\03ºš-†‰(¬­õ…ëˆ.\0˜Ñ…Ğo±4”T£îÌ±æææ–––7n…ë‚.\0˜Ñ…°s\Z¶ù/\\¹\\×ÔxêâÅ_K¶¶¶vttôôô…ë‚.\0˜Ñ…°‹ä4•şëíííêêêŒ‘òTÊKDáÚÑ…\0\03º6’œ†‘H$KöÅÈy*‰ÂuA\0ÌèBØ‹JÃéééÉÉÉññq	ÁÑy Oe¡¼D®]\00£a;‰4ŒF£“Iä)Q¸^èB\0€][óx<ºas¢\0ft!l|±,\0ÀŒ.„­‘/áƒ\0˜Ñ…°5òÅ\"|°\0\03º¶F¾X„\0`FÂÖÈ‹ğÁ\0ÌèBØW8v8ºbs¢\0ft!ì‹.´]\00£a_t¡uèB\0€]û¢­C\0ÌèBØ]hº\0`FÂ¾B¡PQQ‘î£ØTvíÚ•5Ÿ0\0 .„}ƒA§Ó©û(6•’’’ä(<räˆÛíÖ}P\0\0» a_táº»sçNvv¶ŠÂÜÜÜââbùu\0À.èBØ]h…ÂÂBÕ…‡â$2\0 ]û¢­àóùvîÜ©º°±±Q÷á\0\0l„.„}Ñ…ÉËË“.t8ÑhT÷±\0\0l„.„}ù|>Ç£û(6¡êêjéÂªª*İ\0°ºöEZ$\ZfggG\"İ\0°ºöE\0Nt!ì‹.\0 èBØ]\0@:Ñ…°¯úúz®\0\0 mèBØWmŒî£\0\0 SĞ…°/º\0€t¢a_Ş…33÷_éş…§ikA¥ŒßÚşÍÇãy9Î¸ëK\Zc“Óº??\0ÀŠÑ…°¯ŒíÂ¡»“/•]|øE§öÔ[Ëøş¾Ó¾QİŸ%\0`èBØWfv¡«!°e‡K¥Õc9å¯T4lù\\ÆğèôøÄ};uœoœ¼š˜İ|è…â_xšfft¦\0€å¡a_Ççóé>Šô‘~ú»^Õïœğu…µ§Şª‡¿wôé÷O©÷òä{ÕCw\'uº\0€£a_™Ö…*\nz¡øİšëÚÃn½fÕÙğ­•Ì\Z€ıÑ…°¯ŒêBWC@E¡´”ö[Çáë\n«Óâ/•]Ôı\0€.„}eNŞSñôÁ™ví%·îãL[Ÿô®¼»æ®AİŸ4\0`)t!ì+sºPA~rwµö†³h¼RÑ¤Î&ëş¤\0K¡a_n·Ûï÷ë>\nËMN«é´\r}¡ÉÒcxtZMˆ^ºÅ”!\0Ø]ûr:Á`P÷QX®¼9¨æÒ´×›¥ã¹O¼ò6_=Ò¤ûó\0,Š.„}eHnwÁ”SéÓn–£—ºåmşqn¹îÏ\0°(ºö•!]¨î½É.C6PxRŞæ–.İŸ7\0`Qt!–¯­\"«¢-éùàÙ=ó›VßsvM_&Ë.üÊOK%˜ü½£ÚÓÍê¡¾F©ûó\0,Š.ÄrI.è¼](Ùø\0KUd\nÒ…êGAìÿ3wt!\0lzt!–)1Y(5˜ªùÌsƒk/t8ápx-{ØT®2¶¼Ï•ö.òjCŞ¶Ãåîª÷À¶­yŞT/İ<ü\\~ƒ<”nÿ-oÁÖØ’•õNuŞ\0€EÑ…X–Ù©Áy“†æóÈ‹4cên| ºp}ºPÂn«‰„äİ’â™H@Æ ±,Iu—2şs‰s¥˜<_¸ª¹Cºp‰4gœmÒpF\Z“sËóK9q¸TS\Z(]X—ŸØMÁs®0éB\0°9ºË5xöì¿H®Â:ÍÆZ0¹ÿâ˜ô`É17¸`$ÍÆCsÛöøtã\nÎSÓ…\0°Ğ…X–¤)ÂŠ¶†ñ\Zä<ò*¬´}¶•w³«Ô¥8¼ıÀÍEççDXä<òÖ­«8•L€ÍÑ…X¹…ß+Lq¿\Zã{ˆ1+½9Y~~şÄÄÄª7ß(Ö4_?e\\P·pyCŞ¶íÆ4¡·@G>?Û‚Æ&³ë\'JN/T\'‘çºp±óÈt!\0l.t!–mv2°âìR]¨îVcÌªsÇ±ç«»0Y6\\ûQÛß*»0>Õ—¨=sØ%]w¢Ñ\\uš/Œ¿ëN\0 3Ğ…X–yq·ÈydU„)¿_ßb…s‡taÊ1Ûj‡lSQ8{•I~Càf¼ëJ¥g»0q\ryFDöÎnµ’ùÂE»pE·Â¡ÀîèB¬Ü2Î#Ö|ÿBºpÉ‘¸è8©óf.9Úæz.vFxŞM\nWñıBIIuİÉÄr¯h¡`£ a_táƒº0©Ms~ñ.4Z0ömB…¥óÓp…ó…F0ÆNIsŸ\Z\0Ø”èBØ]¸ôHuarr)\Z]x «ñEÃ­É·°‰M4šz.å}jÔŸPËëòAÛá‚iEº\06>º6‡‡î£H‡µ]¼‘]\06GÂ¦èÂÍ7èB\0°9º6•9]¸e‡KjÉß;ª½Û¬êêş¼\0‹¢aS™Ó…çy¤–Î´õiï6«‡¼Í‡_têş¼\0‹¢aS™Ó…ßıà”ÓgÚµw›¥ãBç ¼ÍG^=¤ûó\0,Š.„M…B¡¢¢\"İG‘»k¯K0=ış)íéféx¥¢IŞæv—W÷ç\r\0X]›\nƒNgFœsìì•`zè…â`ÿ˜öz³n<–S.oóøÕnİŸ7\0`Qt!l*sºP<ù^µ4Ó?—Ök¯7‹ÆÇçò·ìpONëş°\0‹¢aSÕ…Í]ƒjÊğBç ö†[÷\nOª+‘w×^×ıI\0–BÂ¦2ªÅ÷?:-åô•Ÿ–n²³ÉÃ£Ó[*å­=ç™™Ñı)\0–DÂ¦2­Ç&§Õ\rkyõ¯+¬½çÖe„Â“*\n·ìpuöêşŒ\0@Â¦|>ŸÇãÑ}iè},·\\İäïİšëÚ«nãPcP>–·Ó|kP÷§\0x0º6•](ÆîM?»¡š8|¥¢iÃ}ãĞß;úÆÉ«êêcRºÌÀFAÂ¦2³ÅÌÌıÊ+İ…ª«ÔPo6æc~ó×WùN!\0l t!l*c»P‘œ*¿Üîònˆ\"L¿è|fßé’†\0·¤€\r‡.„Mex\0~t!lª¾¾¾ªªJ÷Q\0\0AèBØTmŒî£\0\0 ƒĞ…°)º\0€4£aSt!\0\0iFÂ¦èB\0\0ÒŒ.„MÑ…–âZo\0€]›’pñù|ºbÓÊÊÊÒ}\0\0Û¡aSt¡¥èB\0€]›¢-E\0ÌèBØ]h)º\0`FÂ¦èBKÑ…\0\03º6åv»ı~¿î£Ø´èB\0€]›r:Á`P÷QlZt!\0ÀŒ.„MÑ…–¢\0ft!lŠ.´]\00£a/»víÊš¯¨¨H÷AmBt!\0ÀŒ.„½”””$Gá‘#GÜn·îƒÚ„èB\0€]{¹sçNvv¶ŠÂœœœââbÎ&[.\0˜Ñ…°ÂÂBÕ….—‹“È¡\0ft!lÇçóíÜ¹SÂ¥¤¤¤±±Q÷álNt!\0ÀŒ.„ååååää¼õÖ[ÑhT÷±lNt!\0ÀŒ.„UWWïÜ¹óÈ‘#ºdÓ¢\0ft!ì(\Zæääê>M‹.\0˜Ñ…@&¢\0ft!‰èB\0€]d\"º\0`F™ˆ.\0˜Ñ…°£™Eè>®Íƒ.\0˜Ñ…°•}_ÄLOOG£Ñ)Y(/©uÈÄ5¢\0ft!4K¡dßØÈhçÅæ–_×şpíûûÔ§7Î_MLLÜ»wO5\"u¸t!\0ÀŒ.„6‰\"”<÷qéŞï=ûãßıêûM9ä¥÷¿ı·Ò‹}½½‘HD\ZQ‘:\\5º\0`FBU„Òvµïï{å‘¯%÷ßëÿõ¿;¾ù-×³ÏËò4¹eåªwöö˜ëP÷{ÚHèB\0€]\rTö¶¶íúú7Tíıä÷ÿpß3Û®|\\2ÑÑ1İİ½`ÈÂKûÈ\n‰@ÌùÚŸ¶Ö\Z\Z’:œ˜˜˜šš\"\rW„.\0˜Ñ…H7…—U©È{ñKÿ›ûŸş%ì»lÎAóÕ\\Ï>/›¨™ÅÓ%ûûûGFFÆÆÆHÃ¡\0ft!Ò*…ªív}ı½g¼Ë)ÂäÑS{&çkªšòÔş’P(‡IÃ¡\0ft!ÒGEaË¯kU¾ÿí¿MyÖx9C6,|ò»*\rO—$\r311Œill¬qÆäççë>4\0€íĞ…H“Äw\n_şò£Òso~kª«kuQ¨†lşæO©ï&^:]—±i(ïZ•ŸÊ¾ÊÊÊDùeeeÉ¿ê©,W+¨•e+İ\0°ºi\"¡611¡Îÿf=ö\'w[[SÖ^ÃÅÚ¼7ßÿöß¾ûÄSj¸}şBaQÊ•e\'Y~]í°½­­¯¯oddDşJ4\ZİL]ØÓÓ#%ç÷ûUØ¹İné¼½{÷fÅ8U~êÕÆÆFU~ò9è>p\0ÀC\"ÔdáÉ7ß•†ûÑïüAÊïJäI.vÿÂ—¿ü¨ô¢y+Ù•ìPVøøçÙCııı‘HäŞ½{hÊp±S½|ªü$å©ä zUQV–XÔ}à\0€Í†.D:¨›W«3ÈGü3sŞu×ÔªW—ïûoÍ?ø‰:›|õÒ%ÙÓĞñË(ê¦†ºßw§z\0]Ë©ÉÂÓîWõ6z¥e²³3yUµœ(Tã—_ÿÆ‚Íe‡ê–7‡_{#„B¡‘‘‘Å¦\'&&ÜnwYYÙú¾GNõ\06º–“8‹F£o~KÒÍõìów[[Œ_ÎŞİz™ãè6o×Z÷=³Í¸ëÍÿõÍk×®%O.èÂšššììlÕj+zœê\0dº–S\'‘Õ½i®¸„›šÂM±›Â\'_ÉYQªüU•lßOcÓ•KÔ=kš\Z.¾¾¾H$¢.LVÇĞÚÚúúë¯g%Ypœê\0€.„å$Înœ¿ ~¡¤ÿÌ™#ùÇ‘—?\\Ï>¿`?êê“cû]ímm½½½‰SÉ………Y&œê\0`º–›>°\\¢íõÿúßoW0Æ‰*5.­\"\neHMö?nìdv‡ê§–İäSÉò§_{í5s\nNõ\0°\0]k©/Ö¾¿O]M|óÓO“ÇÑÿlu](cÁ®Ô÷?şyö•+W$ø_1nllt»İ999»wï~ï½÷ä¿\0€]kINMMÚS,Ñ¶÷{ÏŞ8p y¸şæïWİ…çò’w%Ñ©ºğÒ¥K@ ¿¿_ıöIò¥\'UUU………ü\n\0\0ft!¬µ ıû÷\'5vaò®taâÒ“rwk\0\0´£a­ä.,|ò»æÕ-©W7ì*q™.\0`uèBXKuaâº“_\n\\Ëu\'v¥~yùğkoĞ…\0\0¬]k©.l­;÷ÃØ}jŒ‹ˆÕÄ³c•÷©ù›¿_Ô»Yv›¸O\r]\0ÀêĞ…°–êÂğàº¯õ…Â¢÷\\İ}­o~úiòNÔ¼£ü‰ÚS§–¸î\0\0,.„µÔ}j$ÑŞ|â)I·}Ïl7\Z¿Pò›¤óc§€—?*~ğ“Ø/4ÎştJãŞï=+Ëw}ıçÎ[pŸ\Zº\0€e¢a¹ééiI´ªwöHºıä÷ÿp ¾aÁï#<Ç^şò£ËŒÂwşÛŸß½6osÙá÷«òRñO~.]¸à¾Öºß=\0\0]Ë}ñÅ÷îİëëí•(”zsÿÓ¿Lvv.Á_Ue=úõF¡1İè»¼`[×³Ï«â¬©ªºxñ¢ßïOş<İï\0€\rƒ.„åTŒ~í\r	¸ıÎt×ÔNww/w[[—¸mTã…Â\"óV²+uÅIÑóÿrîÜ¹ä‹NèB\0\0V„.„å_1ì¿sGİM&ë±?¹{­ÕyªkóŞt=ûü»O<¥†Äâ¥ıR¯|­UÍ2¾òÈ×jOºxñbòId¾\\\0ÀŠĞ…°œÄ™š2i­¿ Î&¿ùÄSS]])ko™C6ı®Î ÛïRWœP(”8‰L\0°|t!ÒAmjjjlllhhèüÁruÏ\ZÇ7¿u·5õ¬á‡l¨.p–]¹…ê›…‰ÉBùsœD\0`EèB¤CbÊ0‰ô÷÷Ÿ.9¨Ò0ëÑ¯÷ñ®4\neu7l…uuuêr0”\'¾YÈd!\0\0+B\"MÔ·\'&&FFFúúú$\rÕ	åıÎì{fÛb_7\\0F¯´ÈÊêBÙ<9\nÕå&²sù|³\0€U ‘&jÊPM‡Ã¡PèÒéº¬ÇşD]nüãßıêŞï={iÿÉÎNsÊByIVP÷)TÇö»’£Pv(»MœA¦\0X)ºécNÃö¶¶Ã¯½‘|Sk)¿œ¯ıé›O<µï™m2ä<Mä š&,şÉÏkORw¥!\n\0X/t!ÒjA\Zöõõuuu]½tÉ]àT\'ˆSyéõoüùÇ?Ï®©ªRW™\\¹rÅï÷Ëæ²¢\0€µ£‘nÉi822Òßßßİİ®]»ÖXßPSrğÓw÷Hÿ%†<=¶ß¥&eU„jšP6”Íe\'D!\0\0kGBƒD\ZNLLD\"‘¡¡¡¾¾>U‡ímmÒ|Wb.%QKä%YA¡l\"Êæ²¢\0€µ£¡‡JÃh4jüDŞØX¢{{{¥ùººº‚Á` ‰<•…ò’¬ ŠPMÊæ²¢\0€µ£¡ÍLÌ‚:”Ú–ìëé‹Qe¡¼$+ÈjŠ(\0`íèBh–\\‡SSS*•H’ÄBYAV£\0Xwt!l!Q‡bzzZ5â²P^RëP„\0\0¬;ºv4³İÇ\0Àföÿûš¶â§Sü)\0\0\0\0IEND®B`‚','20001','leave.png');
INSERT INTO `jbpm4_property` VALUES ('next.dbid','3','30001');
INSERT INTO `persistent_logins` VALUES ('ADMIN','wZFP1T+V4JSqgQT4j0lngQ==','qPt3+clnTFp5hMHaliQaNQ==','2012-06-23 22:44:27');
INSERT INTO `t_common_att` VALUES ('9','barney.txt','\\2012-06-08\\ADMIN\\barney_1.txt','Local',NULL,'txt','2012-06-08 20:56:44','ADMIN'),  ('10','barney.txt','\\2012-06-08\\ADMIN\\barney_2.txt','Local',NULL,'txt','2012-06-08 23:21:00','ADMIN');
INSERT INTO `t_sys_dict` VALUES ('area','åŒºåŸŸ','3','PP_TYPE'),  ('BJ','åŒ—äº¬','1','AREA'),  ('COMMONUSER','æ™®é€šç”¨æˆ·','1','DEFAULTROLE'),  ('COMPANY','å…¬å¸',NULL,'ORGTYPE'),  ('company','åŒå…¬å¸é™åˆ¶',NULL,'PP_LIMIT_TYPE'),  ('CONTRACTFLOW','åˆåŒå®¡æ‰¹æµç¨‹','1','FLOW_TYPE'),  ('DEPT','éƒ¨é—¨','1','ORGTYPE'),  ('dept','åŒéƒ¨é—¨é™åˆ¶','1','PP_LIMIT_TYPE'),  ('FAILURE','å¤±è´¥','1','HANDLERESULT'),  ('femme','å¥³','1','GENDER'),  ('HB','æ¹–åŒ—','2','AREA'),  ('HN','æ¹–å—','3','AREA'),  ('male','ç”·','0','GENDER'),  ('NO','å¦','1','YESORNO'),  ('none','æ— é™åˆ¶','3','PP_LIMIT_TYPE'),  ('OAFLOW','åŠå…¬å®¡æ‰¹æµç¨‹',NULL,'FLOW_TYPE'),  ('ORG','ç»„ç»‡','2','ORGTYPE'),  ('org','åŒå¤„å®¤é™åˆ¶','2','PP_LIMIT_TYPE'),  ('org','ç»„ç»‡','1','PP_TYPE'),  ('role','è§’è‰²','2','PP_TYPE'),  ('SUCCESS','æˆåŠŸ',NULL,'HANDLERESULT'),  ('SYSADMIN','ç³»ç»Ÿç®¡ç†å‘˜',NULL,'DEFAULTROLE'),  ('tree-appLog','æ“ä½œæ—¥å¿—','6','ICONCLS'),  ('tree-att','æ–‡ä»¶å›¾æ ‡','8','ICONCLS'),  ('tree-auth','æˆæƒå›¾æ ‡','999','ICONCLS'),  ('tree-config','é…ç½®æ–‡ä»¶å›¾æ ‡','9','ICONCLS'),  ('tree-dd','å­—å…¸å›¾æ ‡','2','ICONCLS'),  ('tree-org','ç»„ç»‡å›¾æ ‡','1','ICONCLS'),  ('tree-pwd','å¯†ç ä¿®æ”¹','3','ICONCLS'),  ('tree-role','è§’è‰²å›¾æ ‡','5','ICONCLS'),  ('tree-source','èµ„æºå›¾æ ‡','4','ICONCLS'),  ('tree-sysLog','ç³»ç»Ÿæ—¥å¿—','7','ICONCLS'),  ('tree-user','ç”¨æˆ·å›¾æ ‡','0','ICONCLS'),  ('user','äººå‘˜',NULL,'PP_TYPE'),  ('YES','æ˜¯',NULL,'YESORNO');
INSERT INTO `t_sys_dict_type` VALUES ('AREA','åŒºåŸŸ','ç»„ç»‡ã€äººå‘˜æ‰€å±åŒºåŸŸ'),  ('DEFAULTROLE','é»˜è®¤è§’è‰²',''),  ('FLOW_TYPE','æµç¨‹ç±»å‹',NULL),  ('GENDER','æ€§åˆ«',NULL),  ('HANDLERESULT','å¤„ç†ç»“æœ',NULL),  ('ICONCLS','èœå•å›¾æ ‡',NULL),  ('MODULE','æ—¥å¿—æ¨¡å—',NULL),  ('ORGTYPE','ç»„ç»‡ç±»å‹',NULL),  ('PP_LIMIT_TYPE','å‚ä¸è€…é™åˆ¶ç±»å‹',NULL),  ('PP_TYPE','å‚ä¸è€…ç±»å‹',NULL),  ('YESORNO','æ˜¯å¦',NULL);
INSERT INTO `t_sys_log` VALUES ('1','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"PP_TYPE\",\"cname\":\"å‚ä¸è€…ç±»å‹\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:48:33'),  ('2','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"PP_LIMIT_TYPE\",\"cname\":\"å‚ä¸è€…é™åˆ¶ç±»å‹\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:48:56'),  ('3','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"org\",\"dvalue\":\"ç»„ç»‡\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:50:11'),  ('4','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"user\",\"dvalue\":\"äººå‘˜\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:50:29'),  ('5','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":2,\"dname\":\"role\",\"dvalue\":\"è§’è‰²\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:50:37'),  ('6','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":3,\"dname\":\"area\",\"dvalue\":\"åŒºåŸŸ\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:00'),  ('7','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"company\",\"cname\":\"åŒå…¬å¸é™åˆ¶\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:16'),  ('8','org.thorn.dd.service.DataDictServiceImpl','deleteDt','[\"company,\"]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:28'),  ('9','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"company\",\"dvalue\":\"åŒå…¬å¸é™åˆ¶\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:55'),  ('10','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"dept\",\"dvalue\":\"åŒéƒ¨é—¨é™åˆ¶\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:52:06'),  ('11','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":2,\"dname\":\"org\",\"dvalue\":\"åŒå¤„å®¤é™åˆ¶\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:52:30'),  ('12','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":3,\"dname\":\"none\",\"dvalue\":\"æ— é™åˆ¶\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:52:44'),  ('13','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"PARTICIPATOR\",\"sourceName\":\"ç»‘å®šç¯èŠ‚å‚ä¸è€…\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/participator/participator.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":2}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:55:01'),  ('14','org.thorn.workflow.service.ParticipatorServiceImpl','save','[{\"id\":null,\"entity\":\"123,1212\",\"variable\":\"dfgr\",\"processDfId\":\"test\",\"activityId\":\"ç¯èŠ‚1\",\"entityType\":\"org\",\"limitType\":\"org\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:59:59'),  ('15','org.thorn.workflow.service.ParticipatorServiceImpl','queryPage','[\"\",\"\",\"\",\"\",0,20,null,null]','ADMIN','FAILURE','ParticipatorDaoImpl do queryPage exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\r\n### The error may involve ParticipatorMapper.selectPage-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'','2012-06-21 23:59:59'),  ('16','org.thorn.workflow.service.ParticipatorServiceImpl','queryPage','[\"\",\"\",\"\",\"\",0,20,null,null]','ADMIN','FAILURE','ParticipatorDaoImpl do queryPage exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\r\n### The error may involve ParticipatorMapper.selectPage-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'','2012-06-22 00:00:03'),  ('17','org.thorn.workflow.service.ParticipatorServiceImpl','queryPage','[\"\",\"\",\"\",\"\",0,20,null,null]','ADMIN','FAILURE','ParticipatorDaoImpl do queryPage exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\r\n### The error may involve ParticipatorMapper.selectPage-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'','2012-06-22 00:00:10'),  ('18','org.thorn.workflow.service.ParticipatorServiceImpl','delete','[\"1,\"]','ADMIN','SUCCESS',NULL,'2012-06-22 00:04:05'),  ('19','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"participator-query\",\"sourceName\":\"å‚ä¸è€…æŸ¥è¯¢\",\"parentSource\":\"PARTICIPATOR\",\"sourceUrl\":\"/wf/pp/get*.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-06-22 00:05:44'),  ('20','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"participator-modify\",\"sourceName\":\"å‚ä¸è€…è®¾ç½®ä¿®æ”¹\",\"parentSource\":\"PARTICIPATOR\",\"sourceUrl\":\"/wf/pp/saveOrModifyParticipator.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-06-22 00:06:22'),  ('21','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"participator-delete\",\"sourceName\":\"å‚ä¸è€…è®¾ç½®åˆ é™¤\",\"parentSource\":\"PARTICIPATOR\",\"sourceUrl\":\"/wf/pp/deleteParticipator.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-06-22 00:07:00'),  ('22','org.thorn.workflow.service.ParticipatorServiceImpl','save','[{\"id\":null,\"entity\":\"0011\",\"variable\":\"dfd\",\"processDfId\":\"test\",\"activityId\":\"test\",\"entityType\":\"org\",\"limitType\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 15:28:49'),  ('23','org.thorn.workflow.service.ParticipatorServiceImpl','modify','[{\"id\":1,\"entity\":\"0011,0012\",\"variable\":\"dfd\",\"processDfId\":\"test\",\"activityId\":\"test\",\"entityType\":\"org\",\"limitType\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 15:38:41'),  ('24','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"FLOW_TYPE\",\"cname\":\"æµç¨‹ç±»å‹\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:17:41'),  ('25','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"OAFLOW\",\"dvalue\":\"åŠå…¬å®¡æ‰¹æµç¨‹\",\"typeId\":\"FLOW_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:18:04'),  ('26','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"CONTRACTFLOW\",\"dvalue\":\"åˆåŒå®¡æ‰¹æµç¨‹\",\"typeId\":\"FLOW_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:18:28'),  ('27','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"leave\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"è¯·å‡æµç¨‹\"}]','ADMIN','FAILURE','FlowTypeDaoImpl do save exception,\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'ID\' doesn\'t have a default value\r\n### The error may involve FlowTypeMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### Cause: java.sql.SQLException: Field \'ID\' doesn\'t have a default value\n; uncategorized SQLException for SQL []; SQL state [HY000]; error code [1364]; Field \'ID\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'ID\' doesn\'t have a default value','2012-06-23 22:25:15'),  ('28','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"è¯·å‡æµç¨‹\",\"flowKey\":\"è¯·å‡æµç¨‹\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"è¯·å‡æµç¨‹\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:27:40'),  ('29','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"è¯·å‡æµç¨‹\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"è¯·å‡æµç¨‹\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:40:11'),  ('30','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"è¯·å‡æµç¨‹\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"è¯·å‡æµç¨‹\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:41:39'),  ('31','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"è¯·å‡æµç¨‹(æ–°)\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"è¯·å‡æµç¨‹(æ–°)\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:45:13');
INSERT INTO `t_sys_org` VALUES ('1','ROOT','-1','ç»„ç»‡æ ‘','ç»„ç»‡æ ‘','COMPANY',NULL,'0','NO','NO',NULL),  ('2','001','ROOT','åŒ—äº¬å¸‚åˆ†å…¬å¸','åŒ—äº¬å¸‚åˆ†å…¬å¸','COMPANY',NULL,'1','YES','NO','BJ'),  ('11','002','ROOT','æ¹–åŒ—çœåˆ†å…¬å¸','æ¹–åŒ—çœåˆ†å…¬å¸','COMPANY','hb@thorn.com','2','YES','NO','HB'),  ('12','0011','001','ä¿¡æ¯åŒ–éƒ¨','ä¿¡æ¯åŒ–éƒ¨','DEPT',NULL,'0','YES','NO','BJ'),  ('13','0021','002','ä¿¡æ¯åŒ–éƒ¨','ä¿¡æ¯åŒ–éƒ¨','DEPT',NULL,'1','YES','NO','HB'),  ('14','0012','001','åŒ—åˆ†å¸‚åœºéƒ¨','å¸‚åœºéƒ¨','DEPT',NULL,'2','YES','NO','BJ');
INSERT INTO `t_sys_resource` VALUES ('0','ALL','/**','YES','NO','-1','99',''),  ('APPLOG','æ“ä½œæ—¥å¿—','/system/log/appLog.jsp','YES','YES','LOG','1','tree-appLog'),  ('APPLOG-EXCEL','æ“ä½œæ—¥å¿—å¯¼å‡º','/log/exportLogExcel.jmt','YES','NO','APPLOG','999',NULL),  ('APPLOG-QUERY','æ“ä½œæ—¥å¿—æŸ¥è¯¢','/log/getLogPage.jmt','YES','NO','APPLOG','0',NULL),  ('ATT','æ–‡ä»¶ç®¡ç†','/system/att/attachment.jsp','YES','YES','SYS','9','tree-att'),  ('ATT-DELETE','é™„ä»¶åˆ é™¤','/att/delete.jmt','YES','NO','NAV','3',NULL),  ('ATT-DOWNLOAD','é™„ä»¶ä¸‹è½½','/att/download.jmt','YES','NO','NAV','4',NULL),  ('ATT-UPLOAD','é™„ä»¶ä¸Šä¼ ','/att/get*.jmt','YES','NO','NAV','2',NULL),  ('AUTH','ç”¨æˆ·æˆæƒ','/system/role/userAuth.jsp','YES','YES','AUTHMANAGER','1','tree-auth'),  ('AUTH-ADD','æ·»åŠ ç”¨æˆ·','/user/saveUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-DELETE','åˆ é™¤ç”¨æˆ·','/user/deleteUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-QUERY','æˆæƒå…³ç³»æŸ¥è¯¢','/user/get*.jmt','YES','NO','AUTH','0',''),  ('AUTHMANAGER','æƒé™ç®¡ç†',NULL,'NO','YES','SYS','3',NULL),  ('CF','é…ç½®é¡¹ç®¡ç†',NULL,'NO','YES','SYS','0',NULL),  ('CF-MODIFY','é…ç½®æ–‡ä»¶ä¿®æ”¹','/cf/modifyConfig.jmt','YES','NO','CONFIG','1',NULL),  ('CF-QUERY','é…ç½®æ–‡ä»¶æŸ¥çœ‹','/cf/get*.jmt','YES','NO','CONFIG','0',NULL),  ('CONFIG','é…ç½®æ–‡ä»¶ç®¡ç†','/system/cf/configurator.jsp','YES','YES','CF','1','tree-config'),  ('DICT','æ•°æ®å­—å…¸ç®¡ç†','/system/dd/dd.jsp','YES','YES','CF','0','tree-dd'),  ('DICT-DELETE','æ•°æ®å­—å…¸åˆ é™¤','/dd/delete*.jmt','YES','NO','DICT','999',''),  ('DICT-QUERY','æ•°æ®å­—å…¸æŸ¥è¯¢','/dd/get*.jmt','YES','NO','DICT','0',''),  ('DICT-UPDATE','æ•°æ®å­—å…¸æ›´æ–°','/dd/saveOrModify*.jmt','YES','NO','DICT','999',''),  ('HOME','ä¸»é¡µ','/system/main.jsp','YES','NO','NAV','0',NULL),  ('LEFTMENU','èœå•æ ‘','/resource/getLeftTree.jmt','YES','NO','NAV','1',NULL),  ('LOG','æ—¥å¿—ç®¡ç†',NULL,'NO','YES','SYS','1',NULL),  ('MYPWD','ä¿®æ”¹å¯†ç ','/system/user/changePwd.jsp','YES','YES','USERMANAGER','99','tree-pwd'),  ('MYPWD-CHANGE','å¯†ç ä¿®æ”¹','/user/changeMyPwd.jmt','YES','NO','MYPWD','999',''),  ('NAV','åº”ç”¨èœå•','','NO','YES','0','0',''),  ('ORG','ç»„ç»‡ç®¡ç†','/system/org/org.jsp','YES','YES','USERMANAGER','0','tree-org'),  ('ORG-DELETE','ç»„ç»‡åˆ é™¤','/org/delete*.jmt','YES','NO','ORG','999',''),  ('ORG-QUERY','ç»„ç»‡æŸ¥è¯¢','/org/get*.jmt','YES','NO','ORG','0',''),  ('ORG-UPDATE','ç»„ç»‡æ›´æ–°','/org/saveOrModify*.jmt','YES','NO','ORG','999',''),  ('PARTICIPATOR','ç»‘å®šç¯èŠ‚å‚ä¸è€…','/workflow/participator/participator.jsp','YES','YES','WORKFLOW','2',NULL),  ('participator-delete','å‚ä¸è€…è®¾ç½®åˆ é™¤','/wf/pp/deleteParticipator.jmt','YES','NO','PARTICIPATOR','999',NULL),  ('participator-modify','å‚ä¸è€…è®¾ç½®ä¿®æ”¹','/wf/pp/saveOrModifyParticipator.jmt','YES','NO','PARTICIPATOR','999',NULL),  ('participator-query','å‚ä¸è€…æŸ¥è¯¢','/wf/pp/get*.jmt','YES','NO','PARTICIPATOR','0',NULL),  ('PROCESSDF','æµç¨‹å®šä¹‰ç®¡ç†','/workflow/processDf/processDf.jsp','YES','YES','WORKFLOW','0',NULL),  ('processdf-delete','æµç¨‹å®šä¹‰åˆ é™¤','/wf/deleteProcessDf.jmt','YES','NO','PROCESSDF','2',NULL),  ('processdf-deploy','æµç¨‹å‘å¸ƒ','/wf/deployProcess.jmt','YES','NO','PROCESSDF','1',NULL),  ('processdf-query','æµç¨‹å®šä¹‰æŸ¥è¯¢','/wf/getProcessDf*.jmt','YES','NO','PROCESSDF','0',NULL),  ('PROCESSMT','æµç¨‹å®ä¾‹ç›‘æ§','/workflow/processMt/processMt.jsp','YES','YES','WORKFLOW','1',NULL),  ('processmt-cancel','æµç¨‹å®ä¾‹ç»“æŸ','/wf/cancelProcessInst.jmt','YES','NO','PROCESSMT','1',NULL),  ('processmt-delete','æµç¨‹å®ä¾‹åˆ é™¤','/wf/deleteProcessInst.jmt','NO','NO','PROCESSMT','2',NULL),  ('processmt-query','æµç¨‹å®ä¾‹æŸ¥è¯¢','/wf/getProcessInst*.jmt','YES','NO','PROCESSMT','0',NULL),  ('ROLE','è§’è‰²ç®¡ç†','/system/role/role.jsp','YES','YES','AUTHMANAGER','0','tree-role'),  ('ROLE-AUTH','è§’è‰²æˆæƒ','/role/saveAuth.jmt','YES','NO','ROLE','999',''),  ('ROLE-DELETE','è§’è‰²åˆ é™¤','/role/delete*.jmt','YES','NO','ROLE','999',''),  ('ROLE-QUERY','è§’è‰²æŸ¥è¯¢','/role/get*.jmt','YES','NO','ROLE','0',''),  ('ROLE-UPDATE','è§’è‰²æ›´æ–°','/role/saveOrModify*.jmt','YES','NO','ROLE','999',''),  ('SOURCE','èµ„æºç®¡ç†','/system/resource/source.jsp','YES','YES','CF','2','tree-source'),  ('SOURCE-DELETE','èµ„æºåˆ é™¤','/resource/delete*.jmt','YES','NO','SOURCE','999',''),  ('SOURCE-QUERY','èµ„æºæŸ¥è¯¢','/resource/get*.jmt','YES','NO','SOURCE','0',''),  ('SOURCE-UPDATE','èµ„æºæ›´æ–°','/resource/saveOrModify*.jmt','YES','NO','SOURCE','999',''),  ('SYS','ç³»ç»Ÿç®¡ç†','','NO','YES','0','0',''),  ('SYSLOG','ç³»ç»Ÿæ—¥å¿—','/system/log/sysLog.jsp','YES','YES','LOG','0','tree-sysLog'),  ('SYSLOG-LEVEL','ä¿®æ”¹æ—¥å¿—çº§åˆ«','/log/*LogLevel.jmt','YES','NO','SYSLOG','1',NULL),  ('SYSLOG-QUERY','ç³»ç»Ÿæ—¥å¿—æŸ¥è¯¢','/system/log/sysLog*.jsp','YES','NO','SYSLOG','0',NULL),  ('USER','ç”¨æˆ·ç®¡ç†','/system/user/user.jsp','YES','YES','USERMANAGER','1','tree-user'),  ('USER-DELETE','ç”¨æˆ·åˆ é™¤','/user/deleteUser.jmt','YES','NO','USER','2',''),  ('USER-DISABLED','ç”¨æˆ·å¯/ç¦ç”¨','/user/disabled*.jmt','YES','NO','USER','999',''),  ('USER-PWD','å¯†ç ä¿®æ”¹','/user/changePwd.jmt','YES','NO','USER','999',''),  ('USER-QUERY','ç”¨æˆ·æŸ¥è¯¢','/user/get*.jmt','YES','NO','USER','0',''),  ('USER-ROLE','ç”¨æˆ·è§’è‰²ç®¡ç†','/user/saveRoleByUser.jmt','YES','NO','USER','999',''),  ('USER-UPDATE','ç”¨æˆ·æ›´æ–°','/user/saveOrModify*.jmt','YES','NO','USER','1',''),  ('USERMANAGER','ç”¨æˆ·ç®¡ç†',NULL,'NO','YES','SYS','2',NULL),  ('WORKFLOW','æµç¨‹èœå•',NULL,'NO','YES','0','999',NULL);
INSERT INTO `t_sys_role` VALUES ('COMMONUSER','æ™®é€šç”¨æˆ·',NULL,'NO'),  ('TESTDD','æ•°æ®å­—å…¸æµ‹è¯•è§’è‰²',NULL,'NO');
INSERT INTO `t_sys_role_res` VALUES ('COMMONUSER','ATT-DELETE','2012-06-11 21:27:13'),  ('COMMONUSER','ATT-DOWNLOAD','2012-06-11 21:27:13'),  ('COMMONUSER','ATT-UPLOAD','2012-06-11 21:27:13'),  ('COMMONUSER','HOME','2012-06-11 21:27:13'),  ('COMMONUSER','LEFTMENU','2012-06-11 21:27:13'),  ('COMMONUSER','MYPWD','2012-06-11 21:27:13'),  ('COMMONUSER','MYPWD-CHANGE','2012-06-11 21:27:13'),  ('COMMONUSER','USERMANAGER','2012-06-11 21:27:13'),  ('TESTDD','APPLOG','2012-06-11 21:34:10'),  ('TESTDD','APPLOG-QUERY','2012-06-11 21:34:10'),  ('TESTDD','ATT','2012-06-11 21:34:10'),  ('TESTDD','AUTH','2012-06-11 21:34:10'),  ('TESTDD','AUTH-QUERY','2012-06-11 21:34:10'),  ('TESTDD','AUTHMANAGER','2012-06-11 21:34:10'),  ('TESTDD','CF','2012-06-11 21:34:10'),  ('TESTDD','CF-QUERY','2012-06-11 21:34:10'),  ('TESTDD','CONFIG','2012-06-11 21:34:10'),  ('TESTDD','DICT','2012-06-11 21:34:10'),  ('TESTDD','DICT-QUERY','2012-06-11 21:34:10'),  ('TESTDD','LOG','2012-06-11 21:34:10'),  ('TESTDD','ORG','2012-06-11 21:34:10'),  ('TESTDD','ORG-QUERY','2012-06-11 21:34:10'),  ('TESTDD','ROLE','2012-06-11 21:34:10'),  ('TESTDD','ROLE-QUERY','2012-06-11 21:34:10'),  ('TESTDD','SOURCE','2012-06-11 21:34:10'),  ('TESTDD','SOURCE-QUERY','2012-06-11 21:34:10'),  ('TESTDD','SYSLOG','2012-06-11 21:34:10'),  ('TESTDD','SYSLOG-QUERY','2012-06-11 21:34:10'),  ('TESTDD','USER','2012-06-11 21:34:10'),  ('TESTDD','USER-QUERY','2012-06-11 21:34:10'),  ('TESTDD','USERMANAGER','2012-06-11 21:34:10');
INSERT INTO `t_sys_user` VALUES ('ADMIN','ç³»ç»Ÿç®¡ç†å‘˜','é™ˆ','CHENYUN','6994d5fd8501c8576fcfd99c3386f085','male','chenyun313@163.com','18701309727','ROOT','YES','NO','0','SYSADMIN'),  ('AINAN','è‰¾æ¥ ','è‰¾','ainan','67de2274915e33d54ae338ffdabeee76',NULL,'ainan@163.com',NULL,'0021','YES','NO','0','COMMONUSER'),  ('ZHENGYQ','å¼ äºšå¥‡','å¼ ','zhangyq','77b01f654f188c182c6b6b28dffe8df8','male','zhengyq@163.com',NULL,'0021','YES','NO',NULL,'COMMONUSER');
INSERT INTO `t_sys_user_role` VALUES ('AINAN','TESTDD','2012-06-01 15:13:51');
