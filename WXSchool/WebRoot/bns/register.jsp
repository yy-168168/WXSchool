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

		<title>哈师大助手会员登记</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" /> 
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">
function check() {
	var menberName = document.getElementsByName("menberName")[0].value;
	var tel = document.getElementsByName("tel")[0].value;

	if ($.trim(menberName) == "" || $.trim(tel) == "") {
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
				style="margin: -8px -8px 10px -8px; background-color: #18B119; text-align: center; font-size: 26px; font-weight: bold; color: #fff; padding: 10px 0;">
				会员入口
			</div>
			<div style="color: #828282; text-indent: 2em;">
				领取您的专属会员卡，优惠实用，贴心定制，玩转江北，助手独发！
			</div>

			<!-- 
			<div style="line-height: 1.8; margin-top: 10px">
				<form action="/mobile/bns?ac=addMenber" method="post" name="form">
					真实姓名
					<span style="font-size: 13px; color: #aaa">(请务必填写真实姓名)</span>：
					<input type="text" class="html5input" name="menberName"
						onclick="clearMsg();">
					联系电话：
					<input type="text" class="html5input" name="tel"
						onclick="clearMsg();">

					<div id="msg" style="font-size: 12px; height: 20px; color: red;"></div>
					<input type="hidden" name="userwx" value="<%=userwx%>">
					<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
					<input type="button" class="html5btn" value="注册会员"
						style="background-color: #18B119;" onclick="check();">
				</form>
			</div>
			 -->

			<form action="/mobile/bns?ac=addMenber" method="post" name="form">
				<div class="html5yj">
					<div class="formhead">
						会员登记
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td class="text">
								真实姓名
							</td>
							<td class="input">
								<input type="text" class="html5input" name="menberName"
									onclick="clearMsg();">
							</td>
						</tr>
						<tr>
							<td class="text">
								联系电话
							</td>
							<td class="input">
								<input type="text" class="html5input" name="tel"
									onclick="clearMsg();">
							</td>
						</tr>
					</table>
				</div>

				<div id="msg"></div>
				<input type="hidden" name="userwx" value="<%=userwx%>">
				<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
				<input type="button" class="html5btn" value="注册会员"
					style="background-color: #18B119;" onclick="check();">
			</form>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
