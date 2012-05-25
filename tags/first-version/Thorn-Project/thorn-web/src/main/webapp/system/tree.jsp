<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String parentId = request.getParameter("parentId");
String json = "";
if("root".equals(parentId)) {
	json = "[{id:\"bj\",text:\"北京\"},{id:\"sc\",text:\"四川\"}]";
} else if("bj".equals(parentId)) {
	json = "[{id:\"hd\",text:\"海淀\",leaf:true},{id:\"xc\",text:\"西城\",leaf:true}]";
} else if("sc".equals(parentId)) {
	json = "[{id:\"cd\",text:\"成都\",leaf:true},{id:\"my\",text:\"绵阳\",leaf:true}]";
}

out.print(json);

%>


