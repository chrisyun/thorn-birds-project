<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<%
	String path = request.getContextPath();
%>
<head>
	<title>Role - Manage</title>
</head>

<body>
	<script type="text/javascript">
	
		var defaultRole = <thorn:dd  typeId="DEFAULTROLE" />;
		var defaultRoleRender = function(role) {
			return Render.dictRender(defaultRole, role);
		};
		
		var userPermission = {
			SAVE : '<sec:authorize url="/role/saveOrModify*.jmt">true</sec:authorize>',
			MODIFY : '<sec:authorize url="/role/saveOrModify*.jmt">true</sec:authorize>',
			REMOVE : '<sec:authorize url="/role/deleteRole.jmt">true</sec:authorize>',
			AUTH : '<sec:authorize url="/role/saveAuth.jmt">true</sec:authorize>'
		};
		
	</script>
	<script type="text/javascript" src="<%=path %>/plugins/local/tree3.js"></script>
	<script type="text/javascript" src="<%=path %>/js/system/role.js"></script>
</body>