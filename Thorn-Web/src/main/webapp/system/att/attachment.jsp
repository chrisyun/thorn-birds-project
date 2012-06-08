<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/springTag/header.jmt"></jsp:include>

<script type="text/javascript" src="../../plugins/ext-3.2.1/ux/FileUploadField.js"></script>
<script type="text/javascript" src="../../plugins/ext-3.2.1/ux/MultiSelect.js"></script>
<script type="text/javascript" src="../../plugins/ext-3.2.1/ux/DataViewTransition.js"></script>
<script type="text/javascript" src="../../plugins/local/uploadUtils.js"></script>
<script type="text/javascript" src="../../plugins/local/attachment.js"></script>

<style type="text/css">
#attManager {
    background-color: #fff;
    text-shadow: #fff 0 1px 0;
}

#attManager ul {
    position: relative;
    display: block;
    height: auto;
    font-size: 85%;
}

#attManager ul li img {
    margin-bottom: 1px;
}

#attManager ul li {
    float: left;
    padding: 8px 17px;
    margin: 5px;
/*    margin: 10px 0 0 25px;*/
    text-align: center;
    line-height: 1.25em;
    color: #333;
    font-family: "Helvetica Neue",sans-serif;
    height: 113px;
    width: 112px;
    overflow: hidden;
    border-top: 1px solid transparent;
    cursor: pointer;
}

/*#attManager ul li.phone-hover {
    background-color: #eee;
}*/

#attManager ul li.x-view-selected {
    background-color: rgba(100, 100, 100, .15);
    -moz-border-radius: 8px;
    -webkit-border-radius: 8px;
    border-top: 1px solid rgba(0, 0, 0, .15);
}

#attManager ul li img {
/*    display: block;*/
}

#attManager li strong {
    color: #000;
    display: block;
}

#attManager li span {
    color: #999;
}	
</style>

<script type="text/javascript">

	document.title = "attachment - Manager";
	
</script>
<jsp:include page="../../reference/footer.jsp"></jsp:include>