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
    
    <title>配置文件管理</title>
	<script type="text/javascript">
	$(function(){
		$(".renderer-desc").renderer({
			renderer : "detail"
		});
		
		$("#editCfForm input").hover(
			function () {
			  	$(this).popover("show");
			},
			function () {
			  	$(this).popover("hide");
			}
		);
		
		initValidationEngine("editCfForm");
	});
	
	function saveConfig() {
		
		if($.utils.isEmpty($("#configName").val())) {
			$.dialog.alertInfo("请选择配置文件！");
			return ;
		}
		
		if($("#editCfForm input").length < 0) {
			$.dialog.alertInfo("未找到配置项！");
			return ;
		}
		
		$("#editCfForm").submitForm();
	}
	
	function query() {
		var cfName = $("#queryForm select").val();
		
		if($.utils.isEmpty(cfName)) {
			$.dialog.alertInfo("请选择配置文件！");
			return ;
		}
		
		$("#configName").val(cfName);
		$("#queryForm").submit();
	}
	
	</script>
	
	
  </head>
  
  <body>
   	<div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">配置文件管理</li>
		</ul>
	</div>
	
	<div class="row">
		<div class="span8">
			<form class="form-search" method="post" action="<%=path %>/System/cf/queryConfig.jhtml" id="queryForm">
				<label>配置文件：</label>
				<select name="name" class="input-medium">
					<option value="">-----请选择-----</option>
					<c:forEach var="name" items="${cfNames }">
					<option value="${name }">${name }</option>
					</c:forEach>
				</select>
			  	<label style="width: 10px;"></label>
			  	<input type="hidden" name="configName" id="configName">
			  	<button type="button" class="btn" onclick="query();">搜索</button>
			</form>
			
			<form class="form-horizontal well" method="post" action="<%=path%>/System/cf/modifyConfig.jmt" id="editCfForm">
				<fieldset>
					<c:forEach var="map" items="${cf }">
					<div class="control-group">
						<label class="control-label renderer-desc" style="width: 180px;" for="${map.key }">${map.key }：</label>
						<div class="controls">
							<input type="text" title="${map.value }" class="input-xlarge" name="${map.key }" value="${map.value }">
						</div>
					</div>
					</c:forEach>
					<sec:authorize url="/System/cf/modifyConfig.jmt">
					<div class="form-actions">
				    	<button class="btn btn-primary btn-large" type="button" onclick="saveConfig();">保存</button>
				    </div>
				    </sec:authorize>
				</fieldset>
			</form>
		</div>
		
		<div class="span4 well" style="margin-top: 50px;">
			<p>1、部分应用服务器修改配置文件后会自动重启。</p>
			<p>2、配置文件如果没有配置监听，需要重启应用才能生效。</p>
		</div>
		
	</div>
	
	<c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>	
	
  </body>
</html>
