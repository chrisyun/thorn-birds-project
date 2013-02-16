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
    
    <title>操作日志</title>
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
		
		$(".renderer-module").renderer({
			renderArray : <thorn:dd  typeId="MODULE" />
		});
		
		$(".renderer-result").renderer({
			renderArray : <thorn:dd  typeId="HANDLERESULT" />
		});
		
		$("#listHeader").sorter({
			sort : "${param.sort}",
			dir : "${param.dir}"
		});
		
		$("#logForm").formDialog({
			title : "查看日志详情",
			width : 600,
			buttons : [{
				text : "关闭",
				closed : true
			}]
		});
	
		$("#logTable a").tooltip();
	});
	
	function showDetail(id) {
		$("#logForm").formDialog("show");
		$("#logForm").resetForm();
		$.server.ajaxRequest({
			url : "<%=path%>/System/log/queryAppLog.jmt",
			data : {id : id},
			progress : false,
			onSuccess : function(msg, data) {
				$("#logForm").setFormValues(data);
				$("#logForm").formDialog("show");
			}
		});
	}
	
	function exportExcel() {
		var startTime = $("#queryForm [name=startTime]").val();
		var endTime = $("#queryForm [name=endTime]").val();
		var moduleName = $("#queryForm [name=moduleName]").val();
		var handleResult = $("#queryForm [name=handleResult]").val();

		var excelUrl = "<%=path%>/System/log/exportLogExcel.jmt" + "?moduleName=" + moduleName
				+ "&handleResult=" + handleResult + "&startTime=" + startTime + "&endTime=" + endTime;
				
		$("#excelFrame").attr("src", excelUrl);
	}
	
	</script>
	
	
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">操作日志</li>
		</ul>
	</div>
	
	<div class="row">
    	<div class="span12">
  			<form class="form-search" method="post" action="<%=path %>/System/log/queryAppLog.jhtml" id="queryForm">
				<label>操作模块：</label>
			  	<select name="moduleName" class="input-medium renderer-module"></select>
			  	<label style="width: 10px;"></label>
			  	<label>操作结果：</label>
			  	<select name="handleResult" class="input-medium renderer-result"></select>
			  	<label style="width: 10px;"></label>
			  	<label>操作时间：</label>
			  	<input type="text" name="startTime" class="input-mini">
			  	<label style="width: 5px;"></label>—<label style="width: 5px;"></label>
			  	<input type="text" name="endTime" class="input-mini">
			  	<label style="width: 10px;"></label>
			  	<button type="submit" class="btn">搜索</button>
			</form>
			
			<div class="well formOutSide">
				<sec:authorize url="/System/log/exportLogExcel.jmt">
				<button class="btn btn-primary" onclick="exportExcel();">导出Excel</button>
				</sec:authorize>
			</div>
			
			<table class="table table-striped table-bordered table-condensed" id="logTable">
				<thead id="listHeader">
					<tr>
						<th width="30%" class="sort[moduleName]">模块名称</th>
						<th width="10%" class="sort[methodName]">方法名称</th>
						<th width="10%">USERID</th>
						<th width="20%">操作时间</th>
						<th width="10%">操作结果</th>
						<th width="20%">错误信息</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="log" items="${page.reslutSet }">
					<tr>
						<td>
							<a title="点击查看详细" class="renderer-module" href="javascript:void(0);" 
								onclick="showDetail('${log.id}');">${log.moduleName }</a>
						</td>
						<td>${log.methodName }</td>
						<td>${log.userId }</td>
						<td>${log.executeTime }</td>
						<td class="renderer-result">${log.handleResult }</td>
						<td class="renderer-desc">${log.errorMsg }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
			<div id="pagingBar"></div>
		</div>
	</div>
	
	<form class="form-horizontal" id="logForm">
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="moduleName">模块名称：</label>
				<div class="controls">
					<input type="text" readonly class="input-large renderer-module" name="moduleName">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="methodName">方法名称：</label>
				<div class="controls">
					<input type="text" class="input-large" name="methodName" readonly>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="executeTime">操作时间：</label>
				<div class="controls">
					<input type="text" class="input-large" name="executeTime" readonly>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="handleResult">操作结果：</label>
				<div class="controls">
					<select disabled name="handleResult" class="input-medium renderer-result"></select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="userId">操作人：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="userId" readonly>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="parameters">参数详细：</label>
				<div class="controls">
					<textarea rows="5" class="input-large" name="parameters" readonly></textarea>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="errorMsg">错误信息：</label>
				<div class="controls">
					<textarea rows="5" class="input-large" name="errorMsg" readonly></textarea>
				</div>
			</div>
		</fieldset>
	</form>	
	
	<iframe id="excelFrame" style="display: none;" src=""></iframe>
	
    <c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>
	
  </body>
</html>
