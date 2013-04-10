<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Navigation</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body>
	<div class="row">
		<div class="span12">12</div>
	</div>
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="#">我固定在上面 </a>
				<ul class="nav">
					<li class="active"><a href="#"><i class="icon-home"></i>首页</a></li>
					<li class="divider-vertical"></li>
					<li><a href="#">链接</a></li>
					<li class="divider-vertical"></li>
					<li><a href="#">链接</a></li>
					<li class="divider-vertical"></li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
						data-toggle="dropdown">帐户<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<li><a href="#">one</a></li>
							<li><a href="#">two</a></li>
							<li><a href="#">three</a></li>
							<li class="divider"></li>
							<li><a href="#">被隔离的链接</a></li>
						</ul>
					</li>
				</ul>
				<form class="navbar-search pull-left">
					<input type="text" class="search-query" placeholder="Search">
				</form>
				<ul class="nav pull-right">
					<li class="divider-vertical"></li>
					<li><a href="#">链接</a></li>
					<li class="divider-vertical"></li>
					<li><a href="#">链接</a></li>
					<li class="divider-vertical"></li>
				</ul>
			</div>
		</div>
	</div>
	
	<br>
	<br>
	
	<ul class="breadcrumb">
		<li><a href="#">首页</a> <span class="divider">/</span></li>
		<li><a href="#">类库</a> <span class="divider">/</span></li>
		<li class="active">数据</li>
	</ul>
	
	<div style="height: 900px;"></div>
	<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
	<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
	<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
	<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
	<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
	<br>&nbsp;<br>

	<div class="navbar navbar-fixed-bottom">
		<div class="navbar-inner">
			<div class="container">
				<a href="#" class="brand">我固定在下面</a>
				<form class="navbar-search pull-left">
					<input type="text" class="span2" placeholder="Search">
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>
