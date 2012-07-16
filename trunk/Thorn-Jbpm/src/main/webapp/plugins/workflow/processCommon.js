function deleteProcessInst(ids, callBackFn) {
	var processInstDeleteUrl = sys.path + "/wf/deleteProcessInst.jmt";
	
	var params = {
		ids : ids
	};

	var ajaxClass = new AjaxUtil(processInstDeleteUrl);
	ajaxClass.request(params, true, null, callBackFn);
}

function cancelProcessInst(ids, reason, callBackFn) {
	var processInstCancelUrl = sys.path + "/wf/cancelProcessInst.jmt";
	
	var params = {
		ids : ids,
		reason : "控制台结束"
	};

	var ajaxClass = new AjaxUtil(processInstCancelUrl);
	ajaxClass.request(params, true, null, callBackFn);
}

var processDfImageUrl = sys.path + "/wf/getProcessDfImage.jmt";
var processInstImageUrl = sys.path + "/wf/getProcessInstImage.jmt";
var loadingUrl = sys.path + "/resources/images/local/waiting.gif";

function ProcessImage() {
	this.id = Math.random();
	
	var html = "<table width=\"100%\" height=\"100%\">" +
  					"<tr valign=\"middle\" height=\"100%\">" +
  						"<td width=\"100%\" align=\"center\">" +
    						"<img id='processImg_" + this.id + "' src='" + loadingUrl + "'>" +
  				"</td></tr></table>";
	
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
		buttons : [{
			text : "关闭",
			iconCls : "slik-close",
			scope : this,
			handler : function() {
				this.processImageWin.hide();
			}
		}]
	});
}

ProcessImage.prototype.show = function(type, id) {
	this.processImageWin.show();
	Ext.getDom("processImg_" + this.id).src = loadingUrl;
	
	if(type == "def") {
		Ext.getDom("processImg_" + this.id).src = processDfImageUrl + "?processDfId=" + id + "&random=" + Math.random();
	} else if(type == "inst") {
		Ext.getDom("processImg_" + this.id).src = processInstImageUrl + "?processInstId=" + id + "&random=" + Math.random();
	}
}