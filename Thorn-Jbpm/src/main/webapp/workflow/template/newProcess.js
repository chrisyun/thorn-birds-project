Ext.onReady(function() {
	Ext.QuickTips.init();
	
	var tpanel = new Ext.panel({
		height : 100,
		split : true,
//		collapsible : true,
		region : "north",
		tbar : ["-"],
		html : "<div id='title'></div>"
	});
	
	var loadingUrl = sys.path + "/resources/images/local/waiting.gif";
	var html = "<table width=\"100%\" height=\"100%\">" +
				"<tr valign=\"middle\" height=\"100%\">" +
					"<td width=\"100%\" align=\"center\">" +
						"<font style=\"font-size: 14px;\">表单数据加载中...</font><br>" +
						"<img src='" + loadingUrl + "'>" +
			"</td></tr></table>";
	
	var contentPanel = new Ext.panel({
		split : true,
		region : "center",
		html : html
	});
	
	var bPanel = new Ext.panel({
		split : true,
		region : "south",
//		collapsible : true,
		height : 100,
		html : ""
	});
	
	
	var viewport = new Ext.Viewport({
		border : false,
		layout : "border",
		items : [tpanel, contentPanel, bPanel]
	});
	
	completePage();
});