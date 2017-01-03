<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String url = (String)request.getAttribute("url");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>即将跳转</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link href="static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/mycommon.js">
</script>
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">
var time = 3;
$(function() {
	setInterval(
			function() {
				time--;
				if (time <= 0) {
					window.location = '<%=url%>' + "&ad=1";
				}
				$("#time").text(time);
			}, 1300);
});
</script>
	</head>

	<body onload="checkMM();">
		<div style="text-align: center;">
			<span id="time">3</span>秒后页面将跳转
		</div>
		<script type="text/javascript" charset="utf-8"
			src="http://fengche.cpv6.com/load/load_1.php?user_id=26390&site_id=12546&site_md5=330bf2ad50e2916d710e61cec95005f1&auto_jump=0&cpv6_ad_format_pop=0&cpv6_ad_format_img=1&image_location=right_lower">
</script>
		<noscript>
			<a href="http://www.cpv6.com/" target="_blank">风车广告联盟</a>
		</noscript>

		<%--<jsp:include page="../copyright.jsp" />--%>
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
