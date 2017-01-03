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
.menu1 {
	float: left;
	text-align: center;
	width: 25%;
	margin-top: 8px;
}

.menu1 .text {
	background-color: #C6C6C6;
	margin-left: 8px;
	height: 42px;
	line-height: 42px;
	border-left: 1px solid #fff;
	border-top: 1px solid #fff;
	border-right: 1px solid #888;
	border-bottom: 1px solid #888;
}

.menu2 {
	float: left;
	text-align: center;
	width: 50%;
	border-radius: 5px;
}

.menu2 div {
	margin-left: 8px;
}

.menu2 .img {
	margin-top: 8px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.menu2 .img img {
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.menu2 .text {
	background-color: #C6C6C6;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	height: 36px;
	line-height: 36px;
}

#logo {
	position: absolute;
	z-index: 100;
	left: 50%;
	margin-left: -51px;
	margin-top: 147px;
}

#logo .img {
	width: 100px;
	height: 100px;
	border-radius: 50px;
	background-color: #C6C6C6;
	border: 1px solid #666;
	text-align: center;
}
</style>

	</head>

	<body style="margin: 0;">
		<div>
			<jsp:include page="images_move_slide.jsp" flush="true" />
		</div>

		<div id="logo">
			<div class="img">
				<img alt=""
					src="http://t2.qpic.cn/mblogpic/d8d52d744145cfb638f0/460"
					width="100%">
			</div>
		</div>

		<div style="margin-right: 8px">
			<%
				int size = 12;
				for (int i = 0; i < size; i++) {
					if (i >= 4 && i <= 7) {
			%>
			<div class="menu2">
				<div class="img">
					<img alt=""
						src="https://dl.dropboxusercontent.com/u/103828392/images/pictext/shouye1.jpg"
						width="100%" height="100px">
				</div>
				<div class="text">
					分类
				</div>
			</div>
			<%
				} else {
			%>
			<div class="menu1">
				<div class="text">
					分类
				</div>
			</div>
			<%
				}
				}
			%>
			<div style="clear: both;"></div>
		</div>

	</body>
</html>
