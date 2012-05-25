<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../plugins/jquery-1.4.2/jquery-1.4.2.min.js"></script>
</head>
<script type="text/javascript">

function sendJson() {
	var testMethodJson = '{"name":"1234","method":"metio"}';
	var json = '{"age":30,"name":"unameIn","id":"ts00027"}';
	
	var pageSearchJson = '{"filter":{"mao":123,"mao1":1234},"page":{"pageSize":20,"pageNo":1,"doAction":"current.page","skipPage":0},"sorting":{"mySort":[{"order":"desc","sortName":"name"},{"order":"desc","sortName":"num"}]}}';
	var pageTest = '{"start":0,"limit":25}';

	var dictType = '{"ename":"rrrr1","cname":"hhhhh"}';
	
	var ajson;
	$.ajax({
        type: 'POST',
        contentType: 'application/json',
        url: 'http://localhost:8889/thorn-web/dd/addDictType.xhtml',
        data: dictType,
        dataType: 'json',
        success: function(data){
        	//alert("==");
            $("#rs").html(json2Str(data));
        },
        error: function(data){
            //alert("error=="+data);
        	 $("#rs").html(json2Str(data));
        }
    });
}

function json2Str(o) {
    if (o == undefined) {
        return "";
    }
    var r = [];
    if (typeof o == "string") return "\"" + o.replace(/([\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
    if (typeof o == "object") {
        if (!o.sort) {
            for (var i in o)
                r.push("\"" + i + "\":" + json2Str(o[i]));
            if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
                r.push("toString:" + o.toString.toString());
            }
            r = "{" + r.join() + "}"
        } else {
            for (var i = 0; i < o.length; i++)
                r.push(json2Str(o[i]))
            r = "[" + r.join() + "]";
        }
        return r;
    }
    return o.toString().replace(/\"\:/g, '":""');
}

</script>


<body>
<input type="button" value="发起请求" onclick="sendJson();"><br>
<div id="rs"></div>
</body>
</html>