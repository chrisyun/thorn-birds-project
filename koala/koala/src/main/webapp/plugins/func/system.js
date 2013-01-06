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
						_activeProgessBar = setInterval(function(){
							var maxWidth = parseInt($("#_progessDialogBar").parent().css("width"),10);
							var width = parseInt($("#_progessDialogBar").css("width"),10);
							if(width < maxWidth) {
								var persent = width/maxWidth + 0.1;
								
								$("#_progessDialogBar").css("width", maxWidth*persent+"px");
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
	}
// 弹出框提示（成功、失败、一般提示）
// 页面提示（成功、失败、一般提示）
// 模态确认窗口
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
