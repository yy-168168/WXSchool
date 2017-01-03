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

		<title>模板六</title>

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

			<div style="margin-top: 5px">
				<img alt="" src="images/modle6/ind1.jpg" width="33%" height="130px">
				<div
					style="position: absolute; z-index: 3; margin: -120px 0 0 20px;">
					<span style="font-size: 22px; font-weight: 500; color: #fff;">
						餐厅<br />简介</span>
				</div>
				<img alt="" src="images/modle6/ind2.jpg" width="64%" height="130px">
			</div>

			<div style="margin-top: 0px">
				<div
					style="float: left; width: 31%; padding: 10px 0; background-color: #fff; text-align: center; margin-right: 5px;">
					<span style="font-size: 20px; font-weight: 200;">类别</span>
				</div>
				<div
					style="float: left; width: 32%; padding: 10px 0; background-color: #fff; text-align: center; margin-right: 5px;">
					<span style="font-size: 20px; font-weight: 200;">特色</span>
				</div>
				<div
					style="float: left; width: 32%; padding: 10px 0; background-color: #fff; text-align: center; margin-right: 5px;">
					<span style="font-size: 20px; font-weight: 200;">最新菜品</span>
				</div>
				<div style="clear: both;">
				</div>
			</div>

			<div style="margin-top: 5px">
				<img alt="" src="images/modle6/ind3.png" width="64%" height="130px">
				<img alt="" src="images/modle6/ind4.jpg" width="33%" height="130px">
				<div style="position: absolute; z-index: 3; margin: -120px 0 0 66%;">
					<span style="font-size: 22px; font-weight: 500; color: #fff;">
						最新 <br /> 活动</span>
				</div>
			</div>

			<div style="margin-top: 0px">
				<div
					style="float: left; width: 31%; padding: 10px 0; background-color: #fff; text-align: center; margin-right: 5px;">
					<span style="font-size: 20px; font-weight: 200;">活动</span>
				</div>
				<div
					style="float: left; width: 32%; padding: 10px 0; background-color: #fff; text-align: center; margin-right: 5px;">
					<span style="font-size: 20px; font-weight: 200;">优惠</span>
				</div>
				<div
					style="float: left; width: 32%; padding: 10px 0; background-color: #fff; text-align: center; margin-right: 5px;">
					<span style="font-size: 20px; font-weight: 200;">联系我们</span>
				</div>
				<div style="clear: both;">
				</div>
			</div>

			<div style="margin-top: 5px">
				<img alt="" src="images/modle6/ind1.jpg" width="33%" height="130px">
				<div
					style="position: absolute; z-index: 3; margin: -120px 0 0 20px;">
					<span style="font-size: 22px; font-weight: 500; color: #fff;">
						私房<br /> 菜品</span>
				</div>
				<img alt="" src="images/modle6/ind2.jpg" width="64%" height="130px">
			</div>

			<div style="margin-top: -5px;">
				<div
					style="width: 100%; padding: 10px 0; background-color: #fff; margin-top: 5px;">
					<span style="font-size: 20px; font-weight: 200; margin-left: 20px;">私房菜品一</span>
				</div>
				<div
					style="width: 100%; padding: 10px 0; background-color: #fff; margin-top: 5px;">
					<span style="font-size: 20px; font-weight: 200; margin-left: 20px;">私房菜品二
					</span>
				</div>
				<div
					style="width: 100%; padding: 10px 0; background-color: #fff; margin-top: 5px;">
					<span style="font-size: 20px; font-weight: 200; margin-left: 20px;">私房菜品三</span>
				</div>
				<div style="clear: both;">
				</div>
			</div>

			<div style="margin-top: 5px">
				<img alt="" src="images/modle6/ind3.png" width="64%" height="130px">
				<img alt="" src="images/modle6/ind4.jpg" width="33%" height="130px">
				<div style="position: absolute; z-index: 3; margin: -120px 0 0 66%;">
					<span style="font-size: 22px; font-weight: 500; color: #fff;">
						科技 <br /> 新闻</span>
				</div>
			</div>

			<div style="margin-top: 0px">
				<div
					style="float: left; width: 31%; padding: 10px 0; background-color: #fff; text-align: center; margin-right: 5px;">
					<span style="font-size: 20px; font-weight: 200;">数码</span>
				</div>
				<div
					style="float: left; width: 32%; padding: 10px 0; background-color: #fff; text-align: center; margin-right: 5px;">
					<span style="font-size: 20px; font-weight: 200;">游戏</span>
				</div>
				<div
					style="float: left; width: 32%; padding: 10px 0; background-color: #fff; text-align: center; margin-right: 5px;">
					<span style="font-size: 20px; font-weight: 200;">体育新闻</span>
				</div>
				<div style="clear: both;">
				</div>
			</div>

		</div>
	</body>
</html>
