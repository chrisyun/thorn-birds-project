<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.setStatus(HttpServletResponse.SC_OK);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>HTTP 500</title>
    
	<style type="text/css">
	   	body {
			background-color: #4E79B2;
		}
		
		#exception {
            margin-top: 50px;
			padding: 15px 50px;
			width: 800px;
			font-size : 13pt;
			border: 1px solid black;
			background-color: yellow;
			text-align: center;
		}
		
		a{
			font-weight:bold;
			font-family:"宋体";
			font-size:18px;
		}
		
		hr {
			border-width: 2px;
			border-color: black;
		}
    </style>

  </head>
  
  <body>
  	<table align="center" width="100%">
  		<tr><td align="center"> 
  			<div id="exception">
				<h1>程序发生了错误，有可能该页面正在调试或者是设计上的缺陷.</h1><br/>
				<p>An exception was thrown: <b style="color: red;"> <%=exception.getClass()%>:<%=exception.getMessage()%></b></p><br>
				<%
					Enumeration<String> e = request.getHeaderNames();
					String key;
					while (e.hasMoreElements()) {
						key = e.nextElement();
					}
					e = request.getAttributeNames();
				%>
				<%=request.getAttribute("javax.servlet.forward.request_uri")%><br>
				<%=request.getAttribute("javax.servlet.forward.servlet_path")%>
				<p>With the following stack trace:</p>
				<pre>
			   	<%
			   		exception.printStackTrace();
			   		ByteArrayOutputStream ostr = new ByteArrayOutputStream();
			   		exception.printStackTrace(new PrintStream(ostr));
			   		out.print(ostr);
			   	%>
			   	</pre>
			   	<hr width="100%">
			</div>
    	</td></tr>
  	</table>
  </body>
</html>
