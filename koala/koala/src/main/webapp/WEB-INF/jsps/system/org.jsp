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
    
    <title>组织机构管理</title>
    
    <link href="<%=path %>/plugins/zTree/zTreeBookStyle.css" rel="stylesheet">
    <style type="text/css">
	#treeMenu {
		position: absolute;visibility: hidden;top: 0;
	}
	</style>
    
    <script type="text/javascript" src="<%=path %>/plugins/zTree/jquery.ztree.all-3.5.js"></script>
    
	<script type="text/javascript">
	$(function(){
		
		$(".renderer-type").renderer({
			renderArray : <thorn:dd  typeId="ORGTYPE" />
		});
		
		$(".renderer-yn").renderer({
			renderArray : <thorn:dd  typeId="YESORNO" />
		});
		
		$(".renderer-area").renderer({
			renderArray : <thorn:dd  typeId="AREA" />
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
		
		var setting = {
			<sec:authorize url="/System/org/saveOrModify*.jmt">
			edit: {
				enable: true,
				showRemoveBtn: false,
				showRenameBtn: false
			},
			</sec:authorize>
			async: {
				enable: true,
				url:"<%=path%>/System/org/queryOrgTree.jmt",
				autoParam:["id=pid"]
			},
			data : {
				key : {
					name : "text"
				}
			},
			callback : {
				onDblClick : function(event, treeId, node) {
					$("#pid").val(node.id);
					$("#queryForm").submit();
				}
				<sec:authorize url="/System/org/saveOrModify*.jmt">
				,
				onRightClick : function(event, treeId, node) {
					if(node.getParentNode() == null) {
						return ;
					}
					
					orgTree.selectNode(node);
					$("#treeMenu ul").show();
					$("#treeMenu").css({
						"top" : event.clientY + "px",
						"left" : event.clientX + "px",
						"visibility" : "visible"
					});
					$("body").bind("mousedown", onBodyMouseDown);
				},
				beforeDrag : function(treeId, treeNodes) {
					for (var i=0,l=treeNodes.length; i<l; i++) {
						if (treeNodes[i].id === "ROOT") {
							return false;
						}
					}
					return true;
				},
				beforeDrop : function(treeId, treeNodes, targetNode, moveType) {
					if(targetNode.id == "ROOT" && moveType != "inner") {
						$.dialog.alertInfo("根节点不允许更改位置！");
						return false;
					}
					
					var nodeNames = new Array();
					var ids = new Array();
					for (var i=0,l=treeNodes.length; i<l; i++) {
						nodeNames.push(treeNodes[i].text);
						ids.push(treeNodes[i].id);
					}
					
					var opType = "下面";
					switch (moveType) {
					case "prev":
						opType = "前面";
						break;
					case "next":
						opType = "后面";
						break;
					default:
						break;
					}
					
					var msg = "您确认将<span class='red'>" + nodeNames 
						+ "</span>移动到<span class='red'>" + targetNode.text 
						+ "</span>的<span class='blue'>" + opType + "</span>？";
					
					$.dialog.confirm(msg, function(){
						$.server.ajaxRequest({
							url : "<%=path%>/System/org/saveOrModifyOrgDrag.jmt",
							data : {
								ids : ids.toString(),
								moveType : moveType,
								target : targetNode.id
							}
						});
					});
					
					return true;
				}
				</sec:authorize>
			}
		};
		
		var orgTree = $.fn.zTree.init($("#orgTree"), setting, [{
			id : "ROOT",
			pid : "-1",
			text : "文化部",
			isParent : "true"
		}]);
		
		function hideTreeMenu() {
			$("#treeMenu").css({"visibility": "hidden"});
			$("body").unbind("mousedown", onBodyMouseDown);
		}
		
		function onBodyMouseDown(event) {
			if (!(event.target.id == "treeMenu" 
				|| $(event.target).parents("#treeMenu").length > 0)) {
				$("#treeMenu").css({"visibility" : "hidden"});
			}
		}
		
		$("#treeMenu .add").click(function(){
			var node = orgTree.getSelectedNodes()[0];
			hideTreeMenu();
			
			$("#orgMsgTips").html("");
			$("#editOrgForm").resetForm();
			$("#editOrgForm").formDialog("show");
			
			$("#editOrgForm [name=orgName]").attr("readonly", false);
			
			$("#editOrgForm [name='opType']").val("save");
			$("#editOrgForm [name='parentOrg']").val(node.id);
			$("#editOrgForm [name='parentOrgName']").val(node.text);
		});
		
		$("#treeMenu .edit").click(function(){
			hideTreeMenu();
			var node = orgTree.getSelectedNodes()[0];
			
			editOrg(node.id);
		});
			
		$("#editOrgForm").formDialog({
			title : "编辑组织机构",
			width : 700,
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#editOrgForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#orgMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
							setTimeout(function(){
								$.utils.reloadPage();
							}, 2000);
						},
						onFailure : function(msg) {
							$("#orgMsgTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#orgMsgTips").message({
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
		
		initValidationEngine("editOrgForm");
	});
	
	function deleteOrg(ids) {
		$.dialog.confirm("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/System/org/deleteOrg.jmt",
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
	
	function deleteOrgs() {
		
		var ids = $.utils.getChecked($("#orgTable"));
		
		if(ids == "") {
			$.dialog.alertInfo("请选择需要删除的项！");
		} else {
			deleteDt(ids);
		}
	}
	
	function editOrg(orgId) {
		$("#orgMsgTips").html("");
		$("#editOrgForm").resetForm();
		
		$("#editOrgForm [name=orgName]").attr("readonly", true);
		$.server.ajaxRequest({
			url : "<%=path%>/System/org/queryOrg.jmt",
			data : {orgId : orgId},
			progress : false,
			onSuccess : function(msg, data) {
				$("#editOrgForm").setFormValues(data);
				
				$("#editOrgForm [name='opType']").val("modify");
				$("#editOrgForm").formDialog("show");
			}
		});
	}
	
	</script>
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">组织机构管理</li>
		</ul>
	</div>
  
  	<div class="row">
  		<div class="span3">
  			<div style="border: 1px solid #DDDDDD;margin-bottom: 20px;">
  				<div class="rectangle-header">组织机构树</div>
  				<ul id="orgTree" class="ztree" style="height: 400px;overflow: auto;"></ul>
  			</div>
  		</div>
  		
  		<div class="span9">
  			<form class="form-search" method="post" action="<%=path %>/System/org/queryOrgPage.jhtml" id="queryForm">
				<label>组织编码：</label>
			  	<input type="text" name="orgCode" class="input-mini">
			  	<label style="width: 10px;"></label>
			  	<label>组织名称：</label>
			  	<input type="text" name="orgName" class="input-mini">
			  	<label style="width: 10px;"></label>
			  	<label>组织类型：</label>
			  	<select name="orgType" id="queryOrgType" class="input-medium renderer-type"></select>
			  	<input type="hidden" name="pid" id="pid">
			  	<button type="submit" class="btn">搜索</button>
			</form>
			
			<div class="well formOutSide">
				<sec:authorize url="/System/org/delete*.jmt">
				<button class="btn btn-danger" onclick="deleteOrgs();">删除选中项</button>
				</sec:authorize>
			</div>
			
			
			<table class="table table-striped table-bordered table-condensed" id="orgTable">
				<thead id="listHeader">
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll(this);">
						</label></th>
						<th width="13%" class="sort[orgCode]">组织编码</th>
						<th width="25%" class="sort[orgName]">组织名称</th>
						<th width="10%">组织类型</th>
						<th width="15%">所属区域</th>
						<th width="10%">是否显示</th>
						<th width="10%">是否禁用</th>
						<th width="10%" style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="org" items="${page.reslutSet }">
					<tr>
						<td><label class="checkbox"><input type="checkbox" id="${org.orgId }" class="checkOne"></label></td>
						<td>${org.orgCode }</td>
						<td>${org.orgName }</td>
						<td class="renderer-type">${org.orgType }</td>
						<td class="renderer-area">${org.area }</td>
						<td class="renderer-yn">${org.isShow }</td>
						<td class="renderer-yn">${org.isDisabled }</td>
						<td style="text-align: center;">
							<div class="btn-group">
								<sec:authorize url="/System/org/saveOrModify*.jmt">
								<button class="btn btn-info btn-mini" onclick="editOrg('${org.orgId }')">
									<i class="nopadding icon-edit"></i>
								</button>
								</sec:authorize>
								<sec:authorize url="/System/org/delete*.jmt">
								<button class="btn btn-danger btn-mini" onclick="deleteOrg('${org.orgId }')">
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
  	
  	<form class="form-horizontal" method="post" action="<%=path%>/System/org/saveOrModifyOrg.jmt" id="editOrgForm">
		<fieldset>
			<div id="orgMsgTips"></div>
			<input type="hidden" name="opType">
			<input type="hidden" name="parentOrg">
			<input type="hidden" name="orgId">
			<div class="control-group">
				<label class="control-label" for="orgCode">组织机构编码：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="orgCode"
						data-validation-engine="validate[required,custom[onlyLetterNumber]]">
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="parentOrgName">上级组织机构：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="parentOrgName" readonly>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="orgName">组织机构名称：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="orgName"
						data-validation-engine="validate[required]">
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="showName">机构显示名称：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="showName"
						data-validation-engine="validate[required]">
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="orgType">组织机构类型：</label>
				<div class="controls-column input-medium">
					<select name="orgType" class="input-medium renderer-type" 
						data-validation-engine="validate[required]"></select>
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="orgMail">组织邮箱：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="orgMail" 
						data-validation-engine="validate[maxSize[50],custom[email]]">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="isShow">是否显示：</label>
				<div class="controls-column input-medium">
					<select name="isShow" class="input-medium renderer-yn" 
						data-validation-engine="validate[required]"></select>
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="area">所属区域：</label>
				<div class="controls-column input-medium">
					<select name="area" class="input-medium renderer-area"></select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="isDisabled">是否禁用：</label>
				<div class="controls-column input-medium">
					<select name="isDisabled" class="input-medium renderer-yn"
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
  	
  	<div id="treeMenu" style="position: absolute;visibility: hidden;top: 0;">
  		<ul class="dropdown-menu">
  			<li><a href="javascript:void(0);" class="add"><i class="icon-plus-sign"></i>新增组织机构</a></li>
  			<li><a href="javascript:void(0);" class="edit"><i class="icon-edit"></i>修改组织机构</a></li>
  		</ul>
  	</div>
  </body>
</html>
