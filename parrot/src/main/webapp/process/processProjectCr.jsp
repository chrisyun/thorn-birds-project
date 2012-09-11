<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript">

	document.title = "Process - Create";
	
	function openNewFlow(type) {
		var url = sys.path + "/wf/cm/startNewProcess.jmt?key=" + type;
		var height = window.screen.availHeight - 50;
		var width = window.screen.availWidth - 50;
		
		window.open (url, "flowPage", 
				"height="+height+", width="+width+", top=0, left=0, toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no, status=yes");
	}
	
	var html = "<table width=\"90%\" align=\"center\" style=\"font-size: 14px;\">" +
		"<tr><td><strong>为确保申报规范，准确，请注意以下事项：</strong></td></tr>" +
		"<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>" +
		"<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;1、为了保证平台的正常使用，建议使用IE8.0及以上版本，分辨率在1024*768以上，效果最佳。</td></tr>" +
		"<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>" +
		"<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;2、</td></tr>" +
		"<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>" +
		"<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;3、</td></tr>" +
		"<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>" +
		"<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;4、</td></tr>";
	
	Ext.onReady(function() {
		Ext.QuickTips.init();
		
		var projectSet = new Ext.form.FieldSet({
			title : "<span style='color:blue;font-size:15px;'>国家级非物质文化遗产代表性项目补助费申报</span>",
			html : html,
			buttonAlign : "center",
			buttons : [{
				text : "点击发起申报",
				handler : function() {
					openNewFlow("project");
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
		
		var viewport = new Ext.Viewport({
			border : true,
			layout : "fit",
			items : [projectPanel]
		});
		completePage();
	});	
	
</script>
<jsp:include page="../reference/footer.jsp"></jsp:include>