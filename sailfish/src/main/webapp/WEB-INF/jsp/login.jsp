<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <title>后台登录</title>


</head>


<body>
<div class="row">
    <div class="col-md-4">&nbsp;</div>
    <div class="col-md-4">
        <div class="panel panel-primary" style="margin-top: 100px;">
            <div class="panel-heading">
                <h3 class="panel-title">系统登录</h3>
            </div>
            <div class="panel-body">
                <form action="/am/login" method="post" role="form">
                    <div class="form-group">
                        <label for="username">用户名</label>
                        <input type="text" class="form-control" name="username" id="username" placeholder="输入用户名">
                    </div>
                    <div class="form-group">
                        <label for="username">密码</label>
                        <input type="password" class="form-control" name="password" id="password" placeholder="输入密码">

                        <p class="help-block">${error}</p>
                    </div>
                    <button type="submit" class="btn btn-default">登 录</button>
                </form>
            </div>
        </div>
    </div>
    <div class="col-md-4">&nbsp;</div>
</div>
</div>
</body>
</html>