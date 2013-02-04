/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : koala

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2013-02-04 17:25:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_sys_resource`
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
-- Records of t_sys_resource
-- ----------------------------
INSERT INTO `t_sys_resource` VALUES ('App', '应用系统', '/App/index.jhtml', 'NO', 'YES', 'Root', '0', null);
INSERT INTO `t_sys_resource` VALUES ('CMS', '信息发布', '/CMS/index.jhtml', 'NO', 'YES', 'Root', '2', null);
INSERT INTO `t_sys_resource` VALUES ('DDManager', '数据字典管理', '/System/dd/queryDtPage.jhtml', 'NO', 'YES', 'System', '0', null);
INSERT INTO `t_sys_resource` VALUES ('OrgManager', '组织机构管理', '/System/org/queryOrgPage.jhtml', 'NO', 'YES', 'System', '1', null);
INSERT INTO `t_sys_resource` VALUES ('ResourceManager', '资源管理', '/System/resource/queryResourcePage.jhtml', 'NO', 'YES', 'System', '4', null);
INSERT INTO `t_sys_resource` VALUES ('RoleManager', '角色管理', '/System/role/queryRolePage.jhtml', 'NO', 'YES', 'System', '5', null);
INSERT INTO `t_sys_resource` VALUES ('Root', '根节点', '', 'NO', 'NO', '-1', '99', '');
INSERT INTO `t_sys_resource` VALUES ('System', '系统管理', '/System/index.jhtml', 'NO', 'YES', 'Root', '1', null);
INSERT INTO `t_sys_resource` VALUES ('UserManager', '用户管理', '/System/user/queryUserPage.jhtml', 'NO', 'YES', 'System', '2', null);
