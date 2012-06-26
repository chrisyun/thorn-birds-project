<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.thorn.core.util.LocalStringUtils"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>
<%
	String flowKey = LocalStringUtils.defaultString((String) request.getAttribute("flowKey"));
	String flowName = LocalStringUtils.defaultString((String) request.getAttribute("flowName"));
	String flowVersion = LocalStringUtils.defaultString((String) request.getAttribute("flowVersion"));
	String flowInstId = LocalStringUtils.defaultString((String) request.getAttribute("flowInstId"));
	String creater = LocalStringUtils.defaultString((String) request.getAttribute("creater"));
	
	String activityName = LocalStringUtils.defaultString((String) request.getAttribute("activityName"));
	String contentPage = LocalStringUtils.defaultString((String) request.getAttribute("pageUrl"));
%>

<script type="text/javascript" src="../../plugins/workflow/processImage.js"></script>
<script type="text/javascript" src="newProcess.js"></script>
<script type="text/javascript">

	document.title = "Workflow - newProcess";
	
	var processInfo = {
		flowKey : "<%=flowKey %>",
		flowName : "<%=flowName %>",
		flowVersion : "<%=flowVersion %>",
		flowInstId : "<%=flowInstId %>",
		creater : "<%=creater %>",
		activityName : "<%=activityName %>",
		contentPage : "<%=contentPage %>"
	}
	
	
	var flowTypeDD = <thorn:dd  typeId="FLOW_TYPE" />;
	var flowTypeRender = function(str) {
		return Render.dictRender(flowTypeDD, str);
	};
	
	var wfNameDD = <thorn:getWfCNName />
	
	var userPermission = {
		MODIFY : '<sec:authorize url="/wf/cr/modifyFlowType.jmt">true</sec:authorize>',
		REMOVE : '<sec:authorize url="/wf/cr/deleteFlowType.jmt">true</sec:authorize>'
	}
	
</script>

<jsp:include page="<%=contentPage %>"></jsp:include>

<jsp:include page="../reference/footer.jsp"></jsp:include>