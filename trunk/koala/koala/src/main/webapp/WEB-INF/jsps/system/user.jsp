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
			renderArray : <thorn:dd  typeId="YESORNO" />
		});
		
		$(".renderer-gender").renderer({
			renderArray : <thorn:dd  typeId="GENDER" />
		});
		
		$(".renderer-defRole").renderer({
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
			width : 700,
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
		
		$("#restPwdForm").formDialog({
			title : "修改用户密码",
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#restPwdForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#restPwdTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
						},
						onFailure : function(msg) {
							$("#restPwdTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#restPwdTips").message({
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
		$("#roleForm").formDialog({
			title : "设置用户角色",
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#roleForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#roleMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
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
		
		var editOrgTree = $.fn.zTree.init($("#editOrgTree"), setting, [root]);
		var queryOrgTree = $.fn.zTree.init($("#queryOrgTree"), setting, [root]);
		
		$("#queryOrgBtn").click(function() {
			$("#queryOrgTree").toggle();
		});
		$("#editOrgBtn").click(function() {
			$("#editOrgTree").toggle();
		});
		
		initValidationEngine("editUserForm");
		initValidationEngine("restPwdForm");
		initValidationEngine("roleForm");
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
			deleteUser(ids);
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
    
	function openAddWnd() {
		
		$("#userMsgTips").html("");
		$("#editUserForm").resetForm();
		$("#editUserForm").formDialog("show");
		
		$("#editUserForm [name='opType']").val("save");
	}
	
	function openRestWnd() {
		
		var cked = $("#userTable").find(":checkbox:checked[class=checkOne]");
		
		if(cked.length == 0) {
			$.dialog.alertInfo("请选择需要修改的数据项！");
		} else if(cked.length > 1) {
			$.dialog.alertInfo("请选择一条数据项！");
		} else {
			$("#userMsgTips").html("");
			$("#restPwdForm").resetForm();
			$("#restPwdForm").formDialog("show");
			
			$("#restPwdForm [name='userId']").val(cked.attr("id"));
		}
	}
	
	function openRoleWnd() {
		
		var cked = $("#userTable").find(":checkbox:checked[class=checkOne]");
		
		if(cked.length == 0) {
			$.dialog.alertInfo("请选择需要修改的数据项！");
		} else if(cked.length > 1) {
			$.dialog.alertInfo("请选择一条数据项！");
		} else {
			$("#roleMsgTips").html("");
			$("#roleForm").resetForm();
			
			$.server.ajaxRequest({
				url : "<%=path%>/System/user/queryUserRole.jmt",
				data : {userId : cked.attr("id")},
				progress : false,
				onSuccess : function(msg, data) {
					
					$("#roleForm .control-group").empty();
					
					$.each(data, function(i, n) {
						var roleCode = n.object.roleCode;
						var roleName = n.object.roleName;
						var isCheck = n.relevance;
						
						var _laber = $('<label class="checkbox inline" style="margin-left: 10px;"></label>');
						_laber.append('<input type="checkbox" name="roleCodes" value="' + roleCode + '">' + roleName);
						
						if(isCheck) {
							_laber.find(":checkbox").attr("checked", true);
						}
						
						$("#roleForm .control-group").append(_laber);
					});
					
					$("#roleForm").formDialog("show");
				}
			});
			
			$("#roleForm [name='userId']").val(cked.attr("id"));
		}
	}
	
	function openEditWnd(userId) {
		
		$("#userMsgTips").html("");
		$("#editUserForm").resetForm();
		
		$.server.ajaxRequest({
			url : "<%=path%>/System/user/queryUser.jmt",
			data : {userId : userId},
			progress : false,
			onSuccess : function(msg, data) {
				$("#editUserForm").setFormValues(data);
				
				$("#editUserForm [name='opType']").val("modify");
				$("#editUserForm [name='userPwd']").val("");
				$("#editUserForm").formDialog("show");
			}
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
			
			<div class="well formOutSide btn-group">
				<sec:authorize url="/System/user/saveOrModify*.jmt">
				<button class="btn btn-primary" onclick="openAddWnd();"><i class="icon-plus"></i>新增</button>
				</sec:authorize>
				<sec:authorize url="/System/user/delete*.jmt">
				<button class="btn btn-danger" onclick="deleteUsers();">删除选中项</button>
				</sec:authorize>
				<sec:authorize url="/System/user/disabled*.jmt">
				<button class="btn" onclick="disabledUsers(1);">启用</button>
				<button class="btn" onclick="disabledUsers(0);">禁用</button>
				</sec:authorize>
				<sec:authorize url="/System/user/restPwd.jmt">
				<button class="btn" onclick="openRestWnd();">修改密码</button>
				</sec:authorize>
				<sec:authorize url="/System/user/saveRoleByUser.jmt">
				<button class="btn" onclick="openRoleWnd();">设置用户角色</button>
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
						<th width="10%">电话</th>
						<th width="10%">默认角色</th>
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
								<button class="btn btn-info" onclick="openEditWnd('${user.userId }')">编辑</button>
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
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="userId" readonly>
					<p class="help-block">系统自动生成</p>
				</div>
				<label class="control-label" for="userPwd">修改密码：</label>
				<div class="controls-column input-medium">
					<input type="password" class="input-medium" name="userPwd" 
						data-validation-engine="validate[minSize[6],maxSize[15],custom[pwdStrength]]">
				</div>
			</div>
			<div class="control-group">	
				<label class="control-label" for="orgName">所属组织：</label>
				<div class="controls-column input-large">
					<div class="input-append btn-group">
				  		<input type="text" name="orgName" class="input-large" 
				  			data-validation-engine="validate[required]" readonly>
				  		<a class="btn dropdown-toggle" id="editOrgBtn">
				  			选择<span class="caret"></span>
				  		</a>
				  		<ul id="editOrgTree" class="dropdown-menu ztree" 
				  			style="height: 250px;overflow: auto;width: 275px;">
				  		</ul>
				  	</div>
				  	<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
			</div>
			<div class="control-group">	
				<label class="control-label" for="userName">姓名：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="userName"
						data-validation-engine="validate[required]">
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="gender">性别：</label>
				<div class="controls-column input-medium">
					<select name="gender" class="input-medium renderer-gender"></select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="cumail">邮箱：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="cumail" 
						data-validation-engine="validate[required,maxSize[50],custom[email]]">
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="phone">电话号码：</label>
				<div class="controls-column input-medium">
					<input type="text" class="input-medium" name="phone" 
						data-validation-engine="validate[maxSize[50],custom[phone]]">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="isShow">是否显示：</label>
				<div class="controls-column input-medium">
					<select name="isShow" class="input-medium renderer-yn" 
						data-validation-engine="validate[required]"></select>
					<p class="help-block"><i class="redStar">*</i>必填</p>
				</div>
				<label class="control-label" for="defaultRole">默认角色：</label>
				<div class="controls-column input-medium">
					<select name="defaultRole" class="input-medium renderer-defRole" 
						data-validation-engine="validate[required]"></select>
					<p class="help-block"><i class="redStar">*</i>必填</p>
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
    
    <form class="form-horizontal" method="post" action="<%=path%>/System/user/restPwd.jmt" id="restPwdForm">
    	<fieldset>
			<div id="restPwdTips"></div>
			<div class="control-group">
				<label class="control-label" for="newPwd">新密码：</label>
				<div class="controls">
					<input type="hidden" name="userId">
					<input type="password" class="input-xlarge" id="newPwd" name="newPwd"
						data-validation-engine="validate[required,minSize[6],maxSize[15],custom[pwdStrength]]">
					<p class="help-block"><i class="redStar">*</i>必填，长度为6-15位</p>
					<p class="help-block"><i class="redStar">*</i>至少包含数字、特殊符号和大、小写字母中的两种</p>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="cfPassword">确认密码：</label>
				<div class="controls">
					<input type="password" class="input-xlarge" id="cfPassword" name="cfPassword"
						data-validation-engine="validate[required,equals[newPwd]]">
					<p class="help-block"><i class="redStar">*</i>必填，再次输入新密码</p>
				</div>
			</div>
		</fieldset>
    </form>
    
    <form class="form-horizontal" method="post" action="<%=path%>/System/user/saveRoleByUser.jmt" id="roleForm">
    	<fieldset>
			<div id="roleMsgTips"></div>
			<input type="hidden" name="userId">
			<div class="control-group"></div>
    	</fieldset>
    </form>	
    	
    <c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>
  </body>
</html>
