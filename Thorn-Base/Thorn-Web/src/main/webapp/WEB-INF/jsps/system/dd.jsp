<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
	String path = request.getContextPath();
%>
<head>
	<title>Data - Dict</title>
</head>

<body>
	<script type="text/javascript">
	
		var userPermission = {
			SAVE : '<sec:authorize url="/dd/saveOrModify*.jmt">true</sec:authorize>',
			MODIFY : '<sec:authorize url="/dd/saveOrModify*.jmt">true</sec:authorize>',
			REMOVE : '<sec:authorize url="/dd/delete*.jmt">true</sec:authorize>'
		};
	</script>
	<script type="text/javascript" src="<%=path %>/js/system/dd.js"></script>
</body>