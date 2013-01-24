(function($) {

	$.fn.submitForm = function(options) {
		var defaults = {
			progress : true,
			onSuccess : function(msg) {
				$.dialog.alertSuccess(msg, "请求处理成功");
			},
			onFailure : function(msg) {
				$.dialog.alertError(msg, "数据处理出错");
			},
			onError : function() {
				$.dialog.alertError("网络请求超时，请稍后再试！");
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
				var sec = 0;
				if (options.progress) {
					setTimeout(function() {
						$.dialog.progress("close");
					}, 500);
					sec = 800;
				}

				setTimeout(options.onError, sec);
			},
			success : function(result) {
				var sec = 0;
				if (options.progress) {
					setTimeout(function() {
						$.dialog.progress("close");
					}, 500);
					sec = 800;
				}

				var success = result.success;
				var msg = result.message;
				var data = result.obj;

				setTimeout(function() {
					if (success || success == "true") {
						options.onSuccess(msg, data);
					} else {
						options.onFailure(msg, data);
					}
				}, sec);
			},
			dataType : options.dataType,
			data : options.data
		};

		if (checkStatus && options.progress) {
			$.dialog.progress();
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
					$.dialog.alertSuccess(msg, "请求处理成功");
				},
				onFailure : function(msg, data) {
					$.dialog.alertError(msg, "数据处理出错");
				},
				onError : function() {
					$.dialog.alertError("网络请求超时，请稍后再试！");
				},
				data : null,
				async : true,
				type : "POST",
				dataType : "json"
			};

			var options = $.extend(defaults, options);
			if (options.progress) {
				$.dialog.progress();
			}

			$.ajax({
				type : options.type,
				url : options.url,
				cache : false,
				data : options.data,
				dataType : options.dataType,
				async : options.async,
				success : function(result) {
					var sec = 0;
					if (options.progress) {
						setTimeout(function() {
							$.dialog.progress("close");
						}, 500);
						sec = 800;
					}

					var success = result.success;
					var msg = result.message;
					var data = result.obj;

					setTimeout(function() {
						if (success || success == "true") {
							options.onSuccess(msg, data);
						} else {
							options.onFailure(msg, data);
						}
					}, sec);
				},
				error : function() {
					var sec = 0;
					if (options.progress) {
						setTimeout(function() {
							$.dialog.progress("close");
						}, 500);
						sec = 800;
					}
					setTimeout(options.onError, sec);
				}
			});
		}
	};

})(jQuery);