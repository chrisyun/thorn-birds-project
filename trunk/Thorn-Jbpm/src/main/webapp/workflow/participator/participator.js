var ppSaveOrModifyUrl = sys.path + "/wf/pp/saveOrModifyParticipator.jmt";
var ppDeleteUrl = sys.path + "/wf/pp/deleteParticipator.jmt";
var ppPageUrl = sys.path + "/wf/pp/getParticipatorPage.jmt";
var ppGroupPageUrl = sys.path + "/wf/pp/getGroupPage.jmt";

var getAllRoleUrl = sys.path + "/role/getAllRole.jmt";

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
	pp_form.addComp(getText("entity", "参与者", 140), 0.4, false);	
	pp_form.addComp(getButton({
		handler : chooseHandler,
		text : "选择"
	}), 0.1, true);
	pp_form.addComp(getComboBox("limitType", "限制类型", 180, limitTypeDD, false), 0.5,
			true);
	pp_form.addComp(getText("variable", "绑定变量名", 180), 0.5, false);
	pp_form.addComp(getHidden("formType"), 0, true);
	pp_form.addComp(getHidden("id"), 0, true);
	
	var pp_win = new WindowUtil({
				width : 620,
				height : 220
			}, pp_form.getPanel(), ppSaveOrModify);
	
	pp_form.findById("show_entityType").addListener("change", function(){
		groupArray = "";
		pp_form.findById("entity").setValue("");
	});		
			
	/** ****************participator window end************ */
			
	/** ****************open grid window start************ */	
	var checkedRender = function(data, metadata, record, rowIndex, colIndex) {
		if(!Ext.isEmpty(groupArray) && groupArray.indexOf(data + ",") >= 0) {
			var sm = group_grid.getGrid().selModel;
			
			var selectedArray = sm.getSelections();
			selectedArray.push(record);
			
			sm.selectRecords(selectedArray);
		}
		
		return data;
	}
			
	var group_recordArray = [
			getRecord("编号", "id", "string", 100, true, checkedRender),
			getRecord("名称", "name", "string", 100, true),
			getRecord("是否显示", "isShow", "string", 70, true, yesOrNoRender),
			getRecord("是否禁用", "isDisabled", "string", 70, true, yesOrNoRender)];		
	var group_grid = new GridUtil(ppGroupPageUrl, group_recordArray, pageSize);
	
	var group_query = new Ext.ux.form.SearchField({
		id : "group_queryField",
		width : 160,
		emptyText : "请输入查询关键字"
	});
	
	group_grid.setBottomBar();		
	group_grid.setTopBar([{
		xtype : 'tbbutton',
		id : 'group_queryType',
		text : '编号/账号',
		minWidth : 100,
		menu : new Ext.menu.Menu({
			width : 100,
			items : [{
				text : "编号/账号",
				handler : function() {
					Ext.getCmp("group_queryType").setText("编号/账号");
				}
			}, {
				text : "名称",
				handler : function() {
					Ext.getCmp("group_queryType").setText("名称");
				}
			}]
		})
	},group_query]);
	
	group_grid.setGridPanel({
		collapsible : false,
		border : false,
		region : "center",
		split : false
	});
	
  	group_grid.getGrid().getSelectionModel().on('rowselect', function(sm, rowIdx, r) {
  		if(groupArray.indexOf(r.data.id + ",") < 0) {
  			groupArray += r.data.id + ",";
  		}
    }); 
    
    group_grid.getGrid().getSelectionModel().on('rowdeselect', function(sm, rowIdx, r) {
    	if(groupArray.indexOf(r.data.id + ",") >= 0) {
    		var tempArray = groupArray.split(r.data.id + ",");
        	groupArray = tempArray[0] + tempArray[1];
    	}
    }); 
 
	var group_Window = new WindowUtil({
		title : "参与者列表",
		layout : 'border',
		width : 680,
		height : 420
	}, [orgTree, group_grid.getGrid()], checkedOrgAndUserHandler);

	group_query.onTrigger2Click = function() {
		var queryType = Ext.getCmp("group_queryType").getText();

		var groupStore = group_grid.getStore();

		var params = {};

		switch (queryType) {
			case "名称" :
				var name = Ext.getCmp("group_queryField").getValue();
				groupStore.baseParams.name = name;
				groupStore.baseParams.id = "";
				break;
			case "编号/账号" :
				var account = Ext.getCmp("group_queryField").getValue();
				groupStore.baseParams.id = account;
				groupStore.baseParams.name = "";
				break;
		}
		
		groupStore.baseParams.pid = currentActiveNode.attributes.pid;
		groupStore.baseParams.type = groupType;
		groupStore.load({
			params : {
				start : 0,
				limit : group_grid.pageSize
			}
		});
	}
	
	orgTree.border = false;

	doStore = function(node) {
		group_grid.getStore().baseParams = {
			"pid" : node.attributes.pid,
			"type" : groupType
		};
		group_grid.getStore().reload( {
			params : {
				start : 0,
				limit : group_grid.pageSize
			}
		});
	};
	
	/** ****************open grid window end************ */		
	
	/** ****************role window start************ */
	var role_form = new FormUtil( {
		id : "roleForm",
		collapsible : false,
		labelWidth : 30,
		border : false
	});
	var role_win = new WindowUtil( {
		width : 450,
		height : 300
	}, role_form.getPanel(), checkedAreaAndRoleHandler);
	
	var role_store = new Ext.data.Store({
		url : getAllRoleUrl,
		autoLoad : true,
		reader : new Ext.data.JsonReader({}, 
				Ext.data.Record.create([{
					name : 'roleCode',
					type : 'string'
				}, {
					name : 'roleName',
					type : 'string'
				}]))
	});
	
	var area_store = new Ext.data.ArrayStore({
		fields : [{
					name : "code",
					type : "string"
				}, {
					name : "name",
					type : "string"
				}],
		data : areaDD
	});
	
	
	/** ****************role window end************ */
	function saveHandler() {
		pp_win.show("绑定环节参与者");
		
		setTextReadOnly(pp_form.findById("entity"));
		
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
		
		setTextReadOnly(pp_form.findById("entity"));
		
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
			Ext.Msg.alert("提示信息", "请填写完整的数据信息!");
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
	
	function chooseHandler() {
		var type = pp_form.findById("show_entityType").getValue();
		if(Ext.isEmpty(type)) {
			Ext.Msg.alert("提示信息", "请先选择参与者类型!");
			return;
		}
		
		groupArray = pp_form.findById("entity").getValue();
		if(groupArray.length > 0) {
			groupArray += ",";
		}
		
		var typeName = Ext.get('show_entityType').dom.value;
		if(typeName == "组织") {
			groupType = "org";
			group_Window.show();
		} else if(typeName == "人员") {
			groupType = "user";
			group_Window.show();
		} else if(typeName == "角色") {
			groupType = "role";
			
			var thisForm = role_form.getPanel();
			thisForm.removeAll(true);
			
			role_store.each(function(record){
				var code = record.get("roleCode");
				var isChecked = false;
				
				if(groupArray.indexOf(code) >= 0) {
					isChecked = true;
				}
				
				var cb = getCheckbox(code, 
						record.get("roleName"),
						isChecked);
				role_form.addComp(cb, 0.5, true);
			});
			thisForm.doLayout();
			role_win.show("参与者列表");
		} else if(typeName == "区域") {
			groupType = "area";
			
			var thisForm = role_form.getPanel();
			thisForm.removeAll(true);
			
			area_store.each(function(record){
				var code = record.get("code");
				var isChecked = false;
				
				if(groupArray.indexOf(code) >= 0) {
					isChecked = true;
				}
				
				var cb = getCheckbox(code, 
						record.get("name"),
						isChecked);
				role_form.addComp(cb, 0.5, true);
			});
			thisForm.doLayout();
			role_win.show("参与者列表");
		}
	}
	
	function checkedOrgAndUserHandler() {
		
		if (groupArray.length > 0) {
			groupArray = groupArray.substring(0, groupArray.length - 1);
		}
		
		pp_form.findById("entity").setValue(groupArray);
		group_Window.hide();
	}
	
	function checkedAreaAndRoleHandler() {
		var thisForm = role_form.getPanel();

		var checkedGroup = thisForm.findByType("checkbox");
		for (var i = 0; i < checkedGroup.length; i++) {
			var ck = checkedGroup[i];

			if (ck.getValue() && groupArray.indexOf(ck.getId() + ",") < 0) {
				groupArray += ck.getId() + ",";
			} else if (!ck.getValue()
					&& groupArray.indexOf(ck.getId() + ",") >= 0) {
				var tempArray = groupArray.split(ck.getId() + ",");
				groupArray = tempArray[0] + tempArray[1];
			}
		}

		if (groupArray.length > 0) {
			groupArray = groupArray.substring(0, groupArray.length - 1);
		}

		pp_form.findById("entity").setValue(groupArray);
		role_win.hide();
	}
	
	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), pp_grid.getGrid()]
			});

	onSubmitQueryHandler();
	completePage();
});
