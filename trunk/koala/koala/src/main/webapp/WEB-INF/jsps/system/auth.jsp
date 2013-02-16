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
    
    <title>用户授权</title>
	<link href="<%=path %>/plugins/zTree/zTreeBookStyle.css" rel="stylesheet">
    <script type="text/javascript" src="<%=path %>/plugins/zTree/jquery.ztree.all-3.5.js"></script>
    
	<script type="text/javascript">
	var thisPageArray = new Array();
	$(function(){
		$(".renderer-yn").renderer({
			renderArray : <thorn:dd  typeId="YESORNO" />
		});
		
		$(".renderer-defRole").renderer({
			renderArray : <thorn:dd  typeId="DEFAULTROLE" />
		});
		
		$(".renderer-initCk").renderer({
			renderer : "custom",
			rendererFunc : function(obj) {
				var val = obj.val();
				if(!$.utils.isEmpty(val)) {
					obj.attr("checked", true);
					thisPageArray.push(obj.attr("id"));
				}
			}
		});
		
		$("#pagingBar").page({
			align : "right",
			pageSize : parseInt('${page.pageSize}'),
			totalSize : parseInt('${page.total}'),
			pageIndex : parseInt('${page.pageIndex}')
		});
		
		var setting = {
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
					if(treeId == "queryOrgTree") {
						$("#queryForm [name=orgName]").val(node.text);
						$("#queryForm [name=orgCode]").val(node.id);
						$("#queryOrgTree").hide();
					}
				}
			}
		};
		
		var root = {
			id : "ROOT",
			pid : "-1",
			text : "文化部",
			isParent : "true"
		};
		
		$("#queryOrgTree").hide();
		var queryOrgTree = $.fn.zTree.init($("#queryOrgTree"), setting, [root]);
		$("#queryOrgBtn").click(function() {
			$("#queryOrgTree").toggle();
		});
	
	});	
	
	function submitQuery() {
		var roleCode = $("#queryForm [name=roleCode]").val();
		
		if($.utils.isEmpty(roleCode)) {
			$.dialog.alertInfo("请选择角色！");
			return ;
		}
		
		$("#curRoleCode").val(roleCode);
		$("#queryForm").submit();
	}
	
	function saveAuthSetting() {
		var roleCode = $("#curRoleCode").val();
		
		if($.utils.isEmpty(roleCode)) {
			$.dialog.alertInfo("未选择角色！");
			return ;
		}
		
		var ids = $.utils.getChecked($("#userTable"));
		
		$.dialog.confirm("您确认保存当前所设置的用户权限吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/System/user/saveUserRoleSetting.jmt",
				data : {
					oldUserIds : thisPageArray.toString(),
					newUserIds : ids,
					roleCode : roleCode
				}
			});
		});
	}
	
	</script>
	
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">用户授权</li>
		</ul>
	</div>
	
	<div class="row">
    	<div class="span12">
  			<form class="form-search" method="post" action="<%=path %>/System/user/queryUserPageByRole.jhtml" id="queryForm">
  				<label>角色：</label>
			  	<select name="roleCode" class="input-medium renderer-module">
			  		<option value="">-----请选择-----</option>
			  	<c:forEach var="role" items="${roles }">
			  		<option value="${role.roleCode }">${role.roleName }</option>
			  	</c:forEach>
			  	</select>
			  	<label style="width: 10px;"></label>
			  	<label>账号：</label>
			  	<input type="text" name="userAccount" class="input-mini">
			  	<label style="width: 10px;"></label>
			  	<label>姓名：</label>
			  	<input type="text" name="userName" class="input-mini">
			  	<label style="width: 10px;"></label>
  				<label>单位：</label>
			  	<div class="input-append btn-group">
			  		<input type="text" name="orgName" class="input-medium" readonly>
			  		<input type="hidden" name="orgCode" id="orgCode">
			  		<a class="btn dropdown-toggle" id="queryOrgBtn">
			  			选择<span class="caret"></span>
			  		</a>
			  		<ul id="queryOrgTree" class="dropdown-menu ztree" style="height: 280px;overflow: auto;width: 220px;">
			  		</ul>
			  	</div>
			  	<label style="width: 10px;"><input type="hidden" name="curRoleCode" id="curRoleCode"> </label>
			  	<button type="button" class="btn" onclick="submitQuery();">搜索</button>
			</form>
			
			<sec:authorize url="/System/user/saveUserRoleSetting.jmt">
			<div class="well formOutSide">
				<button class="btn" onclick="saveAuthSetting();">保存当前设置</button>
			</div>
			</sec:authorize>
			
			<table class="table table-striped table-bordered table-condensed" id="userTable">
				<thead id="listHeader">
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll(this);">
						</label></th>
						<th width="20%" class="sort[userId]">账号</th>
						<th width="20%" class="sort[userName]">姓名</th>
						<th width="25%">邮箱</th>
						<th width="10%">电话</th>
						<th width="10%">默认角色</th>
						<th width="10%">是否显示</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="user" items="${page.reslutSet }">
					<tr>
						<td><label class="checkbox"><input type="checkbox" id="${user.userId }" 
							value="${user.roleCode }" class="checkOne renderer-initCk"></label></td>
						<td>${user.userId }</td>
						<td>${user.userName }</td>
						<td>${user.cumail }</td>
						<td>${user.phone }</td>
						<td class="renderer-defRole">${user.defaultRole }</td>
						<td class="renderer-yn">${user.isShow }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
			<div id="pagingBar"></div>
		</div>
	</div>
	
	<c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>
  </body>
</html>
