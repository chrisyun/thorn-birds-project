function checkAll() {
	var _checkAll = $(":checkbox[class=checkAll]");
	
	if (_checkAll.attr("checked") == undefined
			|| _checkAll.attr("checked") == ""
			|| _checkAll.attr("checked") == false) {
		$(":checkbox[class=checkOne]").attr("checked", false);
	} else {
		$(":checkbox[class=checkOne]").attr("checked", true);
	}
}

function getChecked() {
	
	var ids = "";
	
	$(":checkbox:checked[class=checkOne]").each(function(){
		ids += $(this).val() + ",";
	});
	
	return ids;
}

function refreshPage() {
	window.location.reload();
}