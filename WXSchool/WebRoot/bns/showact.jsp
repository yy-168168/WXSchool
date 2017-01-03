<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>最新优惠活动</title>

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
		<div>
			<div style="padding: 8px 0"
				onclick="location='http://mp.weixin.qq.com/mp/appmsg/show?__biz=MjM5ODgxOTUyMQ==&appmsgid=10000123&itemidx=1&sign=f9999132406e4f1e07d7898288001471#wechat_redirect'">
				<div style="float: left; width: 35%">
					<img alt=""
						src="https://dl.dropboxusercontent.com/u/103828392/images/bns/glwz.jpg"
						width="90%" height="52px" style="border-radius: 8px">
				</div>
				<div style="float: left; width: 55%">
					<span>咖喱王子庆国庆</span>
					<div style="color: #666; font-size: 13px; margin-top: 6px;">
						所有菜品优惠一元
					</div>
				</div>
				<div style="float: left; width: 10%; padding-top: 18px">
					<img alt="" src="static_/go.png" height="15px">
				</div>
				<div style="clear: both"></div>
			</div>
			<div class="fgx" style=" margin: 0 -8px;"></div>
		</div>
		
		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
