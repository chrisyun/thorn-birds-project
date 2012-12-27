<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <base href="<%=basePath%>">
    
    <title><decorator:title default="koala"/></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link href="<%=path %>/plugins/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="<%=path %>/plugins/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	<link href="<%=path %><spring:theme code="css" />" rel="stylesheet">
	
	<link href="<%=path %>/plugins/validationEngine/css/template.css" rel="stylesheet">
	<link href="<%=path %>/plugins/validationEngine/css/validationEngine.jquery.css" rel="stylesheet">
	
	<script type="text/javascript" src="<%=path %>/plugins/jquery/jquery-1.8.2.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/jquery-ui/jquery-ui-1.9.1.custom.min.js"></script>
	
	<script type="text/javascript" src="<%=path %>/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/validationEngine/jquery.validationEngine.js"></script>
	
	<script type="text/javascript" src="<%=path %>/plugins/func/system.js"></script>
	
	<decorator:head />
	
  </head>
  
  <body>
    <decorator:body />
  </body>
</html>
