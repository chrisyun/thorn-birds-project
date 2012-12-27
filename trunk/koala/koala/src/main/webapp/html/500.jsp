<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.setStatus(HttpServletResponse.SC_OK);
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <base href="<%=basePath%>">
    
    <title>HTTP 500</title>
    
    <link href="<%=path %>/plugins/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="<%=path %>/plugins/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
	
	<script type="text/javascript" src="<%=path %>/plugins/jquery/jquery-1.8.2.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/bootstrap/js/bootstrap.js"></script>
	
	<script type="text/javascript" src="<%=path %>/plugins/func/system.js"></script>
    <script type="text/javascript">
    $(function(){
    	$("#msg").val(Server.HTMLEncode("11111"));
    });
    
    </script>
    
    
  </head>
  
  <body>
  	<!-- http://kaminlee.iteye.com/blog/1144727 -->
	<div class="container">
		<c:import url="/WEB-INF/jsps/ref/header_1.jsp"></c:import>
		<div class="row" style="padding-top: 30px;">
			<div class="span10 offset1">
				<div class="hero-unit">
					<h3>十分抱歉，您请求的页面出现了错误！</h3>
					<p>可能的错误原因：</p>
					<p>系统当前正在升级，请您耐心等待，半小时后重新访问。</p>
					<p>
						<a class="btn btn-primary btn-large" href="<%=path %>">点击这里返回主页</a>
					</p>
					<p>以下是详细的错误信息：</p>
    				<pre id="msg">
    					<%=exception.getMessage().replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>
    				</pre>
    				<%
    					StackTraceElement[] stArray = exception.getStackTrace();
    					StringBuilder errorMsg = new StringBuilder();
    					for(StackTraceElement st : stArray) {
    						errorMsg.append("at ").append(st.getClassName()).append(".");
    						errorMsg.append(st.getMethodName()).append("(");
    						errorMsg.append(st.getFileName()).append(":");
    						errorMsg.append(st.getLineNumber()).append(")").append("\n");
    					}
    				%>
    				<pre><%=errorMsg.toString() %></pre>
				</div>
			</div>
		</div>
    </div>
  	
 	<c:import url="/WEB-INF/jsps/ref/footer_1.jsp"></c:import>
  </body>
</html>
