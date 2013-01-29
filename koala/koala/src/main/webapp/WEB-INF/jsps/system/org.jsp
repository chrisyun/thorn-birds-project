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
		
		$("#queryOrgType").renderer({
			renderArray : <thorn:dd  typeId="ORGTYPE" />
		});
		
		$(".renderer-type").renderer({
			renderer : "text",
			renderArray : <thorn:dd  typeId="ORGTYPE" />
		});
		
		$(".renderer-yn").renderer({
			renderer : "text",
			renderArray : <thorn:dd  typeId="YESORNO" />
		});
		
		$(".renderer-area").renderer({
			renderer : "text",
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
				},
				onRightClick : function(event, treeId, node) {
					orgTree.selectNode(node);
					$("#treeMenu ul").show();
					$("#treeMenu").css({
						"top" : event.clientY + "px",
						"left" : event.clientX + "px",
						"visibility" : "visible"
					});
					$("body").bind("mousedown", function(event){
						if (!(event.target.id == "treeMenu" 
								|| $(event.target).parents("#treeMenu").length > 0)) {
							$("#treeMenu").css({"visibility" : "hidden"});
						}
					});
				}
			}
		};
		
		var orgTree = $.fn.zTree.init($("#orgTree"), setting, [{
			id : "ROOT",
			pid : "-1",
			text : "文化部",
			isParent : "true"
		}]);
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
  				<ul id="orgTree" class="ztree" style="height: 280px;overflow: auto;"></ul>
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
			  	<select name="orgType" id="queryOrgType" class="input-medium"></select>
			  	<input type="hidden" name="pid" id="pid">
			  	<button type="submit" class="btn">搜索</button>
			</form>
			
			<div class="formOutSide">
				<sec:authorize url="/System/org/saveOrModify*.jmt">
				<button class="btn btn-primary" onclick="openAddWnd();"><i class="icon-plus"></i>新增</button>
				</sec:authorize>
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
						<th width="15%" class="sort[orgCode]">组织编码</th>
						<th width="25%" class="sort[orgName]">组织名称</th>
						<th width="10%">组织类型</th>
						<th width="10%">所属区域</th>
						<th width="10%">是否显示</th>
						<th width="10%">是否禁用</th>
						<th width="15%" style="text-align: center;">操作</th>
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
							  <button class="btn btn-info">修改</button>
							  </sec:authorize>
							  <sec:authorize url="/System/org/delete*.jmt">
							  <button class="btn btn-danger" onclick="deleteOrg('${org.orgId }')">删除</button>
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
  	
  	<c:import url="../ref/conditionWriteBack.jsp">
		<c:param name="conditionWriteBackFormId">queryForm</c:param>
	</c:import>
  	
  	<div id="treeMenu" style="position: absolute;visibility: hidden;top: 0;">
  		<ul class="dropdown-menu">
  			<li><a>新增组织机构</a></li>
  			<li><a>修改组织机构</a></li>
  		</ul>
  	</div>
  </body>
</html>
