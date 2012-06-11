<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript">

	document.title = "SysLog - Page";
	
	Ext.onReady(function() {
		Ext.QuickTips.init();
		
		var logPanel = new Ext.Panel({
			region : "center",
			html : "<iframe src='"+ sys.path + "/system/log/sysLogView.jsp' width='100%' height='100%' frameborder='0'></iframe>"
		});
		
		var viewport = new Ext.Viewport({
			border : false,
			layout : "border",
			items : [logPanel]
		});
		
		completePage();
	});
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>