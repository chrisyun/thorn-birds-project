var dtListUrl = sys.basePath + "dd/searchDTPage.xhtml";
var dtSubmitUrl = sys.basePath + "dd/submitDictType.xhtml";
var dtDeleteUrl = sys.basePath + "dd/deleteDictType.xhtml";

var ddListUrl = sys.basePath + "dd/searchDdList.xhtml";
var ddSubmitUrl = sys.basePath + "dd/submitDictData.xhtml";
var ddDeleteUrl = sys.basePath + "dd/deleteDictData.xhtml";

function DictType(dtPagingSize) {
	if (Ext.isEmpty(dtPagingSize)) {
		dtPagingSize = Common.config.defaultPageSize;
	}
	this.dtPagingSize = dtPagingSize;
	this.csModel = new Ext.grid.CheckboxSelectionModel( {});
	this.initDateStore();
	this.initColumnModel();
	this.initPagingBar();
}

DictType.prototype.initDateStore = function() {
	this.dataStore = new Ext.data.Store( {
		url : dtListUrl,
		// 后台排序
		remoteSort : true,
		reader : new Ext.data.JsonReader( {
			totalProperty : "totalCount",
			root : "resultSet"
		}, Ext.data.Record.create( [ {
			name : 'ename',
			type : 'string',
			mapping : 'ename'
		}, {
			name : 'cname',
			type : 'string',
			mapping : 'cname'
		}, {
			name : 'creattime',
			type : 'string',
			mapping : 'creattime'
		} ]))
	});
}

DictType.prototype.initPagingBar = function() {
	var thisObj = this;
	var items = [ '-', {
		text : "增加",
		iconCls : "silk-add",
		minWidth : Common.config.buttonWidth.minButton,
		scope : thisObj,
		handler : this.onAdd
	}, '-', {
		text : "修改",
		iconCls : "silk-edit",
		minWidth : Common.config.buttonWidth.minButton,
		scope : thisObj,
		handler : this.onUpdate
	}, '-', {
		text : "删除",
		iconCls : "silk-delete",
		minWidth : Common.config.buttonWidth.minButton,
		scope : thisObj,
		handler : this.onDelete
	} ];

	var commonPage = new CommonPageBar(this.dataStore, this.dtPagingSize, items);
	this.pagingBar = commonPage.pagingToolBar;
}

DictType.prototype.initColumnModel = function() {
	this.columnModel = new Ext.grid.ColumnModel( [
			new Ext.grid.RowNumberer( {}), this.csModel, {
				header : "字典类型编号",
				dataIndex : "ename",
				sortable : true,
				id : "ename",
				width : 50
			}, {
				header : "字典类型名称",
				dataIndex : "cname",
				sortable : true,
				id : "cname",
				width : 60
			}, {
				header : "创建时间",
				dataIndex : "creattime",
				sortable : true,
				id : "creattime",
				width : 150
			} ]);
}

DictType.prototype.onAdd = function() {
	this.opType = Common.opType.Add;
	this.openWin();
	this.dtWin.setTitle("新增数据字典类型");

	this.dtForm.getForm().reset();

	// 将主键置为可编辑
	var enameText = this.dtForm.findById("ename");
	enameText.el.dom.readOnly = false;
}

DictType.prototype.onDelete = function() {
	if (dtgrid.getSelectionModel().getCount() == 0) {
		Ext.Msg.alert("提示信息", "请至少选择一条记录!");
		return;
	}
	var selectedRecordArray = dtgrid.getSelectionModel().getSelections();

	var thisObj = this;

	Ext.Msg.confirm("确认提示", "确定删除选定的记录?", function(btn) {
		if (btn == 'yes') {
			var ids = "";
			for ( var i = 0; i < selectedRecordArray.length; i++) {
				ids += selectedRecordArray[i].get("ename") + ",";
			}

			var params = {
				ids : ids
			};

			var ajaxClass = new CommonAjax(dtDeleteUrl);
			ajaxClass.request(params, true, thisObj, function(obj) {
				obj.dataStore.reload();
				ddgrid.getStore().removeAll();
			});
		}
	});
}

