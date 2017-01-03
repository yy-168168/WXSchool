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

<title>微接口 - 只为校园而生</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mng.css" type="text/css" rel="stylesheet">
<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/mng.js">
</script>
<style type="text/css">
.circle {
	width: 120px; 
	height: 120px; 
	line-height: 120px; 
	border-radius: 60px; 
	color: #fff;
	font-size: 70px;
	font-weight: bold;
	margin: auto;
}

.platDesc1 {
	font-size: 20px;
	line-height: 120px;
}

.platDesc2 {
	background-color: #ddd; 
	padding: 20px;
	font-size: 15px;
}
</style>

</head>

<body>
	<jsp:include page="/web/head.jsp"></jsp:include>

	<div class="pc_global_width" style="margin-top: 30px;">
		<div>
			<img alt="" src="static_/sysimg/webbanner1.jpg" width="100%">
		</div>
		
		<div style="margin-top: 50px">
			<div>
				<div style="float: left; width: 45%; text-align: center;">
					<div class="circle" style="background-color: #FFA500;">1</div>
				</div>
				<div class="platDesc1" style="float: left; width: 55%">我们只为校园提供服务</div>
				<div style="clear: both"></div>
			</div>
			<div style="margin-top: 30px">
				<div style="float: left; width: 45%; text-align: center;">
					<div class="circle" style="background-color: #8B2500;">2</div>
				</div>
				<div class="platDesc1" style="float: left; width: 55%">我们只做简单实用的功能</div>
				<div style="clear: both"></div>
			</div>
			<div style="margin-top: 30px">
				<div style="float: left; width: 45%; text-align: center;">
					<div class="circle" style="background-color: #8FBC8F;">3</div>
				</div>
				<div class="platDesc1" style="float: left; width: 55%">我们以接口式为您提供任何单一功能</div>
				<div style="clear: both"></div>
			</div>
		</div>
		
		<div style="margin-top: 50px">
			<div style="color: #67AD03; text-align: center; font-size: 30px; border-bottom: 1px solid #67AD03; padding-bottom: 10px">微接口微信服务平台</div>
			<div>
				<div style="float: left; width: 33%">
					<div class="platDesc2" style="margin-right: 30px">专为校园量身定制的一款微信服务平台，为个人或学校提供基于微信公众平台的一系列功能，接口式开放，接口式对外提供服务。</div>
				</div>
				<div style="float: left; width: 34%">
					<div class="platDesc2" style="margin-right: 30px">主要功能包括教务查询、四六级查询、微订餐、微会员，二手交易，创业格子，表白墙，照片墙、寻物招领、树洞、老乡、快递、翻译、搭讪、等系统功能。</div>
				</div>
				<div style="float: left; width: 33%">
					<div class="platDesc2">贴近学生，贴近生活，追求实用，抓住痛点，只为校园而生。只要你有足够的兴趣，充沛的精力，合适的定位，精准的营销，就能短时间内让你的平台在校园一炮走红。</div>
				</div>
				<div style="clear: both"></div>
			</div>
		</div>
	</div>

	<%@ include file="/common/foot.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
