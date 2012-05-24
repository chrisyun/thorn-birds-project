<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="../../plugins/local/tree3.js"></script>
<script type="text/javascript" src="role.js"></script>
<script type="text/javascript">

	document.title = "Role - Manage";
	
	var defaultRole = <thorn:dd  typeId="DEFAULTROLE" />;
	var defaultRoleRender = function(role) {
		return Render.dictRender(defaultRole, role);
	}
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>