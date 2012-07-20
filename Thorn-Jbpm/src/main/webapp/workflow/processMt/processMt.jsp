<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="../../plugins/workflow/processCommon.js"></script>
<script type="text/javascript" src="processMt.js"></script>
<script type="text/javascript">

	document.title = "Workflow - ProcessMt";
	
	var userPermission = {
		CANCEL : '<sec:authorize url="/wf/cm/cancelProcessInst.jmt">true</sec:authorize>',
		DELETE : '<sec:authorize url="/wf/cm/deleteProcessInst.jmt">true</sec:authorize>'
	}
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>