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

		<title>蔬菜</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

	</head>

	<body bgcolor="#EFEFEF">
		<div style="width: 100%">

			<div style="margin: -8px; height: 50px; background-color: green;">
				<span style="color: #fff; line-height: 50px; margin-left: 20px;">微蔬菜</span>
				<a href="shucai1.jsp"> <img alt=""
						src="images/shucai/shucaihome.png" width="40px" height="40px"
						style="margin: 5px 20px; float: right;"> </a>
			</div>

			<div
				style="border: 1px solid #aaa; margin-top: 15px; background-color: #fff;">
				<div style="margin: 15px;">
					<div>
						蔬菜标题蔬菜标题
					</div>
					<div style="margin-top: 5px;">
						<a href="shucai1dt.jsp"><img alt="" src="images/shucai/1.jpg"
								width="100%" height="150px"> </a>
					</div>
					<div
						style="padding: 10px 0; margin-top: 5px; background-color: #ccc;">
						￥100元 100人购买
					</div>
					<div
						style="padding: 10px 0; text-align: center; background-color: green; margin-top: 5px; color: #fff;">
						抢购
					</div>
				</div>

				<div style="border: dotted 1px #aaa;"></div>
				<div style="margin: 15px;" onclick="location='model/shucai1dt.jsp'">
					<div style="float: left;">
						<img alt="" src="images/shucai/2.jpg" width="100px" height="60px">
					</div>
					<div style="float: left; margin-left: 10px">
						蔬菜介绍蔬菜介绍
						<br />
						蔬菜介绍
					</div>
					<div style="clear: both;"></div>
				</div>

				<div style="border: dotted 1px #aaa;"></div>
				<div style="margin: 15px;" onclick="location='model/shucai1dt.jsp'">
					<div style="float: left;">
						<img alt="" src="images/shucai/3.jpg" width="100px" height="60px">
					</div>
					<div style="float: left; margin-left: 10px">
						蔬菜介绍蔬菜介绍
						<br />
						蔬菜介绍
					</div>
					<div style="clear: both;"></div>
				</div>
			</div>

		</div>
	</body>
</html>
