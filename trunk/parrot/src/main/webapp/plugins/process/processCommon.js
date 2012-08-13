ProcessMinds.getMindsUrl = sys.path + "/wf/cm/getProcessMinds.jmt";
function ProcessMinds(flowInstId, activityName, opType) {
	
	this.opType = opType;
	
	this.mindsForm = new FormUtil({
		title : "审批意见",
		region : "center",
		id : "mindsForm",
		autoHeight : true,
		autoScroll : true,
		html : "<div id='mindsDiv'></div>",
		labelWidth : 180
	});
		
	if(opType == "create" || opType == "todo") {
		this.mindsForm.addComp(getHidden("id"), 1.0, true);
		this.mindsForm.addComp(getTextArea("mind", "意见", 500, 80), 1.0, false);
	}
	
	this.html = "";
	this.store = new Ext.data.Store({
		url : ProcessMinds.getMindsUrl,
		baseParams : {flowId : flowInstId},
		reader : new Ext.data.JsonReader({}, 
				Ext.data.Record.create([{
					name : 'activityName',
					type : 'string'
				}, {
					name : 'flowId',
					type : 'string'
				}, {
					name : 'userName',
					type : 'string'
				}, {
					name : 'userId',
					type : 'string'
				}, {
					name : 'time',
					type : 'string'
				}, {
					name : 'mind',
					type : 'string'
				}, {
					name : 'id',
					type : 'string'
				}]))
	});
	this.store.addListener("load", function(store, records) {
		
		this.html = "<table width='100%' style='color: blue;font-size: 13px;'>";
		for(var i=0; i<records.length; i++ ) {
			if(opType == "todo" && activityName == "起草暂存环节"
					&& i == (records.length - 1)
					&& user.userId == records[i].get("userId")) {
				var values = {
					id : records[i].get("id"),
					minds : records[i].get("mind")
				};
				this.mindsForm.getForm().setValues(values);
			} else {
				
				this.html += "<tr>" +
							"<td align='right' width='20%'>" + records[i].get("activityName") + "：&nbsp;&nbsp;</td>" +
							"<td>"  + records[i].get("mind") + "&nbsp;&nbsp;-----&nbsp;&nbsp;" + 
							records[i].get("userName") + "&nbsp;&nbsp;" +records[i].get("time") + "</td>" +
						"</tr>";
			}
		}
		
		this.html += "</table>";
		
		Ext.getDom("mindsDiv").innerHTML = this.html;
	}, this);
}

ProcessMinds.prototype.getMindPanel = function(){
	if(this.opType != "create") {
		this.store.load();
	}
	
	return this.mindsForm.getPanel();
};

ProcessMinds.prototype.getMind = function(){
	var form = this.mindsForm.getForm();
	
	if (!form.isValid()) {
		Ext.Msg.alert("提示信息", "请填写流程意见!");
		return;
	}
	
	return form.getValues();
};


function getNextActivityBtn(name, handler) {
	var activityBtn = new Object();
	
	if(name.indexOf("驳回") > -1 
			|| name.indexOf("退回") > -1
			|| name.indexOf("重新") > -1
			|| name.indexOf("不通过") > -1) {
		activityBtn.iconCls = "silk-cross";
	} else {
		activityBtn.iconCls = "silk-tick";
	}
	
	activityBtn.text = name;
	activityBtn.xtype = "button";
	activityBtn.minWidth = 80;
	activityBtn.handler = function() {
		handler(name);
	};

	return activityBtn;
}
