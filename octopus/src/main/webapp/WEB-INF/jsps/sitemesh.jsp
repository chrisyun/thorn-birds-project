<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

    String thisUrl = request.getServletPath();
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <base href="<%=basePath%>">

    <title><decorator:title default="octopus"/></title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="<%=path%>/plugins/easyui/themes/icon.css">
    <link rel="stylesheet" href="<%=path%>/plugins/easyui/themes/default/easyui.css">

    <script src="<%=path%>/plugins/jquery.min.js" type="text/javascript"></script>
    <script src="<%=path%>/plugins/easyui/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="<%=path%>/plugins/easyui/jquery.easyui.min.js" type="text/javascript"></script>
    <decorator:head />

</head>

<body>
    <decorator:body />
</body>
</html>