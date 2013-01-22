(function($) {

	function CWnd(options) {
		
		this.options = options;
		
		if ($("#" + id).length <= 0) {
			var _frame = $('<div id="' + options.id + '" class="modal fade"></div>');
			var _header = $('<div class="modal-header">' 
					+ '<a class="close" data-dismiss="modal">×</a>'
					+ '<h3>' + options.title + '</h3></div>');
			var _body = $('<div class="modal-body">' + options.body + '</div>');
			var _footer = $('<div class="modal-footer">' + options.foot + '</div>');

			_frame.appned(_header);
			_frame.appned(_body);
			_frame.appned(_footer);
			_frame.appendTo("body");

			_frame.hide();
		} else {
			// reset
			$("#" + id + " > .modal-header > h3").html(options.title);
			$("#" + id + " > .modal-body").html(options.body);
			$("#" + id + " > .modal-footer").html(options.foot);
		}
	};

	CWnd.prototype.show = function() {
		
	};
	
	CWnd.prototype.hide = function() {
		
	};

});