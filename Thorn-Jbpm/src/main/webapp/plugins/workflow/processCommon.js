/**
 * 删除流程
 * @param ids		实例ID,
 * @param callBackFn回调函数
 */
deleteProcessInst.url = sys.path + "/wf/deleteProcessInst.jmt";
function deleteProcessInst(ids, callBackFn) {

	var params = {
		ids : ids
	};

	var ajaxClass = new AjaxUtil(processInstDeleteUrl);
	ajaxClass.request(params, true, null, callBackFn);
}

/**
 * 取消流程
 * @param ids		实例ID,
 * @param reason	取消原因
 * @param callBackFn回调函数
 */
cancelProcessInst.url = sys.path + "/wf/cancelProcessInst.jmt";
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
			+ this.id + "' src='" + loadingUrl + "'>" + "</td></tr></table>";

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

ProcessImage.dfImageUrl = sys.path + "/wf/getProcessDfImage.jmt";
ProcessImage.instImageUrl = sys.path + "/wf/getProcessInstImage.jmt";
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
}