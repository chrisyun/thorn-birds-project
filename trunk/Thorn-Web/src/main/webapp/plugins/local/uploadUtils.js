function UploadUtil(uploadUrl, id) {
	this.uploadForm = new Ext.FormPanel({
		fileUpload : true,
		frame : true,
		autoHeight : true,
		bodyStyle : "padding: 10px 10px 0 10px;",
		labelWidth : 80,
		defaults : {
			anchor : "95%",
			allowBlank : false,
			msgTarget : "side"
		},
		items : [{
					xtype : "textfield",
					id : id + "_name",
					fieldLabel : "文件名"
				}, {
					xtype : "fileuploadfield",
					id : id,
					emptyText : "请选择需要上传的文件",
					fieldLabel : "附件",
					name : "attach",
					buttonText : "",
					buttonCfg : {
						iconCls : "upload-icon"
					},
					listeners : {
						"change" : function(Field, newValue, oldValue) {
							alert(newValue);
						}
					}
				}]
	});

	this.uploadWin = new Ext.Window({
				closeAction : "hide",
				modal : true,
				shadow : true,
				closable : true,
				layout : "fit",
				width : 400,
				height : 210,
				items : [this.uploadForm],
				buttonAlign : "center",
				buttons : [{
					text : "保存",
					iconCls : "silk-accept",
					scope : this,
					handler : function() {
						if (this.uploadForm.getForm().isValid()) {
							Message.showProcessMsgBox();

							this.uploadForm.getForm().submit({
								url : uploadUrl,
								success : function(fp, o) {
									Message.hideProcessMsgBox();
//									msg("Success", "Processed file "
//													+ o.result.file
//													+ " on the server");
								}
							});
						}
					}
				}, {
					text : "关闭",
					iconCls : "slik-close",
					scope : this,
					handler : function() {
						this.uploadWin.hide();
					}
				}]
			});
}

UploadUtil.prototype.show = function(title) {
	this.uploadWin.show();
}