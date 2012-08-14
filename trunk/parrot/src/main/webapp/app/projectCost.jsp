<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<%
	String path = request.getContextPath();
%>
<script type="text/javascript" src="<%=path %>/app/projectCost.js"></script>
<script type="text/javascript">
<!--
var year = <thorn:dd  typeId="YEAR" />;
var yearRender = function(str) {
	return Render.dictRender(year, str);
};
//-->
</script>
