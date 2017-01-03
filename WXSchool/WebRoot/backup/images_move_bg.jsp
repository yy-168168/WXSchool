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

		<title>图片滑动</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/bootstrap.min.js">
</script>

		<style type="text/css">
.carousel {
	position: relative;
	z-index: -100;
	width: 100%;
	height: 100%;
}

.carousel-inner {
	position: relative;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.carousel-inner>.item {
	display: block;
	-webkit-transition: 0.6s ease-in-out left;
	-moz-transition: 0.6s ease-in-out left;
	-o-transition: 0.6s ease-in-out left;
	transition: 0.6s ease-in-out left;
	width: 100%;
	height: 100%;
	background-position: left top;
	background-repeat: no-repeat;
	background-size: cover;
}

.carousel-inner>.item>img,.carousel-inner>.item>a>img {
	display: block;
	line-height: 1;
}

.carousel-inner>.active,.carousel-inner>.next,.carousel-inner>.prev {
	display: block;
}

.carousel-inner>.active {
	left: 0;
}

.carousel-inner>.next,.carousel-inner>.prev {
	position: absolute;
	top: 0;
	width: 100%;
}

.carousel-inner>.next {
	left: 100%;
}

.carousel-inner>.prev {
	left: -100%;
}

.carousel-inner>.next.left,.carousel-inner>.prev.right {
	left: 0;
}

.carousel-inner>.active.left {
	left: -100%;
}

.carousel-inner>.active.right {
	left: 100%;
}
</style>
		<script type="text/javascript">
$(function() {
	//$('.carousel').carousel( {
	//interval : 4000
	//});
});
</script>
	</head>

	<body style="margin: 0;">
		<div id="myCarousel" class="carousel slide">
			<div class="carousel-inner">
				<!-- 
				<div class="item"
					style="background-image: url('https://dl.dropboxusercontent.com/u/103828392/images/menu/slide1.jpg');">
				</div>
				<div class="item"
					style="background-image: url('https://dl.dropboxusercontent.com/u/103828392/images/menu/slide2.jpg');">
				</div>
				-->
				<div class="item"
					style="background-image: url('https://dl.dropboxusercontent.com/u/103828392/images/menu/slide3.jpg');">
				</div>
			</div>
		</div>
	</body>
</html>
