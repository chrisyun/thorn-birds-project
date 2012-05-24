<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="../org/orgTree.js"></script>
<script type="text/javascript" src="userAuth.js"></script>
<script type="text/javascript">

	document.title = "UserAuth - Manage";
	
	var defaultRole = <thorn:dd  typeId="DEFAULTROLE" />;
	var defaultRoleRender = function(role) {
		return Render.dictRender(defaultRole, role);
	}
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>