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
		
		$("#dtForm").modal({
			backdrop : true,
			keyboard : false,
			show : true
		});
	});
	
	function deleteDt(ename) {
		$.message.confirmDialog("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/System/dd/deleteDt.jmt",
				data : {
					ids : ename
				},
				onSuccess : function(msg, data) {
					$.message.alertSuccessDialog(msg, "请求处理成功");
					setTimeout(refreshPage(), 2000);
				}
			});
		});
	}
	
	function deleteDts() {
		
		var ids = getChecked();
		
		if(ids == "") {
			$.message.alertInfoDialog("请选择需要删除的项！");
		} else {
			deleteDt(ids);
		}
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
	<a href="#" id="oop" title="1954年8月16日生于加拿大的著名电影导演，擅长拍摄动作片以及科幻电影。">卡梅隆</a>
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
				<button class="btn btn-primary btn-large"><i class="icon-plus"></i>新增</button>
				<button class="btn btn-danger btn-large" onclick="deleteDts();">删除选中项</button>
			</div>
			
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" class="checkAll" onclick="checkAll();">
						</label></th>
						<th width="25%">字典类型编码</th>
						<th width="20%">字典类型名称</th>
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
						<td>${dt.typeDesc }</td>
						<td style="text-align: center;">
							<div class="btn-group">
							  <button class="btn btn-info">修改</button>
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
	
	<div class="modal" id="dtForm">
  		<div class="modal-header">
    		<a class="close" data-dismiss="modal">×</a>
    		<h3>编辑字典类型</h3>
  		</div>
		<div class="modal-body">
			<form class="form-horizontal" method="post" action="<%=path%>/">
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="ename">字典类型编码：</label>
						<div class="controls">
							<input type="text" class="input-medium" name="ename"
								data-validation-engine="validate[required]">
							<p class="help-inline"><i class="redStar">*</i>必填</p>
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
		</div>
		<div class="modal-footer">
		    <a href="#" class="btn btn-primary">保存</a>
		    <a data-dismiss="modal" class="btn">关闭</a>
		</div>
	</div>
		
	<c:import url="../ref/conditionWriteBack.jsp"></c:import>
  </body>
</html>
