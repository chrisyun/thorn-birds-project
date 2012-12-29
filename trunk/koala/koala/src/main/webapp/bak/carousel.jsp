<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'carousel.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link type="text/css" rel="stylesheet" href="<%=path %>/plugins/rcarousel/css/rcarousel.css" />
	<link type="text/css" rel="stylesheet" href="<%=path %>/plugins/rlightbox/css/lightbox.css" />
	
	<script type="text/javascript" src="<%=path %>/plugins/rcarousel/jquery.ui.rcarousel.min.js"></script>
	<script type="text/javascript" src="<%=path %>/plugins/rlightbox/jquery.ui.rlightbox.min.js"></script>
	
	<style type="text/css">
	#pages {
		width: 150px;
		margin: 0 auto;
		padding-top: 20px;
	}
	</style>
	
	<script type="text/javascript">
	$(function(){
		
		$(".lb_gallery").rlightbox();
		
		$("#carousel").rcarousel({
			visible: 1,
			step: 1,
			speed: 700,
			margin: 10,
			auto: {
				enabled: true
			},
			width: 500,
			height: 375,
			start: generatePages,
			pageLoaded: pageLoaded
		});
		
		function generatePages() {
			var _total, i, _link;
			
			_total = $("#carousel").rcarousel("getTotalPages");
			
			for ( i = 0; i < _total; i++ ) {
				_link = $("<a href='#'></a>");
				
				$(_link).bind("click", {page: i},
						function( event ) {
							$("#carousel").rcarousel("goToPage", event.data.page);
							event.preventDefault();
						}
					).addClass("ui-carousel-bullet-off").appendTo("#pages");
			}
			
			// mark first page as active
			$("a:eq(0)", "#pages").removeClass("ui-carousel-bullet-off")
				.addClass("ui-carousel-bullet-on");
		}
		
		function pageLoaded(event, data) {
			$("a.ui-carousel-bullet-on", "#pages")
				.removeClass("ui-carousel-bullet-on")
				.addClass("ui-carousel-bullet-off");

			$("a", "#pages").eq(data.page)
				.removeClass("ui-carousel-bullet-off")
				.addClass("ui-carousel-bullet-on");
		}
		
		$(".ui-carousel-next-r").add(".ui-carousel-prev-l")
			.add(".bullet").hover(
			function() {
				$(this).css( "opacity", 0.7);
			},
			function() {
				$(this).css("opacity", 1.0);
			}
		);
	});
	
	
	</script>

  </head>
  
  <body>
    	  		<!-- 图片滚动区域 -->
			<div class="span7" style="margin-top: 20px;">
				<div style="position: relative;">
					<!-- 
						<a href="#" class="ui-carousel-prev-l" id="ui-carousel-prev"></a>
						<a href="#" class="ui-carousel-next-r" id="ui-carousel-next"></a>
					 -->
					<div id="carousel" style="width: 500px;margin: 0 auto;">
						<a href="<%=path %>/plugins/rcarousel/images/lightbox/01.jpg" class="lb_gallery"><img src="<%=path %>/plugins/rcarousel/images/lightbox/01_thumb.jpg" /></a>
						<a href="<%=path %>/plugins/rcarousel/images/lightbox/02.jpg" class="lb_gallery"><img src="<%=path %>/plugins/rcarousel/images/lightbox/02_thumb.jpg" /></a>
						<a href="<%=path %>/plugins/rcarousel/images/lightbox/03.jpg" class="lb_gallery"><img src="<%=path %>/plugins/rcarousel/images/lightbox/03_thumb.jpg" /></a>
						<a href="<%=path %>/plugins/rcarousel/images/lightbox/04.jpg" class="lb_gallery"><img src="<%=path %>/plugins/rcarousel/images/lightbox/04_thumb.jpg" /></a>
					</div>
					<div id="pages"></div>
				</div>
			</div>
  </body>
</html>
