<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	//String aId = request.getParameter("aId");
	Article article = (Article) request.getAttribute("article"); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title><%=article.getTitle()%></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript">
$(function() {
	function updateVisitPerson() {
		//$.get("/mobile/article?ac=updateVisitPerson&wxaccount=&aId=");
	}
});
</script>

	</head>

	<body onload="checkMM();" style="overflow: hidden; margin: 0">
	<script type="text/javascript">
	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideToolbar');
});
	</script>
	
		<iframe frameborder="0" width="100%" height="100%" marginheight="0"
			marginwidth="0" scrolling="auto" style="overflow-x: hidden;"
			src="<%=article.getLocUrl()%>"></iframe>

		<jsp:include page="copyright.jsp" />
		<div style="height: 10px"></div>
		<%@ include file="toolbar.html"%>
		<%@ include file="tongji.html"%>
	</body>
</html>
