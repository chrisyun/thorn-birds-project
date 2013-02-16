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
    
    <title>资源管理</title>
	<link href="<%=path %>/plugins/zTree/zTreeBookStyle.css" rel="stylesheet">
    <script type="text/javascript" src="<%=path %>/plugins/zTree/jquery.ztree.all-3.5.js"></script>
    
	<script type="text/javascript">
	$(function(){
		$(".renderer-yn").renderer({
			renderArray : <thorn:dd  typeId="YESORNO" />
		});
		
		$("#pagingBar").page({
			align : "right",
			pageSize : parseInt('${page.pageSize}'),
			totalSize : parseInt('${page.total}'),
			pageIndex : parseInt('${page.pageIndex}')
		});
		
		$("#listHeader").sorter({
			sort : "${param.sort}",
			dir : "${param.dir}"
		});
		
		$("#editResourceForm").formDialog({
			title : "编辑资源信息",
			width : 700,
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#editResourceForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#resourceMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
							setTimeout(function(){
								$.utils.reloadPage();
							}, 2000);
						},
						onFailure : function(msg) {
							$("#resourceMsgTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#resourceMsgTips").message({
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
		
		var setting = {
			async: {
				enable: true,
				url:"<%=path%>/System/resource/queryResourceTree.jmt?pid=Root"
			},
			data : {
				key : {
					name : "text"
				}
			},
			callback : {
				onDblClick : function(event, treeId, node) {
					if(treeId == "queryTree") {
						$("#queryForm [name=pName]").val(node.text);
						$("#queryForm [name=pid]").val(node.id);
						$("#queryTree").hide();
					} else if(treeId == "editTree") {
						$("#editResourceForm [name=parentSourceName]").val(node.text);
						$("#editResourceForm [name=parentSource]").val(node.id);
						$("#editTree").hide();
					}
				}
			}
		};
		
		$("#queryTree").hide();
		$("#queryBtn").click(function() {
			$("#queryTree").toggle();
		});
		$("#editTree").hide();
		$("#editBtn").click(function() {
			$("#editTree").toggle();
		});
		
		var editTree = $.fn.zTree.init($("#editTree"), setting, []);
		var queryTree = $.fn.zTree.init($("#queryTree"), setting, []);
		
		initValidationEngine("editResourceForm");
	});
	
	function deleteResource(ids) {
		$.dialog.confirm("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/System/resource/deleteResource.jmt",
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
	
	function deleteResources() {
		
		var ids = $.utils.getChecked($("#resourceTable"));
		
		if(ids == "") {
			$.dialog.alertInfo("请选择需要删除的项！");
		} else {
			deleteResource(ids);
		}
	}
	
	function openAddWnd() {
		
		$("#resourceMsgTips").html("");
		$("#editResourceForm").resetForm();
		$("#editResourceForm").formDialog("show");
		$("#editResourceForm [name=sourceCode]").attr("readonly", false);
		$("#editResourceForm [name='opType']").val("save");
	}
	
	function openEditWnd(resourceCode) {
		
		$("#resourceMsgTips").html("");
		$("#editResourceForm").resetForm();
		
		$.server.ajaxRequest({
			url : "<%=path%>/System/resource/queryResource.jmt",
			data : {sourceCode : resourceCode},
			progress : false,
			onSuccess : function(msg, data) {
				$("#editResourceForm").setFormValues(data);
				
				$("#editResourceForm [name=sourceCode]").attr("readonly", true);
				$("#editResourceForm [name='opType']").val("modify");
				$("#editResourceForm").formDialog("show");
			}
		});
	}
	
	</script>
	
	
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">资源管理</li>
		</ul>
	</div>
	
	<div class="row">
    	<div class="span12">
  			<form class="form-search" method="post" action="<%=path %>/System/resource/queryResourcePage.jhtml" id="queryForm">
				<label>资源编码：</label>
			  	<input type="text" name="sourceCode" class="input-medium">
			  	<label style="width: 10px;"></label>
			  	<label>资源名称：</label>
			  	<input type="text" name="sourceName" class="input-medium">
			  	<label style="width: 10px;"></label>
			  	<label>父资源：</label>
			  	<div class="input-append btn-group">
			  		<input type="text" name="pName" class="input-medium" readonly>
			  		<input type="hidden" name="pid" id="pid">
			  		<a class="btn dropdown-toggle" id="queryBtn">
			  			选择<span class="caret"></span>
			  		</a>
			  		<ul id="queryTree" class="dropdown-menu ztree" style="height: 280px;overflow: auto;width: 220px;">
			  		</ul>
			  	</div>
			  	<label style="width: 10px;"></label>
			  	<button type="submit" class="btn">搜索</button>
			</form>
		
			<div class="well formOutSide">
				<sec:authorize url="/System/resource/saveOrModify*.jmt">
				<button class="btn btn-primary" onclick="openAddWnd();"><i class="icon-plus"></i>新增</button>
				</sec:authorize>
				<sec:authorize url="/System/resource/delete*.jmt">
				<button class="btn btn-danger" onclick="deleteResources();">删除选中项</button>
				</sec:authorize>
			</div>
		
			<table class="table table-striped table-bordered table-condensed" id="resourceTable">
				<thead id="listHeader">
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll(this);">
						</label></th>
						<th width="10%" class="sort[sourceCode]">资源编码</th>
						<th width="12%" class="sort[sourceName]">资源名称</th>
						<th width="8%">叶子节点</th>
						<th width="5%">图标</th>
						<th width="8%">是否显示</th>
						<th width="34%">访问URL</th>
						<th width="8%">父资源</th>
						<th width="10%" style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="resource" items="${page.reslutSet }">
						<tr>
							<td><label class="checkbox"><input type="checkbox" id="${resource.sourceCode }" class="checkOne"></label></td>
							<td>${resource.sourceCode }</td>
							<td>${resource.sourceName }</td>
							<td class="renderer-yn">${resource.isleaf }</td>
							<td>${resource.iconsCls }</td>
							<td class="renderer-yn">${resource.isShow }</td>
							<td>${resource.sourceUrl }</td>
							<td>${resource.parentSourceName }</td>
							<td style="text-align: center;">
								<div class="btn-group">
									<sec:authorize url="/System/resource/saveOrModify*.jmt">
									<button class="btn btn-info btn-mini" onclick="openEditWnd('${resource.sourceCode }')">
										<i class="nopadding icon-edit"></i>
							  		</button>
									</sec:authorize>
									<sec:authorize url="/System/resource/delete*.jmt">
									<button class="btn btn-danger btn-mini" onclick="deleteResource('${resource.sourceCode }')">
										<i class="nopadding icon-trash"></i>
									</button>
									</sec:authorize>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div id="pagingBar"></div>
		</div>
	</div>
	
	<form class="form-horizontal" method="post" action="<%=path%>/System/resource/saveOrModifyResource.jmt" id="editResourceForm">
		<fieldset>
			<div id="resourceMsgTips"></div>
			<input type="hidden" name="opType">
			<input type="hidden" name="parentSource">
			<div class="control-group">
				<label class="control-label" for="sourceCode">资源编码：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="sourceCode" 
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="sourceName">资源名称：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="sourceName" 
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="parentSourceName">父资源：</label>
				<div class="controls-column input-large">
					<div class="input-append btn-group">
				  		<input type="text" name="parentSourceName" class="input-large" 
				  			data-validation-engine="validate[required]" readonly>
				  		<a class="btn dropdown-toggle" id="editBtn">
				  			选择<span class="caret"></span>
				  		</a>
				  		<ul id="editTree" class="dropdown-menu ztree" 
				  			style="height: 250px;overflow: auto;width: 275px;">
				  		</ul>
				  	</div>
				  	<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="sourceUrl">访问URL：</label>
				<div class="controls-column input-large">
					<input type="text" name="sourceUrl" class="input-large" 
				  			data-validation-engine="validate[required]">
				  	<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">	
				<label class="control-label" for="isleaf">是否叶子节点：</label>
				<div class="controls-column input-medium">
					<select name="isleaf" class="input-medium renderer-yn" 
						data-validation-engine="validate[required]"></select>
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="iconsCls">图标：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="iconsCls">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="isShow">是否显示：</label>
				<div class="controls-column input-medium">
					<select name="isShow" class="input-medium renderer-yn" 
						data-validation-engine="validate[required]"></select>
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="sortNum">排序号：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="sortNum"
						data-validation-engine="validate[custom[number]]">
				</div>
			</div>
		</fieldset>
	</form>
	
	<c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>
	
  </body>
</html>
