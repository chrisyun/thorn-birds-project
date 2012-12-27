<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.setStatus(HttpServletResponse.SC_OK);
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <base href="<%=basePath%>">
    
    <title>HTTP 404</title>
    
    <link href="<%=path %>/plugins/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="<%=path %>/plugins/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	
	<script type="text/javascript" src="<%=path %>/plugins/jquery/jquery-1.8.2.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/bootstrap/js/bootstrap.js"></script>
	
	<script type="text/javascript" src="<%=path %>/plugins/func/system.js"></script>
    
  </head>
  
  <body>
  	<div class="container">
		<c:import url="/WEB-INF/jsps/ref/header_1.jsp"></c:import>
		<div class="row" style="padding-top: 30px;">
			<div class="span10 offset1">
				<div class="hero-unit">
					<h3>抱歉，您请求的页面没有找到！</h3>
					<p>您可以检查页面地址是否有误，或者稍后重新访问。</p>
					<p>
						<a class="btn btn-primary btn-large" href="<%=path %>">点击这里返回主页</a>
					</p>
				</div>
			</div>
		</div>
    </div>
  	
 	<c:import url="/WEB-INF/jsps/ref/footer_1.jsp"></c:import>

</body>
</html>
