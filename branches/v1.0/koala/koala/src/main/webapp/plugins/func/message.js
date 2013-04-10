(function($) {

	$.fn.message = function(options) {
		var defaults = {
			type : "info",
			text : "",
			title : ""
		};

		var options = $.extend(defaults, options);

		if (options.title == "") {
			switch (options.type) {
			case "success":
				options.title = "成功提示";
				break;
			case "error":
				options.title = "错误提示";
				break;
			default:
				options.title = "信息提示";
				break;
			}
		}

		var _msg = $('<div class="alert alert-' + options.type
				+ '"><a class="close" data-dismiss="alert">×</a>'
				+ ' <h4 class="alert-heading">' + options.title + '</h4>'
				+ '<p>' + options.text + '</p>' + '</div>');

		this.each(function() {
			$(this).empty();
			$(this).append(_msg);
		});
	};

})(jQuery);