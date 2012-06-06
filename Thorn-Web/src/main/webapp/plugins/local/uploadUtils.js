function UploadUtil(uploadUrl, id) {
	this.uploadForm = new Ext.FormPanel({
		fileUpload : true,
		border : false,
		autoHeight : true,
		bodyStyle : "padding: 10px 10px 0 10px;",
		labelWidth : 80,
		defaults : {
			anchor : "95%",
			allowBlank : false,
			blankText : Validate.empty
		},
		items : [{
					xtype : "textfield",
					id : id + "_name",
					name : "fileName",
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
					}
				}]
	});
	
	this.uploadForm.findById(id).addListener("fileselected",function(field, value) {
		var file_name = value.substring(value.lastIndexOf("\\")+1,value.length);
		this.uploadForm.getForm().findField("fileName").setValue(file_name);
	}, this);
	
	this.uploadWin = new Ext.Window({
				closeAction : "hide",
				modal : true,
				shadow : true,
				closable : true,
				layout : "fit",
				width : 500,
				height : 130,
				items : [this.uploadForm],
				buttonAlign : "center",
				buttons : [{
					text : "上传",
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