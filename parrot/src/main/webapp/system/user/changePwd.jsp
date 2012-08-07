<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="userPwd.js"></script>
<script type="text/javascript">

	document.title = "Change - MyPassword";
	
	Ext.onReady(function() {
		var Pwd_Obj = new UserPwd("my");
		
		Pwd_Obj.show();
		
		var panel = new Ext.Panel({
			title : "&nbsp;",
			bodyStyle : "padding-top: 7px;",
			region : "center",
			margins : "2 0 0 0"
		});
		
		var viewport = new Ext.Viewport({
			border : true,
			layout : "border",
			items : [panel]
		});
		completePage();
	});	
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>