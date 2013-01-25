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

	String.prototype.replaceAll = function(target, replacement) {
		return this.replace(new RegExp(target, "gm"), replacement);
	};

	$.utils = {
		isEmpty : function(str) {
			if (str == null || str == "" || str == undefined) {
				return true;
			} else {
				return false;
			}
		},
		replaceAll : function(str, target, replacement) {
			return str.replace(new RegExp(target, "gm"), replacement);
		},
		escapeHtml : function(str) {
			str = str.replaceAll("'", "\"");
			str = str.replaceAll("<", "&lt;");
			str = str.replaceAll(">", "&gt;");
			str = str.replaceAll("\"", "&quot;");
			
			return str;
		},
		checkAll : function(ck) {
			// var _checkAll = $(":checkbox[class=checkAll]");
			var _checkAll = $(ck);
			var _ckTable = $(ck).parents("table");

			if (_checkAll.attr("checked") == undefined
					|| _checkAll.attr("checked") == ""
					|| _checkAll.attr("checked") == false) {
				_ckTable.find(":checkbox[class=checkOne]").attr("checked",
						false);
			} else {
				_ckTable.find(":checkbox[class=checkOne]")
						.attr("checked", true);
			}
		},
		getChecked : function(_table) {
			var ids = "";

			_table.find(":checkbox:checked[class=checkOne]").each(function() {
				ids += $(this).attr("id") + ",";
			});
			
			alert(ids);
			
			return ids;
		},
		refreshPage : function() {
			window.location.reload(true);
		},
		reloadPage : function() {
			window.location.replace(window.location.href);
		},
		getJqueryOuterHtml : function(domer) {
			return $($('<div></div>').html(domer.clone())).html();
		},
		object2Json : function(_obj) {
			var array = [];
			var json = "";
			if (Object.prototype.toString.apply(_obj) === '[object Array]') {
				for ( var i = 0; i < _obj.length; i++)
					array.push($.utils.object2Json(_obj[i]));
				json = '[' + array.join(',') + ']';
			} else if (Object.prototype.toString.apply(_obj) === '[object Date]') {
				json = "new Date(" + _obj.getTime() + ")";
			} else if (Object.prototype.toString.apply(_obj) === '[object RegExp]'
					|| Object.prototype.toString.apply(_obj) === '[object Function]') {
				json = _obj.toString();
			} else if (Object.prototype.toString.apply(_obj) === '[object Object]') {
				for ( var i in _obj) {
					var attr = typeof (_obj[i]) == 'string' ? '"' + _obj[i]
							+ '"' : (typeof (_obj[i]) === 'object' ? $.utils
							.object2jsonson(_obj[i]) : _obj[i]);
					array.push(i + ':' + attr);
				}
				json = '{' + array.join(',') + '}';
			}

			return json;
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

	$.fn.sorter = function(options) {

		var defaults = {
			formId : null,
			sort : null,
			dir : null,
			def : {
				"" : ""
			},
			onSort : function(sort, dir) {
				_form.submit();
			}
		};
		var options = $.extend(defaults, options);

		if ($.utils.isEmpty(options.sort)) {

			for ( var key in options.def) {
				options.sort = key;
				options.dir = options.def[key];
			}
		}

		var _form = $("#" + options.formId);
		if ($.utils.isEmpty(options.formId)) {
			_form = $("form:first");
		}
		setSortValue(options.sort, options.dir);

		this.each(function() {
			$(this).find("th[class*='sort']").each(function() {

				var thisCls = $(this).attr("class");
				var getRules = /sort\[(.*)\]/.exec(thisCls);

				if (!getRules) {
					return false;
				}

				var sortName = getRules[1];

				if (options.sort == sortName && options.dir == "asc") {
					sortAsc($(this), $(this).html(), sortName);
				} else if (options.sort == sortName && options.dir == "desc") {
					sortDesc($(this), $(this).html(), sortName);
				} else {
					sortNormal($(this), $(this).html(), sortName);
				}
			});
		});

		function setSortValue(sort, dir) {
			var _sort = _form.find(":input[name='sort']");
			var _dir = _form.find(":input[name='dir']");

			if (_sort.length > 0) {
				_sort.val(sort);
			} else {
				_form.append("<input type='hidden' name='sort' value='" + sort
						+ "'>");
			}

			if (_dir.length > 0) {
				_dir.val(dir);
			} else {
				_form.append("<input type='hidden' name='dir' value='" + dir
						+ "'>");
			}

		}

		function sortNormal(th, text, sortName) {
			var _href = $('<a href="javascript:void(0);"></a>');
			_href.html(text);
			_href.attr("title", '点击按照<span class="red">' + text
					+ '</span><span class="blue">升序</span>排列');

			_href.click(function() {
				setSortValue(sortName, "asc");
				options.onSort(sortName, "asc");
			});

			th.html("");
			th.append(_href);
			_href.tooltip();

			var _iconNormal = $('<i class="icon-resize-vertical" title="点击进行排序"></i>');
			th.append(_iconNormal);
		}

		// 升序
		function sortAsc(th, text, sortName) {
			var _href = $('<a href="javascript:void(0);"></a>');
			_href.html(text);
			_href.attr("title", '点击按照<span class="red">' + text
					+ '</span><span class="blue">降序</span>排列');

			_href.click(function() {
				setSortValue(sortName, "desc");
				options.onSort(sortName, "desc");
			});

			th.html("");
			th.append(_href);
			_href.tooltip();

			var _iconUp = $('<i class="icon-arrow-up" title="按照升序排列"></i>');
			th.append(_iconUp);
		}

		// 降序
		function sortDesc(th, text, sortName) {
			var _href = $('<a href="javascript:void(0);"></a>');
			_href.html(text);
			_href.attr("title", '点击取消排序');

			_href.click(function() {
				setSortValue(sortName, "");
				options.onSort(sortName, "");
			});

			th.html("");
			th.append(_href);
			_href.tooltip();

			var _iconDown = $('<i class="icon-arrow-down" title="按照降序排列"></i>');
			th.append(_iconDown);
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

})(jQuery);
