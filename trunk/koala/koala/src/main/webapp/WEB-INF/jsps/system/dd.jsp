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
    
    <title>数据字典管理</title>
	<script type="text/javascript">
	var _typeId;
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
			title : "编辑字典",
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
		
		$("#editDdForm").formDialog({
			title : "编辑数据项",
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#editDdForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#ddMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
							queryDd(_typeId);
						},
						onFailure : function(msg) {
							$("#ddMsgTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#ddMsgTips").message({
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
		initValidationEngine("editDdForm");
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
		
		var ids = $.utils.getChecked($("#dtTable"));
		
		if(ids == "") {
			$.dialog.alertInfo("请选择需要删除的项！");
		} else {
			deleteDt(ids);
		}
	}
	
	function openModifyDtWnd(ename, cname, typeDesc) {
		$("#dtMsgTips").html("");
		
		$("#editDtForm").setFormValues({
			ename : ename,
			cname : cname,
			typeDesc : typeDesc,
			opType : "modify"
		});
		$("#editDtForm [name=ename]").attr("readonly", true);
		$("#editDtForm").formDialog("show");
	}
	
	function openAddDtWnd() {
		$("#dtMsgTips").html("");
		$("#editDtForm").resetForm();
		$("#editDtForm").formDialog("show");
		
		$("#editDtForm [name=ename]").attr("readonly", false);
		$("#editDtForm [name='opType']").val("save");
	}
	
	function chooseDt(_href) {
		_href = $(_href);
		
		$("#dtTable a[class=dataType]").next("i").remove();
		_href.after("<i class='icon-zoom-in'></i>");
	}
	
	/*----------------------------------------------------------*/
	function deleteDds() {
		
		var ids = $.utils.getChecked($("#ddTable"));
		
		if($.utils.isEmpty(_typeId)) {
			$.dialog.alertInfo("请选择数据字典类型！");
		} else if(ids == "") {
			$.dialog.alertInfo("请选择需要删除的项！");
		} else {
			$.dialog.confirm("您确认删除吗？", function(){
				$.server.ajaxRequest({
					url : "<%=path%>/System/dd/deleteDd.jmt",
					data : {
						ids : ids,
						typeId : _typeId
					},
					onSuccess : function(msg, data) {
						$.dialog.alertSuccess(msg, "请求处理成功");
						queryDd(_typeId);
					}
				});
			});
		}
	}
	
	function openModifyDdWnd() {
		var cked = $("#ddTable").find(":checkbox:checked[class=checkOne]");
		
		if($.utils.isEmpty(_typeId)) {
			$.dialog.alertInfo("请选择左方的字典编码！");
		} else if(cked.length == 0) {
			$.dialog.alertInfo("请选择需要修改的数据项！");
		} else if(cked.length > 1) {
			$.dialog.alertInfo("请选择一条数据项！");
		} else {
			
			var val = cked.val();
			
			var data = eval("(" + val + ")");
			data.opType = "modify";
			
			$("#ddMsgTips").html("");
			
			$("#editDdForm").setFormValues(data);
			$("#editDdForm [name=dname]").attr("readonly", true);
			$("#editDdForm").formDialog("show");
		}
	}
	
	function openAddDdWnd() {
		
		if($.utils.isEmpty(_typeId)) {
			$.dialog.alertInfo("请选择左方的字典编码！");
			return ;
		}
		
		$("#ddMsgTips").html("");
		$("#editDdForm").resetForm();
		$("#editDdForm").formDialog("show");
		
		$("#editDdForm [name=dname]").attr("readonly", false);
		$("#editDdForm [name='opType']").val("save");
		$("#editDdForm [name='typeId']").val(_typeId);
	}
	
	function queryDd(ename) {
		_typeId = ename;
		$.server.ajaxRequest({
			url : "<%=path%>/System/dd/queryDdList.jmt",
			progress : false,
			data : {
				typeId : ename
			},
			onSuccess : function(msg, data) {
				$("#ddTable tbody").empty();
				
				if(data.length == 0) {
					addBlankRow();
					return ;
				}
				
				for(var i = 0; i < data.length; i++) {
					addRow(data[i]);
				}
			}
		});
		
		function addRow(dd) {
			
			var json = $.utils.object2Json(dd);
			
			json = $.utils.escapeHtml(json);
			
			var _row = $("<tr></tr>");
			_row.append('<td><label class="checkbox"><input type="checkbox" id="'
					+ dd.dname + '" value="' + json + '" class="checkOne"></label></td>');
			_row.append("<td>" + dd.dname + "</td>");
			_row.append("<td>" + dd.dvalue + "</td>");
			
			$("#ddTable tbody").append(_row);
		}
		
		function addBlankRow() {
			var _row = $("<tr><td colspan='3'>暂无数据项</td></tr>");
			$("#ddTable tbody").append(_row);
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

	<div class="row">
		<div class="span8">
			<form class="form-search" method="post" action="<%=path %>/System/dd/queryDtPage.jhtml" id="queryForm">
				<label>字典编码：</label>
			  	<input type="text" name="ename" class="input-medium">
			  	<label style="width: 10px;"></label>
			  	<label>字典名称：</label>
			  	<input type="text" name="cname" class="input-medium">
			  	<button type="submit" class="btn">搜索</button>
			</form>
			
			<div class="well formOutSide">
				<sec:authorize url="/System/dd/saveOrModify*.jmt">
				<button class="btn btn-primary" onclick="openAddDtWnd();"><i class="icon-plus"></i>新增</button>
				</sec:authorize>
				<sec:authorize url="/System/dd/delete*.jmt">
				<button class="btn btn-danger" onclick="deleteDts();">删除选中项</button>
				</sec:authorize>
			</div>
			
			<table class="table table-striped table-bordered table-condensed" id="dtTable">
				<thead id="listHeader">
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll(this);">
						</label></th>
						<th width="25%" class="sort[ename]">字典编码</th>
						<th width="20%" class="sort[cname]">字典名称</th>
						<th width="35%">描述</th>
						<th width="15%" style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="dt" items="${page.reslutSet }">
					<tr>
						<td><label class="checkbox"><input type="checkbox" id="${dt.ename }" class="checkOne"></label></td>
						<td><a href="javascript:void(0);" class="dataType" onmouseover="chooseDt(this);" style="padding-right: 10px;"
							title="点击查看该字典的数据" onclick="chooseDt(this);queryDd('${dt.ename }')">${dt.ename }</a>
						</td>
						<td>${dt.cname }</td>
						<td class="renderer-desc">${dt.typeDesc }</td>
						<td style="text-align: center;">
							<div class="btn-group">
							  <sec:authorize url="/System/dd/saveOrModify*.jmt">
							  <button class="btn btn-info" 
							  		onclick="openModifyDtWnd('${dt.ename }','${dt.cname }','${dt.typeDesc }');">修改</button>
							  </sec:authorize>
							  <sec:authorize url="/System/dd/delete*.jmt">
							  <button class="btn btn-danger" onclick="deleteDt('${dt.ename }')">删除</button>
							  </sec:authorize>
							</div>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
			<div id="pagingBar"></div>
		</div>
	
		<div class="span4">
			<div style="height: 95px;"></div>
			
			<table class="table table-striped table-bordered table-condensed" id="ddTable">
				<thead>
					<tr>
						<th width="10%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll(this);">
						</label></th>
						<th width="40%">数据编码</th>
						<th width="50%">数据名称</th>
					</tr>				
				</thead>
				<tbody>
				</tbody>
			</table>
			
			<div>
				<sec:authorize url="/System/dd/saveOrModify*.jmt">
				<button class="btn btn-primary" onclick="openAddDdWnd();"><i class="icon-plus"></i>新增</button>
				<button class="btn btn-info" onclick="openModifyDdWnd();">修改</button>
				</sec:authorize>
				<sec:authorize url="/System/dd/delete*.jmt">
				<button class="btn btn-danger" onclick="deleteDds();">删除选中项</button>
				</sec:authorize>
			</div>
		</div>
	</div>
	
	<form class="form-horizontal" method="post" action="<%=path%>/System/dd/saveOrModifyDt.jmt" id="editDtForm">
		<fieldset>
			<div id="dtMsgTips"></div>
			<div class="control-group">
				<label class="control-label" for="ename">字典编码：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="ename"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
					<input type="hidden" name="opType">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="cname">字典名称：</label>
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
	
	<form class="form-horizontal" method="post" action="<%=path%>/System/dd/saveOrModifyDd.jmt" id="editDdForm">
		<fieldset>
			<div id="ddMsgTips"></div>
			<div class="control-group">
				<label class="control-label" for="dname">数据编码：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="dname"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
					<input type="hidden" name="opType">
					<input type="hidden" name="typeId">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="dvalue">数据名称：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="dvalue"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="sortNum">排序号：</label>
				<div class="controls">
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
