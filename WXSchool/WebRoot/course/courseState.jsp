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

		<title>还没有课表哦</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">

	</head>

	<body>
		<div style="line-height: 1.5; padding: 0 20px;">
			<br />
			<br />
			<br />
			您所在的专业还没有同学添加课表，要不您成为该专业第一人，给大家把课表添加了吧。添加了课表之后，该专业的其他同学就可以直接使用，您愿意为大家效劳么？
			<br />
			<br />
			<input type="button" value="添加课表" class="html5input"
				onclick="location='course/addCourse.jsp?userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
		</div>

		<jsp:include page="../common/copyright.jsp" />		
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
