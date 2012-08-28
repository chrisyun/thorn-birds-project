var projectPageUrl = sys.path + "/project/getProjectPage.jmt";
var projectSubmitUrl = sys.path + "/project/saveOrModifyProject.jmt";
var projectDeleteUrl = sys.path + "/project/deleteProject.jmt";

var getUsersByProvince = sys.path + "/user/getUserList.jmt";
var getHeritorByProvince = sys.path + "/heritor/getHeritorList.jmt";
var bingingProject = sys.path + "/heritor/bingingProject.jmt";

var pageSize = 20;

var chooseProvince;
var chooseId;

Ext.onReady(function() {
	Ext.QuickTips.init();

	/** ****************query panel start*************** */
	var query_attr = {
		title : "查询列表",
		region : "north",
		height : 100,
		labelWidth : 80
	};

	var query_form = new FormUtil(query_attr);

	query_form.addComp(getComboBox("query_type", "项目类别", 160, projectType,
			false), 0.3, true);
	query_form.addComp(getText("query_name", "项目名称",160), 0.3, true);
	query_form.addComp(getComboBox("query_area", "所属省份", 160, area, false),
			0.3, true);
	query_form.addComp(getText("query_code", "项目编码",160), 0.3, true);
	query_form.addComp(getText("query_userName", "项目保护单位",160), 0.3, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.3, true);
	/** ****************query panel end*************** */

	/** ****************project Grid panel start************ */

	var recordArray = [
			getRecord(null, "id", "string"),
			getRecord(null, "userId", "string"),
			getRecord(null, "bigNo", "string"),
			getRecord(null, "smallNo", "string"),
			getRecord("省份", "province", "string", 80, true, areaRender),
			getRecord("项目类别", "type", "string", 150, true, projectTypeRender),
			getRecord("项目编码", "code", "string", 100, false),
			getRecord("项目名称", "name", "string", 200, true),
			getRecord("申报地区或单位", "area", "string", 200, false),
			getRecord("批次", "batchNum", "string", 50, true),
			getRecord("项目保护单位", "userName", "string", 200, true),
			getRecord("民族", "minority", "string", 80, true, minorityRender),
			getRecord("联合国非遗项目", "isUnProject", "string", 130, true, yesOrNoRender)];
	var project_grid = new GridUtil(projectPageUrl, recordArray, pageSize);
	
	var grid_Bar = getCommonBar(saveHandler, modifyHandler, deleteHandler, userPermission);
	if(userPermission.BINGING == "true") {
		grid_Bar.push("-");
		grid_Bar.push({
			text : "设置项目传承人",
			iconCls : "tree-auth",
			handler : bingingHandler
		});
	}
	project_grid.setBottomBar(grid_Bar);

	var listeners = {
		celldblclick : function(thisGrid, rowIndex, columnIndex, ev) {
			if(userPermission.MODIFY == "true") {
				modifyHandler();
			}
		}
	};
	project_grid.setListeners(listeners);

	var grid_attr = {
		title : "非遗项目列表",
		region : "center"
	};
	project_grid.setGridPanel(grid_attr);
	/** ****************project Grid panel end************ */

	var grid = project_grid.getGrid();
	var store = project_grid.getStore();

	/** ****************project window start************ */
	var project_form = new FormUtil({
		id : "projectForm",
		collapsible : false,
		labelWidth : 110,
		border : false
	});
	
	
	var userStore = new Ext.data.Store({
		url : getUsersByProvince,
		listeners : {
			"beforeload" : function(thisStore) {
				var province = project_form.findById("show_province").getValue();
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
	
	var provinceCb = getComboBox("province", "所属省份", 180, area);
	provinceCb.listeners = {
		"change" : function(field, newValue, oldValue) {
			project_form.findById("show_userId").setValue();
			userStore.load();
		}	
	};
	
	project_form.addComp(provinceCb, 0.5, false);
	project_form.addComp(getNumberText("bigNo", "大项序号", 180), 0.5, true);
	project_form.addComp(getComboBox("type", "项目类别", 180, projectType),
			0.5, false);
	project_form.addComp(getText("code", "项目编码", 180), 0.5, false);
	project_form.addComp(getText("name", "项目名称", 180), 0.5, false);

	project_form.addComp(getNumberText("smallNo", "子项序号", 180), 0.5, true);
	project_form.addComp(getComboBox("minority", "民族", 180, minority),
			0.5, true);
	project_form.addComp(getComboBox("isUnProject", "联合国非遗项目", 180,
			yesOrNo), 0.5, true);
	project_form.addComp(getText("batchNum", "批次", 180), 0.5, false);
	project_form.addComp(getText("area", "申报地区或单位", 180), 0.5, false);
	
	var userCb = getComboBox("userId", "项目保护单位", 180, null);
	userCb.valueField = "userId";
	userCb.displayField = "userName";
	userCb.lazyInit = true;
	userCb.mode = "remote";
	userCb.store = userStore;
	userCb.listeners = {
		"expand" : function(field) {
			userStore.removeAll();
			userStore.reload();
		}	
	};
	
	project_form.addComp(userCb, 0.5, false);
	project_form.addComp(getButton({
		text : "新建项目承担单位",
		handler : function() {
			var url = sys.path + "/system/user/user.jsp?createUser=v"; 
			
			parent.window.setActivate(url, {
				id : "USER",
				text : "新建项目承担单位",
				attributes : {
					iconCls : "tree-user"
				}
			});
		}
	}), 0.5, true);
	
	project_form.addComp(getHidden("opType"), 0, true);
	project_form.addComp(getHidden("id"), 0, true);
	
	var project_win = new WindowUtil({
		width : 650,
		height : 340
	}, project_form.getPanel(), saveOrModify);

	/** ****************project window end************ */
	
	
	/** ****************heritor window start************ */
	var checkedRender = function(data, metadata, record, rowIndex, colIndex) {
		var projectId = record.get("projectId");
		
		if(!Ext.isEmpty(projectId) && projectId == chooseId) {
			var sm = heritor_grid.getGrid().selModel;
			
			var selectedArray = sm.getSelections();
			selectedArray.push(record);
			
			sm.selectRecords(selectedArray);
		}
		
		return data;
	};
	
 	var heritor_recordArray = [
 	      			getRecord(null, "id", "string"),
 	      			getRecord(null, "projectId", "string"),
 	      			getRecord("省份", "province", "string", 80, true, areaRender),
 	      			getRecord("项目名称", "projectName", "string", 200, true, checkedRender),
 	      			getRecord("传承人", "name", "string", 100, true),
 	      			getRecord("性别", "gender", "string", 80, true, genderRender),
 	      			getRecord("是否去世", "isDie", "string", 120, true, yesOrNoRender)];
 	var heritor_grid = new GridUtil(getHeritorByProvince, heritor_recordArray);
	
	var heritor_name = new Ext.ux.form.SearchField({
		id : "heritor_queryField",
		width : 160,
		emptyText : "请输入查询关键字"
	});
	heritor_grid.setTopBar([{
		text : '传承人姓名:',
		minWidth : 100
	},heritor_name]);	
	
	heritor_grid.setGridPanel({
		collapsible : false,
		border : false,
		region : "center",
		split : false
	});
	
	heritor_name.onTrigger2Click = loadHeritor;
	
	function loadHeritor() {
		var heritorStore = heritor_grid.getStore();
		var name = heritor_name.getValue();
		heritorStore.baseParams.name = name;
		heritorStore.baseParams.province = chooseProvince;
		heritorStore.load();
	}
	
	var heritor_Window = new WindowUtil({
		title : "非遗传承人列表",
		layout : 'border',
		width : 680,
		height : 420
	},  heritor_grid.getGrid(), bingingHeritors);
	
	function bingingHeritors() {
		var herGrid = heritor_grid.getGrid();
		
		if (herGrid.getSelectionModel().getCount() == 0) {
			Ext.Msg.alert("提示信息", "请至少选择一条记录!");
			return;
		}
		var selectedRecordArray = herGrid.getSelectionModel()
				.getSelections();
		
		var ids = "";
		for ( var i = 0; i < selectedRecordArray.length; i++) {
			ids += selectedRecordArray[i].get("id") + ",";
		}

		var params = {
			projectId : chooseId,
			ids : ids
		};
		
		var ajaxClass = new AjaxUtil(bingingProject);
		ajaxClass.request(params, true, null, function(obj) {
			heritor_Window.hide();
		});
	}
	
	function bingingHandler() {
		if (grid.getSelectionModel().getCount() != 1) {
			Ext.Msg.alert("提示信息", "请选择一条记录!");
			return;
		}
		
		heritor_Window.show("设置项目传承人");
		var selectedRecord = grid.getSelectionModel().getSelected();
		chooseProvince = selectedRecord.get("province");
		chooseId = selectedRecord.get("id");
		loadHeritor();
	}
	
	/** ****************heritor window end************ */
	function saveHandler() {
		project_win.show("新增非遗项目");

		project_form.getForm().reset();
		project_form.findById("opType").setValue(
				Configuration.opType.SAVE);
		
		project_form.findById("show_province").setValue(user.org);
	}
	
	function modifyHandler() {
		if (grid.getSelectionModel().getCount() != 1) {
			Ext.Msg.alert("提示信息", "请选择一条记录!");
			return;
		}

		project_win.show("修改非遗项目");

		project_form.getForm().reset();

		var selectedRecord = grid.getSelectionModel().getSelected();
		var values = {
			id : selectedRecord.get("id"),
			name : selectedRecord.get("name"),
			code : selectedRecord.get("code"),
			type : selectedRecord.get("type"),
			isUnProject : selectedRecord.get("isUnProject"),
			bigNo : selectedRecord.get("bigNo"),
			smallNo : selectedRecord.get("smallNo"),
			batchNum : selectedRecord.get("batchNum"),
			area : selectedRecord.get("area"),
			userId : selectedRecord.get("userId"),
			province : selectedRecord.get("province"),
			opType : Configuration.opType.MODIFY
		};
		project_form.getForm().setValues(values);
		project_form.findById("show_userId").setRawValue(
				selectedRecord.get("userName"));
	}
	
	function saveOrModify() {
		var form = project_form.getForm();

		if (!form.isValid()) {
			Ext.Msg.alert("提示信息", "请填写完整的项目信息!");
			return;
		}

		var ajaxClass = new AjaxUtil(projectSubmitUrl);

		var callBack_obj = new Object();
		callBack_obj.grid = grid;
		callBack_obj.win = project_win;
		callBack_obj.form = project_form;

		ajaxClass.submit(form, null, true, callBack_obj, function(
				obj) {
			obj.grid.getStore().reload();
			var thisForm = obj.form;
			var opType = thisForm.findById("opType").getValue();

			if (opType == Configuration.opType.SAVE) {
				thisForm.getForm().reset();
				thisForm.findById("opType").setValue(opType);
			} else {
				obj.win.hide();
			}
		});
	}
	
	function deleteHandler() {
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

				var ajaxClass = new AjaxUtil(projectDeleteUrl);
				ajaxClass.request(params, true, null, function(obj) {
					grid.getStore().reload();
				});
			}
		});
	}
	
	function onSubmitQueryHandler() {

		var type = Ext.getCmp("show_query_type").getValue();
		var name = Ext.getCmp("query_name").getValue();
		var area = Ext.getCmp("show_query_area").getValue();
		var code = Ext.getCmp("query_code").getValue();
		var userName = Ext.getCmp("query_userName").getValue();

		store.baseParams.name = name;
		store.baseParams.code = code;
		store.baseParams.userName = userName;
		store.baseParams.type = type;
		store.baseParams.province = area;

		store.load({
					params : {
						start : 0,
						limit : project_grid.pageSize
					}
				});
	}

	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), project_grid.getGrid()]
			});

	onSubmitQueryHandler();
	completePage();
});
