var tpanel,contentPanel,bPanel,upload;
var processHandlerUrl = sys.path + "/wf/cm/handlerProcess.jmt";

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
	
	//设置按钮：保存草稿、导出word、作废流程
	var barArray = new Array();
	
	if(processInfo.openType == "create") {
		barArray.push("-");
		barArray.push({
			text : "保存草稿",
			handler : function() {
				handlerProcess("保存草稿");
			}
		});
	} else {
		barArray.push("-");
		barArray.push({
			text : "导出WORD",
			handler : function() {
				
			}
		});
	}
	
	if(processInfo.openType == "todo"
		&& user.userId == processInfo.creater) {
		barArray.push("-");
		barArray.push({
			text : "作废流程",
			handler : function() {
				
			}
		});
	}
	barArray.push("-");
	
	tpanel = new Ext.Panel({
		height : 75,
		split : true,
		margins : "0 0 0 2",
		region : "north",
		tbar : barArray,
		html : thtml
	});
	
	contentPanel = new Ext.Panel({
		split : true,
		layout : "fit",
		height : 500,
		margins : "0 0 0 2",
		region : "center",
		html : html
	});
	
	//附件上传
	var attViewType = "read";
	if(processInfo.openType == "create" 
		|| (processInfo.openType == "todo" 
			&& user.userId == processInfo.creater)) {
		attViewType = "edit";
	}
	upload = new UploadUtil("flowAtt", attViewType);
	
	var attArray = new Array();
	if(attViewType == "edit") {
		attArray.push("-");
		attArray.push({
			text : "附件上传",
			handler : function() {
				upload.show("上传附件");
			}
		});
		attArray.push("-");
	}
	
	var attPanel = upload.initShowPanel({
		title : "附件信息",
		split : true,
		region : "center",
		collapsible : true,
		height : 130,
		autoHeight : false,
		autoWidth : false
	}, processInfo.flowAtts);
	
	if(attArray.length > 0) {
		attPanel.add(new Ext.Toolbar(attArray));
	}
	
	
	var btn = new Array();
	if(processInfo.openType == "todo"
		|| processInfo.openType == "create") {
		for ( var i = 0; i < nextStep.length; i++) {
			btn.push(getNextActivityBtn(nextStep[i], submitProcessInfo));
		}
	}
	btn.push({
		text : "关闭",
		iconCls : "slik-close",
		handler : function() {
			closeThisWindow();
		}
	});
	
	//流程意见
	var processMinds = new ProcessMinds(processInfo.flowInstId,
					processInfo.activityName, processInfo.openType);
	
	bPanel = new Ext.Panel({
		region : "south",
		split : true,
		height : 300,
		margins : "0 0 0 2",
		layout : "border",
		border : false,
		items : [attPanel, processMinds.getMindPanel()],
		buttonAlign : "center",
		buttons : btn
	});
		
	var viewport = new Ext.Viewport({
		border : false,
		layout : "border",
		items : [tpanel, contentPanel, bPanel]
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
		&& !(processInfo.openType == "todo" 
			&& user.userId == processInfo.creater)) {
		contentPanel.findByType("textfield").disable();
		contentPanel.findByType("textarea").disable();
		contentPanel.findByType("button").disable();
		contentPanel.findByType("checkbox").disable();
	}
	
	//提交流程处理
	function submitProcessInfo(nextActivity) {
		//表单验证
		try {
			if(! VerificationForm()) {
				return ;
			}
		} catch(e) {}
		
		handlerProcess(nextActivity);
	}
	
	function handlerProcess(nextActivity) {
		var minds = processMinds.getMind();
		
		var params = {
			mindsId : minds.id,
			minds : minds.mind,
			flowId : processInfo.flowInstId,
			flowType : processInfo.flowKey,
			nextStep : nextActivity,
			creater : processInfo.creater,
			curActivity : processInfo.activityName,
			pid : processInfo.pid,
			flowAtts : upload.getUploadAttIds()
		};
		
		var form = getFormValues();
		
		for ( var attr in form) {
			params[attr] = form[attr];
		}
		
		var ajax = new AjaxUtil(processHandlerUrl);
		ajax.request(params, true, null, function(){
			closeThisWindow();
		});
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

function closeThisWindow() {
	try {
		window.opener.refreshGrid();
	} catch(e) {}
	window.close();
}

