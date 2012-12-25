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
    <base href="<%=basePath%>">
    
    <title>Login</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript">
	$(function(){
		// 记住账户名
		var username = $.cookie.get("LOGIN_USERNAME");
		if(!$.utils.isEmpty(username) && $.utils.isEmpty($("#username").val())) {
			$("#username").val(username);
		}
		
		
	});
	
	function login() {
		if($("#remberUser").attr("checked") == "checked") {
			$.cookie.add("LOGIN_USERNAME", $("#username").val());
		}
		
		
		
		$("#login").submit();
	}
	
	</script>
	
	
  </head>
  
  <body>
	<form id="login" action="<%=path%>/j_spring_security_check">
		<table>
			<tr>
				<td colspan="4" id="errorMsg">
				<c:if test="${param.error eq true}">
					${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}
				</c:if>
				</td>
			</tr>
			<tr>
				<td>账户名：</td>
				<td colspan="2"><input type="text" maxlength="100" 
					name="j_username" id="username" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}"></td>
				<td></td>
			</tr>
			<tr>
				<td>密码：</td>
				<td colspan="2"><input type="password" maxlength="100" name="j_password" id="password"></td>
				<td></td>
			</tr>
			<tr>
				<td>验证码：</td>
				<td><input type="text" maxlength="4" name="ValidateCode" id="ValidateCode"></td>
				<td><div>
						<img alt="验证码" id="authImage" src="<%=path %>/resources/ImageValidateCodeServlet" align="middle" width="80" height="24" />&nbsp;
						<a href="javascript:refresh();">看不清</a>
					</div>
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="checkbox" id="remberUser" checked="checked"><label>记住账号名</label>
					<input type="checkbox" name="_spring_security_remember_me"><label>两周内自动登录</label>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="button" value="登录" onclick="login();">
					<a href="">忘记密码</a>
					<a href="">注册新用户</a>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
