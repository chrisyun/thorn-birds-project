<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="../../plugins/ext-3.2.1/ux/FileUploadField.js"></script>
<script type="text/javascript" src="processDf.js"></script>
<script type="text/javascript">

	document.title = "Workflow - ProcessDf";
	
	var userPermission = {
		DEPLOY : '<sec:authorize url="/wf/deployProcess.jmt">true</sec:authorize>',
		DELETE : '<sec:authorize url="/wf/deleteProcessDf.jmt">true</sec:authorize>'
	}
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>