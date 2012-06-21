<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="processMt.js"></script>
<script type="text/javascript">

	document.title = "Workflow - WfPermission";
	
	var userPermission = {
		SAVE : '<sec:authorize url="/wf/permisson/saveOrModifyPermission.jmt">true</sec:authorize>',
		MODIFY : '<sec:authorize url="/wf/permisson/saveOrModifyPermission.jmt">true</sec:authorize>',
		REMOVE : '<sec:authorize url="/wf/permisson/deletePermission.jmt">true</sec:authorize>'
	}
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>