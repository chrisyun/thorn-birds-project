<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>LeftMenu</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	

  </head>
  
  <body>
    <div class="row">
    	<div class="span4">
   		    <ul class="nav nav-tabs nav-stacked">
		    	<li class="active"><a href="#">首页</a></li>
		    	<li><a href="#"><i class="icon-book"></i>类库</a></li>
		    	<li><a href="#">链接</a></li>
		    </ul>
    	</div>
    	
    	<div class="span4">
    	    <ul class="nav nav-pills nav-stacked">
		    	<li class="active"><a href="#">胶囊首页</a></li>
		    	<li><a href="#"><i class="icon-book"></i>类库</a></li>
		    	<li><a href="#">链接</a></li>
		    </ul>
    	</div>
    	
    	<div class="span4">
			<ul class="nav nav-list">
				<li class="nav-header">列表头</li>
				<li class="active"><a href="#">首页</a></li>
				<li><a href="#">类库</a></li>
				<li class="nav-header">另一个表头</li>
				<li class="active"><a href="#">首页</a></li>
				<li><a href="#">类库</a></li>
				<li class="divider-vertical"></li>
			</ul>
		</div>
    	
    </div>
  </body>
</html>
