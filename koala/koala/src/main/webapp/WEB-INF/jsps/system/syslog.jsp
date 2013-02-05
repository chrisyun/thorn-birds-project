<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <title>系统日志</title>
    <script type="text/javascript" src="<%=path %>/plugins/scrollfollow/jquery.scrollfollow.js"></script>
    
	<script type="text/javascript">
	$(function(){
		initValidationEngine("levelForm");
		
		$.server.ajaxRequest({
			url : "<%=path%>/System/log/querylogRows.jmt",
			onSuccess : function(msg, data) {
				$("#logbody").html(data);
			}
		});
		
		$("#refresh").scrollFollow({
			container : "tableContainer"
		});
	});
	
	function saveLevel() {
		$("#levelForm").submitForm();
	}
	
	</script>
	
	
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">系统日志</li>
		</ul>
	</div>
	
	<sec:authorize url="/System/log/modifyLogLevel.jmt">
	<div class="row">
		<div class="span12">
			<form class="form-search" method="post" action="<%=path %>/System/log/modifyLogLevel.jmt" id="levelForm">
				<label>设置logback日志级别：</label>
			  	<select name="level" class="input-medium" data-validation-engine="validate[required]">
					<option value="">-----请选择-----</option>
					<c:forEach var="map" items="${levels }">
					<option value="${map.key }">${map.value }</option>
					</c:forEach>
				</select>
			  	<label style="width: 10px;"></label>
			  	<button type="button" class="btn btn-primary" onclick="saveLevel();">保存</button>
			</form>
		</div>
	</div>
	</sec:authorize>
	
	<div class="row">
		<div class="span12" id="tableContainer">
			<table class="table table-bordered table-condensed">
				<thead>
					<tr>
						<th width="20%">时间</th>
						<th width="8%">线程名</th>
						<th width="8%">级别</th>
						<th width="10%">类路径</th>
						<th width="55%" style="text-align: center;">输出</th>
					</tr>
				</thead>
				<tbody id="logbody" style="font-size: 12px;"></tbody>
			</table>
			
			<div id="refresh">
				<p>回到顶部</p>
				<p>刷新</p>
			</div>
		</div>
	</div>
	
  </body>
</html>
