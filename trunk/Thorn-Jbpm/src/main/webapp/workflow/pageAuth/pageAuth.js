var saveOrModifyUrl = sys.path + "/wf/pa/saveOrModifyPageAuth.jmt";
var deleteUrl = sys.path + "/wf/pa/deletePageAuth.jmt";
var getPageUrl = sys.path + "/wf/pa/getPageAuthPage.jmt";

var pageSize = 20;

var groupType;
var groupArray;

Ext.onReady(function() {
	Ext.QuickTips.init();

	/** ****************query panel start*************** */
	var query_attr = {
		title : "查询列表",
		region : "north",
		height : 70,
		labelWidth : 80
	};

	var query_form = new FormUtil(query_attr);

	query_form.addComp(getText("query_processDfId", "流程定义ID", 120), 0.2, true);
	query_form.addComp(getText("query_activityId", "环节名称", 120), 0.2, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.2, true);
	/** ****************query panel end*************** */

	/** ****************pageAuth Grid panel start************ */
	var msgRender = function(remark, metadata, record, rowIndex, colIndex) {
		var authArray = remark.split(",");
		var authCN = "";
		for ( var i = 0; i < authArray.length; i++) {
			authCN += pageAuthRender(authArray[i]);
		}
		return Render.detailRender(authCN, pa_grid.cm, colIndex);
	};
	
	var recordArray = [
			getRecord(null, "id", "string"),
			getRecord("流程定义ID", "processDfId", "string", 100, true),
			getRecord("环节名称", "activityId", "string", 100, false),
			getRecord("页面权限", "auth", "string", 500, false, msgRender)];
	var pa_grid = new GridUtil(getPageUrl, recordArray, pageSize);
	
	var grid_Bar = getCommonBar(saveHandler, modifyHandler, deleteHandler, userPermission);
	pa_grid.setBottomBar(grid_Bar);

	var listeners = {
		celldblclick : function(thisGrid, rowIndex, columnIndex, ev) {
			if(userPermission.SAVE == 'true') {
				modifyHandler();
			}
		}
	};
	pa_grid.setListeners(listeners);

	var grid_attr = {
		title : "页面权限列表",
		region : "center"
	};
	pa_grid.setGridPanel(grid_attr);
	/** ****************pageAuth Grid panel end************ */

	var grid = pa_grid.getGrid();
	var store = pa_grid.getStore();

	/** ****************pageAuth window start************ */
	var pa_form = new FormUtil({
				id : "paForm",
				collapsible : false,
				labelWidth : 100,
				border : false
			});
	
	pa_form.addComp(getText("processDfId", "流程定义ID", 180), 0.5, false);		
	pa_form.addComp(getText("activityId", "环节名称", 180), 0.5, false);	
	pa_form.addComp(getTextArea("auth", "页面权限", 420, 80), 0.9, false);	
	pa_form.addComp(getButton({
		handler : chooseHandler,
		text : "选择"
	}), 0.1, true);
	pa_form.addComp(getHidden("formType"), 0, true);
	pa_form.addComp(getHidden("id"), 0, true);
	
	var pa_win = new WindowUtil({
				width : 620,
				height : 220
	}, pa_form.getPanel(), paSaveOrModify);
	/** ****************pageAuth window end************ */
			
	
	/** ****************role window start************ */
	var auth_form = new FormUtil( {
		id : "authForm",
		collapsible : false,
		labelWidth : 30,
		border : false
	});
	var auth_win = new WindowUtil( {
		width : 450,
		height : 300
	}, auth_form.getPanel(), checkedAuthHandler);
	
	var auth_store = new Ext.data.ArrayStore({
		fields : [{
					name : "code",
					type : "string"
				}, {
					name : "name",
					type : "string"
				}],
		data : pageAuthDD
	});
	
	function chooseHandler() {
		var authArray = pa_form.findById("auth").getValue();
			
		var thisForm = auth_form.getPanel();
		thisForm.removeAll(true);
			
		auth_store.each(function(record){
			var code = record.get("code");
			var isChecked = false;
				
			if(authArray.indexOf(code) >= 0) {
				isChecked = true;
			}

			var cb = getCheckbox(code, record.get("name"), isChecked);
			auth_form.addComp(cb, 0.5, true);
		});
		thisForm.doLayout();
		auth_win.show("可选权限");
	}
	
	
	/** ****************role window end************ */
	function saveHandler() {
		pa_win.show("设置页面权限");
		pa_form.getForm().reset();
		setTextReadOnly(pa_form.findById("auth"));
		pa_form.findById("formType").setValue(
				Configuration.opType.SAVE);
	}
	
	function modifyHandler() {
		if (grid.getSelectionModel().getCount() != 1) {
			Ext.Msg.alert("提示信息", "请选择一条记录!");
			return;
		}

		pa_win.show("修改页面权限");
		pa_form.getForm().reset();
		setTextReadOnly(pa_form.findById("auth"));
		var selectedRecord = grid.getSelectionModel().getSelected();
		var values = {
			id : selectedRecord.get("id"),
			processDfId : selectedRecord.get("processDfId"),
			activityId : selectedRecord.get("activityId"),
			auth : selectedRecord.get("auth"),
			formType : Configuration.opType.MODIFY
		};
		pa_form.getForm().setValues(values);
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
					ids += selectedRecordArray[i].get("id") + ",";
				}

				var params = {
					ids : ids
				};

				var ajaxClass = new AjaxUtil(deleteUrl);
				ajaxClass.request(params, true, null, function(obj) {
					pa_grid.getStore().reload();
				});
			}
		});
	}		
			
	function paSaveOrModify() {
		var paForm = pa_form.getForm();

		if (!paForm.isValid()) {
			Ext.Msg.alert("提示信息", "请填写完整的数据信息!");
			return;
		}

		var ajaxClass = new AjaxUtil(saveOrModifyUrl);

		var opType = pa_form.findById("formType").getValue();

		var params = {
			opType : opType
		};

		var callBack_obj = new Object();
		callBack_obj.grid = pa_grid;
		callBack_obj.win = pa_win;
		callBack_obj.form = pa_form;

		ajaxClass.submit(paForm, params, true, callBack_obj, function(obj) {
			obj.grid.getStore().reload();
			var thisForm = obj.form;
			var opType = thisForm.findById("formType").getValue();

			if (opType == Configuration.opType.SAVE) {
				thisForm.getForm().reset();
				thisForm.findById("formType").setValue(Configuration.opType.SAVE);
			} else {
				obj.win.hide();
			}
		});
	}

	function onSubmitQueryHandler() {

		var activityId = Ext.getCmp("query_activityId").getValue();
		var processDfId = Ext.getCmp("query_processDfId").getValue();

		store.baseParams.activityId = activityId;
		store.baseParams.processDfId = processDfId;

		store.load({
					params : {
						start : 0,
						limit : pa_grid.pageSize
					}
				});
	}
	
	function checkedAuthHandler() {
		var thisForm = auth_form.getPanel();
		var authArray = "";
		
		var checkedGroup = thisForm.findByType("checkbox");
		for (var i = 0; i < checkedGroup.length; i++) {
			var ck = checkedGroup[i];
			if(ck.getValue()) {
				authArray += ck.getId() + ",";
			}
		}

		if (authArray.length > 0) {
			authArray = authArray.substring(0, authArray.length - 1);
		}

		pa_form.findById("auth").setValue(authArray);
		auth_win.hide();
	}
	
	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), pa_grid.getGrid()]
			});

	onSubmitQueryHandler();
	completePage();
});
