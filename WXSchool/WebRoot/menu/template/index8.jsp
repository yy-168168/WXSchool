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

		<title>模板八</title>

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

			<div style="">

				<div style="padding: 20px 0 5px 0;">
					<div style="float: left; width: 90%; height: 20px;">
						<span
							style="font-size: 20px; font-weight: 200px; margin-left: 15px;">企业介绍</span>
					</div>
					<div
						style="float: right; width: 10%; height: 20px; text-align: center;">
						<img alt="" src="images/modle8/go.png"
							style="width: 20px; height: 20px;">
					</div>
					<div style="clear: both;"></div>
					<div style="border: 1px solid #ccc; margin: 8px -8px 0 -8px;"></div>
				</div>

				<div style="padding: 20px 0 5px 0;">
					<div style="float: left; width: 90%; height: 20px;">
						<span
							style="font-size: 20px; font-weight: 200px; margin-left: 15px;">企业风采</span>
					</div>
					<div
						style="float: right; width: 10%; height: 20px; text-align: center;">
						<img alt="" src="images/modle8/go.png"
							style="width: 20px; height: 20px;">
					</div>
					<div style="clear: both;"></div>
					<div style="border: 1px solid #ccc; margin: 8px -8px 0 -8px;"></div>
				</div>

				<div style="padding: 20px 0 5px 0;">
					<div style="float: left; width: 90%; height: 20px;">
						<span
							style="font-size: 20px; font-weight: 200px; margin-left: 15px;">最新资讯</span>
					</div>
					<div
						style="float: right; width: 10%; height: 20px; text-align: center;">
						<img alt="" src="images/modle8/go.png"
							style="width: 20px; height: 20px;">
					</div>
					<div style="clear: both;"></div>
					<div style="border: 1px solid #ccc; margin: 8px -8px 0 -8px;"></div>
				</div>

				<div style="padding: 20px 0 5px 0;">
					<div style="float: left; width: 90%; height: 20px;">
						<span
							style="font-size: 20px; font-weight: 200px; margin-left: 15px;">近期活动</span>
					</div>
					<div
						style="float: right; width: 10%; height: 20px; text-align: center;">
						<img alt="" src="images/modle8/go.png"
							style="width: 20px; height: 20px;">
					</div>
					<div style="clear: both;"></div>
					<div style="border: 1px solid #ccc; margin: 8px -8px 0 -8px;"></div>
				</div>

			</div>

		</div>
	</body>
</html>
