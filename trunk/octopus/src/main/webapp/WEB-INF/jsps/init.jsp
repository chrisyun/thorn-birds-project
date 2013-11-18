<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>初始化octopus系统</title>
    <script type="text/javascript">
        function initSys() {

        }
    </script>
</head>

<body>
<div style="position: absolute;top: 30%;left: 40%">

    <div class="easyui-panel" title="设置管理员账号" style="width:300px;height:200px;padding:10px;">
        <div>
            <form id="initForm" action="/init" method="post">
                <table>
                    <tr>
                        <td>用户名：</td>
                        <td><input name="userId" type="text" size="30" class="easyui-validatebox" data-options="required:true">
                        </td>
                    </tr>
                    <tr>
                        <td>密&nbsp;&nbsp;码：</td>
                        <td><input name="password" type="password" size="30" class="easyui-validatebox"
                                   data-options="required:true">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div style="text-align:center;padding:30px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="initSys()">进行系统初始化</a>
        </div>
    </div>
</div>
</body>
</html>