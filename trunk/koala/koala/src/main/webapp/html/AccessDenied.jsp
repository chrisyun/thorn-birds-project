<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <title>Access Denied</title>
  </head>
  
  <body>
  	<div class="container">
  		<c:import url="/WEB-INF/jsps/ref/header_1.jsp"></c:import>
		<div class="row" style="padding-top: 30px;">
  			<div class="span10 offset1">
				<div class="hero-unit">
					<h3>对不起，您的请求被拒绝！</h3>
					<p>${requestScope['SPRING_SECURITY_403_EXCEPTION'].message}</p>
					<p>您没有权限访问本页面，请联系管理员为您分配相应的访问权限！</p>
				</div>
			</div>
		</div>
  	</div>
  
  	<c:import url="/WEB-INF/jsps/ref/footer_1.jsp"></c:import>
   
  </body>
</html>
