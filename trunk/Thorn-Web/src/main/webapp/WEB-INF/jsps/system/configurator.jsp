<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
	String path = request.getContextPath();
%>
<head>
	<title>Configurator - Manager</title>
</head>

<body>
	<script type="text/javascript">
	
		var userPermission = {
			MODIFY : '<sec:authorize url="/cf/modifyConfig.jmt">true</sec:authorize>'
		};
	</script>
	<script type="text/javascript" src="<%=path %>/js/system/configurator.js"></script>
</body>