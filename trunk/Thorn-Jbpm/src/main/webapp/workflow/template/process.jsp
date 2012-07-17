<%@page import="org.thorn.core.util.LocalStringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>
<%
	String path = request.getContextPath();
	String flowKey = LocalStringUtils.defaultString((String) request.getAttribute("flowKey"));
	String flowName = LocalStringUtils.defaultString((String) request.getAttribute("flowName"));
	String flowInstId = LocalStringUtils.defaultString((String) request.getAttribute("flowInstId"));
	String creater = LocalStringUtils.defaultString((String) request.getAttribute("creater"));
	
	String taskId = LocalStringUtils.defaultString((String) request.getAttribute("taskId"));
	String pid = LocalStringUtils.defaultString((String) request.getAttribute("pid"));
	String title = LocalStringUtils.defaultString((String) request.getAttribute("title"));
	String openType = LocalStringUtils.defaultString((String) request.getAttribute("openType"));
	String activityName = LocalStringUtils.defaultString((String) request.getAttribute("activityName"));
	String contentPage = "/wfForm/" + LocalStringUtils.defaultString((String) request.getAttribute("pageUrl"));
	
	Set<String> nextStep = (Set<String>) request.getAttribute("nextStep");
%>

<script type="text/javascript" src="<%=path %>/plugins/workflow/processCommon.js"></script>
<script type="text/javascript" src="<%=path %>/workflow/template/process.js"></script>
<script type="text/javascript">

	document.title = "Workflow - Process";
	
	var flowTypeDD = <thorn:dd  typeId="FLOW_TYPE" />;
	var flowTypeRender = function(str) {
		return Render.dictRender(flowTypeDD, str);
	};
	
	var wfNameDD = <thorn:getWfCNName />
	var wfNameRender = function(str) {
		return Render.dictRender(wfNameDD, str);
	};
	var wfTypeRender = function(key) {
		for(var i=0;i<wfNameDD.length;i++) {
			if(key == wfNameDD[i][0]) {
				return wfNameDD[i][2];
			}
		}
		
		return key;
	};
	
	var processInfo = {
		flowKey : "<%=flowKey %>",
		flowName : wfNameRender("<%=flowKey %>"),
		flowType : flowTypeRender(wfTypeRender("<%=flowKey %>")),
		flowInstId : "<%=flowInstId %>",
		creater : "<%=creater %>",
		taskId : "<%=taskId %>",
		activityName : "<%=activityName %>",
		contentPage : "<%=contentPage %>",
		title : "<%=title%>",
		pid : "<%=pid%>",
		openType : "<%=openType%>"
	};
	
	var nextStep = <%=nextStep.toString()%>;
	
</script>

<jsp:include page="<%=contentPage%>"></jsp:include>
<!-- 之间不能有空格，只能为1种情况 -->
<jsp:include page="/reference/footer.jsp"></jsp:include>