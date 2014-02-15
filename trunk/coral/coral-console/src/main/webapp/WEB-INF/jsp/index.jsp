<%--
  Created by IntelliJ IDEA.
  User: yfchenyun
  Date: 14-2-8
  Time: 下午3:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Coral - Index</title>



    <script type="text/javascript">
        $(function() {
            $(window).resize(function(){
                $('#main-layout').layout('resize');
            });
        });

        function addPanel(title, src) {

            if($("#mainTabs").tabs("exists",title)) {
                $("#mainTabs").tabs("select", title);
            } else {
                $("#mainTabs").tabs("add", {
                    title : title,
                    closable : true,
                    content : '<iframe width="100%" height="100%" frameborder="0" ' +
                            'src="' + src + '"></iframe>'
                });
            }
        }
    </script>
</head>
<body>
    <div class="easyui-layout" style="height:720px;" id="main-layout">
        <div data-options="region:'north'" style="height:100px">
            <p class="logo-font">Welcome to Coral console.</p>
            <p class="logo-setting">
                当前用户：${sessionScope.sessionUser.userName}&nbsp;&nbsp;<a href="#">注销</a>
            </p>
        </div>

        <div data-options="region:'south',split:true" style="height:80px;">
            <p class="foot-font">Coral - <a href="http://zh.wikipedia.org/zh-cn/%E7%8F%8A%E7%91%9A">珊瑚</a>
                本网站使用<a href="http://www.jeasyui.com/">jQuery EasyUI</a>构建</p>
            <p class="foot-font">Powered By C.y_Chris</p>
        </div>

        <div data-options="region:'west',split:true" title="菜单栏" style="width:200px;">
            <ul class="easyui-tree">
                <li>
                    <span>Coral控制台</span>
                    <ul>
                        <li>
                            <span>任务管理</span>
                            <ul>
                                <li><a href="javascript:void(0)" onclick="addPanel('定义新任务', 'http://www.baidu.com')">定义新任务</a></li>
                                <li><a href="javascript:void(0)" onclick="addPanel('查看任务', 'http://www.baidu.com')">查看任务</a></li>
                                <li><a href="javascript:void(0)" onclick="addPanel('查看任务结果', 'http://www.baidu.com')">查看任务结果</a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0)" onclick="addPanel('Agent列表', 'http://www.baidu.com')">Agent列表</a></li>
                        <li>
                            <span>Jar包管理</span>
                            <ul>
                                <li><a href="javascript:void(0)" onclick="addPanel('定义位置', 'http://www.baidu.com')">定义位置</a></li>
                                <li><a href="javascript:void(0)" onclick="addPanel('查看位置', 'http://www.baidu.com')">查看位置</a></li>
                                <li><a href="javascript:void(0)" onclick="addPanel('上传Jar包', 'http://www.baidu.com')">上传Jar包</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>

        <div id="mainTabs" data-options="region:'center'" class="easyui-tabs" style="border: 0;">

            <div title="首页" style="padding: 10px;">
                <p style="font-size:14px">jQuery EasyUI framework helps you build your web pages easily.</p>
            </div>

        </div>
    </div>
</body>
</html>