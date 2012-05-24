<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="source.js"></script>
<script type="text/javascript">

	document.title = "Resource - Manage";
	
	var iconCls = <thorn:dd  typeId="ICONCLS" />;
	var iconClsRender = function(icon) {
		return Render.dictRender(iconCls, icon);
	};
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>