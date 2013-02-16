<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>用户授权</title>
	<script type="text/javascript">
	$(function(){
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
  			<form class="form-search" method="post" action="<%=path %>/System/log/queryAppLog.jhtml" id="queryForm">
  				<label>角色：</label>
			  	<select name="moduleName" class="input-medium renderer-module"></select>
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
			</form>
		</div>
	</div>
	
	
	
	
	
  </body>
</html>
