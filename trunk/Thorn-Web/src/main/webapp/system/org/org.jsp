<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="thorn" uri="/thorn"%>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="../../plugins/local/treeField.js"></script>
<script type="text/javascript" src="orgTree.js"></script>
<script type="text/javascript" src="org.js"></script>
<script type="text/javascript">

	document.title = "Org - Manage";
	
	var orgType = <thorn:dd  typeId="ORGTYPE" />;
	var orgTypeRender = function(type) {
		return Render.dictRender(orgType, type);
	};
	
	var area = <thorn:dd  typeId="AREA" />;
	var areaRender = function(str) {
		return Render.dictRender(area, str);
	};
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>