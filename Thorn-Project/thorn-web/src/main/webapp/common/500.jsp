<%@ page language="java" contentType="text/html; charset=UTF-8"
	isErrorPage="true" pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.PrintStream"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>500 Error Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<h1>程序发生了错误，有可能该页面正在调试或者是设计上的缺陷.</h1>
	<br />
	<p>
		An exception was thrown: <b style="color: red;"> <%=exception.getClass()%>:<%=exception.getMessage()%></b>
	</p>
	<br>
	<%
		Enumeration<String> e = request.getHeaderNames();
		String key;
		while (e.hasMoreElements()) {
			key = e.nextElement();
		}
		e = request.getAttributeNames();
	%>
	<%=request.getAttribute("javax.servlet.forward.request_uri")%><br>
	<%=request.getAttribute("javax.servlet.forward.servlet_path")%>
	<p>With the following stack trace:</p>
	<pre>
   	<%
   		exception.printStackTrace();
   		ByteArrayOutputStream ostr = new ByteArrayOutputStream();
   		exception.printStackTrace(new PrintStream(ostr));
   		out.print(ostr);
   	%>
   	</pre>
	<hr width="100%">
</body>
</html>
