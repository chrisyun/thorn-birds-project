<%@page import="org.thorn.cms.common.CMSConfiguration"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>站点管理</title>
    <script type="text/javascript">
    $(function(){
    	var curWebSite = "${sessionScope.currentWebSite.id}";
    	if(!$.utils.isEmpty(curWebSite)) {
    		$("#switBtn").html("当前站点：${sessionScope.currentWebSite.shortName}");
    	}
    	
		$("#editWSForm").formDialog({
			title : "编辑站点信息",
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#editWSForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#wsMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
							setTimeout(function(){
								$.utils.reloadPage();
							}, 2000);
						},
						onFailure : function(msg) {
							$("#wsMsgTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#wsMsgTips").message({
								type : "error",
								text : "网络请求超时，请稍后再试！",
								title : "数据处理出错"
							});
						}
					});
				}
			}, {
				text : "关闭",
				closed : true
			}]
		});
		
		initValidationEngine("editWSForm");
    });
    
	function openAddWnd() {
		
		$("#wsMsgTips").html("");
		$("#editWSForm").resetForm();
		$("#editWSForm").formDialog("show");
		$("#editWSForm [name=templateFolder]").attr("readonly", false);
		$("#editWSForm [name='opType']").val("save");
	}
	
	function openEditWnd(id) {
		
		$("#wsMsgTips").html("");
		$("#editWSForm").resetForm();
		$("#editWSForm [name=templateFolder]").attr("readonly", true);
		
		$.server.ajaxRequest({
			url : "<%=path%>/CMS/WS/queryWebSite.jmt",
			data : {id : id},
			progress : false,
			onSuccess : function(msg, data) {
				$("#editWSForm").setFormValues(data);
				
				$("#editWSForm [name='opType']").val("modify");
				$("#editWSForm").formDialog("show");
			}
		});
	}
    
	function deleteWebSite(ids) {
		$.dialog.confirm("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/CMS/WS/deleteWebSite.jmt",
				data : {
					ids : ids
				},
				onSuccess : function(msg, data) {
					$.dialog.alertSuccess(msg, "请求处理成功", function(){
						$.utils.refreshPage();
					});
				}
			});
		});
	}
	
	function deleteWebSites() {
		
		var ids = $.utils.getChecked($("#wsTable"));
		
		if(ids == "") {
			$.dialog.alertInfo("请选择需要删除的项！");
		} else {
			deleteWebSite(ids);
		}
	}
	
	function switWebSite(id, name) {
		
		$.server.ajaxRequest({
			url : "<%=path%>/CMS/WS/querySwitchWebSite.jmt",
			data : {id : id},
			onSuccess : function(msg, data) {
				$.dialog.alertSuccess(msg, "请求处理成功");
				
				$("#switBtn").html("当前站点：" + name);
			}
		});
	}
	
	
    </script>
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/CMS/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">站点管理</li>
		</ul>
	</div>
	
	<div class="row">
    	<div class="span12">
  			<form class="form-search" method="post" action="<%=path %>/CMS/WS/queryWebSites.jhtml" id="queryForm">
				<label>站点名称：</label>
			  	<input name="name" class="input-medium" type="text">
			  	<label style="width: 10px;"></label>
			  	<button type="submit" class="btn">搜索</button>
			</form>
			
			<div class="well formOutSide">
				<sec:authorize url="/CMS/WS/saveOrModify*.jmt">
				<button class="btn btn-primary" onclick="openAddWnd();"><i class="icon-plus"></i>新增</button>
				</sec:authorize>
				<sec:authorize url="/CMS/WS/delete*.jmt">
				<button class="btn btn-danger" onclick="deleteWebSites();">删除选中项</button>
				</sec:authorize>
				<div class="btn-group help-inline">
					<button class="btn btn-info" id="switBtn">切换站点</button>
				  	<button class="btn btn-info dropdown-toggle" data-toggle="dropdown">
				    	<span class="caret"></span>
				  	</button>
					<ul class="dropdown-menu" id="wsList" style="height: 100px;">
						<c:forEach var="ws" items="${list }">
						<li><a href="javascript:void(0);" onclick="switWebSite('${ws.id}','${ws.shortName }');">${ws.shortName }</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			
			<table class="table table-striped table-bordered table-condensed" id="wsTable">
				<thead id="listHeader">
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll(this);">
						</label></th>
						<th width="30%">站点名称</th>
						<th width="30%">站点简称</th>
						<th width="25%">模板文件夹</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="ws" items="${list }">
					<tr>
						<td><label class="checkbox"><input type="checkbox" id="${ws.id }" class="checkOne"></label></td>
						<td>${ws.name }</td>
						<td>${ws.shortName }</td>
						<td>${ws.templateFolder }</td>
						<td style="text-align: center;">
							<div class="btn-group">
								<sec:authorize url="/CMS/WS/saveOrModify*.jmt">
								<button class="btn btn-info btn-mini" onclick="openEditWnd('${ws.id}')">
									<i class="nopadding icon-edit"></i>
								</button>
								</sec:authorize>
								<sec:authorize url="/CMS/WS/delete*.jmt">
								<button class="btn btn-danger btn-mini" onclick="deleteWebSite('${ws.id}')">
									<i class="nopadding icon-trash"></i>
								</button>
								</sec:authorize>
							</div>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<form class="form-horizontal" method="post" action="<%=path%>/CMS/WS/saveOrModifyWebSite.jmt" id="editWSForm">
		<fieldset>
			<div id="wsMsgTips"></div>
			<input type="hidden" name="opType">
			<input type="hidden" name="id">
			<div class="control-group">
				<label class="control-label" for="name">站点名称：</label>
				<div class="controls">
					<input type="text" class="input-large" name="name"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="shortName">站点简称：</label>
				<div class="controls">
					<input type="text" class="input-large" name="shortName"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="templateFolder">模板文件夹：</label>
				<div class="controls">
					<div class="input-prepend">
						<span class="add-on"><%=CMSConfiguration.TEMPLATE_ROOT %></span>
						<input type="text" class="input-medium" name="templateFolder"
							data-validation-engine="validate[required,custom[onlyLetterNumber]]">
					</div>
					<p class="help-block"><i class="redStar">*</i>必填，不得与现有的文件夹重名</p>
				</div>
			</div>
		</fieldset>
	</form>
	
	
    <c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>	
  </body>
</html>
