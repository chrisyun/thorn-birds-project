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
    <base href="<%=basePath%>">
    
    <title>用户管理</title>
    <link href="<%=path %>/plugins/zTree/zTreeBookStyle.css" rel="stylesheet">
    <script type="text/javascript" src="<%=path %>/plugins/zTree/jquery.ztree.all-3.5.js"></script>
    
    <script type="text/javascript">
    $(function(){
		$(".renderer-yn").renderer({
			renderer : "text",
			renderArray : <thorn:dd  typeId="YESORNO" />
		});
		
		$(".renderer-ynSel").renderer({
			renderArray : <thorn:dd  typeId="YESORNO" />
		});
		
		$(".renderer-gender").renderer({
			renderer : "text",
			renderArray : <thorn:dd  typeId="GENDER" />
		});
		
		$(".renderer-genderSel").renderer({
			renderArray : <thorn:dd  typeId="GENDER" />
		});
		
		$(".renderer-defRole").renderer({
			renderer : "text",
			renderArray : <thorn:dd  typeId="DEFAULTROLE" />
		});
		
		$(".renderer-defRoleSel").renderer({
			renderArray : <thorn:dd  typeId="DEFAULTROLE" />
		});
		
		$("#queryOrgTree").hide();
		
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
					} else if(treeId == "editOrgTree") {
						$("#editUserForm [name=orgName]").val(node.text);
						$("#editUserForm [name=orgCode]").val(node.id);
						$("#editOrgTree").hide();
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
		
		$("#editUserForm").formDialog({
			title : "编辑用户信息",
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#editUserForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#userMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
							setTimeout(function(){
								$.utils.reloadPage();
							}, 2000);
						},
						onFailure : function(msg) {
							$("#userMsgTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#userMsgTips").message({
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
		
		var editOrgTree = $.fn.zTree.init($("#editOrgTree"), setting, [root]);
		var queryOrgTree = $.fn.zTree.init($("#queryOrgTree"), setting, [root]);
		
		$("#queryOrgBtn").click(function() {
			$("#queryOrgTree").toggle();
		});
		$("#editOrgBtn").click(function() {
			$("#editOrgTree").toggle();
		});
		
		initValidationEngine("editOrgForm");
		$("#editUserForm").formDialog("show");
    });
    
	function deleteUser(ids) {
		$.dialog.confirm("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/System/user/deleteUser.jmt",
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
	
	function deleteUsers() {
		
		var ids = $.utils.getChecked($("#userTable"));
		
		if(ids == "") {
			$.dialog.alertInfo("请选择需要删除的项！");
		} else {
			deleteDt(ids);
		}
	}
    
	function disabledUsers(type) {
		
		var ids = $.utils.getChecked($("#userTable"));
		
		var msg = "启用";
		var opType = "NO";
		if(type == 0) {
			msg = "禁用";
			opType = "YES";
		}
		
		if(ids == "") {
			$.dialog.alertInfo("请选择需要" + msg + "的项！");
			return ;
		}
		
		$.dialog.confirm("您确认" + msg + "选中的项吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/System/user/disabledUser.jmt",
				data : {
					isDisabled : opType,
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
    
    </script>
    
  </head>
  
  <body>
	<div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">用户管理</li>
		</ul>
	</div>
    
    <div class="row">
    	<div class="span12">
  			<form class="form-search" method="post" action="<%=path %>/System/user/queryUserPage.jhtml" id="queryForm">
				<label>账号：</label>
			  	<input type="text" name="userAccount" class="input-mini">
			  	<label style="width: 10px;"></label>
			  	<label>姓名：</label>
			  	<input type="text" name="userName" class="input-mini">
			  	<label style="width: 10px;"></label>
			  	<label>邮箱：</label>
			  	<input type="text" name="cumail" class="input-medium">
			  	<label style="width: 10px;"></label>
			  	<label>所属组织：</label>
			  	<div class="input-append btn-group">
			  		<input type="text" name="orgName" class="input-medium" readonly>
			  		<input type="hidden" name="orgCode" id="orgCode">
			  		<a class="btn dropdown-toggle" id="queryOrgBtn">
			  			选择<span class="caret"></span>
			  		</a>
			  		<ul id="queryOrgTree" class="dropdown-menu ztree" style="height: 280px;overflow: auto;width: 220px;">
			  		</ul>
			  	</div>
			  	<label style="width: 10px;"></label>
			  	<button type="submit" class="btn">搜索</button>
			</form>
			
			<div class="formOutSide btn-group">
				<sec:authorize url="/System/user/delete*.jmt">
				<button class="btn btn-danger" onclick="deleteUsers();">删除选中项</button>
				</sec:authorize>
				<sec:authorize url="/System/user/disabled*.jmt">
				<button class="btn" onclick="disabledUsers(1);">启用</button>
				<button class="btn" onclick="disabledUsers(0);">禁用</button>
				</sec:authorize>
			</div>
    		
    		<table class="table table-striped table-bordered table-condensed" id="userTable">
				<thead id="listHeader">
					<tr>
						<th width="5%"><label class="checkbox">
							<input type="checkbox" title="全选" class="checkAll" onclick="$.utils.checkAll(this);">
						</label></th>
						<th width="10%" class="sort[userId]">账号</th>
						<th width="20%" class="sort[userName]">姓名</th>
						<th width="5%">性别</th>
						<th width="15%">邮箱</th>
						<th width="11%">电话</th>
						<th width="8%">默认角色</th>
						<th width="8%">是否显示</th>
						<th width="8%">是否禁用</th>
						<th width="10%" style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="user" items="${page.reslutSet }">
					<tr>
						<td><label class="checkbox"><input type="checkbox" id="${user.userId }" class="checkOne"></label></td>
						<td>${user.userId }</td>
						<td>${user.userName }</td>
						<td class="renderer-gender">${user.gender }</td>
						<td>${user.cumail }</td>
						<td>${user.phone }</td>
						<td class="renderer-defRole">${user.defaultRole }</td>
						<td class="renderer-yn">${user.isShow }</td>
						<td class="renderer-yn">${user.isDisabled }</td>
						<td style="text-align: center;">
							<div class="btn-group">
								<sec:authorize url="/System/user/saveOrModify*.jmt">
								<button class="btn btn-info" onclick="editUser('${user.userId }')">编辑</button>
								</sec:authorize>
								<sec:authorize url="/System/user/delete*.jmt">
								<button class="btn btn-danger" onclick="deleteUser'${user.userId }')">删除</button>
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
    
   	<form class="form-horizontal" method="post" action="<%=path%>/System/user/saveOrModifyUser.jmt" id="editUserForm">
		<fieldset>
			<div id="userMsgTips"></div>
			<input type="hidden" name="opType">
			<input type="hidden" name="orgCode">
			<div class="control-group">
				<label class="control-label" for="userId">账号：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="userId" readonly>
					<p class="help-inline">系统自动生成</p>
				</div>
			</div>
			<div class="control-group">	
				<label class="control-label" for="userName">姓名：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="userName"
						data-validation-engine="validate[required]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="gender">性别：</label>
				<div class="controls">
					<select name="gender" class="input-medium renderer-genderSel"></select>
				</div>
			</div>
			<div class="control-group">	
				<label class="control-label" for="orgName">所属组织：</label>
				<div class="controls">
					<div class="input-append btn-group">
				  		<input type="text" name="orgName" class="input-medium" readonly>
				  		<a class="btn dropdown-toggle" id="editOrgBtn">
				  			选择<span class="caret"></span>
				  		</a>
				  		<ul id="editOrgTree" class="dropdown-menu ztree" style="height: 280px;overflow: auto;width: 220px;">
				  		</ul>
				  	</div>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="cumail">邮箱：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="cumail" 
						data-validation-engine="validate[required,maxSize[50],custom[email]]">
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">		
				<label class="control-label" for="phone">电话号码：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="phone" 
						data-validation-engine="validate[maxSize[50],custom[phone]]">
				</div>
			</div>
			<div class="control-group">	
				<label class="control-label" for="defaultRole">默认角色：</label>
				<div class="controls">
					<select name="defaultRole" class="input-medium renderer-defRoleSel" 
						data-validation-engine="validate[required]"></select>
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">		
				<label class="control-label" for="userPwd">修改密码：</label>
				<div class="controls">
					<input type="password" class="input-medium" name="userPwd" 
						data-validation-engine="validate[minSize[6],maxSize[15],custom[pwdStrength]]">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="isShow">是否显示：</label>
				<div class="controls">
					<select name="isShow" class="input-medium renderer-ynSel" 
						data-validation-engine="validate[required]"></select>
					<p class="help-inline"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="isDisabled">是否禁用：</label>
				<div class="controls">
					<select name="isDisabled" class="input-medium renderer-ynSel"
						 data-validation-engine="validate[required]"></select>
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
