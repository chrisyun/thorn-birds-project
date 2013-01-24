<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>数据字典管理</title>
	<script type="text/javascript">
	$(function(){
		
		$("#pagingBar").page({
			align : "right",
			pageSize : parseInt('${page.pageSize}'),
			totalSize : parseInt('${page.total}'),
			pageIndex : parseInt('${page.pageIndex}')
		});
		
		$(".renderer-desc").renderer({
			renderer : "detail"
		});
		
		$("#listHeader").sorter({
			sort : "${param.sort}",
			dir : "${param.dir}"
		});
		
		$("#editDtForm").formDialog({
			title : "编辑字典类型",
			width : 480,
			height : 220,
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#editDtForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#dtMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
							setTimeout(function(){
								$.utils.reloadPage();
							}, 2000);
						},
						onFailure : function(msg) {
							$("#dtMsgTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#dtMsgTips").message({
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
		
		// do last
		initValidationEngine("editDtForm");
	});
	
	function deleteDt(ename) {
		$.dialog.confirm("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/System/dd/deleteDt.jmt",
				data : {
					ids : ename
				},
				onSuccess : function(msg, data) {
					$.dialog.alertSuccess(msg, "请求处理成功", function(){
						$.utils.refreshPage();
					});
				}
			});
		});
	}
	
	function deleteDts() {
		
		var ids = $.utils.getChecked();
		
		if(ids == "") {
			$.dialog.alertInfo("请选择需要删除的项！");
		} else {
			deleteDt(ids);
		}
	}
	
	function openModifyDtWnd(ename, cname, typeDesc) {
		$("#dtMsgTips").html("");
		$("#editDtForm").resetForm();
		
		$("#editDtForm").setFormValues({
			ename : ename,
			cname : cname,
			typeDesc : typeDesc,
			opType : "modify"
		});
		$("#editDtForm").formDialog("show");
	}
	
	function openAddDtWnd() {
		$("#dtMsgTips").html("");
		$("#editDtForm").resetForm();
		$("#editDtForm").formDialog("show");
		
		$("#editDtForm [name='opType']").val("save");
	}
	
	</script>
	
	
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">数据字典管理</li>
		</ul>
	</div>

	<div class="row">
		<div class="span12">
			<form class="form-search" method="post" action="<%=path %>/System/dd/dtPage.jhtml" id="queryForm">
				<label>字典类型编码：</label>
			  	<input type="text" name="ename" class="input-medium">
			  	<label style="width: 40px;"></label>
			  	<label>字典类型名称：</label>
			  	<input type="text" name="cname" class="input-medium">
			  	<button type="submit" class="btn">搜索</button>
			</form>
			
			<div class="formOutSide">
				<button class="btn btn-primary" onclick="openAddDtWnd();"><i class="icon-plus"></i>新增</button>
				<button class="btn btn-danger" onclick="deleteDts();">删除选中项</button>
			</div>
			
			<table class="table table-striped table-bordered table-condensed">
				<thead id="listHeader">
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll();">
						</label></th>
						<th width="25%" class="sort[ename]">字典类型编码</th>
						<th width="20%" class="sort[cname]">字典类型名称</th>
						<th width="35%">描述</th>
						<th width="15%" style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="dt" items="${page.reslutSet }">
					<tr>
						<td><label class="checkbox"><input type="checkbox" id="${dt.ename }" class="checkOne"></label></td>
						<td>${dt.ename }</td>
						<td>${dt.cname }</td>
						<td class="renderer-desc">${dt.typeDesc }</td>
						<td style="text-align: center;">
							<div class="btn-group">
							  <button class="btn btn-info" 
							  		onclick="openModifyDtWnd('${dt.ename }','${dt.cname }','${dt.typeDesc }');">修改</button>
							  <button class="btn btn-danger" onclick="deleteDt('${dt.ename }')">删除</button>
							</div>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
			<div id="pagingBar"></div>
		</div>
	</div>
	
	
	<form class="form-horizontal" method="post" action="<%=path%>/System/dd/saveOrModifyDt.jmt" id="editDtForm">
		<fieldset>
			<div id="dtMsgTips"></div>
			<div class="control-group">
				<label class="control-label" for="ename">字典类型编码：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="ename"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
					<input type="hidden" name="opType">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="cname">字典类型名称：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="cname"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="typeDesc">描述：</label>
				<div class="controls">
					<textarea class="input-medium" rows="3" name="typeDesc"></textarea>
				</div>
			</div>
		</fieldset>
	</form>
		
	<c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>
  </body>
</html>
