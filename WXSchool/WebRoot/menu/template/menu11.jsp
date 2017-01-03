<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

		<title>模板</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>

		<style type="text/css">
.mybox {
	position: absolute;
}

.mybox .bg {
	position: absolute;
	background-color: #000;
	opacity: 0.5;
	z-index: -5;
	width: 100%;
	height: 100%;
}

.mybox img,.mybox span {
	font-size: 14px;
	color: #fff;
}
</style>
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideToolbar');
	setTimeout('boxReady()', 1000);
	setTimeout('carouselReady()', 1000);
});

$(function() {
	boxReady();
});

function boxReady() {
	var wd = 77;
	var ht = document.body.clientHeight * 90 / 100 / 4;
	var jg = document.body.clientHeight * 2 / 100;

	$(".mybox").css("width", wd);
	$(".mybox").css("height", ht);
	$(".mybox .bg").css("margin-top", -ht);

	$(".mybox").each(function(i) {
		var n = parseInt(i / 4);
		var m = i % 4;

		$(this).css("left", 10 * (n + 1) + wd * n);
		$(this).css("top", jg * (m + 1) + ht * m);
	});
}
</script>
	</head>

	<body>
		<div>
			<jsp:include page="images_move_bg.jsp"></jsp:include>
		</div>

		<div style="position: absolute; top: 0; left: 0;">
			<%
				int size = 6;
				for (int i = 0; i < size; i++) {
			%>
			<div class="mybox">
				<table width="100%" height="100%" cellpadding="0" cellspacing="0"
					border="0">
					<tr align="center" height="70%">
						<td valign="middle">
							<img alt=""
								src="https://dl.dropboxusercontent.com/u/103828392/images/menbercard.png"
								width="60%">
						</td>
					</tr>
					<tr align="center" height="30%">
						<td valign="top">
							<span>分类</span>
						</td>
					</tr>
				</table>
				<div class="bg"></div>
			</div>
			<%
				}
			%>
		</div>
	</body>
</html>
