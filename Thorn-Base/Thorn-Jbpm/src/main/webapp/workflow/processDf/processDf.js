var deployProcessUrl = sys.path + "/wf/df/deployProcess.jmt";
var processDfListUrl = sys.path + "/wf/df/getProcessDf.jmt";
var deleteProcessUrl = sys.path + "/wf/df/deleteProcessDf.jmt";

Ext.onReady(function() {
	Ext.QuickTips.init();

	/** ****************query panel start*************** */
	var query_attr = {
		title : "查询列表",
		region : "north",
		height : 70,
		labelWidth : 70
	};

	var query_form = new FormUtil(query_attr);
	query_form.addComp(getText("query_name", "名称", 120), 0.2, true);
	query_form.addComp(getText("query_key", "Key", 120), 0.2, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.2, true);
	/** ****************query panel end*************** */

	/** ****************deploy panel start*************** */
	var deployForm = new Ext.FormPanel({
				fileUpload : true,
				border : false,
				autoHeight : true,
				bodyStyle : "padding: 20px 10px 20px 10px;",
				labelWidth : 100,
				labelAlign : "right",
				height : 300,
				defaults : {
					anchor : "95%",
					allowBlank : false,
					blankText : Validate.empty
				},
				items : [{
					xtype : "hidden",
					name : "fileName"
				}, {
					xtype : "fileuploadfield",
					id : "fileUpload",
					emptyText : "请选择需要发布的流程定义文件(.zip/.xml)",
					fieldLabel : Validate.redStar + "流程定义文件",
					name : "attach",
					buttonText : "",
					buttonCfg : {
						iconCls : "upload-icon"
					}
				}, {
					xtype : "textfield",
					name : "flowName",
					fieldLabel : Validate.redStar + "流程中文名"
				}, {
					xtype : "combo",
					hiddenName : "flowType",
					fieldLabel : Validate.redStar + "流程类型",
					valueField : "value",
					displayField : "text",
					mode : "local",
					editable : false,
					triggerAction : "all",
					resizable : true,
					emptyText : "---请选择---",
					value : "",
					store : new Ext.data.SimpleStore( {
						fields : [ 'value', 'text' ],
						data : flowTypeDD
					})
				}, {
					xtype : "textarea",
					name : "flowDesc",
					allowBlank : true,
					height : 80,
					fieldLabel : "流程描述"
				}]
			});

	deployForm.findById("fileUpload").addListener("fileselected",
			function(field, value) {
				var file_name = value.substring(value.lastIndexOf("\\") + 1,
						value.length);
				deployForm.getForm().findField("fileName").setValue(file_name);
			}, this);

	var uploadWin = new Ext.Window({
				title : "发布新流程",
				closeAction : "hide",
				modal : true,
				shadow : true,
				closable : true,
				layout : "fit",
				width : 420,
				items : [deployForm],
				buttonAlign : "center",
				buttons : [{
							text : "发布",
							iconCls : "silk-accept",
							handler : deploy
						}, {
							text : "关闭",
							iconCls : "slik-close",
							handler : function() {
								uploadWin.hide();
							}
						}]
			});

	/** ****************deploy panel end*************** */

	/** ****************grid panel start*************** */
	var store = new Ext.data.GroupingStore({
				reader : new Ext.data.JsonReader({
							totalProperty : "total",
							root : "reslutSet"
						}, Ext.data.Record.create([{
									name : "id",
									type : "string",
									mapping : "id"
								}, {
									name : "deploymentId",
									type : "string",
									mapping : "deploymentId"
								}, {
									name : "key",
									type : "string",
									mapping : "key"
								}, {
									name : "name",
									type : "string",
									mapping : "name"
								}, {
									name : "suspended",
									type : "boolean",
									mapping : "suspended"
								}, {
									name : "version",
									type : "string",
									mapping : "version"
								}, {
									name : "description",
									type : "string",
									mapping : "description"
								}, {
									name : "imageResourceName",
									type : "string",
									mapping : "imageResourceName"
								}])),
				url : processDfListUrl,
				sortInfo : {
					field : "version",
					direction : "DESC"
				},
				groupField : "key"
			});
	
	var msgRender = function(remark, metadata, record, rowIndex, colIndex) {
		return Render.detailRender(remark, cm, colIndex);
	};		
			
	var sm = new Ext.grid.CheckboxSelectionModel({});
	var cm = new Ext.grid.ColumnModel([sm, {
				id : "id",
				header : "ID",
				width : 50,
				dataIndex : "id"
			}, {
				id : "deploymentId",
				header : "DeploymentId",
				width : 50,
				dataIndex : "deploymentId"
			}, {
				id : "key",
				header : "Key",
				width : 40,
				dataIndex : "key"
			}, {
				id : "name",
				header : "名称",
				width : 80,
				dataIndex : "name"
			}, {
				id : "suspended",
				header : "是否挂起",
				width : 50,
				dataIndex : "suspended"
			}, {
				id : "version",
				header : "Version",
				width : 40,
				dataIndex : "version"
			}, {
				id : "description",
				header : "描述",
				width : 200,
				dataIndex : "description",
				renderer : msgRender
			}]);

	var tbar = new Array();
	if(userPermission.DEPLOY == "true") {
		tbar.push("-");
		tbar.push({
			text : "发布新流程",
			iconCls : "silk-add",
			minWidth : Configuration.minBtnWidth,
			handler : deployHandler
		});
	}
	if(userPermission.DELETE == "true") {
		tbar.push("-");
		tbar.push({
			text : "删除流程定义",
			iconCls : "silk-delete",
			minWidth : Configuration.minBtnWidth,
			handler : deleteHandler
		});	
	}
	
	tbar.push("-");
	tbar.push({
				text : "查看流程图",
				iconCls : "silk-edit",
				minWidth : Configuration.minBtnWidth,
				handler : processImageHandler
			});	
			
	var grid = new Ext.grid.GridPanel({
		title : "流程定义列表",
		iconCls : "silk-grid",
		region : "center",
		store : store,
		cm : cm,
		sm : sm,
		view : new Ext.grid.GroupingView({
			forceFit : true,
			groupTextTpl : '{text} ({[values.rs.length]} {[values.rs.length > 1 ? "Items" : "Item"]})'
		}),
		collapsible : true,
		loadMask : true,
		split : true,
		tbar : tbar
	});
	
	var processImage = new ProcessImage();
	
	/** ****************grid panel end*************** */
	function deploy() {
		if (!deployForm.getForm().isValid()) {
			return;
		}
		
		var fileName = deployForm.getForm().findField("fileName").getValue().toLowerCase();
		
		if(fileName.indexOf(".zip") < 0 && fileName.indexOf(".xml") < 0) {
			Ext.Msg.alert("提示信息", "请选择.zip文件或.xml文件进行发布!");
			return;
		}
		
		deployForm.getForm().submit( {
			url : deployProcessUrl,
			timeout : 600000,
			method : "POST",
			success : function(form, action) {
				Message.hideProcessMsgBox();
				TopShow.msg("成功提示", action.result.message);
				onSubmitQueryHandler();
			},
			failure : function(form, action) {
				Message.hideProcessMsgBox();
				var failMsg = Ext.isEmpty(action.result.message)
				   		 ? "流程发布失败." : action.result.message;
				Message.showErrorMsgBox(failMsg);
			}
		});
	
	}
	
	function deployHandler() {
		uploadWin.setTitle("发布新流程");
		uploadWin.show();
	}
	
	function processImageHandler() {
		if (grid.getSelectionModel().getCount() != 1) {
			Ext.Msg.alert("提示信息", "请选择一条记录!");
			return;
		}
		var selectedRecord = grid.getSelectionModel().getSelected();
		var imageResource = selectedRecord.get("imageResourceName");
		if(Ext.isEmpty(imageResource)) {
			Ext.Msg.alert("提示信息", "该流程无可查看的流程图!");
			return;
		}
		
		var id = selectedRecord.get("id");
		processImage.show("def", id);
	}
	
	function deleteHandler() {
		if (grid.getSelectionModel().getCount() == 0) {
			Ext.Msg.alert("提示信息", "请至少选择一条记录!");
			return;
		}
		var selectedRecordArray = grid.getSelectionModel().getSelections();

		Ext.Msg.confirm("确认提示", "确定删除选定的记录?", function(btn) {
			if (btn == 'yes') {
				var ids = "";
				for ( var i = 0; i < selectedRecordArray.length; i++) {
					ids += selectedRecordArray[i].get("deploymentId") + ",";
				}

				var params = {
					ids : ids
				};

				var ajaxClass = new AjaxUtil(deleteProcessUrl);
				ajaxClass.request(params, true, null, function(obj) {
					onSubmitQueryHandler();
				});
			}
		});
	}

	function onSubmitQueryHandler() {
		
		var name = Ext.getCmp("query_name").getValue();
		var key = Ext.getCmp("query_key").getValue();

		store.baseParams.name = name;
		store.baseParams.key = key;
		
		store.load();
	}

	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), grid]
			});

	onSubmitQueryHandler();
	completePage();

});