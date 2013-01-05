<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>密码修改</title>
    
  </head>
  
  <body>
    <div class="container">
		<ul class="breadcrumb">
			<li><a href="<%=path%>">个人设置</a><span class="divider">/</span></li>
			<li class="active">密码修改</li>
		</ul>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="span6 offset2">
				<form class="form-horizontal">
					<fieldset>
						<legend>修改登录密码</legend>
						<div class="control-group">
							<label class="control-label" for="curPassword">当前密码</label>
							<div class="controls">
								<input type="password" class="input-xlarge" id="curPassword" name="curPassword">
								<p class="help-block">请输入当前登录密码</p>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="input01">新密码</label>
							<div class="controls">
								<input type="password" class="input-xlarge" id="newPassword" name="newPassword">
								<p class="help-block">数字、字母、符号均可</p>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="input01">确认密码</label>
							<div class="controls">
								<input type="password" class="input-xlarge" id="cfPassword" name="cfPassword">
								<p class="help-block">请再次输入新密码</p>
							</div>
						</div>
						<div class="form-actions">
					    	<button class="btn btn-primary" type="submit">保存</button>
					    </div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
	
	
  </body>
</html>
