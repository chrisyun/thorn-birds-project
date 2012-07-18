var getLeaveFormUrl = sys.path + "/app/leave/getLeaveForm.jmt";
var saveOrModifyUrl = sys.path + "/app/leave/saveOrModify.jmt";

function startProcessHandler() {

	var myForm = new FormUtil({
		border : false,
		id : "startForm",
		collapsible : false,
		labelWidth : 100
	});

	myForm.addComp(getText("days", "请假天数", 180), 0.5, true);
	myForm.addComp(getTextArea("reason", "请假原因", 500, 60), 1.0, true);
	myForm.addComp(getHidden("id"), 0.5, true);

	for ( var i = 0; i < nextStep.length; i++) {
		myForm.addButton(getNextActivityBtn(nextStep[i], submitForm));
	}

	addContentPanel(myForm.getPanel());

	function submitForm(name) {
		alert(name);

		if (!myForm.getForm().isValid()) {
			Ext.Msg.alert("提示信息", "请填写完整的表单信息!");
			return;
		}

		var ajax = new AjaxUtil(saveOrModifyUrl);
		ajax.submit(myForm.getForm(), null, true, myForm,
			function(scope, appId) {
				submitProcessInfo(processInfo.title, appId, name);
			});

	}

	formLoadingComplate();

	if (processInfo.openType != "create" && processInfo.pid != "") {
		var ajax = new AjaxUtil(getLeaveFormUrl);
		ajax.getData({
			appId : processInfo.pid
		}, null, function(scope, data) {
			myForm.getForm().reset();
			myForm.getForm().setValues(data);
		});
	}
}