<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="pageAuth.js"></script>
<script type="text/javascript">

	document.title = "Workflow - PageAuth";
	
	var pageAuthDD = <thorn:dd  typeId="PAGE_AUTH" />;
	var pageAuthRender = function(str) {
		return Render.dictRender(pageAuthDD, str);
	};
	
	var userPermission = {
		SAVE : '<sec:authorize url="/wf/pa/saveOrModifyPageAuth.jmt">true</sec:authorize>',
		MODIFY : '<sec:authorize url="/wf/pa/saveOrModifyPageAuth.jmt">true</sec:authorize>',
		REMOVE : '<sec:authorize url="/wf/pa/deletePageAuth.jmt">true</sec:authorize>'
	};
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>