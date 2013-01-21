<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>数据字典管理</title>
	<script type="text/javascript">
	$(function(){
		$("#pagingBar").page({
			totalSize : ${page.total},
			pageIndex : ${page.pageIndex}
		});
	});
	
	</script>
	
	
  </head>
  
  <body>
    <div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/System/index.jhtml">系统管理</a><span class="divider">/</span></li>
			<li class="active">数据字典管理</li>
		</ul>
	</div>
	
	<div class="row">
		<div class="span12">
			<form class="form-search">
				<label>字典类型编码：</label>
			  	<input type="text" name="ename" class="input-medium">
			  	<label style="width: 40px;"></label>
			  	<label>字典类型名称：</label>
			  	<input type="text" name="cname" class="input-medium">
			  	<button type="submit" class="btn">搜索</button>
			</form>
			
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th width="5%"><label class="checkbox"><input type="checkbox" class="checkAll"></label></th>
						<th width="20%">字典类型编码</th>
						<th width="20%">字典类型名称</th>
						<th width="35%">描述</th>
						<th width="20%">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="dt" items="${page.reslutSet }">
					<tr>
						<td><label class="checkbox"><input type="checkbox" id="${dt.ename }" class="checkOne"></label></td>
						<td>${dt.ename }</td>
						<td>${dt.cname }</td>
						<td>${dt.typeDesc }</td>
						<td>
							<input type="button" value="修改" class="btn">
							<input type="button" value="删除" class="btn">
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
			<div id="pagingBar"></div>
		</div>
	</div>
  </body>
</html>
