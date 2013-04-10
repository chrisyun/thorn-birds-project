(function($) {
	
	function UploadWin(options) {
		
		this.options = options;
		
		if($("#_uploadWin").length <= 0) {
			var html = '<div class="modal fade" id="_uploadWin">' +
				  	   	'<div class="modal-header">' +
				  	   		'<a class="close" data-dismiss="modal">×</a>' +
				  	   		'<h3>文件上传</h3>' +
				  	   	'</div>' +
				  	   	'<div>' + 
					  	   	'<div class="modal-body"></div>' +
					  	   	'<div class="modal-footer">' +
					  	   		'<a data-dismiss="modal" class="btn">关闭</a>' +
					  	   	'</div>' +
				  	    '</div>' +
				  	   	'<div id="waiting" class="uploadWaiting" style="display:none;"></div>' +
				  	   '</div>';

			var form = 	'<form class="form-horizontal" method="post" action="" id="_uploadForm">' +
							'<fieldset>' +
								'<div id="_uploadForm_MsgTips"></div>' +
								'<div class="control-group">' +
									'<label class="control-label" for="attShow">文件上传：</label>' +
									'<div class="controls" style="position: relative;">' +
										'<div class="input-append btn-group">' +
											'<input class="input-large" type="text" readonly name="attShow">' +
											'<a class="btn">选择</a>' +
										'</div>' +
										'<input type="file" name="attach" class="customfile-input" size="30" data-validation-engine="validate[required]">' +
									'</div>' +
								'</div>' +
								'<div class="control-group">' +
									'<label class="control-label" for="dir">上传目录：</label>' +
									'<div class="controls">' +
										'<input type="text" class="input-large" name="dir"' +
											'data-validation-engine="validate[required]">' +
											'<p class="help-inline"><i class="redStar">*</i>必填</p>' +
									'</div>' +
								'</div>' +
							'</fieldset>' +
						'</form>';
			
			var _html = $(html);
			var _form = $(form);
			
			_html.find(".modal-body").append(_form);
			$("body").append(_html);
			
			_form.find("[name=attach]").on("change", function() {
				_form.find("[name=attShow]").val($(this).val());
			});
			
			var _uploadBtn = $('<a class="btn btn-primary" id="_uploadForm_Upload">点击上传</a>');
			_html.find(".modal-footer").prepend(_uploadBtn);
			initValidationEngine("_uploadForm");
		}
	}
	
	UploadWin.prototype.setValues = function() {
		$("#_uploadForm").attr("action", this.options.url);
		
		if(this.options.dirRead) {
			$("#_uploadForm [name=dir]").attr("readonly", true);
		} else {
			$("#_uploadForm [name=dir]").attr("readonly", false);
		}
		$("#_uploadForm [name=dir]").val(this.options.dir);
		
		$("#_uploadForm_Upload").unbind( "click" );
		
		var obj = this;
		$("#_uploadForm_Upload").click(function(){
			$("#_uploadForm").submitForm({
				progress : true,
				progressStartFunc : function() {
					obj.waiting();
				},
				progressEndFunc : function() {
					obj.waiting(false);
				},
				onSuccess : function(msg) {
					$("#_uploadForm_MsgTips").message({
						type : "success",
						text : msg,
						title : "请求处理成功"
					});
					obj.options.func(new UploadForm($("#_uploadForm")));
				},
				onFailure : function(msg) {
					$("#_uploadForm_MsgTips").message({
						type : "error",
						text : msg,
						title : "数据处理出错"
					});
				},
				onError : function() {
					$("#_uploadForm_MsgTips").message({
						type : "error",
						text : "网络请求超时，请稍后再试！",
						title : "数据处理出错"
					});
				}
			});
		});
	};
	
	UploadWin.prototype.show = function() {
		$("#_uploadForm_MsgTips").html("");
		$("#_uploadForm").resetForm();
		this.waiting(false);
		$("#_uploadWin").modal("show");
		this.setValues();
	};

	UploadWin.prototype.hide = function() {
		$("#_uploadWin").modal("hide");
	};
	
	UploadWin.prototype.waiting = function(flag) {
		var p = $("#_uploadWin .modal-body").parent("div");
		var wait = $("#_uploadWin #waiting");
		if(flag == null || flag == true) {
			wait.width(p.width());
			wait.height(p.height());
			wait.show();
			p.hide();
		} else {
			wait.hide();
			p.show();
		}
	};
	
	function UploadForm(form) {
		this.folder = form.find("[name=dir]").val();
		this.file = form.find("[name=attach]").val();
		this.fileName = form.find("[name=attach]").val();
		
		return this;
	}
	
	$.fn.uploadFile = function(options) {
		
		var defaults = {
			url : sys.path + "/CMS/WS/uploadFile.jmt",
			dir : "",
			func : function(form) {
				setTimeout(function(){
					$.utils.reloadPage();
				}, 2000);
			},
			dirRead : false
		};

		var options = $.extend(defaults, options);
		
		var win = new UploadWin(options);
		
		this.each(function(){
			$(this).click(function(){
				win.show();
			});
		});
	};
	
	
})(jQuery);