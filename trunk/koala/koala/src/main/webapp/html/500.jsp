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
    
    <title>HTTP 500</title>
    
    <link href="<%=path %>/plugins/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="<%=path %>/plugins/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	
	<script type="text/javascript" src="<%=path %>/plugins/jquery/jquery-1.8.2.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/bootstrap/js/bootstrap.js"></script>
	
	<script type="text/javascript" src="<%=path %>/plugins/func/system.js"></script>
    
  </head>
  
  <body>
  	<!-- logo and ad -->
  	<div class="container">
		<div class="row" style="padding-top: 10px;padding-bottom: 10px;">
			<div class="span3">
				<a href="<%=path%>"><img alt="logo" src="<%=path%>/images/logo.jpg"></a>
			</div>
			<div class="span5 offset2 pull-right"><img alt="广告" src="<%=path%>/images/ad.jpg"></div>
		</div>
		<div class="row">
  			<div class="span12">
  			  	<div class="navbar">
					<div class="navbar-inner"></div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="span12">
				<div class="hero-unit">
					<h1>Http 500</h1>
					<br>
					<p>网站出现错误，请您重新访问。<a class="btn btn-primary" href="<%=path %>">点击这里返回主页</a></p>
					<p><a class="btn btn-warning" href="javascript:void(0);" onclick="reportError();">报告问题</a></p>
					<pre id="msg1" style="display: none;">
	   					<%=exception.getMessage() != null ? exception.getMessage().replaceAll("<", "&lt;").replaceAll(">", "&gt;") : "" %>
	   				</pre>
					<%
	   					StackTraceElement[] stArray = exception.getStackTrace();
	   					StringBuilder errorMsg = new StringBuilder();
	   					for(StackTraceElement st : stArray) {
	   						errorMsg.append("at ").append(st.getClassName()).append(".");
	   						errorMsg.append(st.getMethodName()).append("(");
	   						errorMsg.append(st.getFileName()).append(":");
	   						errorMsg.append(st.getLineNumber()).append(")").append("\n");
	   					}
	   				%>
	   				<pre id="msg1" style="display: none;"><%=errorMsg.toString() %></pre>
	   			</div>
			</div>
  		</div>
		<div class="row">
			<div class="span12">
			<small>北京谋智火狐信息技术有限公司&nbsp;&nbsp;&nbsp;&nbsp;京 ICP备11011334号-1</small>
			<hr style="margin-top: 5px;margin-bottom: 5px;">
			<small>关于淘宝&nbsp;&nbsp;&nbsp;&nbsp;合作伙伴&nbsp;&nbsp;&nbsp;&nbsp;
			营销中心&nbsp;&nbsp;&nbsp;&nbsp;服务中心&nbsp;&nbsp;&nbsp;&nbsp;
			开放平台&nbsp;&nbsp;&nbsp;&nbsp;诚征英才&nbsp;&nbsp;&nbsp;&nbsp;
			联系我们&nbsp;&nbsp;&nbsp;&nbsp;网站地图&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="pull-right">版权所有 © 2012 Mozilla Firefox.</span></small>
			<hr style="margin-top: 5px;margin-bottom: 5px;">
			</div>
		</div>
  	</div>
  </body>
</html>
