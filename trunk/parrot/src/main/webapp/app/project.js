var projectPageUrl = sys.path + "/project/getProjectPage.jmt";
var projectSubmitUrl = sys.path + "/project/saveOrModifyProject.jmt";
var projectDeleteUrl = sys.path + "/project/deleteProject.jmt";

var pageSize = 20;

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

	query_form.addComp(getComboBox("query_type", "项目类别", 120, projectType,
			false), 0.3, true);
	query_form.addComp(getText("query_name", "项目名称",120), 0.3, true);
	query_form.addComp(getComboBox("query_area", "所属省份", 120, module, false),
			0.3, true);
	query_form.addComp(getText("query_code", "项目编码",120), 0.3, true);
	query_form.addComp(getText("query_userName", "申报单位",120), 0.3, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.3, true);
	/** ****************query panel end*************** */

	/** ****************project Grid panel start************ */

	var recordArray = [
			getRecord(null, "id", "string"),
			getRecord(null, "userId", "string"),
			getRecord("省份", "province", "string", 80, true, areaRender),
			getRecord("大项序号", "bigNo", "string", 100, true),
			getRecord("项目类别", "type", "string", 150, true, projectTypeRender),
			getRecord("项目编码", "code", "string", 100, false),
			getRecord("项目名称", "name", "string", 200, true),
			getRecord("子项序号", "smallNo", "string", 100, true),
			getRecord("申报地区或单位", "area", "string", 200, false),
			getRecord("批次", "batchNum", "string", 50, true),
			getRecord("项目保护单位", "userName", "string", 200, true),
			getRecord("民族", "minority", "string", 80, true, minorityRender),
			getRecord("联合国非遗项目", "isUnProject", "string", 130, true, yesOrNoRender)];
	var project_grid = new GridUtil(projectPageUrl, recordArray, pageSize);
	
	var grid_Bar = getCommonBar(saveHandler, modifyHandler, deleteHandler, userPermission);
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
	
	project_form.addComp(getComboBox("province", "所属省份", 180, area, true), 0.5,
			true);
	project_form.addComp(getText("bigNo", "大项序号", 180), 0.5, true);
	project_form.addComp(getComboBox("type", "项目类别", 180, projectType, true), 0.5,
			true);
	project_form.addComp(getText("code", "项目编码", 180), 0.5, true);
	project_form.addComp(getText("name", "项目名称", 180), 0.5, true);
	
	project_form.addComp(getText("smallNo", "子项序号", 180), 0.5, true);
	project_form.addComp(getComboBox("minority", "民族", 180, minority, true), 0.5,
			true);
	project_form.addComp(getComboBox("minority", "联合国非遗项目", 180, yesOrNo, true), 0.5,
			true);
	project_form.addComp(getText("batchNum", "批次", 180), 0.5, true);
	project_form.addComp(getText("area", "申报地区或单位", 180), 0.5, true);
	project_form.addComp(getComboBox("userId", "申报单位", 180, yesOrNo, true), 0.5,
			true);
	
	project_form.addComp(getHidden("opType"), 0, true);
	project_form.addComp(getHidden("id"), 0, true);
	
	var project_win = new WindowUtil({
		width : 650,
		height : 340
	}, project_form.getPanel(), null);

	/** ****************project window end************ */

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
