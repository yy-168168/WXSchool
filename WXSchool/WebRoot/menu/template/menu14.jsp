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

		<title>模板一</title>

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
				for (int i = 0; i < 5; i++) {
			%>
			<div style="float: left; width: 50%; margin-top: 10px">
				<div style="padding: 0 8px;">
					<img alt=""
						src="http://t2.qpic.cn/mblogpic/eb17644344a5f98edc98/160"
						width="100%" height="100px"
						style="border-top-left-radius: 12px; border-top-right-radius: 12px;">
					<div
						style="background-color: #fff; height: 40px; line-height: 40px; text-align: center; border-bottom-left-radius: 12px; border-bottom-right-radius: 12px; font-weight: bold;">
						分类名称
					</div>
				</div>
			</div>
			<%
				}
			%>

		</div>
	</body>
</html>
