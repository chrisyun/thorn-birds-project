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
		date.setTime(date.getTime() + 14*3600*1000);
		ck += "; expires=" + date.toGMTString();
		
		document.cookie = ck;
	},
	del : function(key) {
		var exp = new Date();
		exp.setTime(exp.getTime() - 1);
		
		var ckValue = $.cookie.get(key);
		
		if(ckValue != null) {
			document.cookie= key + "="+ckValue+"; expires="+exp.toGMTString();
		}
	}
};

jQuery.utils = {
	isEmpty : function(str) {
		if(str == null || str == "" || str == undefined) {
			return true;
		} else {
			return false;
		}
	}
};
