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

ProcessImage.prototype.show = function(url) {
	this.processImageWin.show();
	Ext.getDom("processImg_" + this.id).src = url;
}