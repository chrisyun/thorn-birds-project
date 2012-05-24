<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.thorn.security.entity.UserSecurity"%>
<%@page import="org.thorn.user.entity.User"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="thorn" uri="/thorn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Authentication auth = SecurityContextHolder.getContext().getAuthentication();
String userId = "";
String userName = "";
String cumail = "";
String phone = "";

if(auth != null) {
	UserSecurity us = (UserSecurity) auth.getPrincipal();
	User user = us.getUser();
	userId = user.getUserId();
	userName = user.getUserName();
	cumail = user.getCumail();
	phone = user.getPhone();
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Page</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<!-- no cache headers -->
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="no-cache">
		<meta http-equiv="Expires" content="-1">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
		<!-- end no cache headers -->
	</head>
	<style type="text/css">
	#loading-mask {
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		z-index: 20001;
		background-color: white;
	}
	
	#loading {
		position: absolute;
		left: 45%;
		top: 40%;
		padding: 2px;
		z-index: 20002;
		height: auto;
	}
	
	#loading a {
		color: #225588;
	}
	
	#loading .loading-indicator {
		background: white;
		color: #444;
		font: bold 13px tahoma, arial, helvetica;
		padding: 10px;
		margin: 0;
		height: auto;
	}
	
	#loading-msg {
		font: normal 10px arial, tahoma, sans-serif;
	}
	</style>
	<body>
		<div id="loading-mask" style=""></div>
		<div id="loading">
		    <div class="loading-indicator">
		    	<img src="<%=path %>/resources/images/local/page-loading.gif" width="32" height="32" style="margin-right:8px;float:left;vertical-align:top;"/>
		    		Ext JS 3.2 - <a href="http://extjs.com">extjs.com</a><br />
		    		<span id="loading-msg">Loading styles and images...</span>
		    </div>
		</div>
		
		<link rel="stylesheet" type="text/css" href="<%=path %><spring:theme code="css" />" />
		<link rel="stylesheet" type="text/css" href="<%=path %>/resources/localStyle.css" />
		
		<script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Loading Core API...';</script>
        <script type="text/javascript" src="<%=path %>/plugins/ext-3.2.1/adapter/ext/ext-base.js" ></script>
        <script type="text/javascript">document.getElementById('loading-msg').innerHTML = 'Loading UI Components...';</script>
        <script type="text/javascript" src="<%=path %>/plugins/ext-3.2.1/ext-all-debug.js"></script>
        <script type="text/javascript" src="<%=path %>/plugins/ext-3.2.1/ux/SearchField.js"></script>
        
        <script type="text/javascript" src="<%=path %>/plugins/local/globalConfig.js" ></script>
        <script type="text/javascript" src="<%=path %>/plugins/local/systemUtils.js" ></script>
        <script type="text/javascript" src="<%=path %>/plugins/local/msgUtils.js" ></script>
        <script type="text/javascript" src="<%=path %>/plugins/local/ajaxUtils.js" ></script>
        <script type="text/javascript" src="<%=path %>/plugins/local/renderUtils.js" ></script>
        
        <script type="text/javascript" src="<%=path %>/plugins/local/componentUtils.js" ></script>
        <script type="text/javascript" src="<%=path %>/plugins/local/validateUtils.js" ></script>
        <script type="text/javascript" src="<%=path %>/plugins/local/windowUtils.js" ></script>
        <script type="text/javascript" src="<%=path %>/plugins/local/gridUtils.js" ></script>
        <script type="text/javascript" src="<%=path %>/plugins/local/formUtils.js" ></script>
        
        
        <script type="text/javascript">
        	document.getElementById('loading-msg').innerHTML = 'Initializing...';
        	Ext.BLANK_IMAGE_URL = "<%=path %>/resources/images/default/s.gif";
        		var sys = {
					path		: "<%=path%>",
					basePath	: "<%=basePath%>"
				};
			
				var user = {
					userId 		: "<%=userId%>",
					userName 	: "<%=userName%>",
					cumail 		: "<%=cumail%>",
					phone 		: "<%=phone%>"
				}
				
				var yesOrNo = <thorn:dd  typeId="YESORNO" />;
				
				var yesOrNoRender = function(status) {
					return Render.dictRender(yesOrNo, status);
				};
        </script>
	
	