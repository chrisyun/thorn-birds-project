var tpanel,contentPanel,bPanel,viewport;

Ext.onReady(function() {
	Ext.QuickTips.init();
	
	var thtml = "<table width=\"100%\" height=\"100%\">" +
   					"<tr valign=\"middle\" height=\"60%\">" +
   						"<td align=\"center\" colspan=\"2\" id=\"title\" style=\"font-size: 18px;\"></td>" +
   					"</tr>" +
   					"<tr height=\"20%\">" +
   						"<td width=\"70%\">&nbsp;</td>" +
   						"<td id=\"activityName\" style=\"font-size: 13px;\"></td>" +
   					"</tr>" +
   					"<tr height=\"20%\">" +
   						"<td>&nbsp;</td>" +
   						"<td id=\"flowType\" style=\"font-size: 13px;\"></td>" +
   					"</tr>" +
   				"</table>";
	
	tpanel = new Ext.Panel({
		height : 100,
		split : true,
		region : "north",
		tbar : ["-"],
		html : thtml
	});
	
	var loadingUrl = sys.path + "/resources/images/local/waiting.gif";
	var html = "<table width=\"100%\" height=\"100%\" id='pageLoading'>" +
				"<tr valign=\"middle\" height=\"100%\">" +
					"<td width=\"100%\" align=\"center\">" +
						"<font style=\"font-size: 14px;\">表单数据加载中...</font><br>" +
						"<img src='" + loadingUrl + "'>" +
					"</td>" + 
				"</tr></table>";
	
	contentPanel = new Ext.Panel({
		split : true,
		layout : "fit",
		region : "center",
		html : html
	});
	
	bPanel = new Ext.Panel({
		title : "附件信息",
		split : true,
		region : "south",
		collapsible : true,
		height : 100,
		html : ""
	});
	
	viewport = new Ext.Viewport({
		border : false,
		layout : "border",
		items : [tpanel, contentPanel, bPanel]
	});
	
	setTitle(processInfo.flowName);
	Ext.getDom("activityName").innerHTML = "当前环节：" + processInfo.activityName;
	Ext.getDom("flowType").innerHTML = "流程类型：" + processInfo.flowType;
	completePage();
	
	try {
		startProcessHandler();
	} catch(e) {
		alert(e);
	}
	
});


function setTitle(processTitle) {
	Ext.getDom("title").innerHTML = processTitle;
	processInfo.title = processTitle;
}

function formLoadingComplate() {
	Ext.getDom("pageLoading").style.display = "none";
}

function addContentPanel(panel) {
	contentPanel.add(panel);
	contentPanel.doLayout();
}
