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
    
    <title>栏目管理</title>
    <link href="<%=path %>/plugins/zTree/zTreeBookStyle.css" rel="stylesheet">
    <script type="text/javascript" src="<%=path %>/plugins/zTree/jquery.ztree.all-3.5.js"></script>
    
    <script type="text/javascript">
    $(function(){
		$(".renderer-yn").renderer({
			renderArray : <thorn:dd  typeId="YESORNO" />
		});
		
		$(".renderer-pNode").renderer({
			renderer : "custom",
			rendererFunc : function(obj) {
				var id = obj.attr("id");
				var pid = id.replaceAll("pNode", "");
				
				if(pid == "-1" || pid == -1) {
					obj.html("栏目根节点");
				}
			}
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
		
		
		$("#editChannelForm").formDialog({
			title : "编辑栏目信息",
			width : 700,
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#editChannelForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#clMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
							setTimeout(function(){
								$.utils.reloadPage();
							}, 2000);
						},
						onFailure : function(msg) {
							$("#clMsgTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#clMsgTips").message({
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
		
		$("#queryTree").hide();
		$("#editTree").hide();
		
		var setting = {
			async: {
				enable: true,
				url:"<%=path%>/CMS/cl/queryChannelTree.jmt",
				autoParam:["id=pid"]
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
						$("#editChannelForm [name=pName]").val(node.text);
						$("#editChannelForm [name=pid]").val(node.id);
						$("#editTree").hide();
					}
				}
			}
		};
		
		var root = {
			id : "-1",
			pid : "",
			text : "栏目根节点",
			isParent : "true"
		};
		
		var editTree = $.fn.zTree.init($("#editTree"), setting, [root]);
		var queryTree = $.fn.zTree.init($("#queryTree"), setting, [root]);
		
		$("#queryBtn").click(function() {
			$("#queryTree").toggle();
		});
		$("#editBtn").click(function() {
			$("#editTree").toggle();
		});
		
		initValidationEngine("editChannelForm");
    });
    
	function openAddWnd() {
		
		$("#clMsgTips").html("");
		$("#editChannelForm").resetForm();
		$("#editChannelForm").formDialog("show");
		$("#editChannelForm [name='opType']").val("save");
	}
	
	function openEditWnd(id) {
		
		$("#clMsgTips").html("");
		$("#editChannelForm").resetForm();
		
		$.server.ajaxRequest({
			url : "<%=path%>/CMS/cl/queryChannel.jmt",
			data : {id : id},
			progress : false,
			onSuccess : function(msg, data) {
				
				if(data.pid == "-1" || data.pid == -1) {
					data.pName = "栏目根节点";
				}
				
				$("#editChannelForm").setFormValues(data);
				
				$("#editChannelForm [name='opType']").val("modify");
				$("#editChannelForm").formDialog("show");
			}
		});
	}
    
	function deleteChannel(ids) {
		$.dialog.confirm("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/CMS/cl/deleteChannel.jmt",
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
	
	function deleteChannels() {
		
		var ids = $.utils.getChecked($("#clTable"));
		
		if(ids == "") {
			$.dialog.alertInfo("请选择需要删除的项！");
		} else {
			deleteChannel(ids);
		}
	}
    </script>
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/CMS/index.jhtml">内容发布</a><span class="divider">/</span></li>
			<li class="active">栏目管理</li>
		</ul>
	</div>
	
	<div class="row">
    	<div class="span12">
  			<form class="form-search" method="post" action="<%=path %>/CMS/cl/queryChannelPage.jhtml" id="queryForm">
				<label>栏目名称：</label>
			  	<input name="name" class="input-medium" type="text">
			  	<label style="width: 10px;"></label>
			  	<label>父栏目：</label>
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
				<sec:authorize url="/CMS/cl/saveOrModify*.jmt">
				<button class="btn btn-primary" onclick="openAddWnd();"><i class="icon-plus"></i>新增</button>
				</sec:authorize>
				<sec:authorize url="/CMS/cl/delete*.jmt">
				<button class="btn btn-danger" onclick="deleteChannels();">删除选中项</button>
				</sec:authorize>
			</div>
			
			<table class="table table-striped table-bordered table-condensed" id="clTable">
				<thead id="listHeader">
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll(this);">
						</label></th>
						<th width="10%">栏目名称</th>
						<th width="10%">父栏目</th>
						<th width="10%">访问路径</th>
						<th width="25%">栏目模板</th>
						<th width="20%">内容模板</th>
						<th width="10%">是否显示</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="cl" items="${page.reslutSet }">
					<tr>
						<td><label class="checkbox"><input type="checkbox" id="${cl.id }" class="checkOne"></label></td>
						<td>${cl.name }</td>
						<td id="pNode${cl.pid }" class="renderer-pNode">${cl.pName }</td>
						<td>${cl.path }</td>
						<td>${cl.channelTemplate }</td>
						<td>${cl.contentTemplate }</td>
						<td class="renderer-yn">${cl.isShow }</td>
						<td style="text-align: center;">
							<div class="btn-group">
								<sec:authorize url="/CMS/cl/saveOrModify*.jmt">
								<button class="btn btn-info btn-mini" onclick="openEditWnd('${cl.id}')">
									<i class="nopadding icon-edit"></i>
								</button>
								</sec:authorize>
								<sec:authorize url="/CMS/cl/delete*.jmt">
								<button class="btn btn-danger btn-mini" onclick="deleteChannel('${cl.id}')">
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
	
	<form class="form-horizontal" method="post" action="<%=path%>/CMS/cl/saveOrModifyChannel.jmt" id="editChannelForm">
		<fieldset>
			<div id="clMsgTips"></div>
			<input type="hidden" name="opType">
			<input type="hidden" name="id">
			<input type="hidden" name="pid">
			<div class="control-group">
				<label class="control-label" for="name">栏目名称：</label>
				<div class="span4 controls-column">
					<input type="text" class="input-large" name="name"
						data-validation-engine="validate[required,custom[onlyLetterNumber]]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">	
				<label class="control-label" for="pName">父栏目：</label>
				<div class="controls-column span5">
					<div class="input-append btn-group">
				  		<input type="text" name="pName" class="input-large" 
				  			data-validation-engine="validate[required]" readonly>
				  		<a class="btn dropdown-toggle" id="editBtn">
				  			选择<span class="caret"></span>
				  		</a>
				  		<ul id="editTree" class="dropdown-menu ztree" 
				  			style="height: 250px;overflow: auto;width: 275px;">
				  		</ul>
				  	</div>
				  	<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="path">访问路径：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="path"
						data-validation-engine="validate[required]">
					<p class="help-block"><i class="redStar">*</i>必填，不能重复</p>
				</div>
				<label class="control-label" for="sortNum">排序号：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="sortNum"
						data-validation-engine="validate[custom[number]]">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="channelTemplate">栏目模板：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="channelTemplate"
						data-validation-engine="validate[required]">
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="contentTemplate">内容模板：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="contentTemplate"
						data-validation-engine="validate[required]">
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="title">栏目标题：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="title">
				</div>
				<label class="control-label" for="tags">关键字：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="tags">
					<p class="help-block">多个关键字以，分隔</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="description">栏目描述：</label>
				<div class="controls-column span4">
					<textarea rows="3" class="span4" name="description"></textarea>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="isDisabled">是否禁用：</label>
				<div class="controls-column input-medium">
					<select name="isDisabled" class="input-medium renderer-yn"
						 data-validation-engine="validate[required]"></select>
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="isShow">是否显示：</label>
				<div class="controls-column input-medium">
					<select name="isShow" class="input-medium renderer-yn" 
						data-validation-engine="validate[required]"></select>
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
			</div>
		</fieldset>
	</form>
	
	
    <c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>	
  </body>
</html>
