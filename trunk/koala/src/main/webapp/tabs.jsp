<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Tabs</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	

  </head>
  
  <body>
	<div class="row">
	
		<!-- 普通 -->
		<div class="span4">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#">首页</a></li>
				<li><a href="#"><i class="icon-book"></i>类库</a></li>
				<li><a href="#">链接</a></li>
				<li class="dropdown">
					<a href="#" data-toggle="dropdown" class="dropdown-toggle">下拉 <b class="caret bottom-up"></b></a>
					<ul class="dropdown-menu bottom-up pull-right">
				    	<li><a href="#">动作</a></li>
			            <li><a href="#">其他动作</a></li>
			            <li><a href="#">其他</a></li>
			            <li class="divider"></li>
			            <li><a href="#">被间隔的链接</a></li>
			        </ul>
				</li>
			</ul>
		</div>
		
		<!-- 胶囊 -->
		<div class="span4">
			<ul class="nav nav-pills">
				<li class="active"><a href="#">首页</a></li>
				<li><a href="#"><i class="icon-book"></i>类库</a></li>
				<li><a href="#">链接</a></li>
				<li class="dropdown">
					<a href="#" data-toggle="dropdown" class="dropdown-toggle">下拉 <b class="caret bottom-up"></b></a>
					<ul class="dropdown-menu bottom-up pull-right">
				    	<li><a href="#">动作</a></li>
			            <li><a href="#">其他动作</a></li>
			            <li><a href="#">其他</a></li>
			            <li class="divider"></li>
			            <li><a href="#">被间隔的链接</a></li>
			        </ul>
				</li>
			</ul>
		</div>
		
		<div class="span4"></div>
	</div>
	
	<br>
	<br>
	<!--带内容  -->
	<div class="row">
		<div class="span4">
			<div class="tabbable">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#1" data-toggle="tab">首页</a></li>
					<li><a href="#2" data-toggle="tab"><i class="icon-book"></i>类库</a></li>
					<li><a href="#">链接</a></li>
					<li class="dropdown">
						<a href="#" data-toggle="dropdown" class="dropdown-toggle">下拉 <b class="caret bottom-up"></b></a>
						<ul class="dropdown-menu bottom-up pull-right">
					    	<li><a href="#">动作</a></li>
				            <li><a href="#">其他动作</a></li>
				            <li><a href="#">其他</a></li>
				            <li class="divider"></li>
				            <li><a href="#">被间隔的链接</a></li>
				        </ul>
					</li>
				</ul>
				
				 <div class="tab-content">
					<div class="tab-pane active" id="1">
						<p>这里是首页.</p>
					</div>
					<div class="tab-pane" id="2">
						<p>这里是类库 2.</p>
					</div>
				</div>
			</div>
		</div>
		<!-- 上下 -->
		<div class="span4">
			<div class="tabbable tabs-below">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#">首页</a></li>
					<li><a href="#"><i class="icon-book"></i>类库</a></li>
					<li><a href="#">链接</a></li>
					<li class="dropdown">
						<a href="#" data-toggle="dropdown" class="dropdown-toggle">下拉 <b class="caret bottom-up"></b></a>
						<ul class="dropdown-menu bottom-up pull-right">
					    	<li><a href="#">动作</a></li>
				            <li><a href="#">其他动作</a></li>
				            <li><a href="#">其他</a></li>
				            <li class="divider"></li>
				            <li><a href="#">被间隔的链接</a></li>
				        </ul>
					</li>
				</ul>
			</div>
		</div>		
		
		<!-- 左右 -->
		<div class="span4">
			<div class="tabbable tabs-left">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#">首页</a></li>
					<li><a href="#"><i class="icon-book"></i>类库</a></li>
					<li><a href="#">链接</a></li>
					<li class="dropdown">
						<a href="#" data-toggle="dropdown" class="dropdown-toggle">下拉 <b class="caret bottom-up"></b></a>
						<ul class="dropdown-menu bottom-up pull-right">
					    	<li><a href="#">动作</a></li>
				            <li><a href="#">其他动作</a></li>
				            <li><a href="#">其他</a></li>
				            <li class="divider"></li>
				            <li><a href="#">被间隔的链接</a></li>
				        </ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
</body>
</html>
