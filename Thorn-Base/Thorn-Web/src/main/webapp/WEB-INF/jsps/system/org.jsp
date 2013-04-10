<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<%
	String path = request.getContextPath();
%>
<head>
	<title>Org - Manage</title>
</head>

<body>
	<script type="text/javascript">
	
		var orgType = <thorn:dd  typeId="ORGTYPE" />;
		var orgTypeRender = function(type) {
			return Render.dictRender(orgType, type);
		};
		
		var area = <thorn:dd  typeId="AREA" />;
		var areaRender = function(str) {
			return Render.dictRender(area, str);
		};
		
		var userPermission = {
			SAVE : '<sec:authorize url="/org/saveOrModify*.jmt">true</sec:authorize>',
			MODIFY : '<sec:authorize url="/org/saveOrModify*.jmt">true</sec:authorize>',
			REMOVE : '<sec:authorize url="/org/deleteOrg.jmt">true</sec:authorize>'
		};
		
	</script>
	<script type="text/javascript" src="<%=path %>/plugins/local/treeField.js"></script>
	<script type="text/javascript" src="<%=path %>/js/system/orgTree.js"></script>
	<script type="text/javascript" src="<%=path %>/js/system/org.js"></script>
</body>