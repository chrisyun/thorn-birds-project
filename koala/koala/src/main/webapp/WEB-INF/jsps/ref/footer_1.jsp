<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<style type="text/css">
.footer {
	border-top: 3px solid #C1D1EA;
	color: #808080;
	font-size: 12px;
	font-family: Arial;
}
</style>

<div class="footer">
	<div class="container">
		<div class="row">
			<div class="span2 offset1">
				<img alt="logo" style="padding-top: 10px;padding-bottom: 10px;" src="<%=path%>/images/logo.png">
			</div>
			<div class="span8">
				<div class="row">
					<div class="span8" style="padding-top: 10px;padding-bottom: 5px;">版权所有 © 2012 Mozilla Firefox. 北京谋智火狐信息技术有限公司 京 ICP备11011334号-1</div>
				</div>
				<div class="row">
					<div class="span8" style="padding-top: 5px;padding-bottom: 10px;">联系我们：请发邮件至moc.allizom@uohzc 主页修复 新版意见反馈 申请收录</div>
				</div>
			</div>
		</div>
	</div>
</div>