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
    
    <title>编辑模板</title>
    <script type="text/javascript">
    $(function(){
    	<sec:authorize url="/CMS/tp/saveOrModify*.jmt">
    	$("#content").on("keydown", function(e) {
    		e = e || window.event;
    		if( (e.keyCode == 115 || e.keyCode == 83) && e.ctrlKey) {
    			save();
    			return false; 
    		}
    	});
    	</sec:authorize>
    	
    	initValidationEngine("templateForm");
    });
    
    function save() {
    	$("#templateForm").submitForm({
    		onSuccess : function(msg) {
				$.dialog.alertSuccess(msg, "操作成功", function() {
					window.location.href = "<%=path%>/CMS/tp/queryTemplates.jhtml?folder=" + $("#folder").val();
				});
			}
    	});
    }
    
    </script>
    
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/CMS/index.jhtml">内容发布</a><span class="divider">/</span></li>
			<li><a href="<%=path%>/CMS/tp/queryTemplates.jhtml">模板管理</a><span class="divider">/</span></li>
			<li class="active">编辑模板</li>
		</ul>
	</div>
	
	<div class="row">
		<div class="span12">
			<form class="form-horizontal" id="templateForm" 
				method="post" action="<%=path%>/CMS/tp/saveOrModifyTemplate.jmt">
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="name" style="text-align: left;width: 100px;">当前文件名：</label>
						<div class="controls" style="margin-left: 100px;">
							<div class="input-prepend">
								<span class="add-on"><%=CMSConfiguration.TEMPLATE_ROOT %>${folder }/</span>
								<input type="text" class="input-medium" id="name" name="name" value="${template.name }"
									data-validation-engine="validate[required]">
							</div>
							<input type="hidden" name="id" value="${template.id }">
							<input type="hidden" name="folder" id="folder" value="${folder }">
							<p class="help-inline"><i class="redStar">*</i>必填，不得与其他文件重名（按Ctrl + s快速保存）</p>
							<a style="float: right;" class="btn btn-info" href="<%=path%>/CMS/tp/queryTemplates.jhtml?folder=${folder}">返回模板列表</a>
						</div>
					</div>
					<div class="control-group">
						<textarea rows="30" class="span12" id="content" name="content">${template.content }</textarea>
					</div>
					<sec:authorize url="/CMS/tp/saveOrModify*.jmt">
					<div class="form-actions">
				    	<button class="btn btn-primary btn-large" type="button" onclick="save();">保存</button>
				    </div>
				    </sec:authorize>
				</fieldset>
			</form>
		</div>
	</div>
	
  </body>
</html>
