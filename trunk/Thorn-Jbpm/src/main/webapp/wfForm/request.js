function startProcessHandler() {
	
	var myForm = new FormUtil({
		border : false,
		id : "startForm",
		collapsible : false,
		labelWidth : 100
	});
	
	myForm.addComp(getText("methodName", "方法名称", 180), 0.5, true);
	myForm.addComp(getText("userId", "操作人", 180), 0.5, true);
	myForm.addComp(getText("executeTime", "操作时间", 180), 0.5, true);
	myForm.addComp(getTextArea("parameters", "方法参数", 500, 60), 1.0, true);
	
	myForm.addButton(getSaveBtn(submitForm));
	
	addContentPanel(myForm.getPanel());
	
	function submitForm() {

	}
	
	formLoadingComplate();
}

