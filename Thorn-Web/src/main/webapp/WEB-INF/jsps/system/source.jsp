<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<%
	String path = request.getContextPath();
%>
<head>
	<title>Resource - Manage</title>
</head>

<body>
	<script type="text/javascript">
	
		var iconCls = <thorn:dd  typeId="ICONCLS" />;
		var iconClsRender = function(icon) {
			return Render.dictRender(iconCls, icon);
		};
		
		var userPermission = {
			SAVE : '<sec:authorize url="/org/saveOrModify*.jmt">true</sec:authorize>',
			MODIFY : '<sec:authorize url="/org/saveOrModify*.jmt">true</sec:authorize>',
			REMOVE : '<sec:authorize url="/org/deleteSource.jmt">true</sec:authorize>'
		};
		
	</script>
	<script type="text/javascript" src="<%=path %>/js/system/source.js"></script>
</body>