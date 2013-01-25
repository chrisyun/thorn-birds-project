<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

// 判断是否有cookie
Cookie[] cookies = request.getCookies();
for(Cookie ck : cookies) {
	if(StringUtils.equals(ck.getName(), "SPRING_SECURITY_REMEMBER_ME_COOKIE")) {
		if(StringUtils.isNotBlank(ck.getValue())) {
			response.sendRedirect("home.jhtml");
		}
	}
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Login</title>
	
	<script type="text/javascript">
	$(function(){
		
		// 记住账户名
		var username = $.cookie("LOGIN_USERNAME");
		if(!$.utils.isEmpty(username) && $.utils.isEmpty($("#username").val())) {
			$("#username").val(username);
		}
		
		initValidationEngine("login", {
			onSuccess : function() { 
        		$.cookie("LOGIN_USERNAME", $("#username").val());
        	}
		});
		
	    <c:if test="${param.error eq true}">
	    	$("#ValidateCode").validationEngine("showPrompt" , "${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}", "error");
		</c:if>
	});
	
	function refresh() {
		$("#authImage").attr("src","<%=path %>/resources/ImageValidateCodeServlet?radom=" + Math.random());
	};
	</script>
  </head>
  
  <body>
  	<div class="container">
		<div class="row">
			<div class="span5" style="margin-top: 30px;">
				<img alt="ad" src="<%=path%>/images/xmas.jpg">
			</div>
		
			<div class="span6">
			    <form class="form-horizontal" id="login" method="post" action="<%=path%>/j_spring_security_check">
			    <fieldset>
			    	<legend>用户登录</legend>
			    	<div class="control-group">
				    	<label class="control-label">账户名</label>
				    	<div class="controls">
				    		<input type="text" class="span2" data-validation-engine="validate[required]"
				    			data-errormessage-value-missing="请输入账户名"
				    			id="username" name="j_username" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}">
				   	 	</div>
				    </div>
				    <div class="control-group">
				    	<label class="control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
				    	<div class="controls">
				    		<input type="password" class="span2" data-validation-engine="validate[required]" 
				    			data-errormessage-value-missing="请输入密码"
				    			name="j_password" id="password">
				    		<span class="help-inline">
				    			<a href="">忘记密码</a>
				    		</span>
				    	</div>
				    </div>
				    <div class="control-group">
				    	<label class="control-label">验证码</label>
				    	<div class="controls">
				    		<input type="text" class="span1" data-validation-engine="validate[required,minSize[4],maxSize[4],custom[integer]]" 
				    			data-errormessage-value-missing="请输入四位数字验证码"
				    			name="ValidateCode" id="ValidateCode">
				    		<span class="help-inline">
				    			<img alt="验证码" id="authImage" src="<%=path %>/resources/ImageValidateCodeServlet" align="middle" width="80" height="24">
				    		</span>
				    		<span class="help-inline">
				    			看不清？<a href="javascript:refresh();" title="点击刷新">换一张</a>
				    		</span>
				    	</div>
				    </div>
				    <div class="control-group">
				    	<div class="controls">
				    		<label class="checkbox inline">
				    			<input type="checkbox" name="_spring_security_remember_me">
				    			<abbr title="2周内访问我们的网站不需要登录">两周内自动登录</abbr>	
				    		</label>
				    	</div>
				    </div>
				    <div class="form-actions">
				    	<button class="btn btn-primary" type="submit">登录</button>
				    	<span class="help-inline">
				    		&nbsp;&nbsp;&nbsp;&nbsp;
				    		还没有账户？<a href="">立即注册！</a>
				    	</span>
				    </div>
			    </fieldset>
			    </form>
			</div>
			
		</div>
	</div>
</body>
</html>
