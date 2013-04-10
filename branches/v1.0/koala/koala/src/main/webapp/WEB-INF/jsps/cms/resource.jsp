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
    
    <title>资源管理</title>
    <script type="text/javascript" src="<%=path %>/plugins/func/uploadFile.js"></script>
    
	<script type="text/javascript">
	$(function(){
		
		$(".renderer-file").renderer({
			renderer : "custom",
			rendererFunc : function(obj) {
				var type = obj.attr("type");
				var name = obj.html();
				var folder = $("#pFolder").val() + name;
				
				var html = "";
				if(type == "folder") {
					html = "<i class='icon-folder-close'></i>" + 
								"<a href='<%=path%>/CMS/rs/queryResource.jhtml?pFolder=" + folder + "'>" 
								+ name + "</a>";
					obj.html(html);
				} else if(type == "image") {
					var _a = $('<a href="<%=path + CMSConfiguration.FOLDER_CSS%>' + folder 
							+ '" target="_blank" title="<img src=\'<%=path + CMSConfiguration.FOLDER_CSS%>' 
							+ folder + '\'>">' + name + '</a>');
					obj.html("<i class='icon-picture'></i>");
					obj.append(_a);
					
					_a.popover({
						trigger : "hover"
					});
				} else {
					html = "<i class='icon-file'></i>" + 
							"<a target='_blank' href='<%=path + CMSConfiguration.FOLDER_CSS%>" + folder + "'>" 
							+ name + "</a>";
					obj.html(html);
				}
			}
		});
		
		$("#folderForm").formDialog({
			title : "编辑目录信息",
			buttons : [{
				text : "保存",
				cls : "btn-primary",
				click : function() {
					$("#folderForm").submitForm({
						progress : false,
						onSuccess : function(msg) {
							$("#folderMsgTips").message({
								type : "success",
								text : msg,
								title : "请求处理成功"
							});
							setTimeout(function(){
								$.utils.reloadPage();
							}, 2000);
						},
						onFailure : function(msg) {
							$("#folderMsgTips").message({
								type : "error",
								text : msg,
								title : "数据处理出错"
							});
						},
						onError : function() {
							$("#folderMsgTips").message({
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
		
		$("#uploadBtn").uploadFile({
			dir : $("#curFolder").val(),
			dirRead : true
		});
		
		initValidationEngine("folderForm");
		initValidationEngine("addFolderForm");		
	});
	
	function deleteFile(name) {
    	$.dialog.confirm("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/CMS/rs/deleteFile.jmt",
				data : {
					file : name,
					folder : $("#pFolder").val()
				},
				onSuccess : function(msg, data) {
					$.dialog.alertSuccess(msg, "请求处理成功", function(){
						$.utils.refreshPage();
					});
				}
			});
		});
	}
	
    function createFolder() {
    	$("#addFolderForm").submitForm({
    		onSuccess : function(msg) {
				$.dialog.alertSuccess(msg, "操作成功", function() {
					$.utils.reloadPage();
				});
			}
    	});
    }
	
    function reNameFile(name) {
    	var folder = $("#pFolder").val();
		$("#folderMsgTips").html("");
		$("#folderForm").resetForm();
		$("#folderForm").setFormValues({
			folder : name,
			oldFolder : name,
			pFolder : folder
		});
		$("#folderForm").formDialog("show");
    }
	</script>
	
	
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/CMS/index.jhtml">内容发布</a><span class="divider">/</span></li>
			<li class="active">资源管理</li>
		</ul>
	</div>
	
	<div class="row">
		<div class="span12">
  			<form class="form-search" method="post" action="<%=path %>/CMS/rs/createFolder.jmt" id="addFolderForm">
				<label>当前目录：</label>
				<input type="text" value="<%=CMSConfiguration.FOLDER_CSS %>${pFolder }" readonly class="input-medium" id="curFolder">
			  	<label style="width: 10px;"></label>
			  	<input type="hidden" id="pFolder" name="pFolder" value="${pFolder }">
			  	<input name="folder" class="input-mini" type="text" data-validation-engine="validate[required,custom[onlyLetterNumber]]">
			  	<label style="width: 10px;"></label>
			  	<button type="button" class="btn btn-primary" onclick="createFolder();">新建目录</button>
			  	<label style="width: 10px;"></label>
			  	<button type="button" class="btn" id="uploadBtn">上传文件</button>
			</form>
			
			<table class="table table-striped table-bordered table-condensed" id="tpTable">
				<thead id="listHeader">
					<tr>
						<th width="40%">文件名</th>
						<th width="20%">大小</th>
						<th width="25%">最后修改时间</th>
						<th width="15%" style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<tr>
					<td colspan="4">
						<i class="icon-folder-open"></i><a href="<%=path%>/CMS/rs/queryResource.jhtml?pFolder=${pFolder}&toParent=..">...</a>
					</td>
				</tr>
				<c:forEach var="rs" items="${list }">
					<tr>
						<td class="renderer-file" type="${rs.type }">${rs.name }</td>
						<td>${rs.size }</td>
						<td>${rs.lastModifyTime }</td>
						<td style="text-align: center;">
							<div class="btn-group">
								<sec:authorize url="/CMS/rs/saveOrModify*.jmt">
								<button class="btn btn-info btn-mini" onclick="reNameFile('${rs.name }')">
									<i class="nopadding icon-edit"></i>
								</button>
								</sec:authorize>
								<sec:authorize url="/CMS/rs/delete*.jmt">
								<button class="btn btn-danger btn-mini" onclick="deleteFile('${rs.name }')">
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

	<form class="form-horizontal" method="post" action="<%=path%>/CMS/rs/saveOrModifyFolder.jmt" id="folderForm">
		<fieldset>
			<div id="folderMsgTips"></div>
			<input type="hidden" name="pFolder">
			<input type="hidden" name="oldFolder">
			<div class="control-group">
				<label class="control-label" for="folder">目录：</label>
				<div class="controls">
					<input type="text" class="input-medium" name="folder"
							data-validation-engine="validate[required,custom[onlyLetterNumber]]">
					<p class="help-block"><i class="redStar">*</i>必填，不得与现有的文件夹重名</p>
				</div>
			</div>
		</fieldset>
	</form>	
	
  </body>
</html>
