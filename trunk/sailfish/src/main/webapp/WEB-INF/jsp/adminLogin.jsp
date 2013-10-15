<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <title>后台登录</title>
    <style>
        .login {
            border-width: 1px;
            border-color: #ddd;
            border-style: solid;
            margin-top: 100px;
            padding: 45px 15px 15px;
            background-color: #e7e7e7;
            border-radius: 6px 6px 6px 6px;
            box-shadow: none;
        }
    </style>


</head>


<body>
<div class="row">
    <div class="col-md-4">&nbsp;</div>
    <div class="col-md-4">
        <div class="login">
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
    <div class="col-md-4">&nbsp;</div>
</div>
</div>
</body>
</html>