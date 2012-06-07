<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="../../plugins/ext-3.2.1/ux/FileUploadField.js"></script>
<script type="text/javascript" src="../../plugins/ext-3.2.1/ux/MultiSelect.js"></script>
<script type="text/javascript" src="../../plugins/local/uploadUtils.js"></script>
<script type="text/javascript">

	document.title = "upload - Demo";
	
	Ext.onReady(function() {
		Ext.QuickTips.init();
		var upload = new UploadUtil("demo1", "edit");
		var panel = upload.initShowPanel({title : "附件显示区域"},"1,2,3");
		panel.render("attShow");
		upload.show();
		
		completePage();	
	});
</script>
<div id="attShow"></div>
<jsp:include page="../../reference/footer.jsp"></jsp:include>