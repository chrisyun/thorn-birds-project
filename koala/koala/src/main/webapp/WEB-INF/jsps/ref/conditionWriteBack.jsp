<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	Enumeration<String> e = request.getParameterNames();
		
	StringBuilder json = new StringBuilder("[");
		
	int i = 0;
	while(e.hasMoreElements()) {
		String name = e.nextElement();
		String value = StringUtils.defaultString(request.getParameter(name));
		
		if(i != 0) {
			json.append(",");
		}
		
		json.append("{'key':'").append(name).append("','value':'").append(value).append("'}");
		i++;
	}
	json.append("]");
%>

<script language="javascript">
$(function() {
	var array = <%=json.toString()%>;

	var _from = $(":input");
	if (!$.utils.isEmpty("${param.conditionWriteBackFormId}")) {
		_from = $("#${param.conditionWriteBackFormId} :input");
	}
	
	for ( var i = 0; i < array.length; i++) {
		var key = array[i].key;
		var value = array[i].value;

		var comp = _from.filter("[name='" + key + "']");
		
		if (comp.length == 1) {
			comp.val(value);
		} else if (comp.length > 1) {

			var type = comp.attr("type").toLowerCase();

			if (type == "checkbox" || type == "radio") {

				comp.each(function() {
					var v = $(this).val();
					if (v == value) {
						$(this).attr("checked", true);
					}
				});
			}
		}
	}
});
</script>
