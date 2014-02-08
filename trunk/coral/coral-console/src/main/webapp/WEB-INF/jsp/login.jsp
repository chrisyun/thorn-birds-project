<%--
  Created by IntelliJ IDEA.
  User: yfchenyun
  Date: 14-2-8
  Time: 下午2:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Coral - Login</title>

    <script type="text/javascript">
        function reset() {
            $('#loginForm').form('clear');
        }
    </script>
</head>

<body>
<div style="margin: 0 auto;width: 400px;padding-top: 130px;">
    <div class="easyui-panel" title="Coral - Login" style="width:350px;height:200px;padding:10px;">
        <form action="/index" method="post" id="loginForm">
            <table>
                <tr>
                    <td width="40%" align="right">用户名：</td>
                    <td width="60%"><input class="easyui-validatebox" type="text" name="username"
                                           data-options="required:true" value="Administrator" /></td>
                </tr>
                <tr>
                    <td align="right">密&nbsp;&nbsp;码：</td>
                    <td><input class="easyui-validatebox" type="password" name="password"
                               data-options="required:true" value="_PL<)OKM" /></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td style="color: red;">${error}</td>
                </tr>
            </table>
            <div style="text-align:center;padding:5px">
                <input type="submit" value="登录">
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="reset()">重置</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>