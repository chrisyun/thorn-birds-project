<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理后台 - 资源与模板</title>
    <script type="text/javascript">
        $(function() {

            $("#dirForm").formDialog({
                title : "新建目录",
                width : 430,
                buttons : [{
                    text : "保存",
                    cls : "btn-primary"
                }, {
                    text : "关闭",
                    closed : true
                }]
            });

            $("#mkdirBtn").click(function() {
                $("#dirForm").formDialog("show");
            });
        });


    </script>
</head>

<body>

<ol class="breadcrumb">
    <li>当前位置：后台管理</li>
    <li class="active">资源与模板</li>
</ol>

<div class="row">
    <div class="col-md-3">
        <div class="panel-group" id="accordion">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                            ${folder.name}<span class="badge pull-right">${folder.fileNumber}</span>
                        </a>
                    </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <ul class="nav nav-pills nav-stacked">
                        <c:if test="${not empty folder.parent}">
                                <li>
                                    <a href="/am/rs/index?p=${folder.parent}">
                                        <span class="glyphicon glyphicon-share-alt"></span>
                                        &nbsp;&nbsp;&nbsp;&nbsp;返回上级目录
                                    </a>
                                </li>
                        </c:if>
                        <c:forEach var="child" items="${folder.childFolders}">
                                <li class="active">
                                    <a href="/am/rs/index?p=${child.path}">
                                        <span class="glyphicon glyphicon-folder-open"></span>
                                        &nbsp;&nbsp;&nbsp;&nbsp;${child.name}<span class="badge pull-right">${child.fileNumber}</span>
                                    </a>
                                </li>
                        </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-9">

        <div class="panel panel-primary">
            <div class="panel-heading">
                <div class="panel-title">
                    <span>当前目录：${p}</span>
                    <a href="#" class="btn btn-success btn-xs pull-right">上传文件</a>
                    <span class="pull-right">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <a href="#" id="mkdirBtn" class="btn btn-info btn-xs pull-right">新建目录</a>
                </div>
            </div>
            <div class="panel-body">
                <table class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                        <tr>
                            <th width="40%">文件名</th>
                            <th width="15%">文件大小</th>
                            <th width="30%">上次修改时间</th>
                            <th width="15%">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="resource" items="${resources}">
                        <tr>
                            <td>${resource.name}</td>
                            <td>${resource.size}</td>
                            <td>${resource.lastModifyTime}</td>
                            <td>
                                <a href="#"><span class="glyphicon glyphicon-edit mr10 ml20"></span></a>
                                <a href="#"><span class="glyphicon glyphicon-trash mr10 ml20"></span></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<form role="form" action="" method="post" id="dirForm">
    <div class="form-group">
        <label for="folder" class="control-label">目录名称</label>
        <div class="input-group">
            <span class="input-group-addon">${p}/</span>
            <input type="text" class="form-control" name="folder" id="folder" placeholder="输入目录名称">
        </div>
        <span class="help-block"><i class="redStar">*</i>必填，目录名称不得与现有目录名称重复</span>
    </div>
</form>



</body>
</html>