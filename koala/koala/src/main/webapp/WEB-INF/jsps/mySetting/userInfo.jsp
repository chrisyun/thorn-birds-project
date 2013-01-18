<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>个人资料修改</title>
    
    <script type="text/javascript">
	$(function(){
		$("#area").initDDBox({
			array : <thorn:dd  typeId="AREA" />,
			defaultValue : "${user.area }",
			box : "text"
		});
		
		initValidationEngine("userForm");
	});
	
	function changeMyInfo() {
		$("#userForm").submitForm();
	}
	
    </script>
  </head>
  
  <body>
	<div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/common/mySetting/userInfo.jhtml">个人设置</a><span class="divider">/</span></li>
			<li class="active">个人资料修改</li>
		</ul>
	</div>
	<div class="row">
		<div class="span10">
			<form class="form-horizontal" id="userForm" 
				method="post" action="<%=path%>/common/mySetting/changeMyInfo.jmt">
				<fieldset>
					<!-- <legend>修改登录密码</legend> -->
					<div class="control-group">
						<label class="control-label">用户名：</label>
						<div class="controls">
							<span class="input-xlarge uneditable-input">${user.userId }</span>
							<span class="help-inline">登录用户名</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">姓名：</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="userName" name="userName"
								value="${user.userName }" data-validation-engine="validate[maxSize[20]]">
							<span class="help-inline">中、英文皆可</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">性别：</label>
						<div class="controls">
							<label class="radio inline">
                				<input type="radio" ${user.gender eq 'male' ? 'checked':'' } value="male" 
                					 data-validation-engine="validate[required]" id="gender-m" name="gender">男
			              	</label>
			              	<label class="radio inline">
                				<input type="radio" ${user.gender eq 'femme' ? 'checked':'' } value="femme" 
                					 data-validation-engine="validate[required]" id="gender-f" name="gender">女
			              	</label>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">单位：</label>
						<div class="controls">
							<span class="input-xlarge uneditable-input">${user.orgName }</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">单位地址：</label>
						<div class="controls">
							<span class="input-xlarge uneditable-input" id="area"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">邮箱：</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="cumail" name="cumail"
								value="${user.cumail }" data-validation-engine="validate[required,maxSize[50],custom[email]]">
							<span class="help-inline"><i class="redStar">*</i>必填，您可以通过邮箱找回密码</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">联系方式：</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="phone" name="phone"
								value="${user.phone }" data-validation-engine="validate[required,custom[phone]]">
							<span class="help-inline"><i class="redStar">*</i>必填，便于我们联系您</span>
						</div>
					</div>
					
					<div class="form-actions">
				    	<button class="btn btn-primary" type="button" onclick="changeMyInfo();">保存</button>
				    </div>
				</fieldset>
			</form>
		</div>
	</div>
	
  </body>
</html>
