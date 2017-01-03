<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String topicId = request.getParameter("topicId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>规则说明</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link href="static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="/static_/jquery-1.8.2.min.js">
</script>
	</head>

	<body>

		<div id="rule" class="html5yj"
			style="padding: 3px 10px; line-height: 1.5;">
			<script type="text/javascript">
var url = "/mobile/topic?ac=getTopic_JSON&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&topicId=<%=topicId%>";
$.get(url, function(data) {
	var obj;
	try{
		obj = $.parseJSON(data);
	}catch(e){
		alert("出错啦");
	}
	
	if (obj == null || obj == "") {

	} else {
		$("#rule").html(obj.desc);
	}
});
</script>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
