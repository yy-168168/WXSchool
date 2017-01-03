<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.wxschool.entity.Merchant"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	Merchant merchant = (Merchant) request.getAttribute("merchant");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title><%=merchant.getName()%></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link href="<%=basePath%>static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath%>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/jquery-1.8.2.min.js">
</script>

	</head>

	<body onload="checkMM();">

		<table width="100%" height="100%">
			<tr>
				<td align="center">
					<div style="margin: 0 30px">
						<div>
							营业时间：<%=merchant.getStartTime()%>-<%=merchant.getEndTime()%>
						</div>
						<div style="margin-top: 10px">
							<%=merchant.getDesc()%>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td height="50px">
					<jsp:include page="../common/copyright.jsp" />
				</td>
			</tr>
		</table>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
