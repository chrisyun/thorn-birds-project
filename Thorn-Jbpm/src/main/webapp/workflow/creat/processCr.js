var processCreatUrl = sys.path + "/wf/cr/getCreatProcessList.jmt";
var modifyFlowTypeUrl = sys.path + "/wf/cr/modifyFlowType.jmt";
var deleteFlowTypeUrl = sys.path + "/wf/cr/deleteFlowType.jmt";

Ext.onReady(function() {
	Ext.QuickTips.init();
	
	var type_store = new Ext.data.ArrayStore({
		fields : [{
					name : "code",
					type : "string"
				}, {
					name : "name",
					type : "string"
				}],
		data : flowTypeDD
	});
	
	var msgRender = function(remark, metadata, record, rowIndex, colIndex) {
		return Render.detailRender(remark, null, colIndex, 50);
	};
	var openRender = function(name, metadata, record, rowIndex, colIndex) {
		var key = record.get("flowKey");
		var url = sys.path + "/AlertTimeOut.jsp?key=" + key
		var link = "<a href='" + url + "' target='_blank'>" + name + "</a>";

		return link;
	};
	
	var recordArray = [
		getRecord(null, "id", "string"),
		getRecord(null, "flowKey", "string"),
		getRecord(null, "flowType", "string"),
		getRecord("流程名称", "flowName", "string", 100, false, openRender),
		getRecord("描述", "flowDesc", "string", 300, false, msgRender)];
	
	var tabArray = new Array();
	
	type_store.each(function(record){
		var code = record.get("code");
		var name = record.get("name");
		
		var grid = new GridUtil(processCreatUrl, recordArray, 0);
		
		var listeners = {
			celldblclick : function(thisGrid, rowIndex, columnIndex, ev) {
				if(userPermission.MODIFY == "true") {
					modifyHandler();
				}
			}
		};
		grid.setListeners(listeners);
		
		grid.setGridPanel({
			collapsible : false,
			iconCls : null,
			border : true
		});
		
		var panel = new Ext.Panel({
			title : name,
			layout : "fit",
			items : [grid.getGrid()]
		});
		
		tabArray.push(panel);
		
		grid.getStore().baseParams.type = code;
		grid.getStore().load();
	});
	
	var tab = new Ext.TabPanel({
		border : false,
		activeTab : 0,
		margins : "2 0 2 0",
		resizeTabs : true,
		deferredRender : false,
		tbar : getCommonBar(null, modifyHandler, deleteHandler, userPermission),
		items : tabArray
	});
	
	/** ****************modify window start************ */
	var type_form = new FormUtil({
		id : "typeForm",
		collapsible : false,
		labelWidth : 100,
		border : false
	});
	
	type_form.addComp(getText("flowName", "流程中文名", 220), 1.0, false);
	type_form.addComp(getComboBox("flowType", "流程类型", 220, flowTypeDD, false),
			1.0, false);
	type_form.addComp(getTextArea("flowDesc", "描述", 220, 60), 1.0, true);
	type_form.addComp(getHidden("id"), 0, false);

	var type_win = new WindowUtil({
		width : 380,
		height : 240
	}, type_form.getPanel(), onModifyHandler);

	/** ****************modify window end************ */
	var viewport = new Ext.Viewport({
		border : false,
		layout : "fit",
		items : [tab]
	});
	
	function modifyHandler() {
		var grid = tab.getActiveTab().findByType("grid")[0];
		
		if (grid.getSelectionModel().getCount() != 1) {
			Ext.Msg.alert("提示信息", "请选择一条记录!");
			return;
		}

		type_win.show("修改流程类型");

		type_form.getForm().reset();

		var selectedRecord = grid.getSelectionModel().getSelected();
		var values = {
			flowDesc : selectedRecord.get("flowDesc"),
			id : selectedRecord.get("id"),
			flowName : selectedRecord.get("flowName"),
			flowType : selectedRecord.get("flowType")
		};
		type_form.getForm().setValues(values);
	}
	
	function deleteHandler() {
		var grid = tab.getActiveTab().findByType("grid")[0];
		
		if (grid.getSelectionModel().getCount() == 0) {
			Ext.Msg.alert("提示信息", "请至少选择一条记录!");
			return;
		}
		var selectedRecordArray = grid.getSelectionModel()
				.getSelections();

		Ext.Msg.confirm("确认提示", "确定删除选定的记录?", function(btn) {
			if (btn == "yes") {
				var ids = "";
				for ( var i = 0; i < selectedRecordArray.length; i++) {
					ids += selectedRecordArray[i].get("id") + ",";
				}

				var params = {
					ids : ids
				};

				var ajaxClass = new AjaxUtil(deleteFlowTypeUrl);
				ajaxClass.request(params, true, null, function(obj) {
					grid.getStore().reload();
				});
			}
		});	
	}
	
	function onModifyHandler() {
		var form = type_form.getForm();
		var grid = tab.getActiveTab().findByType("grid")[0];
		
		if (!form.isValid()) {
			Ext.Msg.alert("提示信息", "请填写完整的流程信息!");
			return;
		}

		var ajaxClass = new AjaxUtil(modifyFlowTypeUrl);

		var callBack_obj = new Object();
		callBack_obj.grid = grid;
		callBack_obj.win = type_win;
		callBack_obj.form = type_form;

		ajaxClass.submit(form, null, true, callBack_obj, function(
				obj) {
			obj.grid.getStore().reload();
			obj.win.hide();
		});
	}
	
	completePage();
});
