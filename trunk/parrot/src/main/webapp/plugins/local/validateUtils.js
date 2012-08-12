var Validate = {
	number : "该输入项为数字格式！",
	eMail : "该输入项为邮箱格式！",
	empty : "该输入项不能为空！",
	pwd : "密码强度不够！密码长度为6-15位，至少包含数字、特殊符号和大、小写字母中的两种",
	rpwd : "两次密码不一致！",
	date : "该输入项为日期格式，格式YYYY-MM-DD",
	redStar : '<em class="required">*</em>'
};

Ext.apply(Ext.form.VTypes, {
	number : function(val, field) {
		if (!Ext.isEmpty(val)) {
			var reg = /^[-]{0,1}[0-9]{1,}$/;
			return reg.test(val);
		}
		return true;
	},
	pwd : function(val, field) {
		if (!Ext.isEmpty(val) && val.length >= 6 && val.length < 16) {
			var strength = val.replace(/^(?:([a-z])|([A-Z])|([0-9])|(.)){5,}|(.)+$/g, "$1$2$3$4$5").length;
			if(strength > 1) {
				return true;
			} else {
				return false;
			}
		}
		return false;
	},
	rpwd : function(val, field) {
		if (field.confirmTo) {
			var pwd = Ext.get(field.confirmTo);
			return (val == pwd.getValue());
		}
		return true;
	}
});
