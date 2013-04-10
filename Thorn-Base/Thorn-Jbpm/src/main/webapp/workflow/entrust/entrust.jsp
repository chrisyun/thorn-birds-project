<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="entrust.js"></script>
<script type="text/javascript">

	document.title = "Workflow - Entrust";
	
	var wfNameDD = <thorn:getWfCNName />;
	var wfNameRender = function(str) {
		return Render.dictRender(wfNameDD, str);
	};
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>