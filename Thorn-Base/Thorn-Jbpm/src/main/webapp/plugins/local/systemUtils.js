function getCookie(key) {
	var arrStr = document.cookie.split("; ");

	for ( var i = 0; i < arrStr.length; i++) {
		var temp = arrStr[i].split("=");
		if (temp[0] == key) {
			return unescape(temp[1]);
		}
	}

	return null;
}

function completePage() {
	    
	var hideMask = function () {
        Ext.get('loading').remove();
        Ext.fly('loading-mask').fadeOut({
            remove:true
        });
    }

    hideMask.defer(250);
}