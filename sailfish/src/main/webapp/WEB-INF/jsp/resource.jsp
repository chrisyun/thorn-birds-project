<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>管理后台 - 资源与模板</title>
    <script type="text/javascript">
        $(function() {

            $("#mkdirBtn").click(function() {
                var dir = $("#newDir").val();
                var p = "${p}";

                if(dir == "") {
                    $.dialog.alertInfo("请填写目录名称", "提示");
                    $("#newDir").focus();
                    return ;
                }

                $.request.ajax({
                    url : "/am/rs/createFolder",
                    data : {p : p, dir : dir},
                    onSuccess : function(msg, data) {
                        $.dialog.alertSuccess(msg, "请求处理成功", function(){
                            $.utils.refreshPage();
                        });
                    }
                });
            });

            $("#dirForm").formDialog({
                title : "修改目录名",
                width : 430,
                buttons : [{
                    text : "保存",
                    cls : "btn-primary",
                    click : function() {
                        var refreshPage = "/am/rs/index?p=${folder.parent}" + $("#renameDir").val()
                        $("#dirForm").submitForm({
                            progress : false,
                            onSuccess : function(msg, data) {
                                $("#dirForm .alert").removeClass("hidden");
                                $("#dirForm .alert").removeClass("alert-danger");
                                $("#dirForm .alert").addClass("alert-success");
                                $("#dirForm .alert").html(msg);
                                setTimeout(function(){
                                    $.utils.toUrl(refreshPage);
                                }, 800);
                            },
                            onFailure : function(msg, data) {
                                $("#dirForm .alert").removeClass("hidden");
                                $("#dirForm .alert").addClass("alert-danger");
                                $("#dirForm .alert").html(msg);
                            }
                        })
                    }
                }, {
                    text : "关闭",
                    closed : true
                }]
            });

            $("#renameDirBtn").click(function() {
                $("#dirForm").formDialog("show");
            });

            $("#uploadForm").formDialog({
                title : "上传文件",
                width : 430,
                buttons : [{
                    text : "上传",
                    cls : "btn-primary",
                    click : function() {
                        $("#uploadForm").submitForm({
                            progress : false,
                            onSuccess : function(msg, data) {
                                $("#uploadForm").formDialog("close");
                                $.dialog.alertSuccess(msg, "请求处理成功", function(){
                                    $.utils.refreshPage();
                                });
                            },
                            onFailure : function(msg, data) {
                                $("#uploadForm").formDialog("close");
                                $.dialog.alertError(msg, "请求处理失败");
                            }
                        })
                    }
                }, {
                    text : "关闭",
                    closed : true
                }]
            });

            $("#uploadBtn").click(function() {
                $("#uploadForm").formDialog("show");
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
        <div class="panel panel-info">
            <div class="panel-heading">
                <h4 class="panel-title">
                    ${folder.name}<span class="badge pull-right">${folder.fileNumber}</span>
                </h4>
            </div>
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
    <div class="col-md-9">

        <div class="panel panel-primary">
            <div class="panel-heading">
                <div class="panel-title">
                    <form class="form-inline" role="form">
                        <div class="form-group">
                            <span>当前目录：${p}/</span>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control pt5 pb5" id="newDir" placeholder="新建目录">
                        </div>
                        <div class="form-group">
                            <button type="button" id="mkdirBtn" class="btn btn-warning btn-sm">新建</button>
                        </div>
                        <div class="form-group pull-right">
                        <c:if test="${not empty folder.parent and folder.path != 'CMS/FLT'}">
                            <a href="#" id="renameDirBtn" class="btn btn-primary btn-sm">修改目录名</a>
                            <span class="pull-right">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        </c:if>
                            <a href="#" id="uploadBtn" class="btn btn-success btn-sm">上传文件</a>
                        </div>
                    </form>
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
                            <td><fmt:formatNumber pattern="#,#0.0#" value="${resource.size/1024}" />&nbsp;KB</td>
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

<form role="form" action="/am/rs/renameFolder" method="post" id="dirForm">
    <div class="form-group">
        <label for="renameDir" class="control-label">目录名称</label>
        <div class="input-group">
            <span class="input-group-addon">${folder.parent}</span>
            <input type="hidden" name="p" value="${p}">
            <input type="text" class="form-control" name="renameDir" value="${folder.name}" id="renameDir" placeholder="输入目录名称">
        </div>
        <span class="help-block"><i class="redStar">*</i>必填，目录名称不得与现有目录名称重复</span>
        <div class="alert mb0 hidden"></div>
    </div>
</form>

<form class="form-horizontal" role="form" action="/am/rs/uploadFile" method="post" id="uploadForm">
    <div class="form-group">
        <label class="col-sm-3 control-label">上传目录</label>
        <div class="input-group col-sm-9">
            <p class="form-control-static">${p}/</p>
            <input type="hidden" name="p" value="${p}">
        </div>
    </div>
    <div class="form-group">
        <label for="fileTxt" class="col-sm-3 control-label">选择文件</label>
        <div class="col-sm-9">
            <input type="file" name="file" id="fileTxt"  class="form-control">
        </div>
    </div>
</form>

</body>
</html>