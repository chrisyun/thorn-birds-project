<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<%
	String path = request.getContextPath();
%>
<head>
	<title>UserAuth - Manage</title>
</head>

<body>
	<script type="text/javascript">
		
		var defaultRole = <thorn:dd  typeId="DEFAULTROLE" />;
		var defaultRoleRender = function(role) {
			return Render.dictRender(defaultRole, role);
		};
		
		var userPermission = {
			SAVEAUTH : '<sec:authorize url="/user/saveUserRole.jmt">true</sec:authorize>',
			REMOVEAUTH : '<sec:authorize url="/user/deleteUserRole.jmt">true</sec:authorize>'
		};
		
	</script>
	<script type="text/javascript" src="<%=path %>/js/system/orgTree.js"></script>
	<script type="text/javascript" src="<%=path %>/js/system/userAuth.js"></script>
</body>