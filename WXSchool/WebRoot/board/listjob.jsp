<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
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

		<title>兼职</title>

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

	</head>

	<body onload="checkMM();">
		<div
			style="margin: -8px -8px 0 -8px; background-color: #4F4F4F; color: #fff; padding: 8px">
			<img alt="" src="static_/save.png" height="12px">
			由助手认证用户提供
		</div>
		<div>
			<%
				List<Board> boards = (List<Board>) request.getAttribute("boards");
				int size;
				if (boards == null || boards.size() == 0) {
					size = 0;
				} else {
					size = boards.size();
				}
				for (int i = 0; i < size; i++) {
					Board job = boards.get(i);
			%>
			<div style="padding: 6px 10px">
				<div style="color: #4C4C4C;">
					<%=job.getContent()%>
				</div>
				<div style="margin: 3px 0; font-size: 14px; color: #666;">
					<img alt="" src="static_/tel.png" height="13px">
					：<%=job.getContact()%>
				</div>
				<div style="text-align: right; font-size: 12px; color: #999;">
					<%=job.getPubTime()%>
				</div>
			</div>
			<div class="fgx" style="margin: 0 -8px"></div>
			<%
				}
			%>
		</div>

		<jsp:include page="../common/copyright.jsp" />		
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
