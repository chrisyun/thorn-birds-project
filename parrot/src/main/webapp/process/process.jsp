<%@page import="org.thorn.core.util.LocalStringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>
<%
	String path = request.getContextPath();
	String flowKey = LocalStringUtils.defaultString((String) request.getAttribute("flowKey"));
	String flowInstId = LocalStringUtils.defaultString((String) request.getAttribute("flowInstId"));
	
	String creater = LocalStringUtils.defaultString((String) request.getAttribute("creater"));
	String createrName = LocalStringUtils.defaultString((String) request.getAttribute("createrName"));
	
	String pid = LocalStringUtils.defaultString((String) request.getAttribute("appId"));
	String title = LocalStringUtils.defaultString((String) request.getAttribute("title"));
	String openType = LocalStringUtils.defaultString((String) request.getAttribute("openType"));
	String activityName = LocalStringUtils.defaultString((String) request.getAttribute("activityName"));
	String contentPage = "/wfForm/" + LocalStringUtils.defaultString((String) request.getAttribute("pageUrl"));
	
	Set<String> nextStep = (Set<String>) request.getAttribute("nextStep");
%>

<script type="text/javascript" src="<%=path %>/plugins/ext-3.2.1/ux/FileUploadField.js"></script>
<script type="text/javascript" src="<%=path %>/plugins/ext-3.2.1/ux/MultiSelect.js"></script>
<script type="text/javascript" src="<%=path %>/plugins/local/uploadUtils.js"></script>
<script type="text/javascript" src="<%=path %>/plugins/process/processCommon.js"></script>
<script type="text/javascript" src="process.js"></script>

<script type="text/javascript">

	document.title = "Workflow - Process";
	
	var flowTypeDD = <thorn:dd  typeId="FLOW_TYPE" />;
	var flowTypeRender = function(str) {
		return Render.dictRender(flowTypeDD, str);
	};
	
	var processInfo = {
		flowKey : "<%=flowKey %>",
		flowInstId : "<%=flowInstId %>",
		creater : "<%=creater %>",
		createrName : "<%=createrName %>",
		activityName : "<%=activityName %>",
		title : "<%=title%>",
		pid : "<%=pid%>",
		openType : "<%=openType%>"
	};
	
	var nextStep = new Array();
	<%
		for(String outcome : nextStep) {
	%>
	nextStep.push("<%=outcome%>");
	<%
		}
	%>
</script>

<jsp:include page="<%=contentPage%>"></jsp:include>
<!-- 之间不能有空格，只能为1种情况 -->
<jsp:include page="/reference/footer.jsp"></jsp:include>