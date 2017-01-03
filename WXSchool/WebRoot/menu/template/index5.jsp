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

		<title>模板五</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

	</head>

	<body bgcolor="#EFEFEF" style="margin: 0">
		<div style="width: 100%">

			<div style="margin-top: 25px">
				<div style="float: left; width: 50%; text-align: center;">
					<img alt="" src="images/modle6/ind2.jpg" width="90%" height="150px">
					<div
						style="text-align: center; position: absolute; z-index: 2; margin-top: -165px; width: 50%;">
						<img alt="" src="images/modle5/ind.png" width="90%" height="180px">
					</div>
					<div
						style="text-align: center; position: absolute; z-index: 5; width: 50%; margin-top: -15px;">
						<span style="font-size: 20px; font-weight: 200;">数码</span>
					</div>
				</div>
				<div style="float: right; width: 50%; text-align: center;">
					<img alt="" src="images/modle6/ind3.jpg" width="90%" height="150px">
					<div
						style="text-align: center; position: absolute; z-index: 2; margin-top: -165px; width: 50%;">
						<img alt="" src="images/modle5/ind.png" width="90%" height="180px">
					</div>
					<div
						style="text-align: center; position: absolute; z-index: 5; width: 50%; margin-top: -15px;">
						<span style="font-size: 20px; font-weight: 200;">游戏 </span>
					</div>
				</div>
				<div style="clear: both;">
					&nbsp;
				</div>
			</div>

			<div style="margin-top: 25px">
				<div style="float: left; width: 50%; text-align: center;">
					<img alt="" src="images/modle6/ind3.jpg" width="90%" height="150px">
					<div
						style="text-align: center; position: absolute; z-index: 2; margin-top: -165px; width: 50%;">
						<img alt="" src="images/modle5/ind.png" width="90%" height="180px">
					</div>
					<div
						style="text-align: center; position: absolute; z-index: 5; width: 50%; margin-top: -15px;">
						<span style="font-size: 20px; font-weight: 200;">新闻</span>
					</div>
				</div>
				<div style="float: right; width: 50%; text-align: center;">
					<img alt="" src="images/modle6/ind2.jpg" width="90%" height="150px">
					<div
						style="text-align: center; position: absolute; z-index: 2; margin-top: -165px; width: 50%;">
						<img alt="" src="images/modle5/ind.png" width="90%" height="180px">
					</div>
					<div
						style="text-align: center; position: absolute; z-index: 5; width: 50%; margin-top: -15px;">
						<span style="font-size: 20px; font-weight: 200;">科技 </span>
					</div>
				</div>
				<div style="clear: both;">
					&nbsp;
				</div>
			</div>

		</div>
	</body>
</html>
