(function($) {
	$.cookie = {
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

	$.utils = {
		isEmpty : function(str) {
			if (str == null || str == "" || str == undefined) {
				return true;
			} else {
				return false;
			}
		}
	};

	$.message = {
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
							+ '<div class="modal-footer"><a class="btn" data-dismiss="modal">关闭</a></div>'
							+ "</div>");

					_dialog.appendTo("body");

					$("#_progessDialog").modal({
						backdrop : true,
						keyboard : true,
						show : false
					});

					// 进度条滚动方法
					var _activeProgessBar;

					$("#_progessDialog").on(
							"shown",
							function() {
								_activeProgessBar = setInterval(function() {
									var maxWidth = parseInt($(
											"#_progessDialogBar").parent().css(
											"width"), 10);
									var width = parseInt(
											$("#_progessDialogBar")
													.css("width"), 10);
									if (width < maxWidth) {
										var persent = width / maxWidth + 0.1;

										$("#_progessDialogBar").css("width",
												maxWidth * persent + "px");
									} else {
										$("#_progessDialogBar").css("width",
												"0px");
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
			$.message.alertDialog(attr);
		},
		alertErrorDialog : function(text, title) {
			var attr = new Object();
			attr.type = "error";
			attr.title = title;
			attr.text = text;
			$.message.alertDialog(attr);
		},
		alertSuccessDialog : function(text, title) {
			var attr = new Object();
			attr.type = "success";
			attr.title = title;
			attr.text = text;
			$.message.alertDialog(attr);
		},
		alertDialog : function(attr) {

			if ($.utils.isEmpty(attr.title)) {
				if (attr.type == "success") {
					attr.title = "成功提示";
				} else if (attr.type == "error") {
					attr.title = "错误提示";
				} else {
					attr.title = "信息提示";
				}
			}

			if ($("#_alertDialog").length > 0) {

				$("#_alertDialogTitle").html(attr.title);
				$("#_alertDialogBody").html("<p>" + attr.text + "</p>");

				$("#_alertDialogBody").removeClass();
				$("#_alertDialogBody")
						.addClass("modal-body alert-" + attr.type);

				$("#_alertDialog").modal("show");
			} else {
				var _dialog = $('<div id="_alertDialog" class="modal fade" style="width: 400px;">'
						+ '<div class="modal-header"><a class="close" data-dismiss="modal">×</a>'
						+ '<h3 id="_alertDialogTitle"></h3>'
						+ '</div>'
						+ '<div class="modal-body" id="_alertDialogBody" style="margin-top: 1px;height:80px;"></div>'
						+ '<div class="modal-footer"><a class="btn" data-dismiss="modal">确定</a></div>'
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
				$("#_alertDialogBody")
						.addClass("modal-body alert-" + attr.type);
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
			$.message.showMsg(options);
		},
		showErrorMsg : function(id, text, title) {
			var options = new Object();
			options.id = id;
			options.text = text;
			options.title = title;
			options.type = "error";
			$.message.showMsg(options);
		},
		showSuccessMsg : function(id, text, title) {
			var options = new Object();
			options.id = id;
			options.text = text;
			options.title = title;
			options.type = "success";
			$.message.showMsg(options);
		},
		showMsg : function(options) {
			$("#" + options.id).empty();

			if ($.utils.isEmpty(options.title)) {
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
					+ '<p>' + options.text + '</p>' + '</div>');

			_msg.appendTo("#" + options.id);
		},
		// 模态确认窗口
		confirmDialog : function(text, title, func) {

			if ($.utils.isEmpty(func)) {
				func = title;
				title = "确认窗口";
			}

			if ($("#_confirmDialog").length > 0) {

				$("#_confirmDialog .modal-footer .btn-primary").unbind("click");
				$("#_confirmDialog .modal-footer .btn-primary").on("click",
						func);
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

				$("#_confirmDialog .modal-footer .btn-primary").on("click",
						func);
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

	$.fn.page = function(options) {
		var defaults = {
			formId : null,
			align : "right",
			pageSize : 20,
			maxPage : 8,
			totalSize : 0,
			pageIndex : 1,
			onSkip : function(pageIndex, pageSize) {
				var _form = $("#" + options.formId);

				if ($.utils.isEmpty(options.formId)) {
					_form = $("form:first");
				}

				_form = _form
						.append("<input type='hidden' name='pageIndex' value='"
								+ pageIndex + "'>");
				_form = _form
						.append("<input type='hidden' name='pageSize' value='"
								+ pageSize + "'>");

				_form.submit();
			}
		};

		var options = $.extend(defaults, options);

		// 计算总页数
		var totalPage = parseInt(options.totalSize / options.pageSize);
		if (options.totalSize % options.pageSize > 0) {
			totalPage = totalPage + 1;
		}

		// 校验
		if (options.pageIndex < 1) {
			options.pageIndex = 1;
		}
		if (options.pageIndex > totalPage) {
			options.pageIndex = totalPage;
		}

		var pageArray = new Array(options.maxPage);
		// 定位中间坐标
		var midIndex = parseInt(options.maxPage / 2);

		for ( var i = 0; i < options.maxPage; i++) {
			pageArray[i] = options.pageIndex - (midIndex - i);
		}

		var dif = 0;
		// 顺序移位，少补多减
		if (pageArray[0] < 1) {
			dif = 1 - pageArray[0];
		} else if (pageArray[pageArray.length - 1] > totalPage) {
			dif = totalPage - pageArray[pageArray.length - 1];
		}
		for ( var i = 0; i < options.maxPage; i++) {
			pageArray[i] += dif;
		}

		var pageStart = pageArray[0], pageEnd = pageArray[pageArray.length - 1];

		// 重新校对
		if (pageStart < 1) {
			pageStart = 1;
		}
		if (pageEnd > totalPage) {
			pageEnd = totalPage;
		}

		// 是否显示上一页、下一页、第一页、最后一页
		var showPre = true, showNext = true, showFirst = true, showLast = true;

		if (pageStart == 1) {
			showPre = false;
			showFirst = false;
		}
		if (pageEnd == totalPage) {
			showNext = false;
			showLast = false;
		}

		// 画页面
		var pageBar = $('<div class="pagination"></div>');
		if (options.align == "right") {
			pageBar = $('<div class="pagination pagination-right"></div>');
		} else if (options.align == "center") {
			pageBar = $('<div class="pagination pagination-centered"></div>');
		}

		var _ul = $('<ul></ul>');
		if (showPre) {
			_ul = _ul
					.append($('<li><a href="javascript:void(0);" class="_page_pre">上一页</a></li>'));
		}
		if (showFirst) {
			_ul = _ul
					.append($('<li><a class="_page_1" href="javascript:void(0);">1</a></li>'));
			_ul = _ul
					.append($('<li class="disabled"><a href="javascript:void(0);">...</a></li>'));
		}

		for ( var i = pageStart; i <= pageEnd; i++) {

			if (i == options.pageIndex) {
				_ul = _ul.append($('<li class="active"><a class="_page_' + i
						+ '" href="javascript:void(0);">' + i + '</a></li>'));
			} else {
				_ul = _ul.append($('<li><a class="_page_' + i
						+ '" href="javascript:void(0);">' + i + '</a></li>'));
			}
		}

		if (showLast) {
			_ul = _ul
					.append($('<li class="disabled"><a href="javascript:void(0);">...</a></li>'));
			_ul = _ul
					.append($('<li><a class="_page_' + totalPage
							+ '" href="javascript:void(0);">' + totalPage
							+ '</a></li>'));
		}
		if (showNext) {
			_ul = _ul
					.append($('<li><a href="javascript:void(0);" class="_page_next">下一页</a></li>'));
		}
		pageBar = pageBar.append(_ul);

		// 绑定事件
		pageBar.find("a").on("click", function() {
			var className = $(this).attr("class");

			if ($.utils.isEmpty(className)) {
				return;
			}

			var action = className.replace("_page_", "");
			switch (action) {
			case "next":
				options.onSkip(options.pageIndex + 1, options.pageSize);
				break;
			case "pre":
				options.onSkip(options.pageIndex - 1, options.pageSize);
				break;
			case options.pageIndex:
				break;
			default:
				options.onSkip(parseInt(action), options.pageSize);
				break;
			}
		});

		this.each(function() {
			$(this).append(pageBar);
		});
	};

	$.fn.initDDBox = function(options) {

		var defaults = {
			box : "select",
			array : new Array(),
			defaultValue : null,
			hasDefaultSelShow : true,
			defaultSelShow : "<option value=''>--------请选择--------</option>"
		};

		var options = $.extend(defaults, options);

		this.each(function() {

			var array = options.array;

			switch (options.box) {
			case "select":

				if (options.hasDefaultShow) {
					$(this).append(options.defaultShow);
				}

				for ( var i = 0; i < array.length; i++) {
					var text = array[i][1];
					var value = array[i][0];

					$(this).append(
							'<option value="' + value + '">' + text
									+ '</option>');
				}
				
				$(this).val(options.defaultValue);
				
				break;
			case "text":
				
				for ( var i = 0; i < array.length; i++) {
					var text = array[i][1];
					var value = array[i][0];
					
					if(value == options.defaultValue) {
						
						if($(this).is("input")) {
							$(this).val(text);
						} else {
							$(this).html(text);
						}
					}
				}
				
				break;
			default:
				break;
			}
		});
	};

	$.fn.submitForm = function(options) {
		var defaults = {
			progress : true,
			onSuccess : function(msg) {
				$.message.alertSuccessDialog(msg, "请求处理成功");
			},
			onFailure : function(msg) {
				$.message.alertErrorDialog(msg, "数据处理出错");
			},
			onError : function() {
				$.message.alertErrorDialog("网络请求超时，请稍后再试！");
			},
			data : null,
			dataType : "json"
		};

		var options = $.extend(defaults, options);

		var checkStatus = $(this).validationEngine("validate");

		var ajaxFormOptions = {
			beforeSubmit : function(formData, jqForm, options) {
				return checkStatus;
			},
			error : function() {
				if (options.progress) {
					$.message.progessDialog("close");
				}

				options.onError();
			},
			success : function(result) {
				if (options.progress) {
					$.message.progessDialog("close");
				}

				var success = result.success;
				var msg = result.message;
				var data = result.obj;

				if (success || success == "true") {
					options.onSuccess(msg, data);
				} else {
					options.onFailure(msg, data);
				}
			},
			dataType : options.dataType,
			data : options.data
		};

		if (checkStatus && options.progress) {
			$.message.progessDialog();
		}

		this.each(function() {
			$(this).ajaxSubmit(ajaxFormOptions);
		});
	};

	$.server = {
		ajaxRequest : function(options) {
			var defaults = {
				url : null,
				progress : true,
				onSuccess : function(msg, data) {
					$.message.alertSuccessDialog(msg, "请求处理成功");
				},
				onFailure : function(msg, data) {
					$.message.alertErrorDialog(msg, "数据处理出错");
				},
				onError : function() {
					$.message.alertErrorDialog("网络请求超时，请稍后再试！");
				},
				data : null,
				async : true,
				type : "POST",
				dataType : "json"
			};

			var options = $.extend(defaults, options);
			if (options.progress) {
				$.message.progessDialog();
			}

			$.ajax({
				type : options.type,
				url : options.url,
				cache : false,
				data : options.data,
				dataType : options.dataType,
				async : options.async,
				success : function(result) {
					if (options.progress) {
						$.message.progessDialog("close");
					}

					var success = result.success;
					var msg = result.message;
					var data = result.obj;

					if (success || success == "true") {
						options.onSuccess(msg, data);
					} else {
						options.onFailure(msg, data);
					}
				},
				error : function() {
					if (options.progress) {
						$.message.progessDialog("close");
					}
					options.onError();
				}
			});
		}
	};
})(jQuery);
