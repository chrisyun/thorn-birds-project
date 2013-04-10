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
    <script type="text/javascript" src="<%=path %>/plugins/func/uploadFile.js"></script>
    <script type="text/javascript">
    $(function(){
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
						window.location.href = "<%=path%>/CMS/tp/queryTemplate.jhtml?id=" + node.id;
					}
				}
			}
		};
    	
		var tree = $.fn.zTree.init($("#tree"), setting, [{
			id : "",
			text : "模板根目录",
			isParent : "true"
		}]);
		
		var root = tree.getNodeByParam("text", "模板根目录", null);
		tree.reAsyncChildNodes(root, "refresh");
		
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
			dirRead : true,
			func : function(form) {
				$.server.ajaxRequest({
					progress : false,
					url : "<%=path%>/CMS/tp/saveOrModifyUpload.jmt",
					data : {
						name : form.fileName,
						folder : $("#pFolder").val()
					},
					onSuccess : function(msg, data) {
						setTimeout(function(){
							$.utils.reloadPage();
						}, 2000);
					}
				});
			}
		});
		
		initValidationEngine("folderForm");
		initValidationEngine("addFolderForm");
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
    
    function createTp() {
    	var folder = $("#pFolder").val();
    	window.location.href = "<%=path%>/CMS/tp/queryTemplate.jhtml?folder=" + folder;
    }
    
    function editTp(id, name) {
    	if($.utils.isEmpty(id)) {
    		//修改文件名
    		var folder = $("#pFolder").val();
    		$("#folderMsgTips").html("");
    		$("#folderForm").resetForm();
    		$("#folderForm").setFormValues({
    			folder : name,
    			oldFolder : name,
    			pFolder : folder
    		});
    		$("#folderForm").formDialog("show");
    	} else {
    		window.location.href = "<%=path%>/CMS/tp/queryTemplate.jhtml?id=" + id;
    	}
    }
    
    function deleteTemplate(id, name) {
    	$.dialog.confirm("您确认删除吗？", function(){
			$.server.ajaxRequest({
				url : "<%=path%>/CMS/tp/deleteTp.jmt",
				data : {
					id : id,
					name : name,
					curFolder : $("#pFolder").val()
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
			<li><a href="<%=path%>/CMS/index.jhtml">内容发布</a><span class="divider">/</span></li>
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
				<input type="text" value="<%=CMSConfiguration.TEMPLATE_ROOT %>${dbFolder }" id="curFolder" readonly class="input-medium">
			  	<label style="width: 10px;"></label>
			  	<input type="hidden" id="pFolder" name="pFolder" value="${dbFolder }">
			  	<input name="folder" class="input-mini" type="text" data-validation-engine="validate[required,custom[onlyLetterNumber]]">
			  	<label style="width: 10px;"></label>
			  	<button type="button" class="btn btn-primary" onclick="createFolder();">新建目录</button>
			  	<label style="width: 10px;"></label>
			  	<button type="button" class="btn btn-info" onclick="createTp();">创建模板</button>
			  	<label style="width: 10px;"></label>
			  	<button type="button" class="btn" id="uploadBtn">上传文件</button>
			</form>
			
			<table class="table table-striped table-bordered table-condensed" id="tpTable">
				<thead id="listHeader">
					<tr>
						<th width="40%">文件名</th>
						<th width="20%">最后修改人</th>
						<th width="25%">最后修改时间</th>
						<th width="15%" style="text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="tp" items="${list }">
					<tr>
						<td>${tp.name }</td>
						<td>${tp.updater }（${tp.updaterName }）</td>
						<td>${tp.updateTime }</td>
						<td style="text-align: center;">
							<div class="btn-group">
								<sec:authorize url="/CMS/tp/saveOrModify*.jmt">
								<button class="btn btn-info btn-mini" onclick="editTp('${tp.id }','${tp.name }')">
									<i class="nopadding icon-edit"></i>
								</button>
								</sec:authorize>
								<sec:authorize url="/CMS/tp/delete*.jmt">
								<button class="btn btn-danger btn-mini" onclick="deleteTemplate('${tp.id }','${tp.name }')">
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
	
	<form class="form-horizontal" method="post" action="<%=path%>/CMS/tp/saveOrModifyFolder.jmt" id="folderForm">
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
