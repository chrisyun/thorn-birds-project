<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>404 Page Not Found</title>
<style type="text/css">
body {
	font: 14px/1.231 arial, helvetica, clean, sans-serif;
	*font-size: small;
	*font: x-small;
	color: blue;
}
hr {
	border-width: 2px;
	border-color: black;
}
</style>
</head>
<%
	response.setStatus(HttpServletResponse.SC_OK);
%>
<body>
	<br>
	<hr width="60%" align="left">
	<h1>您访问的页面不存在！</h1>
	<hr width="100%">
</body>
</html>