DictType.prototype.onUpdate = function() {
	if (dtgrid.getSelectionModel().getCount() != 1) {
		Ext.Msg.alert("提示信息", "请选择一条记录!");
		return;
	}

	this.openWin();
	this.dtWin.setTitle("修改数据字典类型");

	var thisForm = this.dtForm.getForm();
	thisForm.reset();

	// 将主键置为不可编辑
	var enameText = this.dtForm.findById("ename");
	enameText.el.dom.readOnly = true;

	this.opType = Common.opType.Update;
	var selectedRecord = dtgrid.getSelectionModel().getSelected();
	var values = {
		ename : selectedRecord.get("ename"),
		cname : selectedRecord.get("cname")
	};
	thisForm.setValues(values);
}

DictType.prototype.openWin = function() {
	if (this.dtWin == null) {
		this.dtForm = new Ext.FormPanel( {
			bodyStyle : 'padding-top: 30px',
			labelAlign : 'right',
			labelWidth : 100,
			defaults : {
				xtype : "textfield",
				width : 180,
				allowBlank : false,
				blankText : Common.config.msgNull
			},
			items : [ {
				id : "ename",
				name : "ename",
				fieldLabel : Common.config.redStar + "字典类型编号"
			}, {
				id : "cname",
				name : "cname",
				fieldLabel : Common.config.redStar + "字典类型名称"
			} ]
		});
		var thisObj = this;
		this.dtWin = new Ext.Window( {
			title : '数据字典类型',
			closeAction : 'hide',
			modal : true,
			shadow : true,
			closable : true,
			layout : 'fit',
			width : 350,
			height : 180,
			items : [ this.dtForm ],
			buttonAlign : "center",
			buttons : [ {
				text : '保存',
				iconCls : 'silk-accept',
				scope : thisObj,
				handler : this.saveDictType
			}, {
				text : '关闭',
				iconCls : 'slik-close',
				handler : function() {
					thisObj.dtWin.hide();
				}
			} ]
		});
	}
	this.dtWin.show();
}

DictType.prototype.saveDictType = function() {
	var dtForm = this.dtForm.getForm();

	if (!dtForm.isValid()) {
		Ext.Msg.alert("提示信息", "请填写完整的字典类型信息.");
		return;
	}

	var ajaxClass = new CommonAjax(dtSubmitUrl);

	var params = {
		opType : this.opType
	};

	ajaxClass.submitForm(dtForm, params, true, this, function(obj) {
		obj.dataStore.reload();
		obj.dtWin.hide();
	});
}

function DictData() {
	this.csModel = new Ext.grid.CheckboxSelectionModel( {});
	this.typeid = "";
	this.initDateStore();
	this.initColumnModel();
	this.initPagingBar();
}

DictData.prototype.initDateStore = function() {
	this.dataStore = new Ext.data.Store( {
		url : ddListUrl,
		// remoteSort : true,
		reader : new Ext.data.JsonReader( {
			totalProperty : "totalCount",
			root : "resultSet"
		}, Ext.data.Record.create( [ {
			name : 'dname',
			type : 'string',
			mapping : 'dname'
		}, {
			name : 'dvalue',
			type : 'string',
			mapping : 'dvalue'
		}, {
			name : 'sort',
			type : 'int',
			mapping : 'sort'
		}, {
			name : 'typeid',
			type : 'string',
			mapping : 'typeid'
		} ]))
	});
}

DictData.prototype.initPagingBar = function() {
	var thisObj = this;
	var items = [ '-', {
		text : "增加",
		iconCls : "silk-add",
		minWidth : Common.config.buttonWidth.minButton,
		scope : thisObj,
		handler : this.onAdd
	}, '-', {
		text : "修改",
		iconCls : "silk-edit",
		minWidth : Common.config.buttonWidth.minButton,
		scope : thisObj,
		handler : this.onUpdate
	}, '-', {
		text : "删除",
		iconCls : "silk-delete",
		minWidth : Common.config.buttonWidth.minButton,
		scope : thisObj,
		handler : this.onDelete
	} ];

	this.pagingBar = items;
}

DictData.prototype.initColumnModel = function() {
	this.columnModel = new Ext.grid.ColumnModel( [
			new Ext.grid.RowNumberer( {}), this.csModel, {
				header : "字典编码",
				dataIndex : "dname",
				id : "dname",
				width : 50
			}, {
				header : "字典名称",
				dataIndex : "dvalue",
				id : "dvalue",
				width : 60
			}, {
				header : "排序号",
				dataIndex : "sort",
				id : "sort",
				width : 150
			} ]);
}

