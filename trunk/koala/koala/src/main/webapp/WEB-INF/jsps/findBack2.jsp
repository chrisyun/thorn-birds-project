<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>重置密码</title>
	<script type="text/javascript">
	$(function(){
		initValidationEngine("findPwdForm");
	});
	 function changeMyPassword() {
    	$("#findPwdForm").submitForm({
			onSuccess : function(msg) {
				$.dialog.alertSuccess(msg, "密码修改成功", function() {
					window.location.href = "<%=path%>";
				});
			}
		});
    }
	</script>
	
	
  </head>
  
  <body>
  	<div class="row">
    	<div class="offset2 span6">
	<c:choose>
		<c:when test="${status.success == false }">
			<form class="form-horizontal">
				<fieldset>
					<legend>重置密码</legend>
					<h3>${status.message }</h3>
				</fieldset>
			</form>
		</c:when>
		<c:when test="${status.success == true }">
			<form class="form-horizontal" id="findPwdForm" 
				method="post" action="<%=path%>/html/modifyMyPwd.jmt">
				<fieldset>
					<legend>重置密码</legend>
					<div class="control-group">
						<label class="control-label" for="newPassword">新密码：</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="pwd" name="pwd"
								data-validation-engine="validate[required,minSize[6],maxSize[15],custom[pwdStrength]]">
							<p class="help-block"><i class="redStar">*</i>必填，长度为6-15位</p>
							<p class="help-block"><i class="redStar">*</i>至少包含数字、特殊符号和大、小写字母中的两种</p>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="cfPassword">确认密码：</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="cfPassword" name="cfPassword"
								data-validation-engine="validate[required,equals[pwd]]">
							<p class="help-block"><i class="redStar">*</i>必填，再次输入新密码</p>
						</div>
					</div>
					<div class="form-actions">
						<input type="hidden" name="captcha" value="${captcha }">
						<input type="hidden" name="userId" value="${finder }">
				    	<button class="btn btn-primary btn-large" type="button" onclick="changeMyPassword();">保存</button>
				    </div>
				</fieldset>
			</form>
		</c:when>
	</c:choose>
    	</div>
    </div>
  </body>    
</html>
