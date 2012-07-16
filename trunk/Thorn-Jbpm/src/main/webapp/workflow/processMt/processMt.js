var processInstPageUrl = sys.path + "/wf/getProcessInstPage.jmt";

var pageSize = 20;

Ext.onReady(function() {
	Ext.QuickTips.init();

	/** ****************query panel start*************** */
	var query_attr = {
		title : "查询列表",
		region : "north",
		height : 70,
		labelWidth : 100
	};

	var query_form = new FormUtil(query_attr);

	query_form.addComp(getText("query_dfId", "流程定义ID", 120), 0.2, true);
	query_form.addComp(getText("query_id", "流程实例ID", 120), 0.2, true);
	query_form.addComp(getText("query_key", "流程实例Key", 120), 0.2, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.2, true);
	/** ****************query panel end*************** */

	/** ****************inst Grid panel start************ */
	var recordArray = [
			getRecord("流程定义ID", "processDefinitionId", "string", 70, false),
			getRecord("流程实例ID", "id", "string", 70, false),
			getRecord("流程实例Key", "key", "string", 70, false),
			getRecord("流程名称", "name", "string", 70, false),
			getRecord("当前环节", "activeActivityName", "string", 100, false),
			getRecord("状态", "state", "string", 50, false),
			getRecord("是否挂起", "suspended", "string", 70, true),
			getRecord("是否结束", "ended", "string", 70, true)];
	var inst_grid = new GridUtil(processInstPageUrl, recordArray, pageSize);

	var bar = new Array();
	if (userPermission.CANCEL == "true") {
		bar.push("-");
		bar.push({
			text : "结束流程",
			iconCls : "silk-cross",
			minWidth : Configuration.minBtnWidth,
			handler : cancelHandler
		});
	}
	if (userPermission.DELETE == "true") {
		bar.push("-");
		bar.push({
			text : "删除流程",
			iconCls : "silk-delete",
			minWidth : Configuration.minBtnWidth,
			handler : deleteHandler
		});
	}
	bar.push("-");
	bar.push({
		text : "查看流程状态图",
		iconCls : "silk-edit",
		minWidth : Configuration.minBtnWidth,
		handler : instanceImageHandler
	});
	inst_grid.setBottomBar(bar);

	var grid_attr = {
		title : "流程实例列表",
		region : "center"
	};
	inst_grid.setGridPanel(grid_attr);
	/** ****************inst Grid panel end************ */

	var grid = inst_grid.getGrid();
	var store = inst_grid.getStore();
	var processImage = new ProcessImage();
	
	function instanceImageHandler() {
		if (grid.getSelectionModel().getCount() != 1) {
			Ext.Msg.alert("提示信息", "请选择一条记录!");
			return;
		}

		var selectedRecord = grid.getSelectionModel().getSelected();
		var id = selectedRecord.get("id");
		
		processImage.show("inst", id);
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
				
				deleteProcessInst(ids, onSubmitQueryHandler);
			}
		});
	}
	
	function cancelHandler() {
		if (grid.getSelectionModel().getCount() == 0) {
			Ext.Msg.alert("提示信息", "请至少选择一条记录!");
			return;
		}
		var selectedRecordArray = grid.getSelectionModel().getSelections();

		Ext.Msg.confirm("确认提示", "确定结束选定的记录?", function(btn) {
			if (btn == 'yes') {
				var ids = "";
				for ( var i = 0; i < selectedRecordArray.length; i++) {
					ids += selectedRecordArray[i].get("id") + ",";
				}
				
				cancelProcessInst(ids, "控制台结束", onSubmitQueryHandler);
			}
		});
	}
	
	function onSubmitQueryHandler() {
		var thisForm = query_form.getForm();

		var dfId = Ext.getCmp("query_dfId").getValue();
		var id = Ext.getCmp("query_id").getValue();
		var key = Ext.getCmp("query_key").getValue();

		store.baseParams.processDfId = dfId;
		store.baseParams.instanceId = id;
		store.baseParams.instanceKey = key;

		store.load({
			params : {
				start : 0,
				limit : inst_grid.pageSize
			}
		});
	}

	var viewport = new Ext.Viewport({
		border : false,
		layout : "border",
		items : [query_form.getPanel(), inst_grid.getGrid()]
	});

	onSubmitQueryHandler();
	completePage();
});
