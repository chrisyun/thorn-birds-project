var summaryPageUrl = sys.path + "/project/getProjectCostSummary.jmt";

Ext.onReady(function() {
	Ext.QuickTips.init();

	/** ****************query panel start*************** */
	var query_attr = {
		title : "查询列表",
		region : "north",
		height : 70,
		labelWidth : 100
	};
	
	var query_form = new FormUtil(query_attr);
	
	query_form.addComp(getComboBox("query_year", "申报年份", 160, year, false),
			0.3, true);
	var provinceCb = getComboBox("query_area", "申报省份", 160, area, false);
	query_form.addComp(provinceCb, 0.3, true);
	
	query_form.addComp(getQueryBtn(onSubmitQueryHandler), 0.3, true);
	
	var now = new Date(); 
	Ext.getCmp("show_query_year").setValue(now.getFullYear());
	Ext.getCmp("show_query_area").setValue(user.org);
	
	/** ****************query panel end*************** */

	/** ****************summary Grid panel start************ */
	var projectNameRender = function(name, metadata, record, rowIndex, colIndex) {
		var isUn = record.get("isUnProject");
		
		if(isUn == "YES") {
			name = "★ " + name;
		}
		return name;
	};
	
	var msgRender = function(remark, metadata, record, rowIndex, colIndex) {
		return Render.detailRender(remark, summary_grid.cm, colIndex);
	};
	
	var recordArray = [
			getRecord(null, "id", "string"),
			getRecord(null, "isUnProject", "string"),
			getRecord("项目编号", "code", "string", 100, true),
			getRecord("项目名称", "projectName", "string", 200, true, projectNameRender),
			getRecord("资金申报单位", "createrName", "string", 200, true),
			getRecord("金额（万元）", "money", "string", 100, true),
			getRecord("备注", "appReason", "string", 300, false, msgRender)];
	var summary_grid = new GridUtil(summaryPageUrl, recordArray);
	

	summary_grid.setBottomBar([ {
		text : "合计（万元）:",
		xtype : "tbtext"
	}, {
		xtype : "textfield",
		id : "summaryTotal",
		width : 70,
		readOnly : true
	} ]);
	
	var grid_attr = {
		title : "非遗项目补助费申报汇总列表（入选联合国教科文组织非物质文化遗产名录项目在项目名称前用“★”标注）",
		region : "center"
	};
	summary_grid.setGridPanel(grid_attr);
	/** ****************summary Grid panel end************ */

	var grid = summary_grid.getGrid();
	summarystore = summary_grid.getStore();
	
	summarystore.addListener("load", function(store, records) {
		var totalMoney = 0;
		for(var i=0; i<records.length; i++) {
			var money = parseFloat(records[i].get("money"));
			
			totalMoney = parseFloat(totalMoney) + money;
		}
		Ext.getCmp("summaryTotal").setValue(totalMoney);
	});
	
	function onSubmitQueryHandler() {

		var province = Ext.getCmp("show_query_area").getValue();
		var year = Ext.getCmp("show_query_year").getValue();
		
		summarystore.baseParams.year = year;
		summarystore.baseParams.province = province;

		summarystore.load();
	}

	var viewport = new Ext.Viewport({
				border : false,
				layout : "border",
				items : [query_form.getPanel(), summary_grid.getGrid()]
			});

	onSubmitQueryHandler();
	completePage();
});
