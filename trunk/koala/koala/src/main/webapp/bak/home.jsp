<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Home</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
  	<div class="container">
		<div class="row">
			<div class="span4">这是一个940px的布局</div>
			<div class="span8">8</div>
		</div>
		<div class="row">
			<div class="span4">4</div>
			<div class="span4">4</div>
			<div class="span4">4</div>
		</div>
	</div>
	
	<br>
	
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span2">
				这是左边区域
			</div>
			<div class="span10">
				这是右边区域
			</div>
		</div>
	</div>

</body>
</html>
