function startProcessHandler() {
	
	var myForm = new FormUtil({
		border : false,
		id : "startForm",
		collapsible : false,
		labelWidth : 100
	});
	
	myForm.addComp(getText("leaveDays", "请假天数", 180), 0.5, true);
	myForm.addComp(getTextArea("leaveReason", "请假原因", 500, 60), 1.0, true);
	
	myForm.addButton(getSaveBtn(submitForm));
	
	addContentPanel(myForm.getPanel());
	
	function submitForm() {

	}
	
	formLoadingComplate();
}

