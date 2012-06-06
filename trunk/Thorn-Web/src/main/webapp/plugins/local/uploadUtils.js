var uploadUrl;
var downloadUrl;
var queryAttsUrl;

function UploadUtil(id) {
	this.id = id;

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
							xtype : "hidden",
							id : id + "_ids",
							name : "fileIds"
						}, {
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

	this.uploadForm.findById(id).addListener("fileselected",
			function(field, value) {
				var file_name = value.substring(value.lastIndexOf("\\") + 1,
						value.length);
				this.uploadForm.getForm().findField("fileName")
						.setValue(file_name);
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

							this.uploadForm.getForm().submit({
								url : uploadUrl,
								timeout : 10 * 60 * 1000,
								method : "POST",
								success : function(form, action) {
									Message.hideProcessMsgBox();
									TopShow.msg("成功提示", action.result.message);

									var att = new Object();
									att.id = result.obj;
									att.name = form.getValues().name;
									att.downUrl = "";

								},
								failure : function(form, action) {
									Message.hideProcessMsgBox();
									var failMsg = Ext
											.isEmpty(action.result.message)
											? "文件上传失败."
											: action.result.message;
									Message.showErrorMsgBox(failMsg);
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

UploadUtil.prototype.initShowPanel = function(attrObj, type, ids) {
	this.type = type || "read";

	this.showPanel = new Ext.Panel({
				id : this.id + "_show",
				html : "<div id='" + this.id + "_show_div'></div>"
			});

	for (var attr in attrObj) {
		this.showPanel[attr] = attrObj[attr];
	}

	if (!Ext.isEmpty(ids)) {
		var ajax = new AjaxUtil(queryAttsUrl);
		ajax.getData({
					"ids" : ids
				}, this, function(obj, result) {
					if (result == null) {
						return;
					}

					for (var i = 0; i < result.length; i++) {
						var att = new Object();
						att.id = result.id;
						att.name = result.fileName;
						att.downUrl = "";

						this.addAtt(att);
					}
				});
	}

	return this.showPanel;
}

UploadUtil.prototype.show = function(title) {
	this.uploadWin.show();
}

UploadUtil.prototype.addAtt = function(att) {
	var hiddenIds = this.uploadForm.findById(this.id + "_ids").getValue();
	this.uploadForm.findById(this.id + "_ids").setValue(hiddenIds + ","
			+ att.id);

	var attHtml = "<span id='" + this.id + "_" + att.id + "'><a href=\""
			+ att.downUrl + "\" title=\"下载\" target=\"_blank\">" + att.name
			+ "</a></span>";

	Ext.getDom(this.id + "_show_div").innerHTML += attHtml;
}

UploadUtil.prototype.removeAtt = function(id) {
	var hiddenIds = this.uploadForm.findById(this.id + "_ids").getValue();
	var idArray = hiddenIds.split(id + ",");
	this.uploadForm.findById(this.id + "_ids").setValue(idArray[0] + idArray[1]);
	
	Ext.getDom(this.id + "_" + id).innerHTML = "";
	Ext.getDom(this.id + "_" + id).removeNode();
}
