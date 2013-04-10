var saveOrModifyUrl = sys.path + "/wf/cm/saveOrModifyEntruster.jmt";
var deleteUrl = sys.path + "/wf/cm/deleteEntruster.jmt";
var getPageUrl = sys.path + "/wf/cm/getEntruster.jmt";

var getUserLits = sys.path + "/user/getUsersInSameOrg.jmt";

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

	query_form.addComp(getComboBox("query_processDfId", "流程名称", 180, wfNameDD, false), 0.3, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.2, true);
	/** ****************query panel end*************** */

	/** ****************entrust Grid panel start************ */
	
	var recordArray = [
			getRecord(null, "id", "string"),
			getRecord(null, "entruster", "string"),
			getRecord("流程名称", "processDfId", "string", 150, false, wfNameRender),
			getRecord("流程定义ID", "processDfId", "string", 150, true),
			getRecord("委托人", "entrusterName", "string", 200, false),
			getRecord("委托开始日期", "beginDate", "string", 150, false),
			getRecord("委托结束日期", "endDate", "string", 150, false)];
	var en_grid = new GridUtil(getPageUrl, recordArray);
	
	var grid_Bar = new Array();
	grid_Bar.push("-");
	grid_Bar.push({
		text : "设置委托",
		iconCls : "silk-edit",
		minWidth : Configuration.minBtnWidth,
		handler : setHandler
	});
	grid_Bar.push("-");
	grid_Bar.push({
		text : "取消委托",
		iconCls : "silk-delete",
		minWidth : Configuration.minBtnWidth,
		handler : cancelHandler
	});
	
	en_grid.setTopBar(grid_Bar);

	var listeners = {
		celldblclick : function(thisGrid, rowIndex, columnIndex, ev) {
			setHandler();
		}
	};
	en_grid.setListeners(listeners);

	var grid_attr = {
		title : "流程委托列表",
		region : "center"
	};
	en_grid.setGridPanel(grid_attr);
	/** ****************entrust Grid panel end************ */

	var grid = en_grid.getGrid();
	var store = en_grid.getStore();

	/** ****************entrust window start************ */
	var en_form = new FormUtil({
		id : "entrustForm",
		collapsible : false,
		labelWidth : 80,
		border : false
	});
	
	en_form.addComp(getText("processDfId", "流程定义ID", 150), 0.5, false);
	
	var entrusterStore = new Ext.data.Store({
		url : getUserLits,
		autoLoad : true,
		reader : new Ext.data.JsonReader({}, Ext.data.Record
						.create([{
									name : 'userId',
									type : 'string'
								}, {
									name : 'userName',
									type : 'string'
								}]))
	});
	
	var entruster = {
		xtype : "combo",
		id : "show_entruster",
		hiddenName : "entruster",
		triggerAction : "all",
		resizable : true,
		lazyInit : true,
		mode : "remote",
		width : 150,
		forceSelection : true,
		emptyText : "---请选择委托人---",
		fieldLabel : "委托人",
		valueField : "userId",
		displayField : "userName",
		store : entrusterStore
	};
	en_form.addComp(entruster, 0.5, false);
	
	en_form.addComp(getDateText("beginDate", "开始日期", 150), 0.5, false);	
	en_form.addComp(getDateText("endDate", "结束日期", 150), 0.5, false);	
	en_form.addComp(getHidden("formType"), 0, true);
	en_form.addComp(getHidden("id"), 0, true);
	
	var en_win = new WindowUtil({
				width : 550,
				height : 170
	}, en_form.getPanel(), saveOrModify);
	/** ****************entrust window end************ */

	function saveHandler() {
		en_win.show("设置页面权限");
		en_form.getForm().reset();
		setTextReadOnly(en_form.findById("auth"));
		en_form.findById("formType").setValue(
				Configuration.opType.SAVE);
	}
	
	function setHandler() {
		if (grid.getSelectionModel().getCount() != 1) {
			Ext.Msg.alert("提示信息", "请选择一条记录!");
			return;
		}

		en_win.show("设置流程委托");
		en_form.getForm().reset();
		setTextReadOnly(en_form.findById("processDfId"));
		var selectedRecord = grid.getSelectionModel().getSelected();
		var values = {
			id : selectedRecord.get("id"),
			processDfId : selectedRecord.get("processDfId"),
			beginDate : selectedRecord.get("beginDate"),
			endDate : selectedRecord.get("endDate"),
			entruster : selectedRecord.get("entruster"),
			formType : Configuration.opType.MODIFY
		};
		
		if(Ext.isEmpty(values.id) || values.id == "") {
			values.formType = Configuration.opType.SAVE;
		}
		
		en_form.getForm().setValues(values);
	}
	
	function cancelHandler() {
		if (grid.getSelectionModel().getCount() == 0) {
			Ext.Msg.alert("提示信息", "请至少选择一条记录!");
			return;
		}
		var selectedRecordArray = grid.getSelectionModel().getSelections();

		Ext.Msg.confirm("确认提示", "确定删除选定的记录?", function(btn) {
			if (btn == 'yes') {
				var ids = "";
				for ( var i = 0; i < selectedRecordArray.length; i++) {
					var id = selectedRecordArray[i].get("id");
					if(!Ext.isEmpty(id) && id != "") {
						ids += id + ",";
					}
				}
				
				if(ids == "") {
					Ext.Msg.alert("提示信息", "未设置流程委托！");
					return ;
				}

				var params = {
					ids : ids
				};

				var ajaxClass = new AjaxUtil(deleteUrl);
				ajaxClass.request(params, true, null, function(obj) {
					en_grid.getStore().reload();
				});
			}
		});
	}		
			
	function saveOrModify() {
		var enForm = en_form.getForm();

		if (!enForm.isValid()) {
			Ext.Msg.alert("提示信息", "请填写完整的数据信息!");
			return;
		}

		var ajaxClass = new AjaxUtil(saveOrModifyUrl);
		
		var entrusterName = Ext.get('show_entruster').dom.value;
		var opType = en_form.findById("formType").getValue();

		var params = {
			entrusterName : entrusterName,
			opType : opType
		};

		var callBack_obj = new Object();
		callBack_obj.grid = en_grid;
		callBack_obj.win = en_win;
		callBack_obj.form = en_form;

		ajaxClass.submit(enForm, params, true, callBack_obj, function(obj) {
			obj.grid.getStore().reload();
			obj.win.hide();
		});
	}

	function onSubmitQueryHandler() {
		var processDfId = Ext.getCmp("show_query_processDfId").getValue();
		store.baseParams.processDfId = processDfId;
		store.load();
	}
	
	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), en_grid.getGrid()]
			});

	onSubmitQueryHandler();
	completePage();
});
