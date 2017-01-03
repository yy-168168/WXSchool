<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String picId = request.getParameter("picId");
	String title = "", picUrl = "", desc = "";
	Pic pic = (Pic) request.getAttribute("pic");
	if (pic != null) {
		title = pic.getTitle();
		picUrl = pic.getPicUrl();
		desc = pic.getDesc();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>哈师大助手</title>

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
	$.get("/mobile/pic?ac=updateVisitPerson&wxaccount=<%=wxaccount%>&picId=<%=picId%>");
});

function attention() {
	$.get("/mobile/account?ac=getContent&wxaccount=<%=wxaccount%>&type=guideUrl",
		function(data) {
			if (data != null && data != "") {
				window.location.href = data;
			}
		});
}

function updateSharePerson() {
	$.get("/mobile/pic?ac=updateSharePerson&wxaccount=<%=wxaccount%>&picId=<%=picId%>");
}
</script>
	</head>

	<body onload="checkMM();">
		<div id="title" style="font-weight: bold; font-size: 20px; text-align: center;"><%=title%></div>
		<div style="margin-top: 10px; text-align: center;" id="img-content">
			<img id="img" width="100%" style="border-radius: 5px;"
				src="<%=picUrl%>" />
		</div>
		<div style="margin-top: 15px;"><%=desc %></div>
		<div style="text-align: center">
			<%--
			<input type="button" value="发送/分享给好友" class="html5btn_green"
				style="width: 50%; margin-top: 15px;"
				onclick="showScreenNotice_img('static_/gztx.jpg');">
			<input type="button" value="不要点我哦" class="html5btn_green"
				style="width: 50%; margin-top: 15px;" onclick="attention();">
			--%>
		</div>

		<jsp:include page="copyright.jsp" />
		<%@ include file="toolbar.html"%>
		<%@ include file="tongji.html"%>
	</body>
</html>
