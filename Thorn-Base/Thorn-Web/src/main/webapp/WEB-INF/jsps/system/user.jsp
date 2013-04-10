<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<%
	String path = request.getContextPath();
%>
<head>
	<title>User - Manage</title>
</head>

<body>
	<script type="text/javascript">
	
		var area = <thorn:dd  typeId="AREA" />;
		var areaRender = function(str) {
			return Render.dictRender(area, str);
		};
		
		var defaultRole = <thorn:dd  typeId="DEFAULTROLE" />;
		var defaultRoleRender = function(role) {
			return Render.dictRender(defaultRole, role);
		};
		
		var gender = <thorn:dd  typeId="GENDER" />;
		var genderRender = function(str) {
			return Render.dictRender(gender, str);
		};
		
		var userPermission = {
			SAVE : '<sec:authorize url="/user/saveOrModify*.jmt">true</sec:authorize>',
			MODIFY : '<sec:authorize url="/user/saveOrModify*.jmt">true</sec:authorize>',
			REMOVE : '<sec:authorize url="/user/deleteUser.jmt">true</sec:authorize>',
			DISABLED : '<sec:authorize url="/user/disabledUser.jmt">true</sec:authorize>',
			CHANGEPWD : '<sec:authorize url="/user/changePwd.jmt">true</sec:authorize>',
			AUTH : '<sec:authorize url="/user/saveRoleByUser.jmt">true</sec:authorize>'
		};
		
	</script>
	<script type="text/javascript" src="<%=path %>/plugins/local/treeField.js"></script>
	<script type="text/javascript" src="<%=path %>/js/system/orgTree.js"></script>
	<script type="text/javascript" src="<%=path %>/js/system/userPwd.js"></script>
	<script type="text/javascript" src="<%=path %>/js/system/user.js"></script>
</body>
