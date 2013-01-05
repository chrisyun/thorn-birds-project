<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>密码修改</title>
    
  </head>
  
  <body>
    <div class="container">
		<ul class="breadcrumb">
			<li><a href="<%=path%>">首页</a><span class="divider">/</span></li>
			<li><a href="<%=path%>">个人设置</a><span class="divider">/</span></li>
			<li class="active">密码修改</li>
		</ul>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="span12">
				
			</div>
		</div>
	</div>
	
	
  </body>
</html>
