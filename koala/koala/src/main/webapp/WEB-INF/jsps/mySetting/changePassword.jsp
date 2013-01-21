<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>密码修改</title>
    <script type="text/javascript">
	$(function(){
		initValidationEngine("myPasswordForm");
	});
    
	function changeMyPassword() {
		$("#myPasswordForm").submitForm();
	}
    
    </script>
  </head>
  
  <body>
	<div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/common/mySetting/userInfo.jhtml">个人设置</a><span class="divider">/</span></li>
			<li class="active">密码修改</li>
		</ul>
	</div>
	<div class="row">
		<div class="span9">
			<form class="form-horizontal" id="myPasswordForm" 
				method="post" action="<%=path%>/common/mySetting/changeMyPassword.jmt">
				<fieldset>
					<!-- <legend>修改登录密码</legend> -->
					<div class="control-group">
						<label class="control-label" for="curPassword">当前密码：</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="curPassword" name="curPassword"
								data-validation-engine="validate[required]">
							<p class="help-block"><i class="redStar">*</i>必填，当前登录密码</p>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="newPassword">新密码：</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="newPassword" name="newPassword"
								data-validation-engine="validate[required,minSize[6],maxSize[15],custom[pwdStrength]]">
							<p class="help-block"><i class="redStar">*</i>必填，长度为6-15位</p>
							<p class="help-block"><i class="redStar">*</i>至少包含数字、特殊符号和大、小写字母中的两种</p>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="cfPassword">确认密码：</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="cfPassword" name="cfPassword"
								data-validation-engine="validate[required,equals[newPassword]]">
							<p class="help-block"><i class="redStar">*</i>必填，再次输入新密码</p>
						</div>
					</div>
					<div class="form-actions">
				    	<button class="btn btn-primary btn-large" type="button" onclick="changeMyPassword();">保存</button>
				    </div>
				</fieldset>
			</form>
		</div>
	</div>
	
  </body>
</html>
