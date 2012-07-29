var todoPageUrl = sys.path + "/wf/cm/getTodoPage.jmt";
var todoOpenUrl = sys.path + "/wf/cm/openTodoProcess.jmt";

var pageSize = 20;

var onSubmitQueryHandler;

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

	query_form.addComp(getComboBox("query_flowKey", "流程名称", 300, wfNameDD, false),
			0.6, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.4, true);
	/** ****************query panel end*************** */

	/** ****************todo Grid panel start************ */
	var openRender = function(name, metadata, record, rowIndex, colIndex) {
		var taskId = record.get("taskId");
		var url = todoOpenUrl + "?taskId=" + taskId;
		var link = "<a href='" + url + "' target='_blank'>" + name + "</a>";

		return link;
	};
	
	var recordArray = [
			getRecord(null, "taskId", "string"),
			getRecord(null, "flowKey", "string"),
			getRecord(null, "flowInstId", "string"),
			getRecord("流程名称", "flowKey", "string", 150, false, wfNameRender),
			getRecord("标题", "title", "string", 200, false, openRender),
			getRecord("当前环节", "activityName", "string", 150, true),
			getRecord("发送人", "sender", "string", 70, true),
			getRecord("接收时间", "receiptTime", "string", 100, true),
			getRecord("优先级", "priority", "string", 70, true)];
	var todo_grid = new GridUtil(todoPageUrl, recordArray, pageSize);
				
	todo_grid.setBottomBar(null);

	var grid_attr = {
		title : "待办列表",
		region : "center"
	};
	todo_grid.setGridPanel(grid_attr);
	/** ****************todo Grid panel end************ */

	var grid = todo_grid.getGrid();
	var store = todo_grid.getStore();

	onSubmitQueryHandler = function() {
		var flowKey = Ext.getCmp("show_query_flowKey").getValue();

		store.baseParams.flowKey = flowKey;

		store.load({
					params : {
						start : 0,
						limit : todo_grid.pageSize
					}
				});
	};

	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), todo_grid.getGrid()]
			});

	onSubmitQueryHandler();
	completePage();
});

function refreshGrid() {
	onSubmitQueryHandler();
}
