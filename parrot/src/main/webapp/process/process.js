var tpanel,contentPanel,bPanel,viewport,upload;
var processHandlerUrl = sys.path + "/wf/cm/handlerTask.jmt";

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
   				"</table>";
	
	
	var loadingUrl = sys.path + "/resources/images/local/waiting.gif";
	var html = "<table width=\"100%\" height=\"100%\" id='pageLoading'>" +
				"<tr valign=\"middle\" height=\"100%\">" +
					"<td width=\"100%\" align=\"center\">" +
						"<font style=\"font-size: 14px;\">表单数据加载中...</font><br>" +
						"<img src='" + loadingUrl + "'>" +
					"</td>" + 
				"</tr></table>";
	
	tpanel = new Ext.Panel({
		height : 100,
		split : true,
		region : "north",
		tbar : barArray,
		html : thtml
	});
	
	contentPanel = new Ext.Panel({
		split : true,
		layout : "fit",
		region : "center",
		html : html
	});
	
	viewport = new Ext.Viewport({
		border : false,
		layout : "border",
		items : [tpanel, contentPanel]
	});
	
	//设置title
	setTitle(processInfo.title);
	Ext.getDom("activityName").innerHTML = "当前环节：" + processInfo.activityName;
	completePage();
	
	try {
		startProcessHandler();
	} catch(e) {
		alert(e);
	}
	
	// 非新建和待办打开，将所有的控件置为disabled
	if(processInfo.openType != "create" 
		&& processInfo.openType != "todo") {
		contentPanel.findByType("textfield").disable();
		contentPanel.findByType("textarea").disable();
		contentPanel.findByType("button").disable();
		contentPanel.findByType("checkbox").disable();
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

function submitProcessInfo(title, appId, nextActivity) {
	
	var params = {
		taskId : processInfo.taskId,
		appId : appId,
		title : title,
		outcome : nextActivity,
		flowInstId : processInfo.flowInstId,
		flowAtts : upload.getgetUploadAttIds(),
		flowKey : processInfo.flowKey
	};
	
	var ajax = new AjaxUtil(processHandlerUrl);
	ajax.request(params, true, null, function(){
		closeThisWindow();
	});
}

function closeThisWindow() {
	try {
		window.opener.refreshGrid();
	} catch(e) {alert(e);}
	window.close();
}

