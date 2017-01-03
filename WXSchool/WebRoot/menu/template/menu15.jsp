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

		<title>模板四</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

	</head>

	<body bgcolor="#EFEFEF">
		<div>

			<%
				for (int i = 0; i < 9; i++) {
			%>
			<div>
				<div style="float: left; width: 33%">
					<img alt=""
						src="http://t2.qpic.cn/mblogpic/eb17644344a5f98edc98/160"
						width="90%" height="60px">
				</div>
				<div style="float: left; width: 57%">
					<span style="font-size: 18px; font-weight: bold;">类别名称</span>
					<br />
					<span style="color: #666; font-size: 14px;">简要说明简要说明</span>
				</div>
				<div
					style="float: left; width: 10%; text-align: center; margin-top: 22px">
					<img alt="" src="static_/go.png" width="12px" height="16px">
				</div>
				<div style="clear: both;"></div>
			</div>
			<div style="border: solid 1px #ccc; margin: 10px -8px"></div>
			<%
				}
			%>


		</div>
	</body>
</html>
