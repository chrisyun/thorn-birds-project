function WindowUtil(winAttr, form, saveHandler) {
	this.win = new Ext.Window( {
		closeAction : 'hide',
		modal : true,
		shadow : true,
		closable : true,
		layout : 'fit',
		width : 350,
		height : 210,
		items : [ form ],
		buttonAlign : "center",
		buttons : [ {
			text : '保存',
			iconCls : 'silk-accept',
			scope : this,
			handler : saveHandler
		}, {
			text : '关闭',
			iconCls : 'slik-close',
			scope : this,
			handler : function() {
				this.win.hide();
			}
		} ]
	});
	for ( var attr in winAttr) {
		this.win[attr] = winAttr[attr];
	}
}

WindowUtil.prototype.show = function(title) {
	this.win.setTitle(title);
	this.win.show();
}

WindowUtil.prototype.hide = function() {
	this.win.hide();
}

WindowUtil.prototype.getWindow = function() {
	return this.win;
}