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
    <title>新用户注册</title>
    
    <script type="text/javascript">
    $(function(){
    	$(".renderer-area").renderer({
			renderArray : <thorn:dd  typeId="AREA" />
		});
    	
    	initValidationEngine("userForm");
    });
    
	function register() {
		$("#userForm").submitForm({
			onSuccess : function(msg) {
				$.dialog.alertSuccess(msg, "用户注册成功", function() {
					window.location.href = "<%=path%>";
				});
			}
		});
	}
    
    </script>
    
  </head>
  
  <body>
    <div class="row">
    	<div class="offset2 span8">
    		<form class="form-horizontal" id="userForm" 
				method="post" action="<%=path%>/html/registerUser.jmt">
				<fieldset>
					<legend>新用户注册</legend>
					<div class="control-group">
						<label class="control-label">姓名：</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="userName" name="userName"
								data-validation-engine="validate[maxSize[20]]">
							<span class="help-inline">中、英文皆可</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">性别：</label>
						<div class="controls">
							<label class="radio inline">
                				<input type="radio" value="male" checked id="gender-m" name="gender">男
			              	</label>
			              	<label class="radio inline">
                				<input type="radio" value="femme" id="gender-f" name="gender">女
			              	</label>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">单位地址：</label>
						<div class="controls">
							<select name="orgCode" class="input-xlarge renderer-area" 
								data-validation-engine="validate[required]"></select>
							<span class="help-inline"><i class="redStar">*</i>必填</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">邮箱：</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="cumail" name="cumail"
								data-validation-engine="validate[required,maxSize[50],custom[email]]">
							<span class="help-inline"><i class="redStar">*</i>必填，您可以通过邮箱找回密码</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">联系方式：</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="phone" name="phone"
								data-validation-engine="validate[required,custom[phone]]">
							<span class="help-inline"><i class="redStar">*</i>必填，便于我们联系您</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="userPwd">登录密码：</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="userPwd" name="userPwd"
								data-validation-engine="validate[required,minSize[6],maxSize[15],custom[pwdStrength]]">
							<p class="help-inline"><i class="redStar">*</i>必填，长度为6-15位</p>
							<p class="help-block"><i class="redStar">*</i>至少包含数字、特殊符号和大、小写字母中的两种</p>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="cfPassword">确认密码：</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="cfPassword" name="cfPassword"
								data-validation-engine="validate[required,equals[userPwd]]">
							<p class="help-inline"><i class="redStar">*</i>必填，再次输入密码</p>
						</div>
					</div>
					<div class="form-actions">
				    	<button class="btn btn-primary btn-large" type="button" onclick="register();">保存</button>
				    </div>
				</fieldset>
			</form>
    	
    	</div>
    </div>
  </body>
</html>
