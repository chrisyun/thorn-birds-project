<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    	
    	
    });
    
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
			<form class="form-horizontal" id="myPasswordForm" 
				method="post" action="<%=path%>/common/mySetting/changeMyPassword.jmt">
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="curPassword">当前文件名：</label>
						<div class="controls">
							<input type="text" class="input-large" id="name" name="name"
								data-validation-engine="validate[required]">
							<input type="hidden" name="id" value="">
							<input type="hidden" name="folder" value="">
							<p class="help-block"><i class="redStar">*</i>必填，不得与其他文件重名</p>
						</div>
					</div>
					<div class="control-group">
						<div class="controls">
							<textarea rows="50" class="span9"></textarea>
						</div>
					</div>
					<div class="form-actions">
				    	<button class="btn btn-primary btn-large" type="button" onclick="save();">保存</button>
				    </div>
				</fieldset>
			</form>
		</div>
	</div>
	
  </body>
</html>
