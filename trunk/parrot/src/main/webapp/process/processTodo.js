var todoPageUrl = sys.path + "/wf/cm/getPendingPage.jmt";

var getUsersByProvince = sys.path + "/user/getUserList.jmt";

var pageSize = 20;

Ext.onReady(function() {
	Ext.QuickTips.init();

	/** ****************query panel start*************** */
	var query_attr = {
		title : "查询列表",
		region : "north",
		height : 120,
		labelWidth : 70
	};
	
	var query_form = new FormUtil(query_attr);
	
	var userStore = new Ext.data.Store({
		url : getUsersByProvince,
		listeners : {
			"beforeload" : function(thisStore) {
				var province = query_form.findById("show_query_area").getValue();
				thisStore.baseParams.area = province;
			}
		},
		reader : new Ext.data.JsonReader({}, Ext.data.Record
						.create([{
									name : 'userId',
									type : 'string'
								}, {
									name : 'userName',
									type : 'string'
								}]))
	});
	
	query_form.addComp(getComboBox("query_flowType", "流程类型", 160, flowTypeDD, false),
			0.3, true);
	
	var provinceCb = getComboBox("query_area", "申报省份", 160, area, false);
	provinceCb.listeners = {
		"change" : function(field, newValue, oldValue) {
			query_form.findById("show_query_creater").setValue();
			userStore.load();
		}	
	};
	query_form.addComp(provinceCb, 0.3, true);
	var userCb = getComboBox("query_creater", "申报单位", 160, null);
	userCb.valueField = "userId";
	userCb.displayField = "userName";
	userCb.lazyInit = true;
	userCb.mode = "remote";
	userCb.store = userStore;
	query_form.addComp(userCb, 0.3, true);
	
	
	query_form.addComp(getText("query_createrName", "申报单位名称",300), 0.6, true);
	query_form.addComp(getComboBox("query_flowStatus", "审批状态", 160, flowStatusDD, false),
			0.3, true);
	query_form.addComp(getDateText("query_startTime", "开始日期", 120), 0.3, true);
	query_form.addComp(getDateText("query_endTime", "结束日期", 120), 0.3, true);
	
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.3, true);
	/** ****************query panel end*************** */

	/** ****************todo Grid panel start************ */
	var openRender = function(name, metadata, record, rowIndex, colIndex) {
		var id = record.get("id");
		var link = "<a href=\"javascript:openTodoFlow('"+id+"');\">" + name + "</a>";

		return link;
	};
	
	var recordArray = [
			getRecord(null, "id", "string"),
			getRecord("流程类型", "flowType", "string", 150, true, flowTypeRender),
			getRecord("当前环节", "activity", "string", 100, true),
			getRecord("申报地区或单位", "createrName", "string", 200, true, openRender),
			getRecord("上一环节审批情况", "flowStatus", "string", 150, true, flowStatusRender),
			getRecord("申报时间", "createTime", "string", 100, true),
			getRecord("申报省份", "province", "string", 100, true, areaRender)];
	var todo_grid = new GridUtil(todoPageUrl, recordArray, pageSize);
	
	todo_grid.setBottomBar();

	var grid_attr = {
		title : "待办列表",
		region : "center"
	};
	todo_grid.setGridPanel(grid_attr);
	/** ****************todo Grid panel end************ */

	var grid = todo_grid.getGrid();
	var store = todo_grid.getStore();

	function onSubmitQueryHandler() {

		var flowType = Ext.getCmp("show_query_flowType").getValue();
		var flowStatus = Ext.getCmp("show_query_flowStatus").getValue();
		var province = Ext.getCmp("show_query_area").getValue();
		var creater = Ext.getCmp("show_query_creater").getValue();
		var createrName = Ext.getCmp("query_createrName").getValue();
		var startTime = Ext.getCmp("query_startTime").getValue().format("Y-m-d");
		var endTime = Ext.getCmp("query_endTime").getValue().format("Y-m-d");
		
		store.baseParams.flowType = flowType;
		store.baseParams.flowStatus = flowStatus;
		store.baseParams.province = province;
		store.baseParams.creater = creater;
		store.baseParams.createrName = createrName;
		store.baseParams.startTime = startTime;
		store.baseParams.endTime = endTime;

		store.load({
					params : {
						start : 0,
						limit : todo_grid.pageSize
					}
				});
	}

	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), todo_grid.getGrid()]
			});

	onSubmitQueryHandler();
	completePage();
});


function openTodoFlow(id) {
	var url = sys.path + "/wf/cm/openTodoProcess.jmt?id=" + id;
	var height = window.screen.availHeight - 50;
	var width = window.screen.availWidth - 50;
	
	window.open (url, "flowPage", 
			"height="+height+", width="+width+", top=0, left=0, toolbar=no, menubar=no, scrollbars=yes,resizable=no,location=no, status=no");
	//window.open (url, "flowPage");
}
