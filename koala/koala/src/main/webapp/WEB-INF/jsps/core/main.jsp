<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	<link href="<%=path %>/plugins/validationEngine/css/validationEngine.jquery.css" rel="stylesheet">
	
	<script type="text/javascript" src="<%=path %>/plugins/jquery/jquery-1.8.2.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/jquery-ui/jquery-ui-1.9.1.custom.min.js"></script>
	
	<script type="text/javascript" src="<%=path %>/plugins/validationEngine/languages/jquery.validationEngine-zh_CN.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/validationEngine/jquery.validationEngine.js"></script>
	
	<script type="text/javascript" src="<%=path %>/plugins/func/system.js"></script>
	
	<script type="text/javascript">
	var user = {
		userId 		: "<sec:authentication property="principal.username" />",
		userName 	: "<sec:authentication property="principal.user.userName" />",
		org			: "<sec:authentication property="principal.user.orgCode" />",
		cumail 		: "<sec:authentication property="principal.user.cumail" />",
		phone 		: "<sec:authentication property="principal.user.phone" />",
		role		: new Array()
	};
	
	<sec:authentication property="authorities" var="authorities" scope="page"/>
	<c:forEach items="${authorities}" var="authority">
	user.role.push("${authority.authority}");
	</c:forEach>
	</script>
	
	<decorator:head />
	
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
  	</div>
  	
  	<!-- navigation bars -->
  	<!-- no login -->
  	<div class="navbar">
		<div class="navbar-inner">
			<sec:authentication property="principal.username" var="userId" scope="page"/>
		<c:if test="${!empty userId }">
			<div class="container" style="margin-left: 50px;margin-right: 50px;">
				<ul class="nav">
					<li><a href="<%=path%>/home.jhtml"><i class="icon-home"></i>主页</a></li>
					<li class="divider-vertical"></li>
					<!-- app -->
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							应用菜单<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<li><a href="#">修改个人信息</a></li>
							<li><a href="#">修改登录密码</a></li>
							<li class="divider"></li>
							<li><a href="#">被隔离的链接</a></li>
						</ul>
					</li>
					
					<!-- sys -->
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							系统管理<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<li><a href="#">修改个人信息</a></li>
							<li><a href="#">修改登录密码</a></li>
							<li class="divider"></li>
							<li><a href="#">被隔离的链接</a></li>
						</ul>
					</li>
					
					<!-- cms -->
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							信息发布<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<li><a href="#">栏目管理</a></li>
							<li><a href="#">模板管理</a></li>
							<li class="divider"></li>
							<li><a href="#">内容管理</a></li>
						</ul>
					</li>
				</ul>
				<ul class="nav pull-right">
					<li><a class="brand" href="<%=path%>">Koala</a></li>
					<li class="divider-vertical"></li>
					<li><a href="#"><sec:authentication property="principal.user.userName" />，退出</a></li>
					<li class="divider-vertical"></li>
					
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<i class="icon-user"></i>个人账户<b class="caret"></b>
						</a>
						<ul class="dropdown-menu">
							<li><a href="#">修改个人信息</a></li>
							<li><a href="#">修改登录密码</a></li>
							<li class="divider"></li>
							<li><a href="#">被隔离的链接</a></li>
						</ul>
					</li>
					<li class="divider-vertical"></li>
				</ul>
			</div>
		</c:if>
		</div>
	</div>
  	
  	<!-- login -->
  	
    <decorator:body />
    
    <!-- footer -->
    <div class="container">
		<div class="row">
			<div class="span12">
			<hr style="margin-top: 5px;margin-bottom: 5px;">
			<small>北京谋智火狐信息技术有限公司&nbsp;&nbsp;&nbsp;&nbsp;京 ICP备11011334号-1</small>
			<hr style="margin-top: 5px;margin-bottom: 5px;">
			<small>关于淘宝&nbsp;&nbsp;&nbsp;&nbsp;合作伙伴&nbsp;&nbsp;&nbsp;&nbsp;
			营销中心&nbsp;&nbsp;&nbsp;&nbsp;服务中心&nbsp;&nbsp;&nbsp;&nbsp;
			开放平台&nbsp;&nbsp;&nbsp;&nbsp;诚征英才&nbsp;&nbsp;&nbsp;&nbsp;
			联系我们&nbsp;&nbsp;&nbsp;&nbsp;网站地图&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="pull-right">版权所有 © 2012 Mozilla Firefox.</span></small>
			</div>
		</div>
  	</div>
    
    
  </body>
</html>
