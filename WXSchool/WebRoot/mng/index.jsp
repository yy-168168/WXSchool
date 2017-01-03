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

		<title>微接口 - 管理平台</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="微接口,校园微信,校园微信第三方，校园微信服务平台">
		<meta http-equiv="description"
			content="微接口，专为校园量身定制的一款服务平台，为个人或学校提供基于微信公众平台的一系列功能。
			贴近学生，贴近生活，只为校园而生。一流的服务，一流的宣传，一流的策划，让您脱颖而出。">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath%>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/mng.js">
</script>
<style type="text/css">
.platDesc2 {
	background-color: #ddd; 
	padding: 20px;
	font-size: 15px;
}
</style>

		<script type="text/javascript">
document.ready = function() {
	document.getElementById("key").focus();
};

function check() {
	var key = document.getElementsByName("key")[0].value;

	if ($.trim(key) != "") {
		if (key == "test") {
			window.location.href = "/demo/index.jsp";
			return false;
		}

		var strReturn = syncSubmit("/mngs/login?ac=login&key=" + key);
		var obj = $.parseJSON(strReturn);
		if (obj == null || obj == "") {
			$("#erromsg").text("卡壳了，请稍后重试！");
		} else if (obj.wxaccount == null || obj.wxaccount == "") {
			$("#erromsg").text("抱歉，您没有权限！");
		} else {
			window.location.href = "/mngs/login?ac=index&token=" + obj.token;
		}
	}
	return false;
}
</script>
	</head>

	<body>
		<jsp:include page="head.jsp"></jsp:include>
		
		<div style="position: absolute; z-index: 2; right: 160px; margin-top: 30px;">
			<div
				style="background-color: #EAEAEA; border-radius: 8px; border: 1px solid #C6C6C6; line-height: 1.7; padding: 20px 30px;">
				<form style="padding: 0; margin: 0">
					<h1 style="color: #666; font-size: 18px; font-weight: bold;">
						请输入密钥
					</h1>
					<!--<a href="/mng/getKey.jsp" style="float: right; font-size: 13px;">获取密钥</a>-->
					<input type="password" name="key" id="key"
						style="display: block; width: 240px; height: 40px; line-height: 40px; border: 1px solid #CCC; text-align: center; font-size: 20px; padding: 0 5px; border-radius: 8px;">
					<br />
					<input type="submit" value="登 录" onclick="return check();"
						style="display: block; border: 0; background: #67AD03; height: 40px; width: 240px; cursor: pointer; color: #fff; font-weight: bold; font-size: 20px; border-radius: 8px;">
					<div id="erromsg" style="margin-top: 10px; height: 10px"></div>
				</form>
			</div>
		</div>

		<%@ include file="imagesmove.html"%>
		
		<div class="pc_global_width" style="margin-top: 30px;">
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
		

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
