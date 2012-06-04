var cfGetAllUrl = sys.path + "/cf/getConfigName.jmt";

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

	var configNames = {
		xtype : "combo",
		id : "show_configPath",
		hiddenName : "configPath",
		triggerAction : "all",
		resizable : true,
		lazyInit : true,
		mode : "remote",
		width : 300,
		emptyText : "---请先选择配置文件---",
		fieldLabel : "配置文件",
		store : []
	};
	
	var store = new Ext.data.Store({
            proxy: new Ext.data.MemoryProxy(["jdbcsas","ouu"]),
            reader: new Ext.data.ArrayReader({}, Ext.data.Record.create(["k"]))
    });
	store.load();
//	alert(Message.debugJsonDetail(store.getAt(1).data));
	alert(store.collect("k"));

    
    
	query_form.addComp(configNames, 0.4, false);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.3, true);
	/** ****************query panel end*************** */

	/** ****************role Grid panel start************ */

	var viewport = new Ext.Viewport({
				border : false,
				layout : "fit",
				items : [query_form.getPanel()]
			});
	
			
	function onSubmitQueryHandler() {
		var thisForm = query_form.getForm();

		if (!thisForm.isValid()) {
			Ext.Msg.alert("提示信息", "请选择配置文件!");
			return;
		}
		
		var name = Ext.getCmp("show_configPath").getValue();
		alert(name);
	}			

	completePage();	
});
