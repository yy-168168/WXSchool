<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.wxschool.entity.Student"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
	String aId = request.getParameter("aId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>反馈区</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link href="static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/mycommon.js">
</script>
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">

</script>
	</head>

	<body onload="checkM();">

		

		<jsp:include page="../common/copyright.jsp" />

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table width="100%" cellpadding="0" cellspacing="0">
				<tr align="center" height="40px"
					style="line-height: 40px; color: #fff">
					<%
						String urlsort1 = "rs?ac=myCol&wxaccount=" + wxaccount
								+ "&userwx=" + userwx + "&topicId=-66";
					%>
					<td onclick="location='<%=urlsort1%>'">
						我的反馈
					</td>
				</tr>
			</table>
		</div>
		
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
