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
							<input type="password" class="input-large" id="curPassword" name="curPassword"
								data-validation-engine="validate[required]">
							<p class="help-block"><i class="redStar">*</i>必填，当前登录密码</p>
						</div>
					</div>
				
				
				</fieldset>
			</form>
		</div>
	</div>
	
  </body>
</html>
