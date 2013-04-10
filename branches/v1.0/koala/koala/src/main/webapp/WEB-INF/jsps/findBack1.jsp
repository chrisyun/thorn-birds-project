<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>找回密码</title>
    <script type="text/javascript">
    $(function(){
    	initValidationEngine("findPwdForm");
    });
    
    function findBack() {
    	$("#findPwdForm").submitForm({
			onSuccess : function(msg) {
				$.dialog.alertSuccess(msg, "身份验证成功", function() {
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
    		<form class="form-horizontal" id="findPwdForm" 
				method="post" action="<%=path%>/html/verifyIdentity.jmt">
				<fieldset>
					<legend>找回密码</legend>
					<div class="control-group">
						<label class="control-label">登录账号：</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="userId" name="userId"
								data-validation-engine="validate[required]">
							<span class="help-block"><i class="redStar">*</i>必填</span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">注册邮箱：</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="email" name="email"
								data-validation-engine="validate[required,maxSize[50],custom[email]]">
							<span class="help-block"><i class="redStar">*</i>必填</span>
						</div>
					</div>
					<div class="form-actions">
				    	<button class="btn btn-primary btn-large" type="button" onclick="findBack();">提交</button>
				    </div>
				</fieldset>
			</form>
    	</div>
    </div>
  </body>
</html>
