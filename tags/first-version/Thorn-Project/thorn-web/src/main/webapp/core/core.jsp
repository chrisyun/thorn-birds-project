<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.cy.thorn.security.UserSecurity"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.cy.thorn.user.entity.User"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Authentication auth = SecurityContextHolder.getContext().getAuthentication();
String userid = "";
String username = "";
String usermail = "";
String userTel = "";

if(auth != null) {
	UserSecurity us = (UserSecurity) auth.getPrincipal();
	User user = us.getUser();
	userid = user.getUserid();
	username = user.getUname();
	usermail = user.getCumail();
	userTel = user.getPhone();
}

%>
<jsp:include page="ext.jsp"></jsp:include>

<script type="text/javascript">
	var sys = {
		path		: "<%=path%>",
		basePath	: "<%=basePath%>"
	};

	var user = {
		userid 		: "<%=userid%>",
		username 	: "<%=username%>",
		usermail 	: "<%=usermail%>",
		userTel 	: "<%=userTel%>"
	}

</script>