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

		<title>模板七</title>

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

			<div style="margin: -8px;">
				<iframe name="content_frame" width=100% height="200px"
					frameborder="0" scrolling="no" marginwidth=0 marginheight=0
					src="model/images_move.html"></iframe>
			</div>

			<div style="margin-top: 18px">
				<div style="margin-top: 10px">
					<div style="float: left; width: 33%; text-align: center;">
						<img alt="" src="images/modle7/in1.png" width="60%" height="54px">
						<div style="padding: 10px; font-size: 18px; font-weight: 200;">
							功能说明
						</div>
					</div>
					<div style="float: left; width: 33%; text-align: center;">
						<img alt="" src="images/modle7/in2.png" width="60%" height="54px">
						<div style="padding: 10px; font-size: 18px; font-weight: 200;">
							音乐共享
						</div>
					</div>
					<div style="float: left; width: 33%; text-align: center;">
						<img alt="" src="images/modle7/in3.png" width="60%" height="54px">
						<div style="padding: 10px; font-size: 18px; font-weight: 200;">
							个人账户
						</div>
					</div>
					<div style="clear: both;"></div>
				</div>

				<div style="margin-top: 10px">
					<div style="float: left; width: 31%; text-align: center;">
						<img alt="" src="images/modle7/in4.png" width="60%" height="54px">
						<div style="padding: 10px; font-size: 18px; font-weight: 200;">
							邮件箱
						</div>
					</div>
					<div style="float: left; width: 33%; text-align: center;">
						<img alt="" src="images/modle7/in5.png" width="60%" height="54px">
						<div style="padding: 10px; font-size: 18px; font-weight: 200;">
							收藏夹
						</div>
					</div>
					<div style="float: left; width: 33%; text-align: center;">
						<img alt="" src="images/modle7/in6.png" width="60%" height="54px">
						<div style="padding: 10px; font-size: 18px; font-weight: 200;">
							设置
						</div>
					</div>
					<div style="clear: both;"></div>
				</div>
			</div>

		</div>
	</body>
</html>
