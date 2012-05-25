var Common = {
	config : {
		msgTarget : '',
		msgNull : '该输入项不能为空！',
		redStar : '<em class="required">*</em>',
		buttonWidth : {
			minButton : 30,
			defaultButton : 80
		},
		defaultPageSize : 15
	},
	opType : {
		Add : "add",
		Update : "update",
		Del : "delete"
	},
	showProcessMsgBox : function(_msg) {
		var msg = _msg || '数据提交中，请等候...';
		Ext.MessageBox.show( {
			msg : '<div style="margin: 5 5 8 15px;">' + msg + '</div>'
					+ '<div style="margin-left: 8px;"><img src="'
					+ sys.basePath
					+ 'plugins/images/icons/loading.gif"/></div>',
			width : 300,
			progress : false,
			wait : false,
			closable : true
		});
	},
	hideProcessMsgBox : function() {
		Ext.MessageBox.hide();
	},
	showErrorMsgBox : function(failMsg) {
		Ext.Msg.show( {
			title : '失败提示',
			msg : failMsg || '对不起，您的操作失败.',
			modal : false,
			buttons : Ext.Msg.OK,
			icon : Ext.MessageBox.ERROR
		});
	},
	debugJsonDetail : function(data) {
		if (data == undefined) {
			return "";
		}
		var r = [];
		if (typeof data == "string")
			return "\""
					+ data.replace(/([\"\\])/g, "\\$1").replace(/(\n)/g, "\\n")
							.replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t")
					+ "\"";
		if (typeof data == "object") {
			if (!data.sort) {
				for ( var i in data)
					r.push("\"" + i + "\":" + Common.debugJsonDetail(data[i]));
				if (!!document.all
						&& !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/
								.test(data.toString)) {
					r.push("toString:" + data.toString.toString());
				}
				r = "{" + r.join() + "}"
			} else {
				for ( var i = 0; i < data.length; i++)
					r.push(Common.debugJsonDetail(data[i]))
				r = "[" + r.join() + "]";
			}
			return r;
		}
		return data.toString().replace(/\"\:/g, '":""');
	}
};

function CommonPageBar(store, pageSize, items) {
	this.pagingToolBar = new Ext.PagingToolbar( {
		store : store,
		pageSize : pageSize,
		items : items,
		displayInfo : true,
		displayMsg : '当前显示{0}-{1}条,共{2}条',
		emptyMsg : "没有找到相关记录",
		emptyMsg : "没有找到相关记录",
		firstText : "第一页",
		prevText : "上一页",
		nextText : "下一页",
		lastText : "最后页",
		refreshText : "刷新",
		afterPageText : "页,共{0}页",
		beforePageText : "当前第"
	});
}

Ext.topShow = function() {
	var msgCt;
	function createBox(t, s) {
		return [
				'<div class="msg">',
				'<div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div>',
				'<div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc"><h3>',
				t,
				'</h3>',
				s,
				'</div></div></div>',
				'<div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div>',
				'</div>' ].join('');
	}
	return {
		msg : function(title, format) {
			if (!msgCt) {
				msgCt = Ext.DomHelper.insertFirst(document.body, {
					id : 'msg-div'
				}, true);
			}
			msgCt.alignTo(document, 't-t');
			var s = String.format.apply(String, Array.prototype.slice.call(
					arguments, 1));
			var m = Ext.DomHelper.append(msgCt, {
				html : createBox(title, s)
			}, true);
			m.slideIn('t').pause(1).ghost("t", {
				remove : true
			});
		},
		init : function() {
			var t = Ext.get('exttheme');
			if (!t) {
				return;
			}
			var theme = Cookies.get('exttheme') || 'aero';
			if (theme) {
				t.dom.value = theme;
				Ext.getBody().addClass('x-' + theme);
			}
			t.on('change', function() {
				Cookies.set('exttheme', t.getValue());
				setTimeout(function() {
					window.location.reload();
				}, 250);
			});
			var lb = Ext.get('lib-bar');
			if (lb) {
				lb.show();
			}
		}
	};
}();

/**
 * 常用的ajax操作类
 * 
 * @return
 */
function CommonAjax(url) {
	this.ajaxUrl = url;
}

CommonAjax.prototype.request = function(params, showMsg, obj, callback) {
	if (showMsg) {
		Common.showProcessMsgBox();
	}

	Ext.Ajax.request( {
		url : this.ajaxUrl,
		timeout : 120000,
		params : params,
		method : "POST",
		success : function(response, options) {
			var result = Ext.util.JSON.decode(response.responseText);
			if (showMsg) {
				Common.hideProcessMsgBox();
			}

			if (result.success) {
				Ext.topShow.msg("成功提示", result.message);
				callback(obj);
			} else {
				var failMsg = Ext.isEmpty(result.message) ? "数据处理时发生异常."
						: result.message;
				Common.showErrorMsgBox(failMsg);
			}
		},
		failure : function(response, options) {
			if (showMsg) {
				Common.hideProcessMsgBox();
			}
			var result = Ext.util.JSON.decode(response.responseText);

			var failMsg = Ext.isEmpty(result) ? "数据处理时发生异常." : result;
			Common.showErrorMsgBox(failMsg);
		}
	});
}

CommonAjax.prototype.submitForm = function(_form, params, showMsg, obj,
		callback) {
	if (showMsg) {
		Common.showProcessMsgBox();
	}

	_form.submit( {
		url : this.ajaxUrl,
		timeout : 120000,
		params : params,
		method : "POST",
		success : function(form, action) {
			if (showMsg) {
				Common.hideProcessMsgBox();
			}
			Ext.topShow.msg('成功提示', action.result.message);

			// 调用回调函数
			callback(obj);
		},
		failure : function(form, action) {
			if (showMsg) {
				Common.hideProcessMsgBox();
			}
			var failMsg = Ext.isEmpty(action.result.message) ? "数据处理时发生异常."
					: action.result.message;
			Common.showErrorMsgBox(failMsg);
		}
	});
}