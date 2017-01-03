<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>外卖订单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">
function check() {
	var address = document.getElementsByName("address")[0].value;
	var tel = document.getElementsByName("tel")[0].value;

	if ($.trim(address) == "" || $.trim(tel) == "") {
		$("#msg").text("请认真填写信息");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");
	$("form").submit();
}
</script>

	</head>

	<body onload="checkMM();">
		<div>
			<div
				style="margin: -8px -8px 0 -8px; background-color: #4F4F4F; color: #fff; padding: 8px; font-size: 15px">
				请认真填写接餐信息，如有无故捣乱者，将进入平台黑名单.
			</div>

			<div style="line-height: 1.8; margin-top: 10px">
				<form action="" method="post" name="form">
					手机号
					<span style="font-size: 13px; color: #888">(请保持手机畅通亲)</span>：
					<input type="text" class="html5input" name="tel"
						onclick="clearMsg();">
					接餐地址
					<span style="font-size: 13px; color: #888">(公寓号/楼道名称)</span>：
					<input type="text" class="html5input" name="address"
						onclick="clearMsg();">

					<div id="msg" style="font-size: 12px; height: 15px; color: red;"></div>
					<input type="hidden" name="userwx" value="<%=userwx%>">
					<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
					<input type="button" class="html5input" value="提交订单"
						style="margin-top: 10px; background-color: #FBA426; color: #fff"
						onclick="check();">
				</form>
			</div>
		</div>

		<jsp:include page="../common/copyright.jsp" />		
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
