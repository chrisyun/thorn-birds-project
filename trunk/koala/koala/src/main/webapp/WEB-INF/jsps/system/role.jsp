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
    
    <title>角色管理</title>
	<link href="<%=path %>/plugins/zTree/zTreeStyle.css" rel="stylesheet">
    <script type="text/javascript" src="<%=path %>/plugins/zTree/jquery.ztree.all-3.5.js"></script>
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
		
		$(".renderer-yn").renderer({
			hasSelectBlank : false,
			value : "NO",
			renderArray : <thorn:dd  typeId="YESORNO" />
		});
		
		$("#listHeader").sorter({
			sort : "${param.sort}",
			dir : "${param.dir}"
		});
		
		
		var sysSetting = {
			async: {
				enable: true,
				url:"<%=path%>/System/resource/queryResourceTree.jmt",
				otherParam : {"pid" : "System"}
			},
			check: {
				enable: true
			},
			data : {
				key : {
					name : "text"
				}
			},
			callback : {
				beforeAsync : function(treeId, treeNode) {
					if(treeNode != null) {
						return false;
					}
					
					return true;
				}
			}
		};
		
		var cmsSetting = {};
		$.extend(true, cmsSetting, sysSetting);
		cmsSetting.async.otherParam = {"pid" : "CMS"};
		
		var appSetting = {};
		$.extend(true, appSetting, sysSetting);
		appSetting.async.otherParam = {"pid" : "App"};
		
		$.fn.zTree.init($("#sysTree"), sysSetting, []);
		$.fn.zTree.init($("#appTree"), appSetting, []);
		$.fn.zTree.init($("#cmsTree"), cmsSetting, []);
		
		$("#editRoleForm").formDialog({
			title : "编辑角色信息",
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#editRoleForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#roleMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
							setTimeout(function(){
								$.utils.reloadPage();
							}, 2000);
						},
						onFailure : function(msg) {
							$("#roleMsgTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#roleMsgTips").message({
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
		
		initValidationEngine("editRoleForm");
    });
    
    function showRoleAuth() {
    	
		var cked = $("#roleTable").find(":checkbox:checked[class=checkOne]");
		
		if(cked.length == 0) {
			$.dialog.alertInfo("请选择需要查看权限的角色！");
		} else if(cked.length > 1) {
			$.dialog.alertInfo("请选择一个角色！");
		} else {
			var roleCode = cked.attr("id");
			$("#authorizedRoleCode").val("");
			
			$.server.ajaxRequest({
				url : "<%=path%>/System/role/queryRoleAuth.jmt",
				data : {
					roleCode : roleCode
				},
				onSuccess : function(msg, data) {
					
					$("#authorizedRoleCode").val(roleCode);
					
					var sysTree = $.fn.zTree.getZTreeObj("sysTree");
					var appTree = $.fn.zTree.getZTreeObj("appTree");
					var cmsTree = $.fn.zTree.getZTreeObj("cmsTree");
					
					sysTree.checkAllNodes(false);
					appTree.checkAllNodes(false);
					cmsTree.checkAllNodes(false);
					
					var sysNodes = sysTree.transformToArray(sysTree.getNodes());
					var appNodes = appTree.transformToArray(appTree.getNodes());
					var cmsNodes = cmsTree.transformToArray(cmsTree.getNodes());
					
					$.each(sysNodes, function(i, node) {
						
						var id = node.id;
						if($.inArray(id, data) > -1) {
							sysTree.checkNode(node, true, false);
						}
					});
					
					$.each(appNodes, function(i, node) {
						
						var id = node.id;
						if($.inArray(id, data) > -1) {
							appTree.checkNode(node, true, false);
						}
					});
					
					$.each(cmsNodes, function(i, node) {
						
						var id = node.id;
						if($.inArray(id, data) > -1) {
							cmsTree.checkNode(node, true, false);
						}
					});
					
				}
			});
		}
    }
    
    function authorizedRole() {
    	var roleCode = $("#authorizedRoleCode").val();
    	if($.utils.isEmpty(roleCode)) {
    		$.dialog.alertInfo("请首先查看角色的权限！");
    		return ;
    	}
    	
    	var sysTree = $.fn.zTree.getZTreeObj("sysTree");
		var appTree = $.fn.zTree.getZTreeObj("appTree");
		var cmsTree = $.fn.zTree.getZTreeObj("cmsTree");
		
		var nodes = sysTree.getCheckedNodes(true);
		nodes = $.merge(nodes, appTree.getCheckedNodes(true));
		nodes = $.merge(nodes, cmsTree.getCheckedNodes(true));
		
		var ids = new Array();
		for(var i=0;i<nodes.length;i++) {
			ids.push(nodes[i].id);
		}
		
		$.server.ajaxRequest({
			url : "<%=path%>/System/role/authorizedRole.jmt",
			data : {
				roleCode : roleCode,
				ids : ids.toString()
			}
		});
		
    }
    
    function showTree(obj, treeId) {
    	$(obj).parent("li").parent("ul").find("li").removeClass("active");
    	$(obj).parent("li").addClass("active");
    	
    	$("#" + treeId).parent("div").find("ul").hide();
    	$("#" + treeId).show();
    }
    
	function deleteRole(ids) {
		$.dialog.confirm("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/System/role/deleteResource.jmt",
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
	
	function deleteRoles() {
		
		var ids = $.utils.getChecked($("#roleTable"));
		
		if(ids == "") {
			$.dialog.alertInfo("请选择需要删除的项！");
		} else {
			deleteRole(ids);
		}
	}
    
	function openAddWnd() {
		$("#roleMsgTips").html("");
		$("#editRoleForm").resetForm();
		$("#editRoleForm").formDialog("show");
		$("#editRoleForm [name=roleCode]").attr("readonly", false);
		$("#editRoleForm [name='opType']").val("save");
	}
	

	function openEditWnd(roleCode, roleName, roleDesc,
			isDisabled) {
		$("#roleMsgTips").html("");
		$("#editRoleForm").resetForm();
		$("#editRoleForm").formDialog("show");
		$("#editRoleForm").setFormValues({
			roleCode : roleCode,
			roleName : roleName,
			roleDesc : roleDesc,
			isDisabled : isDisabled
		});

		$("#editRoleForm [name=roleCode]").attr("readonly",true);
		$("#editRoleForm [name='opType']").val("modify");
	}
	</script>
    
    
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">角色管理</li>
		</ul>
	</div>
	
	<div class="row">
		<div class="span8">
			<form class="form-search" method="post" action="<%=path %>/System/role/queryRolePage.jhtml" id="queryForm">
				<label>角色编码：</label>
			  	<input type="text" name="roleCode" class="input-medium">
			  	<label style="width: 10px;"></label>
			  	<label>角色名称：</label>
			  	<input type="text" name="roleName" class="input-medium">
			  	<button type="submit" class="btn">搜索</button>
			</form>
			
			<div class="well formOutSide">
				<sec:authorize url="/System/role/saveOrModify*.jmt">
				<button class="btn btn-primary" onclick="openAddWnd();"><i class="icon-plus"></i>新增</button>
				</sec:authorize>
				<sec:authorize url="/System/role/delete*.jmt">
				<button class="btn btn-danger" onclick="deleteRoles();">删除选中项</button>
				</sec:authorize>
				<button class="btn" onclick="showRoleAuth();">查看角色权限</button>
			</div>
			
			<table class="table table-striped table-bordered table-condensed" id="roleTable">
				<thead id="listHeader">
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll(this);">
						</label></th>
						<th width="20%" class="sort[ename]">角色编码</th>
						<th width="20%" class="sort[cname]">角色名称</th>
						<th width="30%">描述</th>
						<th width="15%">是否禁用</th>
						<th width="10%" style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="role" items="${page.reslutSet }">
					<tr>
						<td><label class="checkbox"><input type="checkbox" id="${role.roleCode }" class="checkOne"></label></td>
						<td>${role.roleCode }</td>
						<td>${role.roleName }</td>
						<td class="renderer-desc">${role.roleDesc }</td>
						<td class="renderer-yn">${role.isDisabled }</td>
						<td style="text-align: center;">
							<div class="btn-group">
							  <sec:authorize url="/System/role/saveOrModify*.jmt">
							  <button class="btn btn-info" 
							  		onclick="openEditWnd('${role.roleCode }','${role.roleName }','${role.roleDesc }','${role.isDisabled }');">修改</button>
							  </sec:authorize>
							  <sec:authorize url="/System/role/delete*.jmt">
							  <button class="btn btn-danger" onclick="deleteRole('${role.roleCode }')">删除</button>
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
			<ul class="nav nav-tabs">
				<li class="active">
			    	<a href="javascript:void(0);" onclick="showTree(this,'sysTree');">系统管理</a>
			  	</li>
			  	<li><a href="javascript:void(0);" onclick="showTree(this,'appTree');">应用系统</a></li>
			  	<li><a href="javascript:void(0);" onclick="showTree(this,'cmsTree');">信息发布</a></li>
			</ul>
			
			<div style="border: 1px solid #DDDDDD;margin-bottom: 20px;">
				<div class="rectangle-header">角色权限</div>
  				<ul id="sysTree" class="ztree" style="height: 280px;overflow: auto;"></ul>
  				<ul id="appTree" class="ztree" style="height: 280px;overflow: auto;display: none;"></ul>
  				<ul id="cmsTree" class="ztree" style="height: 280px;overflow: auto;display: none;"></ul>
  				<sec:authorize url="/System/role/authorizedRole.jmt">
  				<div style="margin: 5px 0;padding-left: 100px;">
  					<input type="hidden" id="authorizedRoleCode">
					<button class="btn btn-info" onclick="authorizedRole();">保存授权</button>
				</div>
				</sec:authorize>
  			</div>
		</div>
	</div>
	
	<form class="form-horizontal" method="post" action="<%=path%>/System/role/saveOrModifyRole.jmt" id="editRoleForm">
		<fieldset>
			<div id="roleMsgTips"></div>
			<input type="hidden" name="opType">
			<div class="control-group">
				<label class="control-label" for="roleCode">角色编码：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="roleCode"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="roleName">角色名称：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="roleName"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="isDisabled">是否禁用：</label>
				<div class="controls">
					<select name="isDisabled" class="input-medium renderer-yn"></select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="roleDesc">描述：</label>
				<div class="controls">
					<textarea class="input-medium" rows="3" name="roleDesc"></textarea>
				</div>
			</div>
		</fieldset>
	</form>
	
	<c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>
	
  </body>
</html>
