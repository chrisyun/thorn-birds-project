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

ProcessMinds.saveMindUrl = sys.path + "/wf/cm/saveActivityMind.jmt";
ProcessMinds.getMindsUrl = sys.path + "/wf/cm/getProcessMinds.jmt";
function ProcessMinds(flowInstId, activityName, taskId, opType) {
	
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
	
	this.mindsWin = new WindowUtil({
		width : 500,
		height : 400,
		autoScroll : true
	}, this.mindsForm.getPanel(), null);
	
	if(opType == "create" || opType == "todo") {
		this.mindsForm.addComp(getHidden("id"), 1.0, true);
		this.mindsForm.addComp(radioGroup, 1.0, true);
		this.mindsForm.addComp(getTextArea("minds", "意见", 300, 80), 1.0, false);
	} else {
		// 不显示保存按钮
		this.mindsWin.hideSaveBtn();
	}
	
	this.html = "";
	
	this.store = new Ext.data.Store({
		url : ProcessMinds.getMindsUrl,
		baseParams : {flowInstId : flowInstId},
		autoLoad : true,
		reader : new Ext.data.JsonReader({}, 
				Ext.data.Record.create([{
					name : 'activityName',
					type : 'string'
				}, {
					name : 'taskId',
					type : 'string'
				}, {
					name : 'userName',
					type : 'string'
				}, {
					name : 'userId',
					type : 'string'
				}, {
					name : 'createTime',
					type : 'string'
				}, {
					name : 'minds',
					type : 'string'
				}, {
					name : 'isPassed',
					type : 'string'
				}, {
					name : 'id',
					type : 'string'
				}]))
	});
	this.store.addListener("load", function(store, records) {
		
		this.html = "<table border='1' width='100%'>";
		
		for(var i=0; i<records.length; i++ ) {
			if((opType == "create" || opType == "todo")
					&& taskId == records[i].get("taskId")
					&& user.userId == records[i].get("userId")) {
				var values = {
					id : records[i].get("id"),
					isPassed : records[i].get("isPassed"),
					minds : records[i].get("minds")
				};
				
				this.mindsForm.getForm().setValues(values);
			} else {
				this.html += "<tr>" +
							"<td align='right' width='100px'>" + records[i].get("activityName") + "：&nbsp;&nbsp;</td>" +
							"<td>" + records[i].get("minds") + "-----" + records[i].get("userName") + 
							"&nbsp;&nbsp;&nbsp;&nbsp;" +records[i].get("createTime") + "</td>" +
						"</tr>";
			}
		}
		
		this.html += "</table>";
	}, this);
}

ProcessMinds.prototype.show = function(){
	this.mindsWin.show("流程意见");
	Ext.getDom("mindsDiv").innerHTML = this.html;
};


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
