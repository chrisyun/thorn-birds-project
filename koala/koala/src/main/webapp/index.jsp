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
			response.sendRedirect("/home.jhtml");
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
		var username = $.cookie.get("LOGIN_USERNAME");
		if(!$.utils.isEmpty(username) && $.utils.isEmpty($("#username").val())) {
			$("#username").val(username);
		}
		
	    $("#login").validationEngine({ 
	    	promptPosition: "bottomLeft",
	    	autoHideDelay : 4000,
	    	autoHidePrompt : true,
	    	failure :  false,
        	success : function() { 
        		$.cookie.add("LOGIN_USERNAME", $("#username").val());
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
	
	<style type="text/css">
	.footer {
		border-top: 3px solid #C1D1EA;
		color: #808080;
		font-size: 12px;
		font-family: Arial;
	}
	</style>
  </head>
  
  <body>
  	<div class="container">
		<div class="row">
			<div class="span2 offset2"><img alt="logo" style="padding-top: 10px;padding-bottom: 10px;" src="<%=path%>/images/logo.png"></div>
			<div class="span6"><img alt="广告" style="width: 900px;height: 80px;" src="<%=path%>/images/40a5d2a8jw1e01971ub28j.jpg"></div>
		</div>
		<div class="row">
			<div class="span8 offset2">
				<hr style="border-color: red;margin-top: 0px;margin-bottom: 0px;">
			</div>
		</div>
		<div class="row">
			<div class="span3 offset2">
				<img src="<%=path%>/images/xmas.jpg" style="width: 300px;height: 340px;padding-top: 5px;">
			</div>
			<div class="span5">
			    <form class="form-horizontal" id="login" method="post" action="<%=path%>/j_spring_security_check">
			    <fieldset>
			    	<legend>用户登录</legend>
			    	<div class="control-group">
				    	<label class="control-label" for="input01">账户名</label>
				    	<div class="controls">
				    		<input type="text" class="span2" data-validation-engine="validate[required]"
				    			data-errormessage-value-missing="请输入账户名"
				    			id="username" name="j_username" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}">
				   	 	</div>
				    </div>
				    <div class="control-group">
				    	<label class="control-label" for="input01">密码</label>
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
				    	<label class="control-label" for="input01">验证码</label>
				    	<div class="controls">
				    		<input type="text" class="span1" data-validation-engine="validate[required,minSize[4],maxSize[4],custom[integer]]" 
				    			data-errormessage-value-missing="请输入四位数字验证码"
				    			name="ValidateCode" id="ValidateCode">
				    		<span class="help-inline">
				    			<img alt="验证码" id="authImage" src="<%=path %>/resources/ImageValidateCodeServlet" align="middle" width="80" height="24">
				    		</span>
				    		<span class="help-inline">
				    			<a href="javascript:refresh();" title="点击刷新">看不清</a>
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
	
	<div class="footer">
		<div class="container">
			<div class="row">
				<div class="span2 offset2">
					<img alt="logo" style="padding-top: 10px;padding-bottom: 10px;" src="<%=path%>/images/logo.png">
				</div>
				<div class="span8">
					<div class="row">
						<div class="span8" style="padding-top: 10px;padding-bottom: 5px;">版权所有 © 2012 Mozilla Firefox. 北京谋智火狐信息技术有限公司 京 ICP备11011334号-1</div>
					</div>
					<div class="row">
						<div class="span8" style="padding-top: 5px;padding-bottom: 10px;">联系我们：请发邮件至moc.allizom@uohzc 主页修复 新版意见反馈 申请收录</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>
