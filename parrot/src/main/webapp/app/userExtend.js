var userExtendPageUrl = sys.path + "/project/dw/getProjectDWPage.jmt";
var userExtendSubmitUrl = sys.path + "/project/dw/saveOrModifyProjectDW.jmt";

var pageSize = 20;

Ext.onReady(function() {
	Ext.QuickTips.init();

	/** ****************query panel start*************** */
	var query_attr = {
		title : "查询列表",
		region : "north",
		height : 80,
		labelWidth : 70
	};
	var query_form = new FormUtil(query_attr);
	query_form.addComp(getText("query_code", "单位编码", 120), 0.23, true);
	query_form.addComp(getText("query_name", "承担单位", 120), 0.23, true);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.3, true);
	/** ****************query panel end*************** */

	/** ****************userExtend Grid panel start************ */
	var recordArray = [
			getRecord(null, "id", "string"),
			getRecord(null, "orgCode", "string"),
			getRecord(null, "postalCode", "string"),
			getRecord(null, "companyCtf", "string"),
			getRecord(null, "bankAccount", "string"),
			getRecord(null, "userId", "string"),
			getRecord("承担单位名称", "userName", "string", 150, false),
			getRecord("联系地址", "address", "string", 200, false),
			getRecord("单位负责人", "contacts", "string", 80, false),
			getRecord("联系电话", "phone", "string", 80),
			getRecord("开户名称", "bankName", "string", 100),
			getRecord("开户银行", "bank", "string", 80, false)];
	var userExtend_grid = new GridUtil(userExtendPageUrl, recordArray, pageSize);
	
	var bar = new Array();
	if(userPermission.MODIFY == "true") {
		bar.push("-");
		bar.push({
			text : "修改",
			iconCls : "silk-edit",
			minWidth : Configuration.minBtnWidth,
			handler : modifyHandler
		});
	}
	userExtend_grid.setBottomBar(bar);
	
	var listeners = {
		celldblclick : function(thisGrid, rowIndex, columnIndex, ev) {
			if(userPermission.MODIFY == "true") {
				modifyHandler();
			}
		}
	};
	userExtend_grid.setListeners(listeners);

	var grid_attr = {
		title : "非遗项目承担单位列表",
		region : "center"
	};
	userExtend_grid.setGridPanel(grid_attr);
	/** ****************userExtend Grid panel end************ */
	var grid = userExtend_grid.getGrid();
	var store = userExtend_grid.getStore();
	/** ****************org tree setting start************ */
	doStore = function(node) {
		store.baseParams = {
			"orgCode" : node.attributes.pid
		};
		store.reload( {
			params : {
				start : 0,
				limit : userExtend_grid.pageSize
			}
		});
	};

	/** ****************org tree setting end************ */

	/** ****************org window start************ */
	var userExtend_form = new FormUtil( {
		id : "userExtendForm",
		collapsible : false,
		labelWidth : 120,
		border : false
	});
	userExtend_form.addComp(getText("userId", "单位编码", 180), 0.5, true);
	userExtend_form.addComp(getText("userName", "项目承担单位", 180), 0.5, true);
	
	userExtend_form.addComp(getText("address", "联系地址", 180), 0.5, false);
	userExtend_form.addComp(getText("postalCode", "邮政编码", 180), 0.5, true);
	userExtend_form.addComp(getText("contacts", "申报项目负责人", 180), 0.5, false);
	userExtend_form.addComp(getText("phone", "联系电话", 180), 0.5, false);
	userExtend_form.addComp(getText("bankName", "开户名称", 520), 1.0, false);
	userExtend_form.addComp(getText("bank", "开户银行", 520), 1.0, false);
	userExtend_form.addComp(getText("bankAccount", "开户账号", 520), 1.0, false);
	userExtend_form.addComp(getTextArea("companyCtf", "申报单位具备资质", 520, 80, 1000), 1.0, false);
	
	userExtend_form.addComp(getHidden("id"), 0, true);
	userExtend_form.addComp(getHidden("opType"), 0, true);

	var userExtend_win = new WindowUtil( {
		width : 700,
		height : 380
	}, userExtend_form.getPanel(), saveOrModify);
	/** *****************userextend window start************ */
	function modifyHandler() {
		if (grid.getSelectionModel().getCount() != 1) {
			Ext.Msg.alert("提示信息", "请选择一条记录!");
			return;
		}

		userExtend_win.show("修改项目承担单位信息");
		userExtend_form.getForm().reset();

		setTextReadOnly(userExtend_form.findById("userId"));
		setTextReadOnly(userExtend_form.findById("userName"));
		
		var selectedRecord = grid.getSelectionModel().getSelected();
		var values = {
			userId : selectedRecord.get("userId"),
			userName : selectedRecord.get("userName"),
			address : selectedRecord.get("address"),
			postalCode : selectedRecord.get("postalCode"),
			contacts : selectedRecord.get("contacts"),
			phone : selectedRecord.get("phone"),
			bankName : selectedRecord.get("bankName"),
			bank : selectedRecord.get("bank"),
			bankAccount : selectedRecord.get("bankAccount"),
			companyCtf : selectedRecord.get("companyCtf"),
			id : selectedRecord.get("id")
		};
		userExtend_form.getForm().setValues(values);
		if(Ext.isEmpty(values.id)) {
			userExtend_form.findById("opType").setValue(Configuration.opType.SAVE);
		} else {
			userExtend_form.findById("opType").setValue(Configuration.opType.MODIFY);
		}
	}

	function saveOrModify() {
		var form = userExtend_form.getForm();

		if (!form.isValid()) {
			Ext.Msg.alert("提示信息", "请填写完整的承担单位信息!");
			return;
		}

		var callBack_obj = new Object();
		callBack_obj.grid = grid;
		callBack_obj.win = userExtend_win;
		callBack_obj.form = userExtend_form;
		var ajaxClass = new AjaxUtil(userExtendSubmitUrl);
		ajaxClass.submit(form, null, true, callBack_obj, function(
				obj) {
			obj.grid.getStore().reload();
			obj.win.hide();
		});
	}

	function onSubmitQueryHandler() {
		var thisForm = query_form.getForm();
		var store = grid.getStore();

		var name = Ext.getCmp("query_name").getValue();
		var code = Ext.getCmp("query_code").getValue();
//		var mail = Ext.getCmp("query_mail").getValue();

		store.baseParams.userName = name;
		store.baseParams.userId = code;
//		store.baseParams.cumail = mail;
		store.baseParams.orgCode = "";
		
		store.load( {
			params : {
				start : 0,
				limit : userExtend_grid.pageSize
			}
		});
	}

	var viewport = new Ext.Viewport( {
		border : false,
		layout : "border",
		items : [ orgTree, {
			border : false,
			region : "center",
			layout : "border",
			split : true,
			items : [ query_form.getPanel(), userExtend_grid.getGrid() ]
		} ]
	});

	grid.getStore().reload( {
		params : {
			start : 0,
			limit : userExtend_grid.pageSize,
			orgCode : ""
		}
	});

	completePage();
});
