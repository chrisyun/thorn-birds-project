<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<style>
<!--
.set {
	margin-top: 20px;
	margin-right: 2px;
	margin-bottom: 20px;
}

-->
</style>

<script type="text/javascript">

	document.title = "Process - Create";
	
	Ext.onReady(function() {
		Ext.QuickTips.init();
		
		var projectSet = new Ext.form.FieldSet({
			title : "<span style='color:blue;font-size:15px;'>国家级非物质文化遗产代表性项目补助费申报</span>",
			html : "oooooooooooopppp",
			buttonAlign : "center",
			buttons : [{
				text : "点击发起申报",
				handler : function() {
					
				}
			}]
		});
		
		var projectPanel = new Ext.Panel({
			height : 220,
			bodyStyle : "padding-top: 10px;",
			region : "north",
			border : false,
			layout : "fit",
			items : [ projectSet ]
		});
		
		var reseverSet = new Ext.form.FieldSet({
			region : "south",
			title : "<span style='color:blue;font-size:15px;'>国家级文化生态保护区补助费申报</span>",
			html : "oooooooooooopppp",
			buttonAlign : "center",
			buttons : [{
				text : "点击发起申报",
				handler : function() {
					
				}
			}]
		});
		
		var reseverPanel = new Ext.Panel({
			bodyStyle : "padding-top: 20px;",
			region : "center",
			border : false,
			layout : "fit",
			items : [ reseverSet ]
		});
		
		var viewport = new Ext.Viewport({
			border : true,
			layout : "border",
			items : [projectPanel, reseverPanel]
		});
		completePage();
	});	
	
</script>
<jsp:include page="../reference/footer.jsp"></jsp:include>