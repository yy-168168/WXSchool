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

		<title>微接口 - 获取密钥</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/mng.js">
</script>

		<style type="text/css">
.circle {
	background-color: #67AD03;
	width: 80px;
	height: 80px;
	line-height: 80px;
	border-radius: 62.8px 62.8px 62.8px 62.8px;
	color: #FFFFFF;
	text-align: center;
	font-size: 60px;
}

.step {
	border: 1px solid #aaa;
	border-radius: 20px;
	padding: 10px 15px;
	margin: 0 20px 0 60px;
	background-color: #f6f6f6;
	line-height: 1.5;
}

tr {
	height: 120px;
}
</style>
	</head>

	<body>
		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div
				style="background-color: #f6f6f6; height: 50px; line-height: 50px; border-top-left-radius: 5px; border-top-right-radius: 5px; padding: 0 30px;">
				<span style="font-size: 20px; font-weight: bold; color: #555;">如何获取密钥
				</span><span style="font-size: 14px;">(仅对部分功能适用)</span>
			</div>

			<table width="100%" cellpadding="0" cellspacing="0" border="0"
				style="margin: 30px 0;">
				<tr>
					<td width="30%" align="right">
						<div class="circle">
							1
						</div>
					</td>
					<td width="50%">
						<div class="step">
							使用微信扫描右边的二维码并添加关注
						</div>
					</td>
					<td align="center">
						<img alt="" src="static_/sysimg/qrcode.jpg" width="160px"
							style="border: 1px solid #ddd; box-shadow: 0px 0px 5px 5px #c3c3D3;">
					</td>
				</tr>
				<tr>
					<td width="30%" align="right">
						<div class="circle">
							2
						</div>
					</td>
					<td width="50%">
						<div class="step">
							关注后回复K码，K码已在信息源给出。
						</div>
					</td>
					<td></td>
				</tr>
				<tr>
					<td width="30%" align="right">
						<div class="circle">
							3
						</div>
					</td>
					<td width="50%">
						<div class="step">
							密钥将自动下发到你的手机，请不要泄露密钥。
							<br />
							如果忘记密钥，重新回复关键字即可。
						</div>
					</td>
					<td></td>
				</tr>
				<tr>
					<td width="30%" align="right">
						<div class="circle">
							4
						</div>
					</td>
					<td width="50%">
						<div class="step">
							如操作不成功，请联系微信yy_168168。
						</div>
					</td>
					<td></td>
				</tr>
				<tr>
					<td width="30%" align="right">
						<div class="circle">
							5
						</div>
					</td>
					<td width="50%">
						<div class="step">
							如已获取密钥，可以点击<a href="/mng/">登录</a>开始微接口之旅。
						</div>
					</td>
					<td></td>
				</tr>
			</table>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
