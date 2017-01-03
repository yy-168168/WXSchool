<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
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
		<script type="text/javascript" src="static_/mycommon.js">
</script>
		<script type="text/javascript" src="static_/bootstrap.min.js">
</script>

		<style type="text/css">
.carousel {
	position: relative;
	margin-bottom: 10px;
}

.carousel-inner {
	position: relative;
	width: 100%;
	overflow: hidden;
}

.carousel-inner>.item {
	position: relative;
	display: none;
	-webkit-transition: 0.6s ease-in-out left;
	-moz-transition: 0.6s ease-in-out left;
	-o-transition: 0.6s ease-in-out left;
	transition: 0.6s ease-in-out left;
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

.carousel-indicators {
	position: absolute;
	bottom: 6px;
	right: 15px;
	z-index: 5;
	margin: 0;
	list-style: none;
}

.carousel-indicators li {
	display: block;
	float: left;
	width: 10px;
	height: 10px;
	margin-left: 5px;
	text-indent: -999px;
	background-color: #fff;
	background-color: rgba(255, 255, 255, 0.5);
	border-radius: 5px;
}

.carousel-indicators .active {
	background-color: #fff;
}

.carousel-caption {
	position: absolute;
	z-index: 2;
	right: 0;
	bottom: 0;
	left: 0;
	padding: 3px;
	background: #333333;
	background: rgba(0, 0, 0, 0.45);
}

.carousel-caption h4,.carousel-caption span {
	color: #ffffff;
}

.carousel-caption h4 {
	margin: 0 0 5px;
}

.carousel-caption span {
	margin-bottom: 0;
	font-size: 13px;
}
</style>
		<script type="text/javascript">
function carouselReady() {
	$('.carousel').carousel( {
		interval : 4000
	});
}
</script>
	</head>

	<body onload="carouselReady();">
		<div id="myCarousel" class="carousel slide">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<!-- Carousel items -->
			<div class="carousel-inner">
				<div class="active item">
					<img alt=""
						src="https://dl.dropboxusercontent.com/u/103828392/images/menu/ad0.jpg"
						width="100%">
					<div class="carousel-caption">
						<span id="curTime"><script type="text/javascript">
var curTime = getCurWeek('<%=wxaccount%>');
document.getElementById("curTime").innerHTML = curTime;
</script></span>
					</div>
				</div>
				<div class="item">
					<img alt=""
						src="https://dl.dropboxusercontent.com/u/103828392/images/menu/ad1.jpg"
						width="100%">
					<div class="carousel-caption">
						<span>学生证补办充磁行知楼226</span>
					</div>
				</div>
				<div class="item">
					<img alt=""
						src="https://dl.dropboxusercontent.com/u/103828392/images/menu/ad2.jpg"
						width="100%">
					<div class="carousel-caption">
						<span>哈师大助手 让校园更加温馨</span>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
