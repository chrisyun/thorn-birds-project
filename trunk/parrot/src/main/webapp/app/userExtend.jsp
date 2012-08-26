<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="../plugins/local/treeField.js"></script>
<script type="text/javascript" src="../system/org/orgTree.js"></script>
<script type="text/javascript" src="userExtend.js"></script>
<script type="text/javascript">

	document.title = "UserExtend - Manage";
	
	var userPermission = {
		MODIFY : '<sec:authorize url="/project/dw/saveOrModify*.jmt">true</sec:authorize>'
	};
	
</script>
<jsp:include page="../reference/footer.jsp"></jsp:include>
