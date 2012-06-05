var cfGetAllUrl = sys.path + "/cf/getConfigName.jmt";
var cfGetConfigUrl = sys.path + "/cf/getConfig.jmt";
var cfmodifyConfigUrl = sys.path + "/cf/modifyConfig.jmt";

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
		valueField : "id",
		displayField : "name",
		store : new Ext.data.Store({
			url : getAllRoleUrl,
			reader : new Ext.data.JsonReader({}, Ext.data.Record
							.create([{
										name : 'id',
										type : 'string'
									}, {
										name : 'name',
										type : 'string'
									}]))
		})
	};
    
	query_form.addComp(configNames, 0.4, false);
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.3, true);
	/** ****************query panel end*************** */

	/** ****************Grid panel start************** */
	var propsGrid = new Ext.grid.PropertyGrid({
		region : "center",
		iconCls : "silk-app-go",
		bodyStyle : "padding-top: 7px;",
		margins : "2 0 0 0",
		collapsible : true,
		title: "Property Grid",
		loadMask : true,
    	autoHeight: true,
    	width: 400,
		buttonAlign : "center",
		buttons : [{
			id : "save-nav",
			text : "保存",
			iconCls : "silk-save",
			minWidth : Configuration.btnWidth.MIN,
			handler : saveCfHandler
		}]
	});
	
	/** ****************Grid panel end************** */
	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel()]
			});
	
	function saveCfHandler() {
		var source = propsGrid.getSource;
		alert(source);
		
		
		var ajax = new AjaxUtil(cfmodifyConfigUrl);
		ajax.request(null, true, propsGrid);
	}
			
	function onSubmitQueryHandler() {
		var thisForm = query_form.getForm();

		if (!thisForm.isValid()) {
			Ext.Msg.alert("提示信息", "请选择配置文件!");
			return;
		}
		
		var name = Ext.getCmp("show_configPath").getValue();
		var ajax = new AjaxUtil(cfGetConfigUrl);
		ajax.getData({"name":name}, propsGrid, function(obj, data) {
			propsGrid.setSource(data);
		});
	}			

	completePage();	
});
