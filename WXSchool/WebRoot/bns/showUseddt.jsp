<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	Goods goods = (Goods) request.getAttribute("goods");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title><%=goods.getSimDesc()%></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" /> 
		<link type="text/css" href="<%=basePath %>static_/mycommon.css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>

		<style type="text/css">
.title {
	height: 35px;
	line-height: 35px;
	background-color: #ddd;
	font-size: 16px;
}

.title div {
	float: left;
	width: 10px;
	height: 35px;
	background-color: #70B5FF;
	margin-right: 15px;
}

.conttimg {
	padding: 20px;
	background-color: #fff;
}

.contttext {
	padding: 20px;
	background-color: #fff;
	overflow: hidden;
	line-height: 1.5;
	font-size: 15px;
	color: #555;
	font-family: '宋体';
}

.contttext:last-child {
	border-radius: 5px;
}
</style>
	</head>

	<body onload="checkMM();">
		<div
			style="margin: -8px -8px 10px -8px; box-shadow: 0px 0px 1px 1px #70B5FF;">
			<div style="background-color: #790A8A; height: 2px"></div>
			<div
				style="background-color: #70B5FF; text-align: center; color: #fff; padding: 5px 10px 0 10px;">
				<span style="font-size: 20px;">圈内交易    安全可靠</span>
			</div>
			<div
				style="background-color: #70B5FF; text-align: right; color: #fff; font-size: 12px; padding: 3px 5px 1px 0;">
				<img alt="" src="static_/vp2.png" height="13px"
					style="opacity: 0.4; vertical-align: middle">
				<span id="useNum"><%=goods.getVisitPerson()%></span>人浏览
			</div>
		</div>

		<div
			style="border: 1px solid #ddd; border-radius: 5px; width: 90%; margin: 0 auto;">
			<div class="title">
				图片展示
				<div style="border-top-left-radius: 5px;"></div>
			</div>
			<div class="conttimg">
				<img alt="" src="<%=goods.getPicUrl()%>" width="100%" alt="该图片太大，已被删除。为了节约用户流量，请修改图片大小。">
			</div>
			<div class="title">
				物品详情
				<div></div>
			</div>
			<div class="contttext" style="word-spacing: 2px;">
				<%=goods.getDtlDesc()%>
			</div>
			<div class="title">
				联系物主
				<div></div>
			</div>
			<div class="contttext">
				如有意愿，请用以下方式联系物主。为确保安全，请在校内交易。
				<br />
				手机：<a href="tel:<%=goods.getTel()%>"><%=goods.getTel()%></a>
				<br />
				微信：<%=goods.getWxin()%>
			</div>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
