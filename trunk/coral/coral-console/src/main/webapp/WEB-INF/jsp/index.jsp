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
    </script>
</head>
<body>
    <div class="easyui-layout" style="height:720px;" id="main-layout">
        <div data-options="region:'north'" style="height:100px"></div>
        <div data-options="region:'south',split:true" style="height:80px;"></div>
        <div data-options="region:'west',split:true" title="West" style="width:200px;"></div>
        <div data-options="region:'center',title:'Main Title',iconCls:'icon-ok'">
            <table class="easyui-datagrid"
                   data-options="url:'datagrid_data1.json',method:'get',border:false,singleSelect:true,fit:true,fitColumns:true">
                <thead>
                <tr>
                    <th data-options="field:'itemid'" width="80">Item ID</th>
                    <th data-options="field:'productid'" width="100">Product ID</th>
                    <th data-options="field:'listprice',align:'right'" width="80">List Price</th>
                    <th data-options="field:'unitcost',align:'right'" width="80">Unit Cost</th>
                    <th data-options="field:'attr'" width="150">Attribute</th>
                    <th data-options="field:'status',align:'center'" width="50">Status</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</body>
</html>