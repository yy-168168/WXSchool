<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.wxschool.entity.Menber"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String aId = request.getParameter("aId");
	Menber menber = (Menber) request.getAttribute("menber");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>电子会员卡</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="format-detection" content="telephone=no" />
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" /> 
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">
$(function() {
	checkMM();
	updateVisitPerson();

	var mw = document.body.clientWidth * 88 / 100;
	var mh = mw * 180 / 300;

	$("#nameandtel").css("margin-top", (-mh * 55 / 100));
	$("#nameandtel").css("margin-left", (mw * 7 / 100));

	$("#mennum").css("margin-top", (-mh * 12.2 / 100));
	$("#mennum").css("margin-left", (mw * 56 / 100));
});

function updateVisitPerson() {
	$.get("/mobile/article?ac=updateVisitPerson&wxaccount=<%=wxaccount%>&aId=<%=aId%>");
}
</script>
	</head>

	<body>
		<div>
			<div
				style="margin: -8px; text-align: center; position: absolute; z-index: -5; width: 100%; margin-top: -40px;">
				<img alt="" src="static_/menber_bg.png" width="100%">
			</div>
			<div style="margin-top: 40px">
				<div style="margin-left: 10%">
					<%
						if (menber == null) {
					%>
					<img alt="" src="static_/menbercardno.png" width="88%">
					<%
						} else {
					%>
					<img id="menbercard" alt="" src="static_/menbercard.png"
						width="88%">
					<div id="nameandtel"
						style="position: absolute; z-index: 5; color: #fff;">
						<%=menber.getMenberName()%>
						<br />
						<%=menber.getTel()%>
					</div>
					<div id="mennum"
						style="position: absolute; z-index: 5; color: #83572D; font-size: 13px;">
						NO:<%=menber.getMenberNum()%>
					</div>
					<%
						}
					%>
				</div>

				<div class="html5yj" style="margin-top: 16px">
					<div style="padding: 10px 10px 10px 20px; width: 85%"
						onclick="location='/mobile/bns?ac=card&wxaccount=<%=wxaccount%>'">
						<span style="float: left;">会员卡特权</span>
						<img alt="" src="static_/go.png"
							style="float: right; margin-top: 3px" height="13px">
						<div style="clear: both;"></div>
					</div>

					<!-- 
					<div class="fgx"></div>
					<div style="padding: 10px 10px 10px 20px; width: 85%"
						onclick="location='/mobile/bns/showact.jsp'">
						<span style="float: left;">最新优惠活动</span>
						<img alt="" src="static_/go.png" style="float: right;"
							height="13px">
						<div style="clear: both;"></div>
					</div>
					 -->
				</div>

				<%
					if (menber == null) {
				%>
				<input type="button" class="html5btn" value="点击领取会员卡"
					style="background-color: #18B119; margin-top: 16px"
					onclick="location='/mobile/bns/register.jsp?wxaccount=<%=wxaccount%>&userwx=<%=userwx%>'">
				<!-- 	 
				<input type="button" class="html5input" value="会员卡第一季已发售完毕"
					style="margin-top: 10px; color: #fff; margin-top: 16px">
				-->
				<%
					} else {
				%>
				<div class="html5yj" style="padding: 10px; margin-top: 16px">
					在跟哈师大微信平台合作商家交易时,请出示此会员卡，以享受相应优惠.
				</div>
				<div class="html5yj" style="padding: 10px; margin-top: 16px">
					咨询电话：
					<a href="tel:18646519325"
						style="color: #000; text-decoration: none;">18646519325</a>
				</div>
				<%
					}
				%>
			</div>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
