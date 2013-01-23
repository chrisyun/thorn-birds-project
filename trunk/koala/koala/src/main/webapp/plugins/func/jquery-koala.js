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
		},
		checkAll : function() {
			var _checkAll = $(":checkbox[class=checkAll]");

			if (_checkAll.attr("checked") == undefined
					|| _checkAll.attr("checked") == ""
					|| _checkAll.attr("checked") == false) {
				$(":checkbox[class=checkOne]").attr("checked", false);
			} else {
				$(":checkbox[class=checkOne]").attr("checked", true);
			}
		},
		getChecked : function() {
			var ids = "";

			$(":checkbox:checked[class=checkOne]").each(function() {
				ids += $(this).val() + ",";
			});

			return ids;
		},
		refreshPage : function() {
			window.location.reload();
		},
		getJqueryOuterHtml : function(domer) {
			return $($('<div></div>').html(domer.clone())).html();
		}
	};

	$.fn.setFormValues = function(data) {

		this.each(function() {
			$(this).resetForm();

			$(this).find(":text,:password,:hidden,textarea,select").each(
					function() {
						var _name = $(this).attr("name");
						$(this).val(data[_name]);
					});

			$(this).find(":radio,:checkbox").each(function() {
				var _name = $(this).attr("name");
				var value = data[_name];

				if (value.indexOf($(this).val()) >= 0) {
					$(this).attr("checked", true);
				}
			});

		});
	};

	$.fn.sort = function(options) {

		var defaults = {
			formId : null,
			sort : null,
			dir : null,
			onSort : function(sort, dir) {
				var _form = $("#" + options.formId);

				if ($.utils.isEmpty(options.formId)) {
					_form = $("form:first");
				}

				_form = _form.append("<input type='hidden' name='sort' value='"
						+ sort + "'>");
				_form = _form.append("<input type='hidden' name='dir' value='"
						+ dir + "'>");

				_form.submit();
			}
		};

		var options = $.extend(defaults, options);
		
		this.each(function(){
			$(this).find("th .sort[]")
		});

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

})(jQuery);
