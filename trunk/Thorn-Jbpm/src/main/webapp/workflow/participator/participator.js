var ppSaveOrModifyUrl = sys.path + "/wf/pp/saveOrModifyParticipator.jmt";
var ppDeleteUrl = sys.path + "/wf/pp/deleteParticipator.jmt";
var ppPageUrl = sys.path + "/wf/pp/getParticipatorPage.jmt";

var pageSize = 20;

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
	query_form.addComp(getComboBox("query_type", "参与者类型", 120, entityTypeDD,
					false), 0.2, true);
	query_form.addComp(getText("query_variable", "绑定变量名", 120), 0.2, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.2, true);
	/** ****************query panel end*************** */

	/** ****************participator Grid panel start************ */
	var recordArray = [
			getRecord(null, "id", "string"),
			getRecord("流程定义ID", "processDfId", "string", 100, true),
			getRecord("环节名称", "activityId", "string", 100, false),
			getRecord("参与者类型", "entityType", "string", 70, true, entityTypeRender),
			getRecord("参与者", "entity", "string", 200, false),
			getRecord("限制类型", "limitType", "string", 80, true, limitTypeRender),
			getRecord("绑定变量名", "variable", "string", 80, false)];
	var pp_grid = new GridUtil(ppPageUrl, recordArray, pageSize);
	
	var grid_Bar = getCommonBar(saveHandler, modifyHandler, deleteHandler, userPermission);
	pp_grid.setBottomBar(grid_Bar);

	var listeners = {
		celldblclick : function(thisGrid, rowIndex, columnIndex, ev) {
			if(userPermission.SAVE == 'true') {
				modifyHandler();
			}
		}
	};
	pp_grid.setListeners(listeners);

	var grid_attr = {
		title : "参与者设置列表",
		region : "center"
	};
	pp_grid.setGridPanel(grid_attr);
	/** ****************participator Grid panel end************ */

	var grid = pp_grid.getGrid();
	var store = pp_grid.getStore();

	/** ****************participator window start************ */
	var pp_form = new FormUtil({
				id : "ppForm",
				collapsible : false,
				labelWidth : 100,
				border : false
			});
	
	pp_form.addComp(getText("processDfId", "流程定义ID", 180), 0.5, false);		
	pp_form.addComp(getText("activityId", "环节名称", 180), 0.5, false);	
	pp_form.addComp(getComboBox("entityType", "参与者类型", 180, entityTypeDD, false), 0.5,
			false);
	pp_form.addComp(getText("entity", "参与者", 180), 0.5, false);	
	pp_form.addComp(getComboBox("limitType", "限制类型", 180, limitTypeDD, false), 0.5,
			true);
	pp_form.addComp(getText("variable", "绑定变量名", 180), 0.5, false);
	pp_form.addComp(getHidden("formType"), 0, true);
	pp_form.addComp(getHidden("id"), 0, true);
	
	var pp_win = new WindowUtil({
				width : 620,
				height : 220
			}, pp_form.getPanel(), ppSaveOrModify);

	/** ****************participator window end************ */
	function saveHandler() {
		pp_win.show("绑定环节参与者");
		
		pp_form.getForm().reset();
		pp_form.findById("formType").setValue(
				Configuration.opType.SAVE);
	}
	
	function modifyHandler() {
		if (grid.getSelectionModel().getCount() != 1) {
			Ext.Msg.alert("提示信息", "请选择一条记录!");
			return;
		}

		pp_win.show("修改环节参与者");
		pp_form.getForm().reset();

		var selectedRecord = grid.getSelectionModel().getSelected();
		var values = {
			id : selectedRecord.get("id"),
			processDfId : selectedRecord.get("processDfId"),
			activityId : selectedRecord.get("activityId"),
			entityType : selectedRecord.get("entityType"),
			entity : selectedRecord.get("entity"),
			limitType : selectedRecord.get("limitType"),
			variable : selectedRecord.get("variable"),
			formType : Configuration.opType.MODIFY
		};
		pp_form.getForm().setValues(values);
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

				var ajaxClass = new AjaxUtil(ppDeleteUrl);
				ajaxClass.request(params, true, null, function(obj) {
					pp_grid.getStore().reload();
				});
			}
		});
	}		
			
	function ppSaveOrModify() {
		var ppForm = pp_form.getForm();

		if (!ppForm.isValid()) {
			Ext.Msg.alert("提示信息", "请填写完整的字典数据信息!");
			return;
		}

		var ajaxClass = new AjaxUtil(ppSaveOrModifyUrl);

		var opType = pp_form.findById("formType").getValue();

		var params = {
			opType : opType
		};

		var callBack_obj = new Object();
		callBack_obj.grid = pp_grid;
		callBack_obj.win = pp_win;
		callBack_obj.form = pp_form;

		ajaxClass.submit(ppForm, params, true, callBack_obj, function(obj) {
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
		var thisForm = query_form.getForm();

		var activityId = Ext.getCmp("query_activityId").getValue();
		var processDfId = Ext.getCmp("query_processDfId").getValue();
		var variable = Ext.getCmp("query_variable").getValue();
		var entityType = Ext.getCmp("show_query_type").getValue();

		store.baseParams.activityId = activityId;
		store.baseParams.processDfId = processDfId;
		store.baseParams.variable = variable;
		store.baseParams.entityType = entityType;

		store.load({
					params : {
						start : 0,
						limit : pp_grid.pageSize
					}
				});
	}

	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), pp_grid.getGrid()]
			});

	onSubmitQueryHandler();
	completePage();
});
