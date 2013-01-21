<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>更换主题</title>
	<script type="text/javascript">
	$(function(){
		
		var theme = $.cookie.get("org.springframework.web.servlet.theme.CookieThemeResolver.THEME");
		if(theme == null) {
			theme = "default";
		}
		
		$(":checkbox").each(function(){
			if(theme == $(this).val()) {
				$(this).attr("checked",true);
			}
		});
		
		$(":checkbox").click(function(){
			
			var befCheck = $(this).attr("checked");
			$(":checkbox").attr("checked",false);
			if(befCheck == "checked") {
				$(this).attr("checked",true);
			}
		});
	});
	
	function saveMyTheme() {
		$("#themeForm").submitForm();
	}
	
	
	</script>
  </head>
  
  <body>
  	<div class="row">
		<ul class="breadcrumb">
			<li><a href="<%=path%>/common/mySetting/userInfo.jhtml">个人设置</a><span class="divider">/</span></li>
			<li class="active">更换主题</li>
		</ul>
	</div>
  	
  	<div class="row">
		<div class="span9">
			<form action="<%=path%>/common/mySetting/changeMyTheme.jmt" 
				method="post" id="themeForm">
			<ul class="thumbnails">
				<li class="span3">
					 <div class="thumbnail"><img src="<%=path %>/plugins/rcarousel/images/lightbox/01.jpg">
						<label class="checkbox inline">
					 		<input type="checkbox" name="theme" id="default" value="default">默认主题
					 	</label>
					 </div>				
				</li>	
				<li class="span3">
					 <div class="thumbnail"><img src="<%=path %>/plugins/rcarousel/images/lightbox/02.jpg">
						 <label class="checkbox inline">
						 	<input type="checkbox" name="theme" id="blitzer" value="blitzer">黑色主题
						 </label>
					 </div>
				</li>	
				<li class="span3">
					 <div class="thumbnail"><img src="<%=path %>/plugins/rcarousel/images/lightbox/03.jpg">
						 <label class="checkbox inline">
						 	<input type="checkbox" name="theme" id="humanity" value="humanity">暖色主题
						 </label>
					 </div>
				</li>
				<li class="span3">
					 <div class="thumbnail"><img src="<%=path %>/plugins/rcarousel/images/lightbox/04.jpg">
						 <label class="checkbox inline">
						 	<input type="checkbox" name="theme" id="smoothness" value="smoothness">圆润主题
						 </label>
					 </div>
				</li>
			</ul>
			<div class="form-actions">
				<input class="btn btn-primary btn-large" type="button" value="保存" onclick="saveMyTheme();">
			</div>
			</form>
		</div>
	</div>
  	
  	
  </body>
</html>
