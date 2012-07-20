/**
 * 删除流程
 * @param ids		实例ID,
 * @param callBackFn回调函数
 */
deleteProcessInst.url = sys.path + "/wf/cm/deleteProcessInst.jmt";
function deleteProcessInst(ids, callBackFn) {

	var params = {
		ids : ids
	};

	var ajaxClass = new AjaxUtil(deleteProcessInst.url);
	ajaxClass.request(params, true, null, callBackFn);
}

/**
 * 取消流程
 * @param ids		实例ID,
 * @param reason	取消原因
 * @param callBackFn回调函数
 */
cancelProcessInst.url = sys.path + "/wf/cm/cancelProcessInst.jmt";
function cancelProcessInst(ids, reason, callBackFn) {

	var params = {
		ids : ids,
		reason : reason
	};

	var ajaxClass = new AjaxUtil(cancelProcessInst.url);
	ajaxClass.request(params, true, null, callBackFn);
}


function ProcessImage() {
	this.id = Math.random();

	var html = "<table width=\"100%\" height=\"100%\">"
			+ "<tr valign=\"middle\" height=\"100%\">"
			+ "<td width=\"100%\" align=\"center\">" + "<img id='processImg_"
			+ this.id + "' src='" + ProcessImage.loadingUrl + "'>" + "</td></tr></table>";

	this.processImageWin = new Ext.Window({
		title : "流程图",
		closeAction : "hide",
		modal : true,
		shadow : true,
		closable : true,
		layout : "fit",
		width : 530,
		height : 380,
		autoScroll : true,
		html : html,
		buttonAlign : "center",
		buttons : [ {
			text : "关闭",
			iconCls : "slik-close",
			scope : this,
			handler : function() {
				this.processImageWin.hide();
			}
		} ]
	});
}

ProcessImage.dfImageUrl = sys.path + "/wf/df/getProcessDfImage.jmt";
ProcessImage.instImageUrl = sys.path + "/wf/cm/getProcessInstImage.jmt";
ProcessImage.loadingUrl = sys.path + "/resources/images/local/waiting.gif";

ProcessImage.prototype.show = function(type, id) {
	this.processImageWin.show();
	Ext.getDom("processImg_" + this.id).src = ProcessImage.loadingUrl;

	if (type == "def") {
		Ext.getDom("processImg_" + this.id).src = ProcessImage.dfImageUrl
				+ "?processDfId=" + id + "&random=" + Math.random();
	} else if (type == "inst") {
		Ext.getDom("processImg_" + this.id).src = ProcessImage.instImageUrl
				+ "?processInstId=" + id + "&random=" + Math.random();
	}
};

ProcessMinds.saveMindUrl = sys.path + "/wf/df/saveActivityMind.jmt";
ProcessMinds.getMindsUrl = sys.path + "/wf/df/getProcessMinds.jmt";
function ProcessMinds(flowInstId, activityName, taskId) {
	
	this.params = {
		flowInstId : flowInstId,
		activityName : activityName,
		taskId : taskId
	};
	
	this.mindsForm = new FormUtil({
		border : false,
		id : "mindsForm",
		collapsible : false,
		html : "<div id='mindsDiv'></div>",
		labelWidth : 100
	});
		
	var radioGroup = new Ext.form.RadioGroup({
		fieldLabel : "是否审批通过",
		items : [ {
			boxLabel : '是',
			inputValue : "YES",
			name : "isPassed",
			checked : true
		}, {
			boxLabel : '否',
			name : "isPassed",
			inputValue : "NO"
		} ]
	});

	mindsForm.addComp(radioGroup, 1.0, true);
	mindsForm.addComp(getTextArea("minds", "意见", 300, 70), 1.0, false);
}


function getNextActivityBtn(name, handler) {
	var activityBtn = new Object();
	
	if(name.indexOf("驳回") > -1 
			|| name.indexOf("退回") > -1
			|| name.indexOf("重新") > -1
			|| name.indexOf("不通过") > -1) {
		activityBtn.iconCls = "silk-cross";
	} else {
		activityBtn.iconCls = "silk-tick";
	}
	
	activityBtn.text = name;
	activityBtn.xtype = "button";
	activityBtn.minWidth = 80;
	activityBtn.handler = function() {
		handler(name);
	};

	return activityBtn;
}
