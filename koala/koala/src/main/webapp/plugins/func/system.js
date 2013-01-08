jQuery.cookie = {
	get : function(key) {
		var arrStr = document.cookie.split("; ");

		for ( var i = 0; i < arrStr.length; i++) {
			var temp = arrStr[i].split("=");
			if (temp[0] == key) {
				return unescape(temp[1]);
			}
		}

		return null;
	},
	add : function(key, value) {
		var ck = key + "=" + escape(value);

		var date = new Date();
		date.setTime(date.getTime() + 14 * 3600 * 1000);
		ck += "; expires=" + date.toGMTString();

		document.cookie = ck;
	},
	del : function(key) {
		var exp = new Date();
		exp.setTime(exp.getTime() - 1);

		var ckValue = $.cookie.get(key);

		if (ckValue != null) {
			document.cookie = key + "=" + ckValue + "; expires="
					+ exp.toGMTString();
		}
	}
};

jQuery.message = {
	// 模态进度条
	progessDialog : function(action) {

		if (action != null && action == "close") {
			$("#_progessDialog").modal("hide");
		} else {

			if ($("#_progessDialog").length > 0) {
				$("#_progessDialog").modal("show");
			} else {
				var _dialog = $('<div id="_progessDialog" class="modal fade" style="width: 400px;">'
						+ '<div class="modal-header"><a class="close" data-dismiss="modal">×</a>'
						+ '<h3>请求处理中...</h3>'
						+ '</div>'
						+ '<div class="modal-body">'
						+ '<div class="progress progress-striped active" style="margin-top: 20px;">'
						+ '<div class="bar" id="_progessDialogBar" style="width: 0%;"></div></div>'
						+ '</div>'
						+ '<div class="modal-footer"><a href="#" class="btn" data-dismiss="modal">关闭</a></div>'
						+ "</div>");

				_dialog.appendTo("body");

				$("#_progessDialog").modal({
					backdrop : true,
					keyboard : true,
					show : false
				});

				var _activeProgessBar;

				$("#_progessDialog").on(
						"shown",
						function() {
							_activeProgessBar = setInterval(
									function() {
										var maxWidth = parseInt($(
												"#_progessDialogBar").parent()
												.css("width"), 10);
										var width = parseInt($(
												"#_progessDialogBar").css(
												"width"), 10);
										if (width < maxWidth) {
											var persent = width / maxWidth
													+ 0.1;

											$("#_progessDialogBar").css(
													"width",
													maxWidth * persent + "px");
										} else {
											$("#_progessDialogBar").css(
													"width", "0px");
										}

									}, 700);
						});

				$("#_progessDialog").on("hidden", function() {
					$("#_progessDialogBar").css("width", "0%");
					window.clearInterval(_activeProgessBar);
				});

				_dialog.modal("show");
			}
		}
	},
	progessDialogJQ : function(action) {

		if (action != null && action == "close") {
			$("#_progessDialog").dialog("close");
		} else {

			if ($("#_progessDialog").length > 0) {
				$("#_progessDialog").dialog("open");
			} else {
				var _dialog = $("<div id='_progessDialog' title='请求处理中...'></div>");
				var _activeProgessBar;

				_dialog.appendTo("body");
				_dialog.dialog({
					resizable : false,
					autoOpen : false,
					hide : "explode",
					show : "blind",
					modal : true,
					height : 120,
					widght : 320,
					open : function(event, ui) {
						_activeProgessBar = setInterval(function() {
							var maxWidth = parseInt($("#_progessDialogBar")
									.parent().css("width"), 10);
							var width = parseInt($("#_progessDialogBar").css(
									"width"), 10);
							if (width < maxWidth) {
								var persent = width / maxWidth + 0.1;

								$("#_progessDialogBar").css("width",
										maxWidth * persent + "px");
							} else {
								$("#_progessDialogBar").css("width", "0px");
							}

						}, 800);
					},
					close : function(event, ui) {
						$("#_progessDialogBar").css("width", "0%");
						window.clearInterval(_activeProgessBar);
					}
				});

				var _progessBar = $("<div class='progress progress-striped active' style='margin-top: 20px;'>"
						+ "<div class='bar' id='_progessDialogBar' style='width: 0%;'></div></div>");
				_progessBar.appendTo(_dialog);

				_dialog.dialog("open");
			}
		}
	},
	// 弹出框提示（成功、失败、一般提示）
	alertInfoDialog : function(text, title) {
		var attr = new Object();
		attr.type = "info";
		attr.title = title;
		attr.text = text;
		jQuery.message.alertDialog(attr);
	},
	alertErrorDialog : function(text, title) {
		var attr = new Object();
		attr.type = "error";
		attr.title = title;
		attr.text = text;
		jQuery.message.alertDialog(attr);
	},
	alertSuccessDialog : function(text, title) {
		var attr = new Object();
		attr.type = "success";
		attr.title = title;
		attr.text = text;
		jQuery.message.alertDialog(attr);
	},
	alertDialog : function(attr) {

		if (jQuery.utils.isEmpty(attr.title)) {
			if (attr.type == "success") {
				attr.title = "成功提示";
			} else if (attr.type == "error") {
				attr.title = "错误提示";
			} else {
				attr.title = "信息提示";
			}
		}

		if ($("#_progessDialog").length > 0) {

			$("#_alertDialogTitle").html(attr.title);
			$("#_alertDialogBody").html("<p>" + attr.text + "</p>");

			$("#_alertDialogBody").removeClass();
			$("#_alertDialogBody").addClass("modal-body alert-" + attr.type);

			$("#_alertDialog").modal("show");
		} else {
			var _dialog = $('<div id="_alertDialog" class="modal fade" style="width: 400px;">'
					+ '<div class="modal-header"><a class="close" data-dismiss="modal">×</a>'
					+ '<h3 id="_alertDialogTitle"></h3>'
					+ '</div>'
					+ '<div class="modal-body" id="_alertDialogBody" style="margin-top: 1px;height:80px;"></div>'
					+ '<div class="modal-footer"><a href="#" class="btn" data-dismiss="modal">确定</a></div>'
					+ "</div>");

			_dialog.appendTo("body");

			$("#_alertDialog").modal({
				backdrop : true,
				keyboard : true,
				show : false
			});

			$("#_alertDialogTitle").html(attr.title);
			$("#_alertDialogBody").html("<p>" + attr.text + "</p>");

			$("#_alertDialogBody").removeClass();
			$("#_alertDialogBody").addClass("modal-body alert-" + attr.type);
			$("#_alertDialog").modal("show");
		}
	},
	// 页面提示（成功、失败、一般提示）
	showInfoMsg : function(id, text, title) {
		var options = new Object();
		options.id = id;
		options.text = text;
		options.title = title;
		options.type = "info";
		jQuery.message.showMsg(options);
	},
	showErrorMsg : function(id, text, title) {
		var options = new Object();
		options.id = id;
		options.text = text;
		options.title = title;
		options.type = "error";
		jQuery.message.showMsg(options);
	},
	showSuccessMsg : function(id, text, title) {
		var options = new Object();
		options.id = id;
		options.text = text;
		options.title = title;
		options.type = "success";
		jQuery.message.showMsg(options);
	},
	showMsg : function(options) {
		$("#" + options.id).empty();

		if (jQuery.utils.isEmpty(options.title)) {
			if (options.type == "success") {
				options.title = "成功提示";
			} else if (options.type == "error") {
				options.title = "错误提示";
			} else {
				options.title = "信息提示";
			}
		}

		var _msg = $('<div class="alert alert-' + options.type
				+ '"><a class="close" data-dismiss="alert">×</a>'
				+ ' <h4 class="alert-heading">' + options.title + '</h4>'
				+ '<p>' + options.text + '</p>');

		_msg.appendTo("#" + options.id);
	},
	// 模态确认窗口
	confirmDialog : function(text, title, func) {

		if (jQuery.utils.isEmpty(func)) {
			func = title;
			title = "确认窗口";
		}

		if ($("#_confirmDialog").length > 0) {

			$("#_confirmDialog .modal-footer .btn-primary").unbind("click");
			$("#_confirmDialog .modal-footer .btn-primary").on("click", func);
			$("#_confirmDialogTitle").html(title);
			$("#_confirmDialogBody").html("<p>" + text + "</p>");

			$("#_confirmDialog").modal("show");
		} else {
			var _dialog = $('<div id="_confirmDialog" class="modal fade" style="width: 400px;">'
					+ '<div class="modal-header"><a class="close" data-dismiss="modal">×</a>'
					+ '<h3 id="_confirmDialogTitle"></h3>'
					+ '</div>'
					+ '<div class="modal-body alert-block" id="_confirmDialogBody" style="margin-top: 1px;height:80px;"></div>'
					+ '<div class="modal-footer">'
					+ '<a href="#" class="btn btn-primary" data-dismiss="modal">确定</a>'
					+ '<a href="#" class="btn" data-dismiss="modal">关闭</a>'
					+ "</div></div>");

			_dialog.appendTo("body");

			$("#_confirmDialog .modal-footer .btn-primary").on("click", func);
			$("#_confirmDialogTitle").html(title);
			$("#_confirmDialogBody").html("<p>" + text + "</p>");

			$("#_confirmDialog").modal({
				backdrop : true,
				keyboard : true,
				show : false
			});

			$("#_confirmDialog").modal("show");
		}
	}
};

jQuery.utils = {
	isEmpty : function(str) {
		if (str == null || str == "" || str == undefined) {
			return true;
		} else {
			return false;
		}
	}
};
