<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<jsp:include page="core/meta.jsp"></jsp:include>
		<title>SYS - Login</title>
	</head>
	<jsp:include page="core/core.jsp"></jsp:include>


	<style>
	<!--
	body {
		background-color: #4E79B2;
	}
	
	.error {
		color: red;
		padding-left: 120px;
		padding-top: 2px;
	}
	-->
	</style>


	<script type="text/javascript">
	var iSerror = '${param.error}';
	var error = '${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}';
	var userName = '${sessionScope['SPRING_SECURITY_LAST_USERNAME']}';
	var loginUrl = sys.path + "/j_spring_security_check";
	var authCodeUrl = sys.path + "/common/ImageValidateCodeServlet";
	
	Ext.onReady(function() {
		Ext.QuickTips.init();

		if(!Ext.isEmpty(user.userid)) {
			window.location = loginUrl;
		}
		
		var loginPanel = new Ext.FormPanel( {
			bodyStyle : 'padding-top: 30px',
			labelWidth : 100,
			border: false,
			labelAlign : "right",
			onSubmit: Ext.emptyFn, 
			submit: function() { 
				this.getEl().dom.action = loginUrl; 
				this.getEl().dom.method = 'post'; 
				this.getEl().dom.submit(); 
			}, 
			defaults : {
				xtype : "textfield",
				width : 150,
				allowBlank: false,
				blankText : Common.config.msgNull
			},
			items : [ {
				id : "username",
				name : "j_username",
				fieldLabel : "用户名"
			}, {
				name : "j_password",
				fieldLabel : "密码",
				inputType : "password"
			}, {
				xtype:'panel',
				width: 370,
				border: false,
				layout : 'column',
				items : [{
					xtype:'panel',
					layout : "form",
					border: false,
					columnWidth : 0.8,
					items: [{
						xtype:'textfield',
						name : "ValidateCode",
						width : 70,
						fieldLabel : "验证码",
						labelWidth : 100,
						allowBlank: false,
						blankText : Common.config.msgNull
					}]
				},{
					xtype:'label',
					html:'<img alt="验证码" id="authImage" align="middle" width="80" height="24">&nbsp;<a href="javascript:refresh();">看不清</a>'
				}]
				
			},{
				xtype : "checkbox",
				name : "_spring_security_remember_me",
				boxLabel : "三天内不再登录"
			},{
				xtype:'panel',
				width: 370,
				border: false,
				html : '<div id="loginMsg" class="error"></div>'
			} ]
		});

		var loginWindow = new Ext.Window({
			title:"SYS - Login",
			closable:false,
			draggable:false,
			layout : 'fit',
			resizable : false,
			width:370,
			height:250,
			tbar:[{text:"注册"},"-",{text:"密码找回"}],
			items : [loginPanel],
			buttonAlign : "center",
			buttons : [ {
				text : "登录",
				handler : function() {
					var thisForm = loginPanel.form;
					if (!thisForm.isValid()) {
						return;
					}
					
					Common.showProcessMsgBox();
					loginPanel.form.submit();
				}
			}, {
				text : "重置",
				handler : function() {
					loginPanel.form.reset();
				}
			} ]
		});
		loginWindow.show();

		refresh();
		
		if(iSerror == 'true') {
			Ext.getDom("loginMsg").innerHTML = error;
		}

		if(!Ext.isEmpty(userName)) {
			Ext.getCmp("username").setValue(userName);
		}
		
	});

	function refresh() {
		Ext.getDom("authImage").src = authCodeUrl + "?radom=" + Math.random();
	}

</script>

	<body>
		
	</body>
</html>
