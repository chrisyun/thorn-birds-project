(function($) {
	$.fn.renderer = function(options) {

		// renderer[select,text,detail,custom]

		var defaults = {
			renderer : "select",
			renderArray : new Array(),
			value : null,
			hasSelectBlank : true,
			rendererFunc : null,
			selectBlank : "<option value=''>--------请选择--------</option>"
		};

		var options = $.extend(defaults, options);

		this.each(function() {

			var array = options.renderArray;

			switch (options.renderer) {
			case "select":

				if (options.hasSelectBlank) {
					$(this).append(options.selectBlank);
				}

				for ( var i = 0; i < array.length; i++) {
					var text = array[i][1];
					var value = array[i][0];

					$(this).append(
							'<option value="' + value + '">' + text
									+ '</option>');
				}

				$(this).val(options.value);

				break;
			case "text":

				if ($(this).is("input")) {
					options.value = $(this).val();
				} else {
					options.value = $(this).html();
				}
				
				for ( var i = 0; i < array.length; i++) {
					var text = array[i][1];
					var value = array[i][0];
					
					if (value == options.value) {

						if ($(this).is("input")) {
							$(this).val(text);
						} else {
							$(this).html(text);
						}
					}
				}

				break;
			case "detail":

				var width = $(this).width();
				var letterNum = parseInt(width / 16.5 + 3);
				var content = $(this).html();
				
				if (content.length > letterNum) {
					
					var short = content.substring(0, letterNum-3) + "...";
					
					if($(this).is("a")) {
						$(this).attr("title", content);
						$(this).html(short);
					} else {
						
						var _tip = $('<a href="javascript:void(0);"></a>');
						_tip.attr("title", content);
						_tip.html(short);
						
						$(this).empty();
						$(this).append(_tip);
					}
					
					$(this).tooltip();
				}

				break;
			case "custom":
				options.rendererFunc($(this));
				break;
			default:
				break;
			}
		});
	};
})(jQuery);