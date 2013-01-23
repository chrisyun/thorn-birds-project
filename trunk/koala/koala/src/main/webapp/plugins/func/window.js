(function($) {

	function CWnd(options) {

		var defaults = {
			id : "",
			title : "",
			body : "",
			foot : "",
			width : "",
			height : "",
			cls : ""
		};

		this.options = $.extend(defaults, options);

		if ($("#" + options.id).length <= 0) {
			var _frame = $('<div id="' + options.id
					+ '" class="modal fade"></div>');
			var _header = $('<div class="modal-header">'
					+ '<a class="close" data-dismiss="modal">×</a>' + '<h3>'
					+ options.title + '</h3></div>');
			var _body = $('<div class="modal-body"></div>')
					.append(options.body);
			var _footer = $('<div class="modal-footer"></div>').append(
					options.foot);

			_frame.append(_header);
			_frame.append(_body);
			_frame.append(_footer);
			_frame.appendTo("body");

			$("#" + options.id).modal({
				backdrop : true,
				keyboard : false,
				show : false
			});
			$("#" + options.id).modal("hide");
		} else {
			// reset
			$("#" + options.id + " > .modal-header > h3").html(options.title);
			$("#" + options.id + " > .modal-body").empty();
			$("#" + options.id + " > .modal-body").append(options.body);
			$("#" + options.id + " > .modal-footer").empty();
			$("#" + options.id + " > .modal-footer").append(options.foot);
		}

		if (!$.utils.isEmpty(options.width)) {
			$("#" + options.id).css("width", options.width);
		} else {
			$("#" + options.id).css("width", "");
		}

		var _modalBody = $("#" + options.id + " > .modal-body");

		if (!$.utils.isEmpty(options.height)) {
			_modalBody.css("height", options.height);
		} else {
			_modalBody.css("height", "");
		}

		if (!$.utils.isEmpty(options.cls)) {
			_modalBody.addClass(options.cls);
		} else {
			_modalBody.removeClass();
			_modalBody.addClass("modal-body");
		}
	}
	;

	CWnd.prototype.show = function() {
		$("#" + this.options.id).modal("show");
	};

	CWnd.prototype.hide = function() {
		$("#" + this.options.id).modal("hide");
	};

	$.dialog = {
		progress : function(action) {

			var cwnd = new CWnd(
					{
						id : "_progressDialog",
						title : "请求处理中...",
						width : 400,
						body : '<div class="progress progress-striped active" style="margin-top: 20px;">'
								+ '<div class="bar" id="_progressDialogBar" style="width: 0%;"></div>',
						foot : '<a class="btn" data-dismiss="modal">关闭</a>'
					});

			if (action != null && action == "close") {
				cwnd.hide();
				return;
			}

			var _activeProgressBar;

			$("#_progressDialog").on(
					"shown",
					function() {
						_activeProgressBar = setInterval(function() {
							var maxWidth = parseInt($("#_progressDialogBar")
									.parent().css("width"), 10);
							var width = parseInt($("#_progressDialogBar").css(
									"width"), 10);
							if (width < maxWidth) {
								var persent = width / maxWidth + 0.1;

								$("#_progressDialogBar").css("width",
										maxWidth * persent + "px");
							} else {
								$("#_progressDialogBar").css("width", "0px");
							}

						}, 700);
					});

			$("#_progressDialog").on("hidden", function() {
				$("#_progressDialogBar").css("width", "0%");
				window.clearInterval(_activeProgressBar);
			});

			cwnd.show();
		},
		alertInfo : function(text, title) {
			var attr = new Object();
			attr.type = "info";
			attr.title = title;
			attr.text = text;
			$.dialog.alert(attr);
		},
		alertError : function(text, title) {
			var attr = new Object();
			attr.type = "error";
			attr.title = title;
			attr.text = text;
			$.dialog.alert(attr);
		},
		alertSuccess : function(text, title) {
			var attr = new Object();
			attr.type = "success";
			attr.title = title;
			attr.text = text;
			$.dialog.alert(attr);
		},
		alert : function(options) {

			if ($.utils.isEmpty(options.title)) {
				if (options.type == "success") {
					options.title = "成功提示";
				} else if (options.type == "error") {
					options.title = "错误提示";
				} else {
					options.title = "信息提示";
				}
			}

			var cwnd = new CWnd({
				id : "_alertDialog",
				title : options.title,
				width : 400,
				height : 60,
				cls : "alert-" + options.type,
				body : "<p>" + options.text + "</p>",
				foot : '<a class="btn" data-dismiss="modal">关闭</a>'
			});

			cwnd.show();
		},
		confirm : function(text, title, func) {
			if ($.utils.isEmpty(func)) {
				func = title;
				title = "确认窗口";
			}

			var cwnd = new CWnd({
				id : "_confirmDialog",
				title : title,
				width : 400,
				height : 60,
				cls : "alert-info",
				body : "<p>" + text + "</p>",
				foot : '<a class="btn btn-primary" data-dismiss="modal">确定</a>'
						+ '<a class="btn" data-dismiss="modal">关闭</a>'
			});

			$("#_confirmDialog .modal-footer .btn-primary").on("click", func);
			cwnd.show();
		}
	};

	$.fn.formDialog = function(options) {

		var _formId = $(this).attr("id");
		var _dialogId = "_formDialog_" + _formId;
		var _form = $(this);

		var _method = {
			show : function() {
				$("#" + _dialogId).modal("show");
			},
			close : function() {
				$("#" + _dialogId).modal("hide");
			},
			init : function(options) {
				var defaults = {
					title : "",
					buttons : [ {
						text : "关闭",
						cls : "",
						closed : true,
						click : function() {
							$("#" + _dialogId).modal("hide");
						}
					} ]
				};

				var options = $.extend(defaults, options);

				var _body = $.utils.getJqueryOuterHtml($("#" + _formId));
				_form.remove();

				var _foot = null;
				for ( var i = 0; i < options.buttons.length; i++) {

					var btn = options.buttons[i];

					var _btn = $('<a class="btn"></a>');
					_btn.html(btn.text);
					_btn.addClass(btn.cls);

					if (!$.utils.isEmpty(btn.closed) && btn.closed == true) {
						_btn.attr("data-dismiss", "modal");
					}

					if (!$.utils.isEmpty(btn.click)) {
						_btn.click(btn.click);
					}

					if (_foot == null || _foot == undefined) {
						_foot = _btn;
					} else {
						_foot.after(_btn);
					}
				}

				new CWnd({
					id : _dialogId,
					title : options.title,
					body : _body,
					foot : _foot,
					height : options.height,
					width : options.width
				});
			}
		};

		if ($.utils.isEmpty(options)) {
			options = "show";
		}

		if (typeof options == "string") {
			_method[options]();
			return;
		} else {
			_method["init"](options);
		}
	};

})(jQuery);