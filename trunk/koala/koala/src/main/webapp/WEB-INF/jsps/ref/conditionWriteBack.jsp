<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java"  pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript">
$(function(){
	<%
		Enumeration<String> e = request.getParameterNames();
		
		String formId = request.getParameter("conditionWriteBackFormId");
		
		if(StringUtils.isEmpty(formId)) {
			formId = "";
		}
		
		while(e.hasMoreElements()) {
			String name = e.nextElement();
			String value = StringUtils.defaultString(request.getParameter(name));
	%>
	var comp;
	if("<%=formId%>" == "") {
		comp = $("[name='<%=name%>']");
	} else {
		comp = $("#<%=formId%> [name='<%=name%>']");
	}
	
	if(comp.length > 1) {
		
		var type = comp.attr("type").toLowerCase();
		
		if(type == "checkbox" || type == "radio") {
			
			comp.each(function(){
				var v = $(this).val();
				if(v == "<%=value%>") {
					$(this).attr("checked", true);
				}
			});
		}
		
	} else {
		comp.val("<%=value%>");
	}
	<%
		}
	%>
});
</script>
