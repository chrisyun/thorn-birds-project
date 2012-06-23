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
INSERT INTO `jbpm4_extend_flowtype` VALUES ('2','请假流程(新)','leave','OAFLOW','2012-06-23 22:45:13','请假流程(新)');
INSERT INTO `jbpm4_extend_participator` VALUES ('1','test','test','org','0011,0012',NULL,'dfd');
INSERT INTO `jbpm4_lob` VALUES ('10002','0','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process name=\"leave\" xmlns=\"http://jbpm.org/4.3/jpdl\">\r\n   <start g=\"196,25,48,48\" name=\"start1\">\r\n      <transition to=\"申请\"/>\r\n   </start>\r\n   <task assignee=\"#{owner}\" form=\"request.jsp\" g=\"172,118,92,52\" name=\"申请\">\r\n      <transition to=\"经理审批\"/>\r\n   </task>\r\n   <task assignee=\"manager\" form=\"manager.jsp\" g=\"175,217,92,52\" name=\"经理审批\">\r\n      <transition g=\"-32,-8\" name=\"批准\" to=\"exclusive1\"/>\r\n      <transition g=\"128,221;124,165:-42,-18\" name=\"驳回\" to=\"申请\"/>\r\n   </task>\r\n   <decision expr=\"#{day > 3 ? \'老板审批\' : \'结束\'}\" g=\"200,308,48,48\" name=\"exclusive1\">\r\n      <transition g=\"-39,-10\" name=\"结束\" to=\"end1\"/>\r\n      <transition g=\"339,342:-71,-17\" name=\"老板审批\" to=\"老板审批\"/>\r\n   </decision>\r\n   <task assignee=\"boss\" form=\"boss.jsp\" g=\"294,375,92,52\" name=\"老板审批\">\r\n      <transition g=\"339,457:\" to=\"end1\"/>\r\n   </task>\r\n   <end g=\"199,445,48,48\" name=\"end1\"/>\r\n</process>','10001','leave.jpdl.xml'),  ('10003','0','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0]\0\0�\0\0\0mL�T\0\0>oIDATx���P[w~��g��tv����ٻw�<wӛ��<��d����γw���m�tw����ٴicߧIw�]o���dC��1IL,\'��6��k��`#�`�m�FXLd~jA\"�~��B���:���5�q��sG�?����w\0\0\0����>\0\0\0\0�]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]�fff������.B^R��ʺ�\0�͌.��%�&\'\'\'&&����޽1��� ����!\0\0֡�n�\"�w�d߱��]����{�?��˿��?��_��e�y*奣����FFFdeل:\0�\"t!�\'�G##�e��c���[�g���\'�����R���w�2�<��� ���w�B�p�:\0�\"t!�DE��������d�s9�w�>���m�}����KYAV��e�ONf�������NdW�!\0\0�.D:�(�����课��_v��[:�C6�\re������aٕ�4\0`�Ѕ�\\\"\nC���������{�\\i�!�沓�����H$B\Z\0�^�BX+��p�s/��D�č�E�\Z���Dvu�֭���\0��B�Z�;�ccc9��y������4�]�%\re�껆��+\0\0]���D������U?�޿~yէ�S�P�:O����{xxX���!�\0X���/�ݻ���?���r/4���2��u����ޑ��CL\0�t!��&�޽�8���^���d���́�N����M����x<���t3��XY6��SjcCc���©��[�y ���?Ĕ!\0\0kA�*���p�v�o�>\Z��4�ih,��z:[�������B��ͭ?_\'�Tv+;oii���?Ĕ!\0\0kA����C���Ύ-M]��\Z���e���z<j<P�o���+�^V�tK.�2��ʉn�6i\n��������`�\0�5�a	uo������ڶ��Ϸ��Pc�\Z��X-�o7Fl�P�ql�ؿ�c�cO������y���>u�ڵ۷o˟S�����\0ؐ�BXB�lbbbhȸ�DҰ��g-�ظ����[xJ^\r}_�Ω�\\=�V��`l2��en��$\n�O477�A�s�G�B\0\0V�.�%�������~��������WM=�c�\Z�Y=�N,��7ǖ4�c��[���jvI�BYYv.��@@���Q�Ӻ�=\0\0]K�/���=��>mx���O�+�߬��\rcI���������Oe��\n�%�T��j�5e��\\�Ĺs�����ϩ��~�\0\0lHt!,!q�DB��_��k�����С��==��84�UYn,Q���ş\Z�+�j�/�����~�s�G�B\0\0V�.�%�����>:}�����t�����tPNw0�����g_�8��Y���>�uuut!\0\0kD��.|��/:�o�\\Gi<�:T�I�@,�-�R��z���<3���u��8x6_��t�����B\0\0ւ.�%]��O~�݊R��������Y`u�.0w9�B��jj��8����\\�]\0��х�D��!�џ�?ɗ��wͻ�$����\'\rٹ�	�#\0�vt!,���W���s�S�5�&5͉[�$ߞ[޼p�������Dv.��N\0\0X;��Hܧ�����9�V�r�v����q-���Wk�%V��m2{O���_ת%u�Rٹ��/�O\r\0\0kG���Z������O���O��\n/>�~oh�����_�KzI��ne�\'N���\0\0�]K$~/��g~�w�^�5�5z�K��u�\\6c�i���BY2���$�����Cl\'�e���\Z~\0���a	����ɑ��۷o��\\���G%�>�����?�?n�?kS/��+��>n�[G-3��e��*����]�vM���9��t!\0\0�C�333�+�����������S7&oʘ�4����R�;��:�N���il�V6����<s�����;N�<y��E��ԗ�O�~�\0\0lHt!���_ܻw/�����������_�o�Fx�{�Cv\"��;v���Nv.B���9&\0X5�VI�2MMM;��o/��D�4���(��Ȯ***N�:%���3Y\0��х���2������ދ5�sϿ�������F�eC�\\vr�����ꆆ٭�\\���\0\0�]�)����������������g��������s+�B�D6��?��ӓ\'Oʮd��[ٹ�	&\0X#����/������oݺu��5��ʗ�1����G�9������9(+�j��l���K��ղٕ�Pv+;�?�d!\0\0kD�Z333�5�Hd``@J��������g5����!�ѿڱ����_~�?��\n.O|~�/C�SY(/�\n���\\�iٱc�N�:%��NdW�C٭�7\r��\0\0�]�%����`ww���ojj���;y�di�k9��}����/�����oː�T�K�Byy���,�Ȇ���DvE\0���B�C\"\r��Ɔ��{{{�@KK�ŋ%�jjjN�8QYY)�w���#1�@��ByIV��de�D6��e\'�+�\0�uD\"MT\ZNMM������������ttt\\�v�����Ν�z�uI�,��dYMV�MdC�\\v��SH\0�^�B��J�h4z�޽�w��a��۷o��@ �����ByIV��de�D6��e\'D!\0\0�.D�-�Ñ�������������,��dY�\"\0�Rt!�H���������ؘd_�D�K���F\0`)�:�:����E�Kj�\0\0Kх��ǣ�\0\0�Pt!�%++K�!\0\0���B�]\0�.t!�.\0@��B\0�]{�\0Ѕ.��D\"����G\0@��a#�p��p�>\n\0\02]�\0Ј.��Ѕ\0\0hD�F�B\0\04�a#�����\0�E�F������}\0\0d(�6B\0�]�\0Ј.��Ѕ\0\0hD�F�B\0\04�a#~���v�>\n\0\02]��|�G�Q\0\0���B�]\0�Ft!l�.\0@#�6B\0�]�\0Ј.�����>\n\0\02]�\0Ј.��Ѕ\0\0hD�F�B\0\04�a#t!\0\0\Zх����\Z�׫�(\0\0�Pt!l����|>�G\0@��a#t!\0\0\Zх��\0\0��B�]\0�Ft!l�.\0@#�6�r�:::t\0\0�.��8��`0��(\0\0�Pt!l�.\0@#�6B\0�]�v�ڕ5_QQ��\0 �ЅЯ��$9\n�9�v�u\0\0�.�~w�����VQ���S\\\\��d\0\0ҏ.�-�.t�\\�D\0@�����v��)]XRR��ب�p\0\0�Dt!�\"///\'\'筷ފF���\0�LD�.���w��y���\0@��a�h4\'\'gppP��\0\0���B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B������W��i�ZP)㷶`��x�G�����������\0\0[��,Cw\'_*����N����}�}��?K\0\0l�.ă�\Z[v�TZ=�S�JE�ɖ�e�N�Oܷ�P���ɫ��͇^(���ifF�g\n\0��ЅX��������x焯+�=�V=���O�J��\'߫�;���\0�^�B,EE�C/�[s]{ح��:����YC\0\0�хX��!��PZJ{ϭ��u��i��.���\0����S����v�%���L[������Aݟ4\0\0vA\"5u�����΢�JE�:����\0�.�B�069���6�&K���i5!z�S�\0\0�B�P�Tsi������\'^y��i��y\0`t!R��2�)�ҧ=�,G/u�����rݟ7\0\0�@\"u�Mv�y��6��p���\0��)|姥L��Q��f�P_���y\0`t!RP?\n��g�\Z���/�=����.\0�zt!RP]hiJ�?Wڻ�r�wk*)7Y�P�T��\r\0�-ЅHAc\Z����/�\0H���5](��r0f[r��y��Tk�y�B\0\0�B\"˺p�������.����yD�\0H�)h���co�s�\r��,.�V�\0X?t!R�y��B����5n�[�(�\0HF\"���.�z��.\0 ]�l҅�\0�Nt!R�}�p�ւ<�\0H/�)h�/���ڸ\0��B\0\0Ҍ.D\nZ�ks]�-PӅ��c\'t!\0\0��B���.�ɠ\0H��]\0@��.�%��n�z�w���\0��B��x�Gj�L[��n�z��|�E���\0\0[�3��o���_�r�޽�������n�Zl��~pJ��3�ڻ��q�sP��#�J��\0\0l�.� yyyY&�5w�^�`z��S�����JE����.o��_\0\0`Ctay������ߗ%7n�0���?*������1��f�x,�\\������\0�\rх����DGGGmm������WE�����g��ݻ7�,���UK3�si��z�h||> op����t:��\0\0`[t�f�[ZZ*++���$].�ta0��Ξ=+QXXXx��񲲲h4��~��Ք��A�\r��#�TW\"﮽���1\0\0�]��B���FI=G�<���p�j�o����=x��rv���NK9}姥��l����ւJyk��yff��\0\0]�Q�A�;�˕��_TTTYY�����ު��@V[���V7�y��C�����[�\nO�(ܲ���?���\0\0lt�111���kjj��ݛ���t:�;::d�u4�7�Xn���߻5׵W�\ZǡƠ:},o��֠u�\0\0]hk�p���UVV����n����ӓ�c�7�t�v�j�𕊦\r��C��\'����eH�2S\0�]h;�}���������466h<�����W�%\nUW��&�l>���毯�B\0\0R���F��˂N�377w�޽UUU~����h!9U~)����E�<~��̾�%\rnI\0��B=��������՗���w\0\0�u�B\r�\n\n�nw}}}��,\0\0��P�����\0\0\0�]�AQQ����\0\0\0zх\Z8�N��t\0\0\0�AjPVV��\0\0H�P�����t�UVVrE6\0\0�Ѕ\Z���>\n;�\0\04�5�z�555���B\0\04�5��|�G�Q�Wj\0�]����w�ݺ��R\0\0��B\r$}$�t�х\0\0hDj000PXX��(���v��~�G\0@��5���C�Q�w�\0@#��A���ZBE۪�*[��qn\nt!\0\0\Zet&\'����t�����m�,�[h��*�077�8����x�^�G\0@���.L�4�pp�x�`\"К.�F})q�o\0\04��.l��5_�?��]8�d��O�]��.�F})х\0\0hDJ��ү-�}s�g��,�/�Z�2ܐ%������J�G\0@���.�w]\"�����5]XVV��Ҳoas�`\0\0�(��tb8~b�����=�̅�)х\0\0h��]��2ដ���Ay6w��5�|�.%~	\0\0�2��$���^��zd��[SS��M73�\0\0���y�عb����&-��5\'LS�\0�(ӻ0q*���\"+k��`[�l#Z0_����n��6����@\0\04��.ԅ����B\0\04��(,,�}��D\n\n\nt\0\0�.ԃ���dee�>\0\02]�\r�\0\0�Ѕ����F�Q�Ga;|,\0\0�Bj�p8��>\0\0t��)**\n�B���v�B\0\0t��q:��`P�Q��\0�.t�6eee---���v�e\0\0t���x<>�O�Q�]\0�.t�6�1���v�n����}\0\0d\"�P��[SS��(l�iT\0\0t������}�C\0�]����w�ݺ��vjjj�^��\0\0 х��A�ө�(l��]\0�]����@aa��\0\0]�Bm�����}����XYY��(\0\0�Dt�NYYY��v�\0\0]�B�rss�Ѩ�\0\0]�B�G8�}���8\0\0�B�TTT\n�t�]�ڵ+k>�|t\0\0�.ԉ�NVRR��G����\0\0�]�SYYYKK��;w�dgg�(���-..&�\0H\'�P\'~�m���BՅ��$2\0\0iF��=��J޹s�����F݇\0@f�u�z�555���^���w�\0 ��B��W�Yuu�taUU��\0 �Ѕ:��~.�] \Z�fggG\"�\0@ơu��\0\0�>�B�\nu\0\0��.�);�G\0\0`�5����}\0\0\0�P���������F~(\0\0�Ej�[ZZ*++�����n�������}\\\0\0 �Ѕ6211���kjj��ݛ���t:kkk���33��_����ikA���������y9���K\Zc�Ӻ??\0\0�.��h4*E(](u���%�(�(�(�����N�Tv����So-���N�F�~�\0\0�\r]�1���x�^�۝��_TTTYY��Ғ��?�\Z[v�TZ=�S�JE�ɖ�e�N�Oܷ�P���ɫ��͇^(���if&�!\0\0�En<�P�����������px<��700`��~���^���u���ު��w���O����{�Cw\'-��\0\0�(�-�Y.,,�Lt�����V\\ڬ���߭��=��kQ�\r�ZPɬ!\0\0����$������������\\����z��WC@E�����[���\n���/�]\\��\0�FGnN�h������F]��.m�%�|���=<���3��Kn�Ǚ�>�]yw�]�V��\0\0`�3�����r���UUU���e^��� ?��Z{�Y4^�hRg����\0\0��х\'\n��׻�������J���S�<69���6�&K���i5!z�S�\0��Ff������F���p8�N�y��栚K�^o���>���|�HS��\0\0`t!���eSN�O{�Y:�^ꖷ�ǹ�?o\0\0t��u�Mv�y��6��p���\0Љ.�R���R	&��t�z��Q���\0Љ.�Rԏ���g��B\0\0֎.�RT���zl�~���nM��/غ�y[c�<o���<�\\~�<�n���X�-�\Z[�ҡީ��\0\0��B,e5]�(3��拧[R�%V�����lS��] ��t!\0\0�.�RVޅvu)\'��&-O��ނ��4\r�u��M\n��p��H\0@b)+�¤i��3�F�͏���v�:���S�۶;��n;`�\0�����v��w�gLnݚX-W��4Ϸ�@���/\\�T�\\q�<�l���J�\0�����P��I;�U�-g�0�Tr�|�욉�Ӌ�G�\0X!�KYq.�n���/���A��yG�;\0`�ЅXʪ�#uh�D2����4�2����|Ő.\0�.�RVu��.�t)I�����U���BIIu݉z�.\0`%�B,e5]hj��]؛|\rJb�����MRr�\Z\0\0V�.�RVsY����p�y��Yd�7SާF��Z^��͆<�\"]\0�2ЅXʺ�G��.\0�.�R�B\0\02]��l��Z���j�6��z��?o\0\0t�����<RKg���w��C���/:u�\0\0�Db)�����gڵw���B砼�G^=���\0@\'�K�]{]����OiO7K�+M�6����?o\0\0t�����Q	��^(��i�7��c9��6�_���y\0�]�x�ji�.��^o����\rn��\Z����a\0�]�h�\ZTS�:�7ܺ�PxR]������O\Z\0\0��B<��?:-�����n���ã�[*�=�癙��)\0�]���V7�y��C�����[�\nO�(ܲ���?��3\0@?���},�\\���ݚ�ګn��PcP�>���|kP��\0�-ЅX��{�O�ng�&_�h�p�8����q��X��.3�\0\0$ЅX�����W�%\nUW��&�l>���毯�B\0\0�хX1ɩ�K��.�(������g��.ipK\Z\0\0��B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B�Teee4\Z�}\0\0d�6�p8���\0\0 �Ѕ�)�\0�4�aSt!\0\0iF¦�B\0\0Ҍ.�M�B!�G\0@�aSN�3�>\n\0\02]��\0H3�6E\0�ft!l�.\0 ��Bؔ�������\0�B¦<����}\0\0d�6E\0�ft!l�.\0 ��B����=m�{�\ZK�*�bKY�Xkn�%х\0\0�]�5xPʳ��s/-�kjj�^�\r\0\0R��JF��U�5w��i�؃�Փ�9���kc��^\0\0�}�k�4_ϼ=�\n��7!}v�p���	t!\0\0iFb\rR�GN\n��X��0\\�t2]\0@�хX��y��M�^a�\0\0;��J���^�<{Ny�󅍍����־\0\0��.�\Z,u=r[�lο��2�}>�����\0�	]�5XЅ��꺓Ģ�;�Ѕ\0\0�]�5Xp=�$�����\0\\�F5��.\0 ��B��jA58.p��R\\����Ӆ\0\0�]�\n�N�S�Q\0\0�A�B�]\0@�х�)�\0�4�aSt!\0\0iF¦�B\0\0Ҍ.�M��a�á�(\0\0� t!l�.\0 ��B�ή]������H�A\0��х������(<r����}P\0\0l~t!l�Ν;���*\nsss�������\0`�aG����:�Id\0\0҃.��|��;w�.lll�}8\0\0d�6���\']�p8�Ѩ�c\0 #Ѕ����j�ª�*�\0@��aS�h4;;;��>\0\02]\0\0\0]\0\0\0];����D-�}t\0\0lNt!lG��pph(���)c2&\Z�NOO�:�}�\0\0lBt!�e6\n;?z韛q���D��ǥIC\0\0,B�FT\r������w��y�ў�����\'&&��(i\0���a�(��s\\��H���Ɓ����Q�\0\0+Ѕ��Qx�1<r6��sF\Z�6Ұx�h�_�4!\r\0Xwt!�K�R�҅�4�_o \r\0�]��)�͹��Mw�6\r��4\0�jt!tZl�P��X��&IC\0\0,EB�EOǢpdv����ei\0�U�B�\"\n���|��nR&����ᕷIC\0\0�@Bs�.�54|f8|f4�`�ы2£���YA��L\Z\0���B��9\n�/�>0�����yc���?H5Ԛ�	i\0����V�(�p1��2��9�i��)k~�7C�����\rY(/�\n�Z(��lH\Z\0���B��9\n/6���{����jTZ�/1�i�%YMV����J6\'\r\0X/t!����v��.v�K�����a�wd��ە�`�K���������\0\0���`�³�~v3�!m\'cA��q���e�|��VEWwE�̓��i\0��х��9\nϜ~���u��D�N�G�2e���rb�.ٕ�0Mi�V����*^3<�\'��m�Wb/���k�XdU\0\0�]k�(�L���m�h�%]b�<��(�����m�~@�͜���������r\0��~�ӅF�H�I�-)�~t!\0@�֒.&Ga˵d��9e\\k��ھ�z�����8^�g�?��7�m�\'�ʆƿ���>?�ّH�6�I�H$299)i�ַ�*�h��ۼ�SQ�\'e<.9��j0��T�5w!�\0�]k�� �����m-��ȸ~�#-���PO+��|�(���W^��ڳJý�p�r]ooo8�F���~��.ւɡ��ߛ��[ʢk%��CsϞ�t�\n�S\0�bt!�%]��ש����������j�P��}|\n���_r�P^�\r�Vj�P�5\Z��N���҅M�����S�ky)O/�8�[��-��A����y����\0�%�BX+х�ː��ot��%#7V�C�˅�Mn��P�3qa�t�ŋ�������]cΧ���hm{�\'���G>;w�x6���;��<_��F\"0S�G\0�Jt!�%](Yv��_��?ľ���ϝU�\\��]��|1r�%ɲ�D֝9��Ң�����}�����x<�1�R0fbbb�$>�7w*�vIם�@4W݃��s�	\0@��R]�D:�ix�a�͠۸�`�q�`w�b�)\\쾆]�*�m���M?|\"QX[�innnmmU�{{{;::�}>��²�2gL~~�j��{��%555j�===��Z�l��g�ƻ��2[��S���5�e�.څ����?\0d*�֒.�F�����p�F{c\"\r/\\��]�s���m�GMR�_u�w�?v���{\'�?y���d���>��p�BKK����;��S!��zU�L�^T�(�t~�إ����xmcc���壻�ͳ��G�\\��r�L�*�_;A9�h=��\0\0��.��fff���Ք���@��B\"\r�/���.�w2�Ǒ������G�7�ɟ����{L��dA^�r�ƍ�z�x����	��y�Ӌ~�����X*�俥®��7v9>���zֿ�5��;+��G���*o�\r���O\\s�\Z\0@ZЅ����������訴��zC\"\r}�ޔq����4������\Z<\Z���49\nee��ln�������n+�k����s�?~��я�>��|/6�����v�0{g|m�X7�Q�I����B�b��������B\0�u�BXN�a4\Z�JY���o~&���Z��T�p�����PV������QhϟH�R��555*���T��%eeej�ϧ6�D\"�\0��хH����ʕ��� c4� #�x��zj����32d�\r��!�*���Eu���Q�(ɨ�Q\"R-���R�k���\0llt!�d�4�z��ᑳ2F�6�qw�߻��e�sN֑�7e.S(RX__����r�RTᘛ����r����6��G��\0�.D�,?\r!��x�(\\y��;::TVUU�R,,,LL:�>L\0��ЅH���1#��sw��\ZQ8rV^\"\n׋���C\0\0�]�t[ά�$`�|��G$\n�]\00����Ґ(�]\00���2Ӑ���\0ft!�Y�w\r�B�Ѕ\0\03�:=0\r�B�Ѕ\0\03��-���(�����.\0�х�o�4�T��̱��斖�7n��.\0�х�s\Z��/\\�\\��x���_K���vtt�����.\0�х���4��������ꌑ�T�KD��х\0\03�6����H$K���y*��uA\0��B؋J���������q	��y Oe��D�]\00�a;�4�F��I�)Q�^�B\0�][�x<�as�\0ft!l�|�,\0��.���/�\0�х�5��\"|�\0\03��F�X�\0`F������\0��B�W8v8��bs�\0ft!�.�]\00�a_t�u�B\0�]���C\0��B�]h�\0`F¾B�PQQ���Tv�ڕ5�0\0 �.�}�A�ө�(6�����(<r����}P\0\0��a_tẻs�Nvv��������b��u\0�.�B�]h���BՅ��$2\0 ]������v�ܩ����Q��\0\0l�.�}х��˓.t8�hT��\0\0l�.�}�|>�ǣ�(6���j�ª�*�\0���EZ$\Z�fggG\"�\0���E\0�Nt!�.\0 ��B�]\0@:х����z��\0\0 m�B�Wm��\0\0 SЅ�/�\0�t�a_ޅ33��_����ikA���������y9���K\Zc�Ӻ??\0��х����¡��/�]|�E���[����Ӂ�Qݟ%\0`�B�Wfv��!�e�K��c9�T4�l�\\������};u�o�����|��_x�fft�\0��a_�����>���~���^���u���ު��w���O����{�Cw\'u�\0��a_�օ*\nz��ݚ���n�f�����\Z��х����BWC@E�����[���\n���/�]��\0�.�}eN�S����v�%���L[������Aݟ4\0`)t!�+s�P�A~rw����h�RѤ�&���\0K�a_n�����>\nˍMN��\r}���cxtZM�^�Ŕ!\0�]�r:��`P�QX��9��Ҵכ��O��6_=Ҥ��\0,�.�}eHnw��S�Ӟn������m�qn���\0�(���!]����.C6�PxR��.ݟ7\0`Qt!���\"��-����=�V�svM_&ː.��OK%�������꡾F���\0,�.�rI.�](��\0KUd\n҅�GA��3wt!\0lzt!�)1Y(5����s�k�/t8�px-{�T�2��ϕ�.�jC޶Á������y�T/�<�\\~�<�n��-o��ؒ��Nu�\0�EхX�٩�y����ȋ4c�n| �p}�P�n�����ݒ�H@Ơ�,Iu�2�s�s��<_���C�p�4g�m�pF\Z�s���K9q�TS\Z(]X���M�s�0�B\0�9��5x���H��:��Z0��⍘�`�17�`$��Cs���t�\n�SӅ\0�ЅX��)���\Z�<�*��}��w��ԥ8�����E��D�X�<�֭�8�L��хX���+Lq�\Z�{�1+�9Y~~���Ī7�(�4_?e\\P�pyC޶��4��@�G>�?ۂ�&��\'�JN�/T\'��p���t!\0l.t!�mv2���R]��Vc��sǱ竻0Y6\\�Q��*�0>՗�=s�%]w��\\u�/����N\0 3ЅX�yq��ydU�)�_�b�s�ta�1�j�lSQ8{�I~C�f��J�g�0�q\ryFD��n����E�pE�¡���B��2�#�|�B�pɑ��8��f.9��z.vFx�M\nW��BIIu���r�h�`��a_tჺ0�Ms~�.4Z0�mB����p��F0�NIs�\Z\0ؔ�B�]��Huarr)\Z]x ��Eíɷ��M4�z.�}jԟP���A��iE�\06>�6���H��]���]\06G¦���7�B\0�9�6�9]�e�Kj��;��۬����\0��aS�Ӆ��y��δ�i�6���͇_t���\0��aS�Ӆ�����gڵw���B砼�G^=���\0,�.�M�B���\"�G��k�K0=��)��f�x��I��v�W��\r\0X]�\n�NgF�s���`z��`���z�n<�S.o���nݟ7\0`Qt!l*s�P<�^�4�?��k�7�������p�ON���\0��aSՅ�]�j��B���[�\nO�+�w�^��I\0�B¦2���?:-�����n���ã�[*�=�癙��)\0�D¦2��&��\rky���+����e�*\n��pu�����\0@¦|>����}i�},�\\���ݚ�ګn��PcP�>���|kP��\0x0�6��](��M?����8|��i�}���;��ɫ��cR���FA¦2������+�����Po6�c~��W�N!\0l t!l*c�P��*����n�\"L��|f�钆\0���\r�.�Mex\0�~t!l������J�Q\0\0�A�B�Tm��\0\0 �Ѕ�)�\0�4�aSt!\0\0iF¦�B\0\0Ҍ.�Mх��Zo\0�]��p��|��b�����}\0\0ۡaSt���B\0�]��-E\0��B�]h)�\0`F¦�BKх\0\03�6�v��~��ش�B\0�]�r:��`P�QlZt!\0��.�Mх��\0ft!l�.�]\00�a/�v�ʚ���H�AmBt!\0��.�����$G�#G�n��ڄ�B\0�]{�s�Nvv������b�&[�.\0�х����BՅ.�����\0ft!l����ܹS¥�����Q��lNt!\0��.���������[�hT��lNt!\0��.�UWW�ܹ�ȑ#�dӢ\0ft!�(\Z�����>�M�.\0�х@&�\0ft!���B\0�]d\"�\0`F��.\0�х���E�>�̓.\0�х��}_�LOOG��)Y(/�u��5�\0ft!4K�d���h���_מ�p���Ԑ�7�_���MLLܻwO5\"u�t!\0��.�6�\"�<�q���=������M9�����ҋ}���HD\ZQ�:\\5�\0`FBU��v���{呯%������;��-׳�ː�4�e�w����P�{�H�B\0�]\rT������7T�����p�3ۮ|\\2��1�ݽ`��K��\n�@��ڟ�֝\Z\Z�:������\"\rW�.\0�хH7���U��{�K�����%�l�A��\\�>/�����%���GFF���H��\0ft!�*���v}��g��)���S{&�k������P(�I��\0ft!�GEa˯kU���My�x9C6,|�*\rO�$\r311�ill��q�����>4\0��ЅH��w\n_���s�o~k��kuQ��l��O��&^:]��i(�Z��ʾ���D�eeeɿ�,W+��e+�\0��i\"�611���f=�\'w[[S�^��ڼ7���߾��Sj��}�BaQʕe\'Y�~]�����oddD�J4\Z�L]���#%���Uع�n鼽{�f�8U~����FU~�9�>p\0�C\"�d��7ߕ�����A��J�I.v������y+ٕ�PV����C����H�޽{h�p�S�|��$��zUQV�X�}�\0�͆.D:��W�3�G�3s�u�ԪW���o��?��:�|��%��А��(ꦆ��w�z\0]˩����W�6z�e��3yU��(T�_�Ƃ�e��7�_{#�B����Ŧ\'&&�nwYY���GN�\06���8�F��o~K�����w[[�_���z���6o�Z�=�͸�����k׮%O.�����l�j+z��\0d��S\'�սi������M����\'_�YQ��U�l�Ocӕ�K�=k�\Z.����H$�.LV�������g%Yp���\0�.��$�n���~���̙#�Ǒ�?\\�>�`?��c�]�mm����S����Y&��\0`�����>�\\������oW�0Ɖ*5.�\"\neHM�?n�dv�꧖���S��_{�5s\nN�\0�\0]k�/־�O]M|��O����lu](c����?�y��+W$�_1nllt��999�w�~����\0�]kINMM��S,Ѷ�{��8p y����W݅���w%ѩ��ҥK�@���_��I�\'UUU����\n\0\0ft!������\'�5va�ta�ғ�rwk\0\0��a��.,|���-�W7�*q�.\0`u�BXKua⺓_\n\\�u\'v�~y��koЅ\0\0�]k�.l�;���}j����ĳc�������_��Yv��O\r]\0��Ѕ�����������¢�\\�}�o~�i�NԼ����S����\0\0,�.���}j$��|�)I�}�l7\Z�P��c���?*~��/�4��tJ���=+�w}��Ν[p�\Z�\0�e�a���iI��w�H�����p��a��#<�^��ˌ�w�߽۟6os�����R�O~.]��ֺ�=\0\0]�}��������(�zs�ӿLvv.�_Ue=��F�1�軼`[׳ϫ⬩��x���O�<��\0�\r�.��T���~�\r	���t��Nww/w[[��m�T��\"�V�+u�I���r�ܹ�N�B\0\0V�.��_1�sG�M&�?�{��y�k��t=���O<�����R�|�U�2����jO��x�b�Id�\\\0��Ѕ��ę�2i����&���SS]])ko�C6��� ��RW��P(�8�L\0�|t!�Amjjjlllhh���ru�\Z�7�u�5����l�.p�]��ꛅ��B�s�D\0`E�B�Cb�0�����.9��0�ѯ���4\neu7l�uuu�r0��\'�Y�d!\0\0+B\"MԷ\'&&FFF���$\r�	����{f�b_7\\0F�����B�<9\n��&�s�|�\0�U��&j�P�M�áP��麬��D]n�������={i����Ns�ByIVP�)T������Pv(�M�A�\0X)��cN����ï��|Sk)�����O<��m2�<M䠚&,���kO�Rw�!\n\0X/t!�jA\Z���uuu]�t�]��T\'�Sy��o���?Ϯ��RW�\\�r������\0����n�i822�������]��X�PSr��w�H�%�<=�ߥ&eU�j�P6��e\'D!\0\0kGB�D\ZNLLD\"������>U��mm�|Wb.%QK�%YA�l\"���\0�����J�h4j�D��X�{{{�������` �<��򒬠�PM���\0�����L̂:������Q�e��$+�j��(\0`��Bh�\\�SSS*�H��BYAV�\0Xwt!l!Q�bzzZ5��P^R�P�\0\0�;�v4���\0�f������S�)\0\0\0\0IEND�B`�','10001','leave.png'),  ('10009','0','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process name=\"leave\" xmlns=\"http://jbpm.org/4.3/jpdl\">\r\n   <start g=\"196,25,48,48\" name=\"start1\">\r\n      <transition to=\"申请\"/>\r\n   </start>\r\n   <task assignee=\"#{owner}\" form=\"request.jsp\" g=\"172,118,92,52\" name=\"申请\">\r\n      <transition to=\"经理审批\"/>\r\n   </task>\r\n   <task assignee=\"manager\" form=\"manager.jsp\" g=\"175,217,92,52\" name=\"经理审批\">\r\n      <transition g=\"-32,-8\" name=\"批准\" to=\"exclusive1\"/>\r\n      <transition g=\"128,221;124,165:-42,-18\" name=\"驳回\" to=\"申请\"/>\r\n   </task>\r\n   <decision expr=\"#{day > 3 ? \'老板审批\' : \'结束\'}\" g=\"200,308,48,48\" name=\"exclusive1\">\r\n      <transition g=\"-39,-10\" name=\"结束\" to=\"end1\"/>\r\n      <transition g=\"339,342:-71,-17\" name=\"老板审批\" to=\"老板审批\"/>\r\n   </decision>\r\n   <task assignee=\"boss\" form=\"boss.jsp\" g=\"294,375,92,52\" name=\"老板审批\">\r\n      <transition g=\"339,457:\" to=\"end1\"/>\r\n   </task>\r\n   <end g=\"199,445,48,48\" name=\"end1\"/>\r\n</process>','10008','leave.jpdl.xml'),  ('10010','0','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0]\0\0�\0\0\0mL�T\0\0>oIDATx���P[w~��g��tv����ٻw�<wӛ��<��d����γw���m�tw����ٴicߧIw�]o���dC��1IL,\'��6��k��`#�`�m�FXLd~jA\"�~��B���:���5�q��sG�?����w\0\0\0����>\0\0\0\0�]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]�fff������.B^R��ʺ�\0�͌.��%�&\'\'\'&&����޽1��� ����!\0\0֡�n�\"�w�d߱��]����{�?��˿��?��_��e�y*奣����FFFdeل:\0�\"t!�\'�G##�e��c���[�g���\'�����R���w�2�<��� ���w�B�p�:\0�\"t!�DE��������d�s9�w�>���m�}����KYAV��e�ONf�������NdW�!\0\0�.D:�(�����课��_v��[:�C6�\re������aٕ�4\0`�Ѕ�\\\"\nC���������{�\\i�!�沓�����H$B\Z\0�^�BX+��p�s/��D�č�E�\Z���Dvu�֭���\0��B�Z�;�ccc9��y������4�]�%\re�껆��+\0\0]���D������U?�޿~yէ�S�P�:O����{xxX���!�\0X���/�ݻ���?���r/4���2��u����ޑ��CL\0�t!��&�޽�8���^���d���́�N����M����x<���t3��XY6��SjcCc���©��[�y ���?Ĕ!\0\0kA�*���p�v�o�>\Z��4�ih,��z:[�������B��ͭ?_\'�Tv+;oii���?Ĕ!\0\0kA����C���Ύ-M]��\Z���e���z<j<P�o���+�^V�tK.�2��ʉn�6i\n��������`�\0�5�a	uo������ڶ��Ϸ��Pc�\Z��X-�o7Fl�P�ql�ؿ�c�cO������y���>u�ڵ۷o˟S�����\0ؐ�BXB�lbbbhȸ�DҰ��g-�ظ����[xJ^\r}_�Ω�\\=�V��`l2��en��$\n�O477�A�s�G�B\0\0V�.�%�������~��������WM=�c�\Z�Y=�N,��7ǖ4�c��[���jvI�BYYv.��@@���Q�Ӻ�=\0\0]K�/���=��>mx���O�+�߬��\rcI���������Oe��\n�%�T��j�5e��\\�Ĺs�����ϩ��~�\0\0lHt!,!q�DB��_��k�����С��==��84�UYn,Q���ş\Z�+�j�/�����~�s�G�B\0\0V�.�%�����>:}�����t�����tPNw0�����g_�8��Y���>�uuut!\0\0kD��.|��/:�o�\\Gi<�:T�I�@,�-�R��z���<3���u��8x6_��t�����B\0\0ւ.�%]��O~�݊R��������Y`u�.0w9�B��jj��8����\\�]\0��х�D��!�џ�?ɗ��wͻ�$����\'\rٹ�	�#\0�vt!,���W���s�S�5�&5͉[�$ߞ[޼p�������Dv.��N\0\0X;��Hܧ�����9�V�r�v����q-���Wk�%V��m2{O���_ת%u�Rٹ��/�O\r\0\0kG���Z������O���O��\n/>�~oh�����_�KzI��ne�\'N���\0\0�]K$~/��g~�w�^�5�5z�K��u�\\6c�i���BY2���$�����Cl\'�e���\Z~\0���a	����ɑ��۷o��\\���G%�>�����?�?n�?kS/��+��>n�[G-3��e��*����]�vM���9��t!\0\0�C�333�+�����������S7&oʘ�4����R�;��:�N���il�V6����<s�����;N�<y��E��ԗ�O�~�\0\0lHt!���_ܻw/�����������_�o�Fx�{�Cv\"��;v���Nv.B���9&\0X5�VI�2MMM;��o/��D�4���(��Ȯ***N�:%���3Y\0��х���2������ދ5�sϿ�������F�eC�\\vr�����ꆆ٭�\\���\0\0�]�)����������������g��������s+�B�D6��?��ӓ\'Oʮd��[ٹ�	&\0X#����/������oݺu��5��ʗ�1����G�9������9(+�j��l���K��ղٕ�Pv+;�?�d!\0\0kD�Z333�5�Hd``@J��������g5����!�ѿڱ����_~�?��\n.O|~�/C�SY(/�\n���\\�iٱc�N�:%��NdW�C٭�7\r��\0\0�]�%����`ww���ojj���;y�di�k9��}����/�����oː�T�K�Byy���,�Ȇ���DvE\0���B�C\"\r��Ɔ��{{{�@KK�ŋ%�jjjN�8QYY)�w���#1�@��ByIV��de�D6��e\'�+�\0�uD\"MT\ZNMM������������ttt\\�v�����Ν�z�uI�,��dYMV�MdC�\\v��SH\0�^�B��J�h4z�޽�w��a��۷o��@ �����ByIV��de�D6��e\'D!\0\0�.D�-�Ñ�������������,��dY�\"\0�Rt!�H���������ؘd_�D�K���F\0`)�:�:����E�Kj�\0\0Kх��ǣ�\0\0�Pt!�%++K�!\0\0���B�]\0�.t!�.\0@��B\0�]{�\0Ѕ.��D\"����G\0@��a#�p��p�>\n\0\02]�\0Ј.��Ѕ\0\0hD�F�B\0\04�a#�����\0�E�F������}\0\0d(�6B\0�]�\0Ј.��Ѕ\0\0hD�F�B\0\04�a#~���v�>\n\0\02]��|�G�Q\0\0���B�]\0�Ft!l�.\0@#�6B\0�]�\0Ј.�����>\n\0\02]�\0Ј.��Ѕ\0\0hD�F�B\0\04�a#t!\0\0\Zх����\Z�׫�(\0\0�Pt!l����|>�G\0@��a#t!\0\0\Zх��\0\0��B�]\0�Ft!l�.\0@#�6�r�:::t\0\0�.��8��`0��(\0\0�Pt!l�.\0@#�6B\0�]�v�ڕ5_QQ��\0 �ЅЯ��$9\n�9�v�u\0\0�.�~w�����VQ���S\\\\��d\0\0ҏ.�-�.t�\\�D\0@�����v��)]XRR��ب�p\0\0�Dt!�\"///\'\'筷ފF���\0�LD�.���w��y���\0@��a�h4\'\'gppP��\0\0���B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B������W��i�ZP)㷶`��x�G�����������\0\0[��,Cw\'_*����N����}�}��?K\0\0l�.ă�\Z[v�TZ=�S�JE�ɖ�e�N�Oܷ�P���ɫ��͇^(���ifF�g\n\0��ЅX��������x焯+�=�V=���O�J��\'߫�;���\0�^�B,EE�C/�[s]{ح��:����YC\0\0�хX��!��PZJ{ϭ��u��i��.���\0����S����v�%���L[������Aݟ4\0\0vA\"5u�����΢�JE�:����\0�.�B�069���6�&K���i5!z�S�\0\0�B�P�Tsi������\'^y��i��y\0`t!R��2�)�ҧ=�,G/u�����rݟ7\0\0�@\"u�Mv�y��6��p���\0��)|姥L��Q��f�P_���y\0`t!RP?\n��g�\Z���/�=����.\0�zt!RP]hiJ�?Wڻ�r�wk*)7Y�P�T��\r\0�-ЅHAc\Z����/�\0H���5](��r0f[r��y��Tk�y�B\0\0�B\"˺p�������.����yD�\0H�)h���co�s�\r��,.�V�\0X?t!R�y��B����5n�[�(�\0HF\"���.�z��.\0 ]�l҅�\0�Nt!R�}�p�ւ<�\0H/�)h�/���ڸ\0��B\0\0Ҍ.D\nZ�ks]�-PӅ��c\'t!\0\0��B���.�ɠ\0H��]\0@��.�%��n�z�w���\0��B��x�Gj�L[��n�z��|�E���\0\0[�3��o���_�r�޽�������n�Zl��~pJ��3�ڻ��q�sP��#�J��\0\0l�.� yyyY&�5w�^�`z��S�����JE����.o��_\0\0`Ctay������ߗ%7n�0���?*������1��f�x,�\\������\0�\rх����DGGGmm������WE�����g��ݻ7�,���UK3�si��z�h||> op����t:��\0\0`[t�f�[ZZ*++���$].�ta0��Ξ=+QXXXx��񲲲h4��~��Ք��A�\r��#�TW\"﮽���1\0\0�]��B���FI=G�<���p�j�o����=x��rv���NK9}姥��l����ւJyk��yff��\0\0]�Q�A�;�˕��_TTTYY�����ު��@V[���V7�y��C�����[�\nO�(ܲ���?���\0\0lt�111���kjj��ݛ���t:�;::d�u4�7�Xn���߻5׵W�\ZǡƠ:},o��֠u�\0\0]hk�p���UVV����n����ӓ�c�7�t�v�j�𕊦\r��C��\'����eH�2S\0�]h;�}���������466h<�����W�%\nUW��&�l>���毯�B\0\0R���F��˂N�377w�޽UUU~����h!9U~)����E�<~��̾�%\rnI\0��B=��������՗���w\0\0�u�B\r�\n\n�nw}}}��,\0\0��P�����\0\0\0�]�AQQ����\0\0\0zх\Z8�N��t\0\0\0�AjPVV��\0\0H�P�����t�UVVrE6\0\0�Ѕ\Z���>\n;�\0\04�5�z�555���B\0\04�5��|�G�Q�Wj\0�]����w�ݺ��R\0\0��B\r$}$�t�х\0\0hDj000PXX��(���v��~�G\0@��5���C�Q�w�\0@#��A���ZBE۪�*[��qn\nt!\0\0\Zet&\'����t�����m�,�[h��*�077�8����x�^�G\0@���.L�4�pp�x�`\"К.�F})q�o\0\04��.l��5_�?��]8�d��O�]��.�F})х\0\0hDJ��ү-�}s�g��,�/�Z�2ܐ%������J�G\0@���.�w]\"�����5]XVV��Ҳoas�`\0\0�(��tb8~b�����=�̅�)х\0\0h��]��2ដ���Ay6w��5�|�.%~	\0\0�2��$���^��zd��[SS��M73�\0\0���y�عb����&-��5\'LS�\0�(ӻ0q*���\"+k��`[�l#Z0_����n��6����@\0\04��.ԅ����B\0\04��(,,�}��D\n\n\nt\0\0�.ԃ���dee�>\0\02]�\r�\0\0�Ѕ����F�Q�Ga;|,\0\0�Bj�p8��>\0\0t��)**\n�B���v�B\0\0t��q:��`P�Q��\0�.t�6eee---���v�e\0\0t���x<>�O�Q�]\0�.t�6�1���v�n����}\0\0d\"�P��[SS��(l�iT\0\0t������}�C\0�]����w�ݺ��vjjj�^��\0\0 х��A�ө�(l��]\0�]����@aa��\0\0]�Bm�����}����XYY��(\0\0�Dt�NYYY��v�\0\0]�B�rss�Ѩ�\0\0]�B�G8�}���8\0\0�B�TTT\n�t�]�ڵ+k>�|t\0\0�.ԉ�NVRR��G����\0\0�]�SYYYKK��;w�dgg�(���-..&�\0H\'�P\'~�m���BՅ��$2\0\0iF��=��J޹s�����F݇\0@f�u�z�555���^���w�\0 ��B��W�Yuu�taUU��\0 �Ѕ:��~.�] \Z�fggG\"�\0@ơu��\0\0�>�B�\nu\0\0��.�);�G\0\0`�5����}\0\0\0�P���������F~(\0\0�Ej�[ZZ*++�����n�������}\\\0\0 �Ѕ6211���kjj��ݛ���t:kkk���33��_����ikA���������y9���K\Zc�Ӻ??\0\0�.��h4*E(](u���%�(�(�(�����N�Tv����So-���N�F�~�\0\0�\r]�1���x�^�۝��_TTTYY��Ғ��?�\Z[v�TZ=�S�JE�ɖ�e�N�Oܷ�P���ɫ��͇^(���if&�!\0\0�En<�P�����������px<��700`��~���^���u���ު��w���O����{�Cw\'-��\0\0�(�-�Y.,,�Lt�����V\\ڬ���߭��=��kQ�\r�ZPɬ!\0\0����$������������\\����z��WC@E�����[���\n���/�]\\��\0�FGnN�h������F]��.m�%�|���=<���3��Kn�Ǚ�>�]yw�]�V��\0\0`�3�����r���UUU���e^��� ?��Z{�Y4^�hRg����\0\0��х\'\n��׻�������J���S�<69���6�&K���i5!z�S�\0��Ff������F���p8�N�y��栚K�^o���>���|�HS��\0\0`t!���eSN�O{�Y:�^ꖷ�ǹ�?o\0\0t��u�Mv�y��6��p���\0Љ.�R���R	&��t�z��Q���\0Љ.�Rԏ���g��B\0\0֎.�RT���zl�~���nM��/غ�y[c�<o���<�\\~�<�n���X�-�\Z[�ҡީ��\0\0��B,e5]�(3��拧[R�%V�����lS��] ��t!\0\0�.�RVޅvu)\'��&-O��ނ��4\r�u��M\n��p��H\0@b)+�¤i��3�F�͏���v�:���S�۶;��n;`�\0�����v��w�gLnݚX-W��4Ϸ�@���/\\�T�\\q�<�l���J�\0�����P��I;�U�-g�0�Tr�|�욉�Ӌ�G�\0X!�KYq.�n���/���A��yG�;\0`�ЅXʪ�#uh�D2����4�2����|Ő.\0�.�RVu��.�t)I�����U���BIIu݉z�.\0`%�B,e5]hj��]؛|\rJb�����MRr�\Z\0\0V�.�RVsY����p�y��Yd�7SާF��Z^��͆<�\"]\0�2ЅXʺ�G��.\0�.�R�B\0\02]��l��Z���j�6��z��?o\0\0t�����<RKg���w��C���/:u�\0\0�Db)�����gڵw���B砼�G^=���\0@\'�K�]{]����OiO7K�+M�6����?o\0\0t�����Q	��^(��i�7��c9��6�_���y\0�]�x�ji�.��^o����\rn��\Z����a\0�]�h�\ZTS�:�7ܺ�PxR]������O\Z\0\0��B<��?:-�����n���ã�[*�=�癙��)\0�]���V7�y��C�����[�\nO�(ܲ���?��3\0@?���},�\\���ݚ�ګn��PcP�>���|kP��\0�-ЅX��{�O�ng�&_�h�p�8����q��X��.3�\0\0$ЅX�����W�%\nUW��&�l>���毯�B\0\0�хX1ɩ�K��.�(������g��.ipK\Z\0\0��B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B�Teee4\Z�}\0\0d�6�p8���\0\0 �Ѕ�)�\0�4�aSt!\0\0iF¦�B\0\0Ҍ.�M�B!�G\0@�aSN�3�>\n\0\02]��\0H3�6E\0�ft!l�.\0 ��Bؔ�������\0�B¦<����}\0\0d�6E\0�ft!l�.\0 ��B����=m�{�\ZK�*�bKY�Xkn�%х\0\0�]�5xPʳ��s/-�kjj�^�\r\0\0R��JF��U�5w��i�؃�Փ�9���kc��^\0\0�}�k�4_ϼ=�\n��7!}v�p���	t!\0\0iFb\rR�GN\n��X��0\\�t2]\0@�хX��y��M�^a�\0\0;��J���^�<{Ny�󅍍����־\0\0��.�\Z,u=r[�lο��2�}>�����\0�	]�5XЅ��꺓Ģ�;�Ѕ\0\0�]�5Xp=�$�����\0\\�F5��.\0 ��B��jA58.p��R\\����Ӆ\0\0�]�\n�N�S�Q\0\0�A�B�]\0@�х�)�\0�4�aSt!\0\0iF¦�B\0\0Ҍ.�M��a�á�(\0\0� t!l�.\0 ��B�ή]������H�A\0��х������(<r����}P\0\0l~t!l�Ν;���*\nsss�������\0`�aG����:�Id\0\0҃.��|��;w�.lll�}8\0\0d�6���\']�p8�Ѩ�c\0 #Ѕ����j�ª�*�\0@��aS�h4;;;��>\0\02]\0\0\0]\0\0\0];����D-�}t\0\0lNt!lG��pph(���)c2&\Z�NOO�:�}�\0\0lBt!�e6\n;?z韛q���D��ǥIC\0\0,B�FT\r������w��y�ў�����\'&&��(i\0���a�(��s\\��H���Ɓ����Q�\0\0+Ѕ��Qx�1<r6��sF\Z�6Ұx�h�_�4!\r\0Xwt!�K�R�҅�4�_o \r\0�]��)�͹��Mw�6\r��4\0�jt!tZl�P��X��&IC\0\0,EB�EOǢpdv����ei\0�U�B�\"\n���|��nR&����ᕷIC\0\0�@Bs�.�54|f8|f4�`�ы2£���YA��L\Z\0���B��9\n�/�>0�����yc���?H5Ԛ�	i\0����V�(�p1��2��9�i��)k~�7C�����\rY(/�\n�Z(��lH\Z\0���B��9\n/6���{����jTZ�/1�i�%YMV����J6\'\r\0X/t!����v��.v�K�����a�wd��ە�`�K���������\0\0���`�³�~v3�!m\'cA��q���e�|��VEWwE�̓��i\0��х��9\nϜ~���u��D�N�G�2e���rb�.ٕ�0Mi�V����*^3<�\'��m�Wb/���k�XdU\0\0�]k�(�L���m�h�%]b�<��(�����m�~@�͜���������r\0��~�ӅF�H�I�-)�~t!\0@�֒.&Ga˵d��9e\\k��ھ�z�����8^�g�?��7�m�\'�ʆƿ���>?�ّH�6�I�H$299)i�ַ�*�h��ۼ�SQ�\'e<.9��j0��T�5w!�\0�]k�� �����m-��ȸ~�#-���PO+��|�(���W^��ڳJý�p�r]ooo8�F���~��.ւɡ��ߛ��[ʢk%��CsϞ�t�\n�S\0�bt!�%]��ש����������j�P��}|\n���_r�P^�\r�Vj�P�5\Z��N���҅M�����S�ky)O/�8�[��-��A����y����\0�%�BX+х�ː��ot��%#7V�C�˅�Mn��P�3qa�t�ŋ�������]cΧ���hm{�\'���G>;w�x6���;��<_��F\"0S�G\0�Jt!�%](Yv��_��?ľ���ϝU�\\��]��|1r�%ɲ�D֝9��Ң�����}�����x<�1�R0fbbb�$>�7w*�vIם�@4W݃��s�	\0@��R]�D:�ix�a�͠۸�`�q�`w�b�)\\쾆]�*�m���M?|\"QX[�innnmmU�{{{;::�}>��²�2gL~~�j��{��%555j�===��Z�l��g�ƻ��2[��S���5�e�.څ����?\0d*�֒.�F�����p�F{c\"\r/\\��]�s���m�GMR�_u�w�?v���{\'�?y���d���>��p�BKK����;��S!��zU�L�^T�(�t~�إ����xmcc���壻�ͳ��G�\\��r�L�*�_;A9�h=��\0\0��.��fff���Ք���@��B\"\r�/���.�w2�Ǒ������G�7�ɟ����{L��dA^�r�ƍ�z�x����	��y�Ӌ~�����X*�俥®��7v9>���zֿ�5��;+��G���*o�\r���O\\s�\Z\0@ZЅ����������訴��zC\"\r}�ޔq����4������\Z<\Z���49\nee��ln�������n+�k����s�?~��я�>��|/6�����v�0{g|m�X7�Q�I����B�b��������B\0�u�BXN�a4\Z�JY���o~&���Z��T�p�����PV������QhϟH�R��555*���T��%eeej�ϧ6�D\"�\0��хH����ʕ��� c4� #�x��zj����32d�\r��!�*���Eu���Q�(ɨ�Q\"R-���R�k���\0llt!�d�4�z��ᑳ2F�6�qw�߻��e�sN֑�7e.S(RX__����r�RTᘛ����r����6��G��\0�.D�,?\r!��x�(\\y��;::TVUU�R,,,LL:�>L\0��ЅH���1#��sw��\ZQ8rV^\"\n׋���C\0\0�]�t[ά�$`�|��G$\n�]\00����Ґ(�]\00���2Ӑ���\0ft!�Y�w\r�B�Ѕ\0\03�:=0\r�B�Ѕ\0\03��-���(�����.\0�х�o�4�T��̱��斖�7n��.\0�х�s\Z��/\\�\\��x���_K���vtt�����.\0�х���4��������ꌑ�T�KD��х\0\03�6����H$K���y*��uA\0��B؋J���������q	��y Oe��D�]\00�a;�4�F��I�)Q�^�B\0�][�x<�as�\0ft!l�|�,\0��.���/�\0�х�5��\"|�\0\03��F�X�\0`F������\0��B�W8v8��bs�\0ft!�.�]\00�a_t�u�B\0�]���C\0��B�]h�\0`F¾B�PQQ���Tv�ڕ5�0\0 �.�}�A�ө�(6�����(<r����}P\0\0��a_tẻs�Nvv��������b��u\0�.�B�]h���BՅ��$2\0 ]������v�ܩ����Q��\0\0l�.�}х��˓.t8�hT��\0\0l�.�}�|>�ǣ�(6���j�ª�*�\0���EZ$\Z�fggG\"�\0���E\0�Nt!�.\0 ��B�]\0@:х����z��\0\0 m�B�Wm��\0\0 SЅ�/�\0�t�a_ޅ33��_����ikA���������y9���K\Zc�Ӻ??\0��х����¡��/�]|�E���[����Ӂ�Qݟ%\0`�B�Wfv��!�e�K��c9�T4�l�\\������};u�o�����|��_x�fft�\0��a_�����>���~���^���u���ު��w���O����{�Cw\'u�\0��a_�օ*\nz��ݚ���n�f�����\Z��х����BWC@E�����[���\n���/�]��\0�.�}eN�S����v�%���L[������Aݟ4\0`)t!�+s�P�A~rw����h�RѤ�&���\0K�a_n�����>\nˍMN��\r}���cxtZM�^�Ŕ!\0�]�r:��`P�QX��9��Ҵכ��O��6_=Ҥ��\0,�.�}eHnw��S�Ӟn������m�qn���\0�(���!]����.C6�PxR��.ݟ7\0`Qt!���\"��-����=�V�svM_&ː.��OK%�������꡾F���\0,�.�rI.�](��\0KUd\n҅�GA��3wt!\0lzt!�)1Y(5����s�k�/t8�px-{�T�2��ϕ�.�jC޶Á������y�T/�<�\\~�<�n��-o��ؒ��Nu�\0�EхX�٩�y����ȋ4c�n| �p}�P�n�����ݒ�H@Ơ�,Iu�2�s�s��<_���C�p�4g�m�pF\Z�s���K9q�TS\Z(]X���M�s�0�B\0�9��5x���H��:��Z0��⍘�`�17�`$��Cs���t�\n�SӅ\0�ЅX��)���\Z�<�*��}��w��ԥ8�����E��D�X�<�֭�8�L��хX���+Lq�\Z�{�1+�9Y~~���Ī7�(�4_?e\\P�pyC޶��4��@�G>�?ۂ�&��\'�JN�/T\'��p���t!\0l.t!�mv2���R]��Vc��sǱ竻0Y6\\�Q��*�0>՗�=s�%]w��\\u�/����N\0 3ЅX�yq��ydU�)�_�b�s�ta�1�j�lSQ8{�I~C�f��J�g�0�q\ryFD��n����E�pE�¡���B��2�#�|�B�pɑ��8��f.9��z.vFx�M\nW��BIIu���r�h�`��a_tჺ0�Ms~�.4Z0�mB����p��F0�NIs�\Z\0ؔ�B�]��Huarr)\Z]x ��Eíɷ��M4�z.�}jԟP���A��iE�\06>�6���H��]���]\06G¦���7�B\0�9�6�9]�e�Kj��;��۬����\0��aS�Ӆ��y��δ�i�6���͇_t���\0��aS�Ӆ�����gڵw���B砼�G^=���\0,�.�M�B���\"�G��k�K0=��)��f�x��I��v�W��\r\0X]�\n�NgF�s���`z��`���z�n<�S.o���nݟ7\0`Qt!l*s�P<�^�4�?��k�7�������p�ON���\0��aSՅ�]�j��B���[�\nO�+�w�^��I\0�B¦2���?:-�����n���ã�[*�=�癙��)\0�D¦2��&��\rky���+����e�*\n��pu�����\0@¦|>����}i�},�\\���ݚ�ګn��PcP�>���|kP��\0x0�6��](��M?����8|��i�}���;��ɫ��cR���FA¦2������+�����Po6�c~��W�N!\0l t!l*c�P��*����n�\"L��|f�钆\0���\r�.�Mex\0�~t!l������J�Q\0\0�A�B�Tm��\0\0 �Ѕ�)�\0�4�aSt!\0\0iF¦�B\0\0Ҍ.�Mх��Zo\0�]��p��|��b�����}\0\0ۡaSt���B\0�]��-E\0��B�]h)�\0`F¦�BKх\0\03�6�v��~��ش�B\0�]�r:��`P�QlZt!\0��.�Mх��\0ft!l�.�]\00�a/�v�ʚ���H�AmBt!\0��.�����$G�#G�n��ڄ�B\0�]{�s�Nvv������b�&[�.\0�х����BՅ.�����\0ft!l����ܹS¥�����Q��lNt!\0��.���������[�hT��lNt!\0��.�UWW�ܹ�ȑ#�dӢ\0ft!�(\Z�����>�M�.\0�х@&�\0ft!���B\0�]d\"�\0`F��.\0�х���E�>�̓.\0�х��}_�LOOG��)Y(/�u��5�\0ft!4K�d���h���_מ�p���Ԑ�7�_���MLLܻwO5\"u�t!\0��.�6�\"�<�q���=������M9�����ҋ}���HD\ZQ�:\\5�\0`FBU��v���{呯%������;��-׳�ː�4�e�w����P�{�H�B\0�]\rT������7T�����p�3ۮ|\\2��1�ݽ`��K��\n�@��ڟ�֝\Z\Z�:������\"\rW�.\0�хH7���U��{�K�����%�l�A��\\�>/�����%���GFF���H��\0ft!�*���v}��g��)���S{&�k������P(�I��\0ft!�GEa˯kU���My�x9C6,|�*\rO�$\r311�ill��q�����>4\0��ЅH��w\n_���s�o~k��kuQ��l��O��&^:]��i(�Z��ʾ���D�eeeɿ�,W+��e+�\0��i\"�611���f=�\'w[[S�^��ڼ7���߾��Sj��}�BaQʕe\'Y�~]�����oddD�J4\Z�L]���#%���Uع�n鼽{�f�8U~����FU~�9�>p\0�C\"�d��7ߕ�����A��J�I.v������y+ٕ�PV����C����H�޽{h�p�S�|��$��zUQV�X�}�\0�͆.D:��W�3�G�3s�u�ԪW���o��?��:�|��%��А��(ꦆ��w�z\0]˩����W�6z�e��3yU��(T�_�Ƃ�e��7�_{#�B����Ŧ\'&&�nwYY���GN�\06���8�F��o~K�����w[[�_���z���6o�Z�=�͸�����k׮%O.�����l�j+z��\0d��S\'�սi������M����\'_�YQ��U�l�Ocӕ�K�=k�\Z.����H$�.LV�������g%Yp���\0�.��$�n���~���̙#�Ǒ�?\\�>�`?��c�]�mm����S����Y&��\0`�����>�\\������oW�0Ɖ*5.�\"\neHM�?n�dv�꧖���S��_{�5s\nN�\0�\0]k�/־�O]M|��O����lu](c����?�y��+W$�_1nllt��999�w�~����\0�]kINMM��S,Ѷ�{��8p y����W݅���w%ѩ��ҥK�@���_��I�\'UUU����\n\0\0ft!������\'�5va�ta�ғ�rwk\0\0��a��.,|���-�W7�*q�.\0`u�BXKua⺓_\n\\�u\'v�~y��koЅ\0\0�]k�.l�;���}j����ĳc�������_��Yv��O\r]\0��Ѕ�����������¢�\\�}�o~�i�NԼ����S����\0\0,�.���}j$��|�)I�}�l7\Z�P��c���?*~��/�4��tJ���=+�w}��Ν[p�\Z�\0�e�a���iI��w�H�����p��a��#<�^��ˌ�w�߽۟6os�����R�O~.]��ֺ�=\0\0]�}��������(�zs�ӿLvv.�_Ue=��F�1�軼`[׳ϫ⬩��x���O�<��\0�\r�.��T���~�\r	���t��Nww/w[[��m�T��\"�V�+u�I���r�ܹ�N�B\0\0V�.��_1�sG�M&�?�{��y�k��t=���O<�����R�|�U�2����jO��x�b�Id�\\\0��Ѕ��ę�2i����&���SS]])ko�C6��� ��RW��P(�8�L\0�|t!�Amjjjlllhh���ru�\Z�7�u�5����l�.p�]��ꛅ��B�s�D\0`E�B�Cb�0�����.9��0�ѯ���4\neu7l�uuu�r0��\'�Y�d!\0\0+B\"MԷ\'&&FFF���$\r�	����{f�b_7\\0F�����B�<9\n��&�s�|�\0�U��&j�P�M�áP��麬��D]n�������={i����Ns�ByIVP�)T������Pv(�M�A�\0X)��cN����ï��|Sk)�����O<��m2�<M䠚&,���kO�Rw�!\n\0X/t!�jA\Z���uuu]�t�]��T\'�Sy��o���?Ϯ��RW�\\�r������\0����n�i822�������]��X�PSr��w�H�%�<=�ߥ&eU�j�P6��e\'D!\0\0kGB�D\ZNLLD\"������>U��mm�|Wb.%QK�%YA�l\"���\0�����J�h4j�D��X�{{{�������` �<��򒬠�PM���\0�����L̂:������Q�e��$+�j��(\0`��Bh�\\�SSS*�H��BYAV�\0Xwt!l!Q�bzzZ5��P^R�P�\0\0�;�v4���\0�f������S�)\0\0\0\0IEND�B`�','10008','leave.png'),  ('20002','0','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<process name=\"leave\" xmlns=\"http://jbpm.org/4.3/jpdl\">\r\n   <start g=\"196,25,48,48\" name=\"start1\">\r\n      <transition to=\"申请\"/>\r\n   </start>\r\n   <task assignee=\"#{owner}\" form=\"request.jsp\" g=\"172,118,92,52\" name=\"申请\">\r\n      <transition to=\"经理审批\"/>\r\n   </task>\r\n   <task assignee=\"manager\" form=\"manager.jsp\" g=\"175,217,92,52\" name=\"经理审批\">\r\n      <transition g=\"-32,-8\" name=\"批准\" to=\"exclusive1\"/>\r\n      <transition g=\"128,221;124,165:-42,-18\" name=\"驳回\" to=\"申请\"/>\r\n   </task>\r\n   <decision expr=\"#{day > 3 ? \'老板审批\' : \'结束\'}\" g=\"200,308,48,48\" name=\"exclusive1\">\r\n      <transition g=\"-39,-10\" name=\"结束\" to=\"end1\"/>\r\n      <transition g=\"339,342:-71,-17\" name=\"老板审批\" to=\"老板审批\"/>\r\n   </decision>\r\n   <task assignee=\"boss\" form=\"boss.jsp\" g=\"294,375,92,52\" name=\"老板审批\">\r\n      <transition g=\"339,457:\" to=\"end1\"/>\r\n   </task>\r\n   <end g=\"199,445,48,48\" name=\"end1\"/>\r\n</process>','20001','leave.jpdl.xml'),  ('20003','0','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0]\0\0�\0\0\0mL�T\0\0>oIDATx���P[w~��g��tv����ٻw�<wӛ��<��d����γw���m�tw����ٴicߧIw�]o���dC��1IL,\'��6��k��`#�`�m�FXLd~jA\"�~��B���:���5�q��sG�?����w\0\0\0����>\0\0\0\0�]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]\0\0\0]�fff������.B^R��ʺ�\0�͌.��%�&\'\'\'&&����޽1��� ����!\0\0֡�n�\"�w�d߱��]����{�?��˿��?��_��e�y*奣����FFFdeل:\0�\"t!�\'�G##�e��c���[�g���\'�����R���w�2�<��� ���w�B�p�:\0�\"t!�DE��������d�s9�w�>���m�}����KYAV��e�ONf�������NdW�!\0\0�.D:�(�����课��_v��[:�C6�\re������aٕ�4\0`�Ѕ�\\\"\nC���������{�\\i�!�沓�����H$B\Z\0�^�BX+��p�s/��D�č�E�\Z���Dvu�֭���\0��B�Z�;�ccc9��y������4�]�%\re�껆��+\0\0]���D������U?�޿~yէ�S�P�:O����{xxX���!�\0X���/�ݻ���?���r/4���2��u����ޑ��CL\0�t!��&�޽�8���^���d���́�N����M����x<���t3��XY6��SjcCc���©��[�y ���?Ĕ!\0\0kA�*���p�v�o�>\Z��4�ih,��z:[�������B��ͭ?_\'�Tv+;oii���?Ĕ!\0\0kA����C���Ύ-M]��\Z���e���z<j<P�o���+�^V�tK.�2��ʉn�6i\n��������`�\0�5�a	uo������ڶ��Ϸ��Pc�\Z��X-�o7Fl�P�ql�ؿ�c�cO������y���>u�ڵ۷o˟S�����\0ؐ�BXB�lbbbhȸ�DҰ��g-�ظ����[xJ^\r}_�Ω�\\=�V��`l2��en��$\n�O477�A�s�G�B\0\0V�.�%�������~��������WM=�c�\Z�Y=�N,��7ǖ4�c��[���jvI�BYYv.��@@���Q�Ӻ�=\0\0]K�/���=��>mx���O�+�߬��\rcI���������Oe��\n�%�T��j�5e��\\�Ĺs�����ϩ��~�\0\0lHt!,!q�DB��_��k�����С��==��84�UYn,Q���ş\Z�+�j�/�����~�s�G�B\0\0V�.�%�����>:}�����t�����tPNw0�����g_�8��Y���>�uuut!\0\0kD��.|��/:�o�\\Gi<�:T�I�@,�-�R��z���<3���u��8x6_��t�����B\0\0ւ.�%]��O~�݊R��������Y`u�.0w9�B��jj��8����\\�]\0��х�D��!�џ�?ɗ��wͻ�$����\'\rٹ�	�#\0�vt!,���W���s�S�5�&5͉[�$ߞ[޼p�������Dv.��N\0\0X;��Hܧ�����9�V�r�v����q-���Wk�%V��m2{O���_ת%u�Rٹ��/�O\r\0\0kG���Z������O���O��\n/>�~oh�����_�KzI��ne�\'N���\0\0�]K$~/��g~�w�^�5�5z�K��u�\\6c�i���BY2���$�����Cl\'�e���\Z~\0���a	����ɑ��۷o��\\���G%�>�����?�?n�?kS/��+��>n�[G-3��e��*����]�vM���9��t!\0\0�C�333�+�����������S7&oʘ�4����R�;��:�N���il�V6����<s�����;N�<y��E��ԗ�O�~�\0\0lHt!���_ܻw/�����������_�o�Fx�{�Cv\"��;v���Nv.B���9&\0X5�VI�2MMM;��o/��D�4���(��Ȯ***N�:%���3Y\0��х���2������ދ5�sϿ�������F�eC�\\vr�����ꆆ٭�\\���\0\0�]�)����������������g��������s+�B�D6��?��ӓ\'Oʮd��[ٹ�	&\0X#����/������oݺu��5��ʗ�1����G�9������9(+�j��l���K��ղٕ�Pv+;�?�d!\0\0kD�Z333�5�Hd``@J��������g5����!�ѿڱ����_~�?��\n.O|~�/C�SY(/�\n���\\�iٱc�N�:%��NdW�C٭�7\r��\0\0�]�%����`ww���ojj���;y�di�k9��}����/�����oː�T�K�Byy���,�Ȇ���DvE\0���B�C\"\r��Ɔ��{{{�@KK�ŋ%�jjjN�8QYY)�w���#1�@��ByIV��de�D6��e\'�+�\0�uD\"MT\ZNMM������������ttt\\�v�����Ν�z�uI�,��dYMV�MdC�\\v��SH\0�^�B��J�h4z�޽�w��a��۷o��@ �����ByIV��de�D6��e\'D!\0\0�.D�-�Ñ�������������,��dY�\"\0�Rt!�H���������ؘd_�D�K���F\0`)�:�:����E�Kj�\0\0Kх��ǣ�\0\0�Pt!�%++K�!\0\0���B�]\0�.t!�.\0@��B\0�]{�\0Ѕ.��D\"����G\0@��a#�p��p�>\n\0\02]�\0Ј.��Ѕ\0\0hD�F�B\0\04�a#�����\0�E�F������}\0\0d(�6B\0�]�\0Ј.��Ѕ\0\0hD�F�B\0\04�a#~���v�>\n\0\02]��|�G�Q\0\0���B�]\0�Ft!l�.\0@#�6B\0�]�\0Ј.�����>\n\0\02]�\0Ј.��Ѕ\0\0hD�F�B\0\04�a#t!\0\0\Zх����\Z�׫�(\0\0�Pt!l����|>�G\0@��a#t!\0\0\Zх��\0\0��B�]\0�Ft!l�.\0@#�6�r�:::t\0\0�.��8��`0��(\0\0�Pt!l�.\0@#�6B\0�]�v�ڕ5_QQ��\0 �ЅЯ��$9\n�9�v�u\0\0�.�~w�����VQ���S\\\\��d\0\0ҏ.�-�.t�\\�D\0@�����v��)]XRR��ب�p\0\0�Dt!�\"///\'\'筷ފF���\0�LD�.���w��y���\0@��a�h4\'\'gppP��\0\0���B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B������W��i�ZP)㷶`��x�G�����������\0\0[��,Cw\'_*����N����}�}��?K\0\0l�.ă�\Z[v�TZ=�S�JE�ɖ�e�N�Oܷ�P���ɫ��͇^(���ifF�g\n\0��ЅX��������x焯+�=�V=���O�J��\'߫�;���\0�^�B,EE�C/�[s]{ح��:����YC\0\0�хX��!��PZJ{ϭ��u��i��.���\0����S����v�%���L[������Aݟ4\0\0vA\"5u�����΢�JE�:����\0�.�B�069���6�&K���i5!z�S�\0\0�B�P�Tsi������\'^y��i��y\0`t!R��2�)�ҧ=�,G/u�����rݟ7\0\0�@\"u�Mv�y��6��p���\0��)|姥L��Q��f�P_���y\0`t!RP?\n��g�\Z���/�=����.\0�zt!RP]hiJ�?Wڻ�r�wk*)7Y�P�T��\r\0�-ЅHAc\Z����/�\0H���5](��r0f[r��y��Tk�y�B\0\0�B\"˺p�������.����yD�\0H�)h���co�s�\r��,.�V�\0X?t!R�y��B����5n�[�(�\0HF\"���.�z��.\0 ]�l҅�\0�Nt!R�}�p�ւ<�\0H/�)h�/���ڸ\0��B\0\0Ҍ.D\nZ�ks]�-PӅ��c\'t!\0\0��B���.�ɠ\0H��]\0@��.�%��n�z�w���\0��B��x�Gj�L[��n�z��|�E���\0\0[�3��o���_�r�޽�������n�Zl��~pJ��3�ڻ��q�sP��#�J��\0\0l�.� yyyY&�5w�^�`z��S�����JE����.o��_\0\0`Ctay������ߗ%7n�0���?*������1��f�x,�\\������\0�\rх����DGGGmm������WE�����g��ݻ7�,���UK3�si��z�h||> op����t:��\0\0`[t�f�[ZZ*++���$].�ta0��Ξ=+QXXXx��񲲲h4��~��Ք��A�\r��#�TW\"﮽���1\0\0�]��B���FI=G�<���p�j�o����=x��rv���NK9}姥��l����ւJyk��yff��\0\0]�Q�A�;�˕��_TTTYY�����ު��@V[���V7�y��C�����[�\nO�(ܲ���?���\0\0lt�111���kjj��ݛ���t:�;::d�u4�7�Xn���߻5׵W�\ZǡƠ:},o��֠u�\0\0]hk�p���UVV����n����ӓ�c�7�t�v�j�𕊦\r��C��\'����eH�2S\0�]h;�}���������466h<�����W�%\nUW��&�l>���毯�B\0\0R���F��˂N�377w�޽UUU~����h!9U~)����E�<~��̾�%\rnI\0��B=��������՗���w\0\0�u�B\r�\n\n�nw}}}��,\0\0��P�����\0\0\0�]�AQQ����\0\0\0zх\Z8�N��t\0\0\0�AjPVV��\0\0H�P�����t�UVVrE6\0\0�Ѕ\Z���>\n;�\0\04�5�z�555���B\0\04�5��|�G�Q�Wj\0�]����w�ݺ��R\0\0��B\r$}$�t�х\0\0hDj000PXX��(���v��~�G\0@��5���C�Q�w�\0@#��A���ZBE۪�*[��qn\nt!\0\0\Zet&\'����t�����m�,�[h��*�077�8����x�^�G\0@���.L�4�pp�x�`\"К.�F})q�o\0\04��.l��5_�?��]8�d��O�]��.�F})х\0\0hDJ��ү-�}s�g��,�/�Z�2ܐ%������J�G\0@���.�w]\"�����5]XVV��Ҳoas�`\0\0�(��tb8~b�����=�̅�)х\0\0h��]��2ដ���Ay6w��5�|�.%~	\0\0�2��$���^��zd��[SS��M73�\0\0���y�عb����&-��5\'LS�\0�(ӻ0q*���\"+k��`[�l#Z0_����n��6����@\0\04��.ԅ����B\0\04��(,,�}��D\n\n\nt\0\0�.ԃ���dee�>\0\02]�\r�\0\0�Ѕ����F�Q�Ga;|,\0\0�Bj�p8��>\0\0t��)**\n�B���v�B\0\0t��q:��`P�Q��\0�.t�6eee---���v�e\0\0t���x<>�O�Q�]\0�.t�6�1���v�n����}\0\0d\"�P��[SS��(l�iT\0\0t������}�C\0�]����w�ݺ��vjjj�^��\0\0 х��A�ө�(l��]\0�]����@aa��\0\0]�Bm�����}����XYY��(\0\0�Dt�NYYY��v�\0\0]�B�rss�Ѩ�\0\0]�B�G8�}���8\0\0�B�TTT\n�t�]�ڵ+k>�|t\0\0�.ԉ�NVRR��G����\0\0�]�SYYYKK��;w�dgg�(���-..&�\0H\'�P\'~�m���BՅ��$2\0\0iF��=��J޹s�����F݇\0@f�u�z�555���^���w�\0 ��B��W�Yuu�taUU��\0 �Ѕ:��~.�] \Z�fggG\"�\0@ơu��\0\0�>�B�\nu\0\0��.�);�G\0\0`�5����}\0\0\0�P���������F~(\0\0�Ej�[ZZ*++�����n�������}\\\0\0 �Ѕ6211���kjj��ݛ���t:kkk���33��_����ikA���������y9���K\Zc�Ӻ??\0\0�.��h4*E(](u���%�(�(�(�����N�Tv����So-���N�F�~�\0\0�\r]�1���x�^�۝��_TTTYY��Ғ��?�\Z[v�TZ=�S�JE�ɖ�e�N�Oܷ�P���ɫ��͇^(���if&�!\0\0�En<�P�����������px<��700`��~���^���u���ު��w���O����{�Cw\'-��\0\0�(�-�Y.,,�Lt�����V\\ڬ���߭��=��kQ�\r�ZPɬ!\0\0����$������������\\����z��WC@E�����[���\n���/�]\\��\0�FGnN�h������F]��.m�%�|���=<���3��Kn�Ǚ�>�]yw�]�V��\0\0`�3�����r���UUU���e^��� ?��Z{�Y4^�hRg����\0\0��х\'\n��׻�������J���S�<69���6�&K���i5!z�S�\0��Ff������F���p8�N�y��栚K�^o���>���|�HS��\0\0`t!���eSN�O{�Y:�^ꖷ�ǹ�?o\0\0t��u�Mv�y��6��p���\0Љ.�R���R	&��t�z��Q���\0Љ.�Rԏ���g��B\0\0֎.�RT���zl�~���nM��/غ�y[c�<o���<�\\~�<�n���X�-�\Z[�ҡީ��\0\0��B,e5]�(3��拧[R�%V�����lS��] ��t!\0\0�.�RVޅvu)\'��&-O��ނ��4\r�u��M\n��p��H\0@b)+�¤i��3�F�͏���v�:���S�۶;��n;`�\0�����v��w�gLnݚX-W��4Ϸ�@���/\\�T�\\q�<�l���J�\0�����P��I;�U�-g�0�Tr�|�욉�Ӌ�G�\0X!�KYq.�n���/���A��yG�;\0`�ЅXʪ�#uh�D2����4�2����|Ő.\0�.�RVu��.�t)I�����U���BIIu݉z�.\0`%�B,e5]hj��]؛|\rJb�����MRr�\Z\0\0V�.�RVsY����p�y��Yd�7SާF��Z^��͆<�\"]\0�2ЅXʺ�G��.\0�.�R�B\0\02]��l��Z���j�6��z��?o\0\0t�����<RKg���w��C���/:u�\0\0�Db)�����gڵw���B砼�G^=���\0@\'�K�]{]����OiO7K�+M�6����?o\0\0t�����Q	��^(��i�7��c9��6�_���y\0�]�x�ji�.��^o����\rn��\Z����a\0�]�h�\ZTS�:�7ܺ�PxR]������O\Z\0\0��B<��?:-�����n���ã�[*�=�癙��)\0�]���V7�y��C�����[�\nO�(ܲ���?��3\0@?���},�\\���ݚ�ګn��PcP�>���|kP��\0�-ЅX��{�O�ng�&_�h�p�8����q��X��.3�\0\0$ЅX�����W�%\nUW��&�l>���毯�B\0\0�хX1ɩ�K��.�(������g��.ipK\Z\0\0��B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B\0\0\0�B�Teee4\Z�}\0\0d�6�p8���\0\0 �Ѕ�)�\0�4�aSt!\0\0iF¦�B\0\0Ҍ.�M�B!�G\0@�aSN�3�>\n\0\02]��\0H3�6E\0�ft!l�.\0 ��Bؔ�������\0�B¦<����}\0\0d�6E\0�ft!l�.\0 ��B����=m�{�\ZK�*�bKY�Xkn�%х\0\0�]�5xPʳ��s/-�kjj�^�\r\0\0R��JF��U�5w��i�؃�Փ�9���kc��^\0\0�}�k�4_ϼ=�\n��7!}v�p���	t!\0\0iFb\rR�GN\n��X��0\\�t2]\0@�хX��y��M�^a�\0\0;��J���^�<{Ny�󅍍����־\0\0��.�\Z,u=r[�lο��2�}>�����\0�	]�5XЅ��꺓Ģ�;�Ѕ\0\0�]�5Xp=�$�����\0\\�F5��.\0 ��B��jA58.p��R\\����Ӆ\0\0�]�\n�N�S�Q\0\0�A�B�]\0@�х�)�\0�4�aSt!\0\0iF¦�B\0\0Ҍ.�M��a�á�(\0\0� t!l�.\0 ��B�ή]������H�A\0��х������(<r����}P\0\0l~t!l�Ν;���*\nsss�������\0`�aG����:�Id\0\0҃.��|��;w�.lll�}8\0\0d�6���\']�p8�Ѩ�c\0 #Ѕ����j�ª�*�\0@��aS�h4;;;��>\0\02]\0\0\0]\0\0\0];����D-�}t\0\0lNt!lG��pph(���)c2&\Z�NOO�:�}�\0\0lBt!�e6\n;?z韛q���D��ǥIC\0\0,B�FT\r������w��y�ў�����\'&&��(i\0���a�(��s\\��H���Ɓ����Q�\0\0+Ѕ��Qx�1<r6��sF\Z�6Ұx�h�_�4!\r\0Xwt!�K�R�҅�4�_o \r\0�]��)�͹��Mw�6\r��4\0�jt!tZl�P��X��&IC\0\0,EB�EOǢpdv����ei\0�U�B�\"\n���|��nR&����ᕷIC\0\0�@Bs�.�54|f8|f4�`�ы2£���YA��L\Z\0���B��9\n�/�>0�����yc���?H5Ԛ�	i\0����V�(�p1��2��9�i��)k~�7C�����\rY(/�\n�Z(��lH\Z\0���B��9\n/6���{����jTZ�/1�i�%YMV����J6\'\r\0X/t!����v��.v�K�����a�wd��ە�`�K���������\0\0���`�³�~v3�!m\'cA��q���e�|��VEWwE�̓��i\0��х��9\nϜ~���u��D�N�G�2e���rb�.ٕ�0Mi�V����*^3<�\'��m�Wb/���k�XdU\0\0�]k�(�L���m�h�%]b�<��(�����m�~@�͜���������r\0��~�ӅF�H�I�-)�~t!\0@�֒.&Ga˵d��9e\\k��ھ�z�����8^�g�?��7�m�\'�ʆƿ���>?�ّH�6�I�H$299)i�ַ�*�h��ۼ�SQ�\'e<.9��j0��T�5w!�\0�]k�� �����m-��ȸ~�#-���PO+��|�(���W^��ڳJý�p�r]ooo8�F���~��.ւɡ��ߛ��[ʢk%��CsϞ�t�\n�S\0�bt!�%]��ש����������j�P��}|\n���_r�P^�\r�Vj�P�5\Z��N���҅M�����S�ky)O/�8�[��-��A����y����\0�%�BX+х�ː��ot��%#7V�C�˅�Mn��P�3qa�t�ŋ�������]cΧ���hm{�\'���G>;w�x6���;��<_��F\"0S�G\0�Jt!�%](Yv��_��?ľ���ϝU�\\��]��|1r�%ɲ�D֝9��Ң�����}�����x<�1�R0fbbb�$>�7w*�vIם�@4W݃��s�	\0@��R]�D:�ix�a�͠۸�`�q�`w�b�)\\쾆]�*�m���M?|\"QX[�innnmmU�{{{;::�}>��²�2gL~~�j��{��%555j�===��Z�l��g�ƻ��2[��S���5�e�.څ����?\0d*�֒.�F�����p�F{c\"\r/\\��]�s���m�GMR�_u�w�?v���{\'�?y���d���>��p�BKK����;��S!��zU�L�^T�(�t~�إ����xmcc���壻�ͳ��G�\\��r�L�*�_;A9�h=��\0\0��.��fff���Ք���@��B\"\r�/���.�w2�Ǒ������G�7�ɟ����{L��dA^�r�ƍ�z�x����	��y�Ӌ~�����X*�俥®��7v9>���zֿ�5��;+��G���*o�\r���O\\s�\Z\0@ZЅ����������訴��zC\"\r}�ޔq����4������\Z<\Z���49\nee��ln�������n+�k����s�?~��я�>��|/6�����v�0{g|m�X7�Q�I����B�b��������B\0�u�BXN�a4\Z�JY���o~&���Z��T�p�����PV������QhϟH�R��555*���T��%eeej�ϧ6�D\"�\0��хH����ʕ��� c4� #�x��zj����32d�\r��!�*���Eu���Q�(ɨ�Q\"R-���R�k���\0llt!�d�4�z��ᑳ2F�6�qw�߻��e�sN֑�7e.S(RX__����r�RTᘛ����r����6��G��\0�.D�,?\r!��x�(\\y��;::TVUU�R,,,LL:�>L\0��ЅH���1#��sw��\ZQ8rV^\"\n׋���C\0\0�]�t[ά�$`�|��G$\n�]\00����Ґ(�]\00���2Ӑ���\0ft!�Y�w\r�B�Ѕ\0\03�:=0\r�B�Ѕ\0\03��-���(�����.\0�х�o�4�T��̱��斖�7n��.\0�х�s\Z��/\\�\\��x���_K���vtt�����.\0�х���4��������ꌑ�T�KD��х\0\03�6����H$K���y*��uA\0��B؋J���������q	��y Oe��D�]\00�a;�4�F��I�)Q�^�B\0�][�x<�as�\0ft!l�|�,\0��.���/�\0�х�5��\"|�\0\03��F�X�\0`F������\0��B�W8v8��bs�\0ft!�.�]\00�a_t�u�B\0�]���C\0��B�]h�\0`F¾B�PQQ���Tv�ڕ5�0\0 �.�}�A�ө�(6�����(<r����}P\0\0��a_tẻs�Nvv��������b��u\0�.�B�]h���BՅ��$2\0 ]������v�ܩ����Q��\0\0l�.�}х��˓.t8�hT��\0\0l�.�}�|>�ǣ�(6���j�ª�*�\0���EZ$\Z�fggG\"�\0���E\0�Nt!�.\0 ��B�]\0@:х����z��\0\0 m�B�Wm��\0\0 SЅ�/�\0�t�a_ޅ33��_����ikA���������y9���K\Zc�Ӻ??\0��х����¡��/�]|�E���[����Ӂ�Qݟ%\0`�B�Wfv��!�e�K��c9�T4�l�\\������};u�o�����|��_x�fft�\0��a_�����>���~���^���u���ު��w���O����{�Cw\'u�\0��a_�օ*\nz��ݚ���n�f�����\Z��х����BWC@E�����[���\n���/�]��\0�.�}eN�S����v�%���L[������Aݟ4\0`)t!�+s�P�A~rw����h�RѤ�&���\0K�a_n�����>\nˍMN��\r}���cxtZM�^�Ŕ!\0�]�r:��`P�QX��9��Ҵכ��O��6_=Ҥ��\0,�.�}eHnw��S�Ӟn������m�qn���\0�(���!]����.C6�PxR��.ݟ7\0`Qt!���\"��-����=�V�svM_&ː.��OK%�������꡾F���\0,�.�rI.�](��\0KUd\n҅�GA��3wt!\0lzt!�)1Y(5����s�k�/t8�px-{�T�2��ϕ�.�jC޶Á������y�T/�<�\\~�<�n��-o��ؒ��Nu�\0�EхX�٩�y����ȋ4c�n| �p}�P�n�����ݒ�H@Ơ�,Iu�2�s�s��<_���C�p�4g�m�pF\Z�s���K9q�TS\Z(]X���M�s�0�B\0�9��5x���H��:��Z0��⍘�`�17�`$��Cs���t�\n�SӅ\0�ЅX��)���\Z�<�*��}��w��ԥ8�����E��D�X�<�֭�8�L��хX���+Lq�\Z�{�1+�9Y~~���Ī7�(�4_?e\\P�pyC޶��4��@�G>�?ۂ�&��\'�JN�/T\'��p���t!\0l.t!�mv2���R]��Vc��sǱ竻0Y6\\�Q��*�0>՗�=s�%]w��\\u�/����N\0 3ЅX�yq��ydU�)�_�b�s�ta�1�j�lSQ8{�I~C�f��J�g�0�q\ryFD��n����E�pE�¡���B��2�#�|�B�pɑ��8��f.9��z.vFx�M\nW��BIIu���r�h�`��a_tჺ0�Ms~�.4Z0�mB����p��F0�NIs�\Z\0ؔ�B�]��Huarr)\Z]x ��Eíɷ��M4�z.�}jԟP���A��iE�\06>�6���H��]���]\06G¦���7�B\0�9�6�9]�e�Kj��;��۬����\0��aS�Ӆ��y��δ�i�6���͇_t���\0��aS�Ӆ�����gڵw���B砼�G^=���\0,�.�M�B���\"�G��k�K0=��)��f�x��I��v�W��\r\0X]�\n�NgF�s���`z��`���z�n<�S.o���nݟ7\0`Qt!l*s�P<�^�4�?��k�7�������p�ON���\0��aSՅ�]�j��B���[�\nO�+�w�^��I\0�B¦2���?:-�����n���ã�[*�=�癙��)\0�D¦2��&��\rky���+����e�*\n��pu�����\0@¦|>����}i�},�\\���ݚ�ګn��PcP�>���|kP��\0x0�6��](��M?����8|��i�}���;��ɫ��cR���FA¦2������+�����Po6�c~��W�N!\0l t!l*c�P��*����n�\"L��|f�钆\0���\r�.�Mex\0�~t!l������J�Q\0\0�A�B�Tm��\0\0 �Ѕ�)�\0�4�aSt!\0\0iF¦�B\0\0Ҍ.�Mх��Zo\0�]��p��|��b�����}\0\0ۡaSt���B\0�]��-E\0��B�]h)�\0`F¦�BKх\0\03�6�v��~��ش�B\0�]�r:��`P�QlZt!\0��.�Mх��\0ft!l�.�]\00�a/�v�ʚ���H�AmBt!\0��.�����$G�#G�n��ڄ�B\0�]{�s�Nvv������b�&[�.\0�х����BՅ.�����\0ft!l����ܹS¥�����Q��lNt!\0��.���������[�hT��lNt!\0��.�UWW�ܹ�ȑ#�dӢ\0ft!�(\Z�����>�M�.\0�х@&�\0ft!���B\0�]d\"�\0`F��.\0�х���E�>�̓.\0�х��}_�LOOG��)Y(/�u��5�\0ft!4K�d���h���_מ�p���Ԑ�7�_���MLLܻwO5\"u�t!\0��.�6�\"�<�q���=������M9�����ҋ}���HD\ZQ�:\\5�\0`FBU��v���{呯%������;��-׳�ː�4�e�w����P�{�H�B\0�]\rT������7T�����p�3ۮ|\\2��1�ݽ`��K��\n�@��ڟ�֝\Z\Z�:������\"\rW�.\0�хH7���U��{�K�����%�l�A��\\�>/�����%���GFF���H��\0ft!�*���v}��g��)���S{&�k������P(�I��\0ft!�GEa˯kU���My�x9C6,|�*\rO�$\r311�ill��q�����>4\0��ЅH��w\n_���s�o~k��kuQ��l��O��&^:]��i(�Z��ʾ���D�eeeɿ�,W+��e+�\0��i\"�611���f=�\'w[[S�^��ڼ7���߾��Sj��}�BaQʕe\'Y�~]�����oddD�J4\Z�L]���#%���Uع�n鼽{�f�8U~����FU~�9�>p\0�C\"�d��7ߕ�����A��J�I.v������y+ٕ�PV����C����H�޽{h�p�S�|��$��zUQV�X�}�\0�͆.D:��W�3�G�3s�u�ԪW���o��?��:�|��%��А��(ꦆ��w�z\0]˩����W�6z�e��3yU��(T�_�Ƃ�e��7�_{#�B����Ŧ\'&&�nwYY���GN�\06���8�F��o~K�����w[[�_���z���6o�Z�=�͸�����k׮%O.�����l�j+z��\0d��S\'�սi������M����\'_�YQ��U�l�Ocӕ�K�=k�\Z.����H$�.LV�������g%Yp���\0�.��$�n���~���̙#�Ǒ�?\\�>�`?��c�]�mm����S����Y&��\0`�����>�\\������oW�0Ɖ*5.�\"\neHM�?n�dv�꧖���S��_{�5s\nN�\0�\0]k�/־�O]M|��O����lu](c����?�y��+W$�_1nllt��999�w�~����\0�]kINMM��S,Ѷ�{��8p y����W݅���w%ѩ��ҥK�@���_��I�\'UUU����\n\0\0ft!������\'�5va�ta�ғ�rwk\0\0��a��.,|���-�W7�*q�.\0`u�BXKua⺓_\n\\�u\'v�~y��koЅ\0\0�]k�.l�;���}j����ĳc�������_��Yv��O\r]\0��Ѕ�����������¢�\\�}�o~�i�NԼ����S����\0\0,�.���}j$��|�)I�}�l7\Z�P��c���?*~��/�4��tJ���=+�w}��Ν[p�\Z�\0�e�a���iI��w�H�����p��a��#<�^��ˌ�w�߽۟6os�����R�O~.]��ֺ�=\0\0]�}��������(�zs�ӿLvv.�_Ue=��F�1�軼`[׳ϫ⬩��x���O�<��\0�\r�.��T���~�\r	���t��Nww/w[[��m�T��\"�V�+u�I���r�ܹ�N�B\0\0V�.��_1�sG�M&�?�{��y�k��t=���O<�����R�|�U�2����jO��x�b�Id�\\\0��Ѕ��ę�2i����&���SS]])ko�C6��� ��RW��P(�8�L\0�|t!�Amjjjlllhh���ru�\Z�7�u�5����l�.p�]��ꛅ��B�s�D\0`E�B�Cb�0�����.9��0�ѯ���4\neu7l�uuu�r0��\'�Y�d!\0\0+B\"MԷ\'&&FFF���$\r�	����{f�b_7\\0F�����B�<9\n��&�s�|�\0�U��&j�P�M�áP��麬��D]n�������={i����Ns�ByIVP�)T������Pv(�M�A�\0X)��cN����ï��|Sk)�����O<��m2�<M䠚&,���kO�Rw�!\n\0X/t!�jA\Z���uuu]�t�]��T\'�Sy��o���?Ϯ��RW�\\�r������\0����n�i822�������]��X�PSr��w�H�%�<=�ߥ&eU�j�P6��e\'D!\0\0kGB�D\ZNLLD\"������>U��mm�|Wb.%QK�%YA�l\"���\0�����J�h4j�D��X�{{{�������` �<��򒬠�PM���\0�����L̂:������Q�e��$+�j��(\0`��Bh�\\�SSS*�H��BYAV�\0Xwt!l!Q�bzzZ5��P^R�P�\0\0�;�v4���\0�f������S�)\0\0\0\0IEND�B`�','20001','leave.png');
INSERT INTO `jbpm4_property` VALUES ('next.dbid','3','30001');
INSERT INTO `persistent_logins` VALUES ('ADMIN','wZFP1T+V4JSqgQT4j0lngQ==','qPt3+clnTFp5hMHaliQaNQ==','2012-06-23 22:44:27');
INSERT INTO `t_common_att` VALUES ('9','barney.txt','\\2012-06-08\\ADMIN\\barney_1.txt','Local',NULL,'txt','2012-06-08 20:56:44','ADMIN'),  ('10','barney.txt','\\2012-06-08\\ADMIN\\barney_2.txt','Local',NULL,'txt','2012-06-08 23:21:00','ADMIN');
INSERT INTO `t_sys_dict` VALUES ('area','区域','3','PP_TYPE'),  ('BJ','北京','1','AREA'),  ('COMMONUSER','普通用户','1','DEFAULTROLE'),  ('COMPANY','公司',NULL,'ORGTYPE'),  ('company','同公司限制',NULL,'PP_LIMIT_TYPE'),  ('CONTRACTFLOW','合同审批流程','1','FLOW_TYPE'),  ('DEPT','部门','1','ORGTYPE'),  ('dept','同部门限制','1','PP_LIMIT_TYPE'),  ('FAILURE','失败','1','HANDLERESULT'),  ('femme','女','1','GENDER'),  ('HB','湖北','2','AREA'),  ('HN','湖南','3','AREA'),  ('male','男','0','GENDER'),  ('NO','否','1','YESORNO'),  ('none','无限制','3','PP_LIMIT_TYPE'),  ('OAFLOW','办公审批流程',NULL,'FLOW_TYPE'),  ('ORG','组织','2','ORGTYPE'),  ('org','同处室限制','2','PP_LIMIT_TYPE'),  ('org','组织','1','PP_TYPE'),  ('role','角色','2','PP_TYPE'),  ('SUCCESS','成功',NULL,'HANDLERESULT'),  ('SYSADMIN','系统管理员',NULL,'DEFAULTROLE'),  ('tree-appLog','操作日志','6','ICONCLS'),  ('tree-att','文件图标','8','ICONCLS'),  ('tree-auth','授权图标','999','ICONCLS'),  ('tree-config','配置文件图标','9','ICONCLS'),  ('tree-dd','字典图标','2','ICONCLS'),  ('tree-org','组织图标','1','ICONCLS'),  ('tree-pwd','密码修改','3','ICONCLS'),  ('tree-role','角色图标','5','ICONCLS'),  ('tree-source','资源图标','4','ICONCLS'),  ('tree-sysLog','系统日志','7','ICONCLS'),  ('tree-user','用户图标','0','ICONCLS'),  ('user','人员',NULL,'PP_TYPE'),  ('YES','是',NULL,'YESORNO');
INSERT INTO `t_sys_dict_type` VALUES ('AREA','区域','组织、人员所属区域'),  ('DEFAULTROLE','默认角色',''),  ('FLOW_TYPE','流程类型',NULL),  ('GENDER','性别',NULL),  ('HANDLERESULT','处理结果',NULL),  ('ICONCLS','菜单图标',NULL),  ('MODULE','日志模块',NULL),  ('ORGTYPE','组织类型',NULL),  ('PP_LIMIT_TYPE','参与者限制类型',NULL),  ('PP_TYPE','参与者类型',NULL),  ('YESORNO','是否',NULL);
INSERT INTO `t_sys_log` VALUES ('1','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"PP_TYPE\",\"cname\":\"参与者类型\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:48:33'),  ('2','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"PP_LIMIT_TYPE\",\"cname\":\"参与者限制类型\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:48:56'),  ('3','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"org\",\"dvalue\":\"组织\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:50:11'),  ('4','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"user\",\"dvalue\":\"人员\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:50:29'),  ('5','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":2,\"dname\":\"role\",\"dvalue\":\"角色\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:50:37'),  ('6','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":3,\"dname\":\"area\",\"dvalue\":\"区域\",\"typeId\":\"PP_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:00'),  ('7','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"company\",\"cname\":\"同公司限制\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:16'),  ('8','org.thorn.dd.service.DataDictServiceImpl','deleteDt','[\"company,\"]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:28'),  ('9','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"company\",\"dvalue\":\"同公司限制\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:51:55'),  ('10','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"dept\",\"dvalue\":\"同部门限制\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:52:06'),  ('11','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":2,\"dname\":\"org\",\"dvalue\":\"同处室限制\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:52:30'),  ('12','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":3,\"dname\":\"none\",\"dvalue\":\"无限制\",\"typeId\":\"PP_LIMIT_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:52:44'),  ('13','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"PARTICIPATOR\",\"sourceName\":\"绑定环节参与者\",\"parentSource\":\"WORKFLOW\",\"sourceUrl\":\"/workflow/participator/participator.jsp\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"YES\",\"sortNum\":2}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:55:01'),  ('14','org.thorn.workflow.service.ParticipatorServiceImpl','save','[{\"id\":null,\"entity\":\"123,1212\",\"variable\":\"dfgr\",\"processDfId\":\"test\",\"activityId\":\"环节1\",\"entityType\":\"org\",\"limitType\":\"org\"}]','ADMIN','SUCCESS',NULL,'2012-06-21 23:59:59'),  ('15','org.thorn.workflow.service.ParticipatorServiceImpl','queryPage','[\"\",\"\",\"\",\"\",0,20,null,null]','ADMIN','FAILURE','ParticipatorDaoImpl do queryPage exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\r\n### The error may involve ParticipatorMapper.selectPage-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'','2012-06-21 23:59:59'),  ('16','org.thorn.workflow.service.ParticipatorServiceImpl','queryPage','[\"\",\"\",\"\",\"\",0,20,null,null]','ADMIN','FAILURE','ParticipatorDaoImpl do queryPage exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\r\n### The error may involve ParticipatorMapper.selectPage-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'','2012-06-22 00:00:03'),  ('17','org.thorn.workflow.service.ParticipatorServiceImpl','queryPage','[\"\",\"\",\"\",\"\",0,20,null,null]','ADMIN','FAILURE','ParticipatorDaoImpl do queryPage exception,\r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\r\n### The error may involve ParticipatorMapper.selectPage-Inline\r\n### The error occurred while setting parameters\r\n### Cause: com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.MySQLSyntaxErrorException: Unknown column \'processDfId\' in \'order clause\'','2012-06-22 00:00:10'),  ('18','org.thorn.workflow.service.ParticipatorServiceImpl','delete','[\"1,\"]','ADMIN','SUCCESS',NULL,'2012-06-22 00:04:05'),  ('19','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"participator-query\",\"sourceName\":\"参与者查询\",\"parentSource\":\"PARTICIPATOR\",\"sourceUrl\":\"/wf/pp/get*.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":0}]','ADMIN','SUCCESS',NULL,'2012-06-22 00:05:44'),  ('20','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"participator-modify\",\"sourceName\":\"参与者设置修改\",\"parentSource\":\"PARTICIPATOR\",\"sourceUrl\":\"/wf/pp/saveOrModifyParticipator.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-06-22 00:06:22'),  ('21','org.thorn.resource.service.ResourceServiceImpl','save','[{\"sourceCode\":\"participator-delete\",\"sourceName\":\"参与者设置删除\",\"parentSource\":\"PARTICIPATOR\",\"sourceUrl\":\"/wf/pp/deleteParticipator.jmt\",\"iconsCls\":\"\",\"isleaf\":\"YES\",\"isShow\":\"NO\",\"sortNum\":999}]','ADMIN','SUCCESS',NULL,'2012-06-22 00:07:00'),  ('22','org.thorn.workflow.service.ParticipatorServiceImpl','save','[{\"id\":null,\"entity\":\"0011\",\"variable\":\"dfd\",\"processDfId\":\"test\",\"activityId\":\"test\",\"entityType\":\"org\",\"limitType\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 15:28:49'),  ('23','org.thorn.workflow.service.ParticipatorServiceImpl','modify','[{\"id\":1,\"entity\":\"0011,0012\",\"variable\":\"dfd\",\"processDfId\":\"test\",\"activityId\":\"test\",\"entityType\":\"org\",\"limitType\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 15:38:41'),  ('24','org.thorn.dd.service.DataDictServiceImpl','saveDt','[{\"ename\":\"FLOW_TYPE\",\"cname\":\"流程类型\",\"typeDesc\":\"\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:17:41'),  ('25','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":0,\"dname\":\"OAFLOW\",\"dvalue\":\"办公审批流程\",\"typeId\":\"FLOW_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:18:04'),  ('26','org.thorn.dd.service.DataDictServiceImpl','saveDd','[{\"sortNum\":1,\"dname\":\"CONTRACTFLOW\",\"dvalue\":\"合同审批流程\",\"typeId\":\"FLOW_TYPE\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:18:28'),  ('27','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"leave\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程\"}]','ADMIN','FAILURE','FlowTypeDaoImpl do save exception,\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'ID\' doesn\'t have a default value\r\n### The error may involve FlowTypeMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### Cause: java.sql.SQLException: Field \'ID\' doesn\'t have a default value\n; uncategorized SQLException for SQL []; SQL state [HY000]; error code [1364]; Field \'ID\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'ID\' doesn\'t have a default value','2012-06-23 22:25:15'),  ('28','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"请假流程\",\"flowKey\":\"请假流程\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:27:40'),  ('29','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"请假流程\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:40:11'),  ('30','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"请假流程\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:41:39'),  ('31','org.thorn.workflow.service.FlowTypeServiceImpl','saveOrModifyFlowType','[{\"id\":null,\"flowName\":\"请假流程(新)\",\"flowKey\":\"leave\",\"flowType\":\"OAFLOW\",\"flowDesc\":\"请假流程(新)\"}]','ADMIN','SUCCESS',NULL,'2012-06-23 22:45:13');
INSERT INTO `t_sys_org` VALUES ('1','ROOT','-1','组织树','组织树','COMPANY',NULL,'0','NO','NO',NULL),  ('2','001','ROOT','北京市分公司','北京市分公司','COMPANY',NULL,'1','YES','NO','BJ'),  ('11','002','ROOT','湖北省分公司','湖北省分公司','COMPANY','hb@thorn.com','2','YES','NO','HB'),  ('12','0011','001','信息化部','信息化部','DEPT',NULL,'0','YES','NO','BJ'),  ('13','0021','002','信息化部','信息化部','DEPT',NULL,'1','YES','NO','HB'),  ('14','0012','001','北分市场部','市场部','DEPT',NULL,'2','YES','NO','BJ');
INSERT INTO `t_sys_resource` VALUES ('0','ALL','/**','YES','NO','-1','99',''),  ('APPLOG','操作日志','/system/log/appLog.jsp','YES','YES','LOG','1','tree-appLog'),  ('APPLOG-EXCEL','操作日志导出','/log/exportLogExcel.jmt','YES','NO','APPLOG','999',NULL),  ('APPLOG-QUERY','操作日志查询','/log/getLogPage.jmt','YES','NO','APPLOG','0',NULL),  ('ATT','文件管理','/system/att/attachment.jsp','YES','YES','SYS','9','tree-att'),  ('ATT-DELETE','附件删除','/att/delete.jmt','YES','NO','NAV','3',NULL),  ('ATT-DOWNLOAD','附件下载','/att/download.jmt','YES','NO','NAV','4',NULL),  ('ATT-UPLOAD','附件上传','/att/get*.jmt','YES','NO','NAV','2',NULL),  ('AUTH','用户授权','/system/role/userAuth.jsp','YES','YES','AUTHMANAGER','1','tree-auth'),  ('AUTH-ADD','添加用户','/user/saveUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-DELETE','删除用户','/user/deleteUserRole.jmt','YES','NO','AUTH','999',''),  ('AUTH-QUERY','授权关系查询','/user/get*.jmt','YES','NO','AUTH','0',''),  ('AUTHMANAGER','权限管理',NULL,'NO','YES','SYS','3',NULL),  ('CF','配置项管理',NULL,'NO','YES','SYS','0',NULL),  ('CF-MODIFY','配置文件修改','/cf/modifyConfig.jmt','YES','NO','CONFIG','1',NULL),  ('CF-QUERY','配置文件查看','/cf/get*.jmt','YES','NO','CONFIG','0',NULL),  ('CONFIG','配置文件管理','/system/cf/configurator.jsp','YES','YES','CF','1','tree-config'),  ('DICT','数据字典管理','/system/dd/dd.jsp','YES','YES','CF','0','tree-dd'),  ('DICT-DELETE','数据字典删除','/dd/delete*.jmt','YES','NO','DICT','999',''),  ('DICT-QUERY','数据字典查询','/dd/get*.jmt','YES','NO','DICT','0',''),  ('DICT-UPDATE','数据字典更新','/dd/saveOrModify*.jmt','YES','NO','DICT','999',''),  ('HOME','主页','/system/main.jsp','YES','NO','NAV','0',NULL),  ('LEFTMENU','菜单树','/resource/getLeftTree.jmt','YES','NO','NAV','1',NULL),  ('LOG','日志管理',NULL,'NO','YES','SYS','1',NULL),  ('MYPWD','修改密码','/system/user/changePwd.jsp','YES','YES','USERMANAGER','99','tree-pwd'),  ('MYPWD-CHANGE','密码修改','/user/changeMyPwd.jmt','YES','NO','MYPWD','999',''),  ('NAV','应用菜单','','NO','YES','0','0',''),  ('ORG','组织管理','/system/org/org.jsp','YES','YES','USERMANAGER','0','tree-org'),  ('ORG-DELETE','组织删除','/org/delete*.jmt','YES','NO','ORG','999',''),  ('ORG-QUERY','组织查询','/org/get*.jmt','YES','NO','ORG','0',''),  ('ORG-UPDATE','组织更新','/org/saveOrModify*.jmt','YES','NO','ORG','999',''),  ('PARTICIPATOR','绑定环节参与者','/workflow/participator/participator.jsp','YES','YES','WORKFLOW','2',NULL),  ('participator-delete','参与者设置删除','/wf/pp/deleteParticipator.jmt','YES','NO','PARTICIPATOR','999',NULL),  ('participator-modify','参与者设置修改','/wf/pp/saveOrModifyParticipator.jmt','YES','NO','PARTICIPATOR','999',NULL),  ('participator-query','参与者查询','/wf/pp/get*.jmt','YES','NO','PARTICIPATOR','0',NULL),  ('PROCESSDF','流程定义管理','/workflow/processDf/processDf.jsp','YES','YES','WORKFLOW','0',NULL),  ('processdf-delete','流程定义删除','/wf/deleteProcessDf.jmt','YES','NO','PROCESSDF','2',NULL),  ('processdf-deploy','流程发布','/wf/deployProcess.jmt','YES','NO','PROCESSDF','1',NULL),  ('processdf-query','流程定义查询','/wf/getProcessDf*.jmt','YES','NO','PROCESSDF','0',NULL),  ('PROCESSMT','流程实例监控','/workflow/processMt/processMt.jsp','YES','YES','WORKFLOW','1',NULL),  ('processmt-cancel','流程实例结束','/wf/cancelProcessInst.jmt','YES','NO','PROCESSMT','1',NULL),  ('processmt-delete','流程实例删除','/wf/deleteProcessInst.jmt','NO','NO','PROCESSMT','2',NULL),  ('processmt-query','流程实例查询','/wf/getProcessInst*.jmt','YES','NO','PROCESSMT','0',NULL),  ('ROLE','角色管理','/system/role/role.jsp','YES','YES','AUTHMANAGER','0','tree-role'),  ('ROLE-AUTH','角色授权','/role/saveAuth.jmt','YES','NO','ROLE','999',''),  ('ROLE-DELETE','角色删除','/role/delete*.jmt','YES','NO','ROLE','999',''),  ('ROLE-QUERY','角色查询','/role/get*.jmt','YES','NO','ROLE','0',''),  ('ROLE-UPDATE','角色更新','/role/saveOrModify*.jmt','YES','NO','ROLE','999',''),  ('SOURCE','资源管理','/system/resource/source.jsp','YES','YES','CF','2','tree-source'),  ('SOURCE-DELETE','资源删除','/resource/delete*.jmt','YES','NO','SOURCE','999',''),  ('SOURCE-QUERY','资源查询','/resource/get*.jmt','YES','NO','SOURCE','0',''),  ('SOURCE-UPDATE','资源更新','/resource/saveOrModify*.jmt','YES','NO','SOURCE','999',''),  ('SYS','系统管理','','NO','YES','0','0',''),  ('SYSLOG','系统日志','/system/log/sysLog.jsp','YES','YES','LOG','0','tree-sysLog'),  ('SYSLOG-LEVEL','修改日志级别','/log/*LogLevel.jmt','YES','NO','SYSLOG','1',NULL),  ('SYSLOG-QUERY','系统日志查询','/system/log/sysLog*.jsp','YES','NO','SYSLOG','0',NULL),  ('USER','用户管理','/system/user/user.jsp','YES','YES','USERMANAGER','1','tree-user'),  ('USER-DELETE','用户删除','/user/deleteUser.jmt','YES','NO','USER','2',''),  ('USER-DISABLED','用户启/禁用','/user/disabled*.jmt','YES','NO','USER','999',''),  ('USER-PWD','密码修改','/user/changePwd.jmt','YES','NO','USER','999',''),  ('USER-QUERY','用户查询','/user/get*.jmt','YES','NO','USER','0',''),  ('USER-ROLE','用户角色管理','/user/saveRoleByUser.jmt','YES','NO','USER','999',''),  ('USER-UPDATE','用户更新','/user/saveOrModify*.jmt','YES','NO','USER','1',''),  ('USERMANAGER','用户管理',NULL,'NO','YES','SYS','2',NULL),  ('WORKFLOW','流程菜单',NULL,'NO','YES','0','999',NULL);
INSERT INTO `t_sys_role` VALUES ('COMMONUSER','普通用户',NULL,'NO'),  ('TESTDD','数据字典测试角色',NULL,'NO');
INSERT INTO `t_sys_role_res` VALUES ('COMMONUSER','ATT-DELETE','2012-06-11 21:27:13'),  ('COMMONUSER','ATT-DOWNLOAD','2012-06-11 21:27:13'),  ('COMMONUSER','ATT-UPLOAD','2012-06-11 21:27:13'),  ('COMMONUSER','HOME','2012-06-11 21:27:13'),  ('COMMONUSER','LEFTMENU','2012-06-11 21:27:13'),  ('COMMONUSER','MYPWD','2012-06-11 21:27:13'),  ('COMMONUSER','MYPWD-CHANGE','2012-06-11 21:27:13'),  ('COMMONUSER','USERMANAGER','2012-06-11 21:27:13'),  ('TESTDD','APPLOG','2012-06-11 21:34:10'),  ('TESTDD','APPLOG-QUERY','2012-06-11 21:34:10'),  ('TESTDD','ATT','2012-06-11 21:34:10'),  ('TESTDD','AUTH','2012-06-11 21:34:10'),  ('TESTDD','AUTH-QUERY','2012-06-11 21:34:10'),  ('TESTDD','AUTHMANAGER','2012-06-11 21:34:10'),  ('TESTDD','CF','2012-06-11 21:34:10'),  ('TESTDD','CF-QUERY','2012-06-11 21:34:10'),  ('TESTDD','CONFIG','2012-06-11 21:34:10'),  ('TESTDD','DICT','2012-06-11 21:34:10'),  ('TESTDD','DICT-QUERY','2012-06-11 21:34:10'),  ('TESTDD','LOG','2012-06-11 21:34:10'),  ('TESTDD','ORG','2012-06-11 21:34:10'),  ('TESTDD','ORG-QUERY','2012-06-11 21:34:10'),  ('TESTDD','ROLE','2012-06-11 21:34:10'),  ('TESTDD','ROLE-QUERY','2012-06-11 21:34:10'),  ('TESTDD','SOURCE','2012-06-11 21:34:10'),  ('TESTDD','SOURCE-QUERY','2012-06-11 21:34:10'),  ('TESTDD','SYSLOG','2012-06-11 21:34:10'),  ('TESTDD','SYSLOG-QUERY','2012-06-11 21:34:10'),  ('TESTDD','USER','2012-06-11 21:34:10'),  ('TESTDD','USER-QUERY','2012-06-11 21:34:10'),  ('TESTDD','USERMANAGER','2012-06-11 21:34:10');
INSERT INTO `t_sys_user` VALUES ('ADMIN','系统管理员','陈','CHENYUN','6994d5fd8501c8576fcfd99c3386f085','male','chenyun313@163.com','18701309727','ROOT','YES','NO','0','SYSADMIN'),  ('AINAN','艾楠','艾','ainan','67de2274915e33d54ae338ffdabeee76',NULL,'ainan@163.com',NULL,'0021','YES','NO','0','COMMONUSER'),  ('ZHENGYQ','张亚奇','张','zhangyq','77b01f654f188c182c6b6b28dffe8df8','male','zhengyq@163.com',NULL,'0021','YES','NO',NULL,'COMMONUSER');
INSERT INTO `t_sys_user_role` VALUES ('AINAN','TESTDD','2012-06-01 15:13:51');
