<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

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

	document.title = "非物质文化遗产项目管理平台 - 登录";

	var iSerror = "${param.error}";
	var error = '${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}';
	var userName = "${sessionScope['SPRING_SECURITY_LAST_USERNAME']}";
	Ext.getDom("userEscape").innerHTML = userName;
	userName = Ext.getDom("userEscape").innerHTML;
	
	var loginUrl = sys.path + "/j_spring_security_check";
	var indexUrl = sys.path + "/system/main.jsp";
	var authCodeUrl = sys.path + "/resources/ImageValidateCodeServlet";
	
	Ext.onReady(function() {
		Ext.QuickTips.init();
		
		var securityCookie = getCookie("SPRING_SECURITY_REMEMBER_ME_COOKIE");
		
		if(!Ext.isEmpty(user.userId) || !Ext.isEmpty(securityCookie)) {
			window.location = indexUrl;
		}
		
		var loginPanel = new Ext.FormPanel( {
			bodyStyle : "padding-top: 30px",
			labelWidth : 100,
			border: false,
			labelAlign : "right",
			onSubmit: Ext.emptyFn, 
			submit: function() { 
				this.getEl().dom.action = loginUrl; 
				this.getEl().dom.method = "post"; 
				this.getEl().dom.submit(); 
			}, 
			defaults : {
				xtype : "textfield",
				width : 150,
				allowBlank: false,
				blankText : Validate.empty
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
				xtype:"panel",
				width: 370,
				border: false,
				layout : "column",
				items : [{
					xtype:"panel",
					layout : "form",
					border: false,
					columnWidth : 0.5,
					items: [{
						xtype:"textfield",
						name : "ValidateCode",
						width : 70,
						fieldLabel : "验证码",
						labelWidth : 100,
						allowBlank: false,
						blankText : Validate.empty,
						listeners : {
							focus : function() {
								var codeLable = Ext.getCmp("codeLabel");
								if(codeLable.hidden) {
									codeLable.show();
									refresh();
								}
							}
						}
					}]
				},{
					id : "codeLabel",
					hidden : true,
					xtype:"label",
					html:'<img alt="验证码" id="authImage" align="middle" width="80" height="24" />&nbsp;<a href="javascript:refresh();">看不清</a>'
				}]
				
			},{
				xtype : "checkbox",
				name : "_spring_security_remember_me",
				boxLabel : "两周内不再登录"
			},{
				xtype:"panel",
				width: 370,
				border: false,
				html : '<div id="loginMsg" class="error"></div>'
			} ]
		});

		var loginWindow = new Ext.Window({
			title:"系统登录 - Login",
			closable:false,
			draggable:false,
			layout : "fit",
			resizable : false,
			width:370,
			height:250,
			tbar:["->", "-", {text:"忘记密码", handler : function() {
				findPwd_win.show("找回密码");
			}}, "-"],
			items : [loginPanel],
			buttonAlign : "center",
			buttons : [ {
				text : "登录",
				handler : function() {
					doSub();
				}
			}, {
				text : "重置",
				handler : function() {
					loginPanel.form.reset();
				}
			} ]
		});
		
		
		var findPwd_form = new FormUtil( {
			id : "fpwdForm",
			collapsible : false,
			labelWidth : 120,
			border : false,
			html : "<div style='padding: 10px 20px 10px 20px;color: red;font-size: 14px;'>请输入系统的登录用户名及注册邮箱，核对无误后，我们会将新密码发送至您的邮箱，请注意查收！</div>"
		});
		
		findPwd_form.addComp(getText("userId", "用户名", 180), 1.0, false);
		findPwd_form.addComp(getMailText("userEmail", "注册邮箱", 180), 1.0, false);
		var findPwd_win = new WindowUtil( {
			width : 370,
			height : 230
		}, findPwd_form.getPanel(), findMyPwd);
		
		findPwd_win.saveBtn.setText("提交");
		
		var findBackPwdUrl = sys.path + "/user/findBackMyPwd.jmt";
		function findMyPwd() {
			var form = findPwd_form.getForm();

			if (!form.isValid()) {
				return;
			}

			var ajaxClass = new AjaxUtil(findBackPwdUrl);
			ajaxClass.submit(form, null, true, findPwd_win, function(
					obj) {
				obj.hide();
				return ;
			});
		};
		
		loginWindow.show();
		
		function doSub() {
			var thisForm = loginPanel.form;
			if (!thisForm.isValid()) {
				return;
			}
			
			Message.showProcessMsgBox();
			loginPanel.form.submit();
		}
		
		
		if(iSerror == "true" && !Ext.isEmpty(error) ) {
			Message.showErrorMsgBox(error,"登陆失败");
			//Ext.getDom("loginMsg").innerHTML = error;
		}

		if(!Ext.isEmpty(userName)) {
			Ext.getCmp("username").setValue(userName);
		}
		
		document.onkeydown = function(event){
			var event 	= event || window.event;
			var keyCode = event.keyCode;
			if (keyCode == 13) {	//回车键
				doSub();
			}
		}
		
		completePage();
		
	});

	function refresh() {
		Ext.getDom("authImage").src = authCodeUrl + "?radom=" + Math.random();
	};

</script>
<jsp:include page="reference/footer.jsp"></jsp:include>
