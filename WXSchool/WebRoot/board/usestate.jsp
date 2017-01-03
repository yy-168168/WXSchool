<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>使用声明</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" /> 
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

	</head>

	<body>

		<div class="html5yj"
			style="padding: 6px 10px; line-height: 1.5; font-size: 15px">
			<ol>
				<li>
					这个平台需要大家一起来维护秩序，请遵守消息发布规则。
				</li>
				<li>
					请按照分类发布您的消息，如果您无法确定您的消息分类，请先发送反馈。
				</li>
				<li>
					不要发布无关没用消息，一经审核，立即拉入平台黑名单，并且不可恢复。
				</li>
				<li>
					如有任何问题，请发送反馈，或者联系我们。
				</li>
			</ol>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
