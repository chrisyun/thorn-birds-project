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
    
    <title>模板管理</title>
    <link href="<%=path %>/plugins/zTree/zTreeBookStyle.css" rel="stylesheet">
    <script type="text/javascript" src="<%=path %>/plugins/zTree/jquery.ztree.all-3.5.js"></script>
    
    <script type="text/javascript">
    $(function(){
    	initValidationEngine("addFolderForm");
    	
		var setting = {
			async: {
				enable: true,
				url:"<%=path%>/CMS/tp/queryTemplateTree.jmt",
				autoParam:["id=folder"]
			},
			data : {
				key : {
					name : "text"
				}
			},
			callback : {
				onDblClick : function(event, treeId, node) {
					if(node.isParent) {
						window.location.href = "<%=path%>/CMS/tp/queryTemplates.jhtml?folder=" + node.id;
					} else {
						//修改
					}
				}
			}
		};
    	
		var tree = $.fn.zTree.init($("#tree"), setting, [{
			id : "",
			text : "模板根目录",
			isParent : "true"
		}]);
    });
    
    function createFolder() {
    	$("#addFolderForm").submitForm({
    		onSuccess : function(msg) {
				$.dialog.alertSuccess(msg, "操作成功", function() {
					$.utils.reloadPage();
				});
			}
    	});
    }
    
    </script>

  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/CMS/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">模板管理</li>
		</ul>
	</div>
	
	<div class="row">
  		<div class="span3">
  			<div style="border: 1px solid #DDDDDD;margin-bottom: 20px;">
  				<div class="rectangle-header">模板目录</div>
  				<ul id="tree" class="ztree" style="height: 400px;overflow: auto;"></ul>
  			</div>
  		</div>
	
		<div class="span9">
  			<form class="form-search" method="post" action="<%=path %>/CMS/tp/createFolder.jmt" id="addFolderForm">
				<label>当前目录：</label>
				<span class="input-medium uneditable-input"><%=CMSConfiguration.TEMPLATE_ROOT %>${dbFolder }</span>
			  	<label style="width: 10px;"></label>
			  	<input type="hidden" name="pFolder" value="${dbFolder }">
			  	<input name="folder" class="input-mini" type="text" data-validation-engine="validate[required]">
			  	<label style="width: 10px;"></label>
			  	<button type="button" class="btn btn-primary" onclick="createFolder();">新建目录</button>
			  	<label style="width: 10px;"></label>
			  	<button type="button" class="btn btn-info">创建模板</button>
			  	<label style="width: 10px;"></label>
			  	<button type="button" class="btn">上传文件</button>
			</form>
			
			<table class="table table-striped table-bordered table-condensed" id="tpTable">
				<thead id="listHeader">
					<tr>
						<th width="40%">文件名</th>
						<th width="20%">最后修改人</th>
						<th width="20%">最后修改时间</th>
						<th width="20%" style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="tp" items="${list }">
					<tr>
						<td>${tp.name }</td>
						<td>${tp.updaterName }</td>
						<td>${tp.updateTime }</td>
						<td style="text-align: center;">
							<div class="btn-group">
								<sec:authorize url="/System/org/saveOrModify*.jmt">
								<button class="btn btn-info btn-mini" onclick="edit('${tp.id }')">
									<i class="nopadding icon-edit"></i>
								</button>
								</sec:authorize>
								<sec:authorize url="/System/org/delete*.jmt">
								<button class="btn btn-danger btn-mini" onclick="delete('${tp.id }','${tp.name }')">
									<i class="nopadding icon-trash"></i>
								</button>
								</sec:authorize>
							</div>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
  </body>
</html>
