<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="participator.js"></script>
<script type="text/javascript">

	document.title = "Workflow - Participator";
	
	var entityTypeDD = <thorn:dd  typeId="PP_TYPE" />;
	var entityTypeRender = function(str) {
		return Render.dictRender(entityTypeDD, str);
	};
	
	var limitTypeDD = <thorn:dd  typeId="PP_LIMIT_TYPE" />;
	var limitTypeRender = function(str) {
		return Render.dictRender(limitTypeDD, str);
	};
	
	var userPermission = {
		SAVE : '<sec:authorize url="/wf/pp/saveOrModifyPermission.jmt">true</sec:authorize>',
		MODIFY : '<sec:authorize url="/wf/pp/saveOrModifyPermission.jmt">true</sec:authorize>',
		REMOVE : '<sec:authorize url="/wf/pp/deletePermission.jmt">true</sec:authorize>'
	}
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>