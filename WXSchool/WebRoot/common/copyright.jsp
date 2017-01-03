<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>版权信息</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<%--<link href="static_/mycommon.css" type="text/css" rel="stylesheet">--%>
		<%--<script type="text/javascript" src="static_/mycommon.js?v=12345"></script>--%>
		<%--<script type="text/javascript" src="static_/jquery-1.8.2.min.js"></script>--%>

		<script type="text/javascript">
$(function() {
	var copyrightCookie = getCookie("copyright@<%=wxaccount%>");
	if(copyrightCookie == ""){
		$.get("/mobile/account?ac=getAccount&wxaccount=<%=wxaccount%>", function(data) {
			var obj = null;
			try{
				obj = $.parseJSON(data);
			}catch(e){
			}
			
			if (obj != null && obj != '') {
				var wxName = obj.wxName;
				var wxNum = obj.wxNum;
				$("#copyright").html("©&nbsp;&nbsp;"+wxName+"("+wxNum+")");
				addCookie("copyright@<%=wxaccount%>", "© "+wxName+"("+wxNum+")", 30*24*60);
			}
		});
	}else{
		$("#copyright").html(copyrightCookie);
	}
});
</script>
	</head>

	<body>
		<div id="copyright" style="text-align: center; margin-top: 15px; font-size: 13px; color: #333"></div>
	</body>
</html>