DictData.prototype.openWin = function() {
	if (this.ddWin == null) {
		this.ddForm = new Ext.FormPanel( {
			bodyStyle : 'padding-top: 30px',
			labelAlign : 'right',
			labelWidth : 100,
			defaults : {
				xtype : "textfield",
				width : 180,
				allowBlank : false,
				blankText : Common.config.msgNull
			},
			items : [ {
				id : "dname",
				name : "dname",
				fieldLabel : Common.config.redStar + "字典编码"
			}, {
				id : "dvalue",
				name : "dvalue",
				fieldLabel : Common.config.redStar + "字典名称"
			}, {
				id : "sort",
				name : "sort",
				fieldLabel : "排序号",
				allowBlank : true
			}, {
				id : "typeid",
				name : "typeid",
				xtype : "hidden"
			} ]
		});
		var thisObj = this;
		this.ddWin = new Ext.Window( {
			title : '数据字典',
			closeAction : 'hide',
			modal : true,
			shadow : true,
			closable : true,
			layout : 'fit',
			width : 350,
			height : 210,
			items : [ this.ddForm ],
			buttonAlign : "center",
			buttons : [ {
				text : '保存',
				iconCls : 'silk-accept',
				scope : thisObj,
				handler : this.saveDict
			}, {
				text : '关闭',
				iconCls : 'slik-close',
				handler : function() {
					thisObj.ddWin.hide();
				}
			} ]
		});
	}
	this.ddWin.show();
}

DictData.prototype.onAdd = function() {
	this.opType = Common.opType.Add;

	if (Ext.isEmpty(this.typeid)) {
		Ext.Msg.alert("提示信息", "请选择数据字典类型!");
		return;
	}

	this.openWin();
	this.ddWin.setTitle("新增数据字典");

	this.ddForm.getForm().reset();
	this.ddForm.findById("typeid").setValue(this.typeid);

	// 将主键置为可编辑
	var dnameText = this.ddForm.findById("dname");
	dnameText.el.dom.readOnly = false;
}

DictData.prototype.onUpdate = function() {
	if (ddgrid.getSelectionModel().getCount() != 1) {
		Ext.Msg.alert("提示信息", "请选择一条记录!");
		return;
	}

	this.openWin();
	this.ddWin.setTitle("修改数据字典");

	var thisForm = this.ddForm.getForm();
	thisForm.reset();

	// 将主键置为不可编辑
	var dnameText = this.ddForm.findById("dname");
	dnameText.el.dom.readOnly = true;

	this.opType = Common.opType.Update;
	var selectedRecord = ddgrid.getSelectionModel().getSelected();
	var values = {
		dname : selectedRecord.get("dname"),
		dvalue : selectedRecord.get("dvalue"),
		sort : selectedRecord.get("sort"),
		typeid : selectedRecord.get("typeid")
	};
	thisForm.setValues(values);
}

DictData.prototype.onDelete = function() {
	if (ddgrid.getSelectionModel().getCount() == 0) {
		Ext.Msg.alert("提示信息", "请至少选择一条记录!");
		return;
	}
	var selectedRecordArray = ddgrid.getSelectionModel().getSelections();

	var thisObj = this;

	Ext.Msg.confirm("确认提示", "确定删除选定的记录?", function(btn) {
		if (btn == 'yes') {
			var ids = "";
			for ( var i = 0; i < selectedRecordArray.length; i++) {
				ids += selectedRecordArray[i].get("dname") + ",";
			}

			var params = {
				ids : ids,
				typeid : thisObj.typeid
			};

			var ajaxClass = new CommonAjax(ddDeleteUrl);
			ajaxClass.request(params, true, thisObj, function(obj) {
				obj.dataStore.reload();
			});
		}
	});
}

DictData.prototype.saveDict = function() {
	var ddForm = this.ddForm.getForm();

	if (!ddForm.isValid()) {
		Ext.Msg.alert("提示信息", "请填写完整的字典类型信息.");
		return;
	}

	var ajaxClass = new CommonAjax(ddSubmitUrl);

	var params = {
		opType : this.opType
	};

	ajaxClass.submitForm(ddForm, params, true, this, function(obj) {
		obj.dataStore.reload();
		obj.ddWin.hide();
	});
}