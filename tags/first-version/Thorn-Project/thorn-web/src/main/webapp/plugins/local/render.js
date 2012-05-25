var Render = {
	dictRender : function(dictArray, dictValue) { // 字典转化
		if (Ext.isEmpty(dictArray) || dictArray.length == 0) {
			return dictValue;
		}
		if (Ext.isEmpty(dictValue)) {
			return "";
		}
		for ( var i = 0; i < dictArray.length; i++) {
			var arr = dictArray[i];
			if (arr[0] == dictValue) {
				return arr[1];
			}
		}
		return dictValue;
	},
	dateRender : function(value) { // 日期转化
		if (Ext.isEmpty(value)) {
			return "";
		}
		var reDate = /\d{4}\-\d{2}\-\d{2}/gi;
		return value.match(reDate);
	},
	timeRender : function(value) { // 时间转化
		if (Ext.isEmpty(value)) {
			return "";
		}
		var reDate = /\d{4}\-\d{2}\-\d{2}/gi;
		var reTime = /\d{2}:\d{2}:\d{2}/gi;
		return value.match(reDate) + " " + value.match(reTime);
	},
	detailRender : function(value, cm, colIndex) {
		var _maxLength = cm.getColumnWidth(colIndex) / 11.6;
		if (Ext.isEmpty(value) || value.length <= _maxLength) {
			return value;
		}
		var valueDisplay = value.length > _maxLength ? value.substring(0,
				_maxLength)
				+ "..." : value;
		var contentEl = "content_" + Math.random();
		return '<a title="'
				+ value
				+ '" href="javascript: void(0);" onclick="javascript: Render.viewFieldDetail(\''
				+ contentEl + '\');">' + valueDisplay + '</a><div id="'
				+ contentEl + '" style="display: none;">' + value + '</div>';
	},
	viewFieldDetail : function (contentEl, title) {
		if (this.viewFieldDetailWin == null) {
			var windowWidth = document.body.clientWidth > 760 ? 760 : document.body.clientWidth - 10;
			var windowHeight = document.body.clientHeight > 560 ? 560 : document.body.clientHeight - 10;
			this.viewFieldDetailWin = new Ext.Window({ //定义对话框
				title		: title || '详细信息',
				closeAction : 'hide',
				modal 		: true,
				shadow 		: true,
				closable 	: true,
				layout 		: 'fit',
				width 		: windowWidth,
				height 		: windowHeight,
				items 		: [{
					xtype: 'textarea',
					id: 'detailField'
				}]
			});
		}
		this.viewFieldDetailWin.show();
		this.viewFieldDetailWin.doLayout();
		Ext.getCmp("detailField").setValue(document.getElementById(contentEl).innerHTML);
	}
}