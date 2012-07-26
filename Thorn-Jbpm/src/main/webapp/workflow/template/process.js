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
   					"<tr height=\"20%\">" +
   						"<td>&nbsp;</td>" +
   						"<td id=\"flowType\" style=\"font-size: 13px;\"></td>" +
   					"</tr>" +
   				"</table>";
	

	var mindsCls = new ProcessMinds(processInfo.flowInstId,
		processInfo.activityName, processInfo.taskId,
		processInfo.openType);
	
	var processImage = new ProcessImage();
	
	var attViewType = "edit";
	if(processInfo.openType != "create" 
		&& processInfo.openType != "todo") {
		attViewType = "read";
	}
	upload = new UploadUtil("flowAtt", attViewType);
	
	var barArray = new Array();
	barArray.push("-");
	barArray.push({
		text : "流程图",
		minWidth : Configuration.minBtnWidth,
		scope : processImage,
		handler : function() {
			processImage.show("inst", processInfo.flowInstId);
		}
	});
	barArray.push("-");
	barArray.push({
		text : "流程意见",
		minWidth : Configuration.minBtnWidth,
		scope : mindsCls,
		handler : mindsCls.show
	});
	barArray.push("-");
	barArray.push({
		text : "上传附件",
		minWidth : Configuration.minBtnWidth,
		handler : function() {
			upload.show("上传附件");
		}
	});
	barArray.push("-");
	barArray.push({
		text : "作废流程",
		minWidth : Configuration.minBtnWidth,
		handler : function() {
			Ext.MessageBox.show({
	           title: '流程作废',
	           msg: '请输入作废原因：',
	           width:350,
	           buttons: Ext.MessageBox.OKCANCEL,
	           multiline: true,
	           icon: Ext.MessageBox.INFO,
	           fn: function(buttonId, text) {
	        	  if(buttonId == "cancel") {
	        		  return ;
	        	  }
	        	  cancelProcessInst(processInfo.flowInstId, text,closeThisWindow);
	           }
	       });
		}
	});
	barArray.push("-");
	
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
	
	bPanel = upload.initShowPanel({
		title : "附件信息",
		split : true,
		autoHeight : false,
		autoWidth : false,
		region : "south",
		collapsible : true,
		height : 100,
	}, processInfo.flowAtts);
	
	viewport = new Ext.Viewport({
		border : false,
		layout : "border",
		items : [tpanel, contentPanel, bPanel]
	});
	
	//设置title
	if(processInfo.title == "") {
		setTitle(processInfo.flowName);
	} else {
		setTitle(processInfo.title);
	}
	
	Ext.getDom("activityName").innerHTML = "当前环节：" + processInfo.activityName;
	Ext.getDom("flowType").innerHTML = "流程类型：" + processInfo.flowType;
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

