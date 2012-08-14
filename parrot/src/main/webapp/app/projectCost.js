var oneForm,twoForm,threeForm;

function startProcessHandler() {
	
	var getProjectByUser = sys.path + "/project/getProjectByUser.jmt";
	var loadFormUrl = sys.path + "/project/getProjectCostById.jmt";
	
	oneForm = new FormUtil({
		iconCls : "",
		title : "基本信息",
		border : false,
		id : "oneForm",
		collapsible : false,
		labelWidth : 150
	});
	
	var projectStore = new Ext.data.Store({
		url : getProjectByUser,
		autoLoad : true,
		reader : new Ext.data.JsonReader({}, Ext.data.Record
						.create([{
									name : 'id',
									type : 'string'
								}, {
									name : 'name',
									type : 'string'
								}]))
	});
	var projectCb = getComboBox("projectId", "项目", 500, null);
	projectCb.valueField = "id";
	projectCb.displayField = "name";
	projectCb.lazyInit = true;
	projectCb.mode = "remote";
	projectCb.store = projectStore;
	
	oneForm.addComp(projectCb, 0.6, false);
	oneForm.addComp(getComboBox("year", "申报年份", 220, year), 0.3, true);
	oneForm.addComp(getText("createrName", "申报单位", 500), 0.6, false);
	
	oneForm.addComp(getText("address", "地址", 220), 0.3, false);
	oneForm.addComp(getText("postalCode", "邮政编码", 180), 0.3, true);
	oneForm.addComp(getText("contacts", "联系人", 220), 0.3, false);
	oneForm.addComp(getText("phone", "联系电话", 220), 0.3, false);
	oneForm.addComp(getText("bankName", "开户行", 220), 0.3, false);
	oneForm.addComp(getText("bank", "银行", 220), 0.3, false);
	oneForm.addComp(getText("bankAccount", "银行1", 220), 0.3, false);
	oneForm.addComp(getTextArea("companyCtf", "单位资质", 700, 80), 0.9, true);
	
	twoForm = new FormUtil({
		iconCls : "",
		title : "详细信息",
		border : false,
		id : "twoForm",
		collapsible : false,
		labelWidth : 150
	});
	
	twoForm.addComp(getTextArea("appReason", "备注", 700, 80), 0.9, true);
	twoForm.addComp(getTextArea("content", "备注", 700, 80), 0.9, true);
	twoForm.addComp(getTextArea("target", "备注", 700, 80), 0.9, true);
	
	threeForm = new FormUtil({
		iconCls : "",
		title : "预算明细",
		border : false,
		id : "threeForm",
		collapsible : false,
		labelWidth : 150
	});
	threeForm.addComp(getText("usedYear", "银行", 220), 0.3, false);
	threeForm.addComp(getMoneyText("money", "金额（万元）", 220), 0.3, false);
	threeForm.addComp(getTextArea("budget", "备注", 500, 60), 0.9, true);
	
	
	var mainTab = new Ext.TabPanel( {
		activeTab : 0,
		margins : "2 0 2 0",
		resizeTabs : true,
		border : false,
		minTabWidth : 120,
		buttonAlign : "center",
		buttons : [{
			text : "上一步",
			minWidth : 200,
			handler : function() {
				var activateId = mainTab.getActiveTab().getItemId();
				
				if(activateId == "twoForm") {
					mainTab.activate("oneForm");
				} else if(activateId == "threeForm") {
					mainTab.activate("twoForm");
				}
			}
		}, {
			text : "下一步",
			minWidth : 200,
			handler : function() {
				var activateId = mainTab.getActiveTab().getItemId();
				
				if(activateId == "oneForm") {
					mainTab.activate("twoForm");
				} else if(activateId == "twoForm") {
					mainTab.activate("threeForm");
				}
			}
		}],
		items : [ oneForm.getPanel(), twoForm.getPanel(), threeForm.getPanel()]
	});
	
	addContentPanel(mainTab);
	formLoadingComplate();
	
	oneForm.findById("createrName").setDisabled(true);
	
	//非新建时load表单数据
	if(processInfo.openType != "create") {
		oneForm.findById("show_projectId").setDisabled(true);
		
		var ajax = new AjaxUtil(loadFormUrl);
		ajax.getData({
			id : processInfo.pid
		}, null, function(scope, data) {
			oneForm.getForm().reset();
			oneForm.getForm().setValues(data);
			twoForm.getForm().reset();
			twoForm.getForm().setValues(data);
			threeForm.getForm().reset();
			threeForm.getForm().setValues(data);
			
			oneForm.findById("show_projectId").setRawValue(data.projectName);
			
			reLoadAtts(data.attids);
		});
		
		
	} else {
		oneForm.findById("createrName").setValue(user.userName);
	}
}

function VerificationForm() {
	
	if(!oneForm.getForm().isValid()
			|| !twoForm.getForm().isValid()
			|| !threeForm.getForm().isValid()) {
		Ext.Msg.alert("提示信息", "请填写完整的费用申报信息，带<em class=\"required\">*</em>为必填项!");
		return false;
	}
	
	return true;
}

function getFormValues() {
	
	var obj = new Object();
	
	var form1 = oneForm.getForm().getValues(false);
	var form2 = twoForm.getForm().getValues(false);
	var form3 = threeForm.getForm().getValues(false);
	
	for ( var attr in form1) {
		obj["pc_" + attr] = form1[attr];
	}
	for ( var attr in form2) {
		obj["pc_" + attr] = form2[attr];
	}
	for ( var attr in form3) {
		obj["pc_" + attr] = form3[attr];
	}
	
	obj.pc_projectName = oneForm.findById("show_projectId").getRawValue();
	return obj;
}

