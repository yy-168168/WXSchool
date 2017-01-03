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

		<title>新闻</title>

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
			<ul style="list-style: none; margin: 0; padding: 0;">
				<li
					onclick="location = 'http://news.163.com/13/0609/09/90TUFFKH0001124J.html'">
					<div style="width: 100%">
						<div style="float: left; height: 50px">
							<img alt="" src="images/20130609132341.jpg" width="90px"
								height="50px">
						</div>
						<div style="float: left; height: 50px; margin-left: 5px;">
							习近平向奥巴马阐明
							<br />
							钓鱼岛和南海问题立场
							<br />
							<span style="font-size: 12px; color: #888"></span>
						</div>
						<div style="clear: both;"></div>
					</div>
				</li>
				<li style="margin: 6px 0; width: 100%; border: solid 1px #ddd;">
				</li>
				<li
					onclick="location = 'http://news.163.com/special/xiamenbrtgongjiaoqihuo/'">
					<div style="width: 100%">
						<div style="float: left; height: 50px">
							<img alt="" src="images/20130608001117cf2d3.jpg" width="90px"
								height="50px">
						</div>
						<div style="float: left; height: 50px; margin-left: 5px;">
							官员称厦门公交纵火
							<br />
							案嫌犯反映问题不实
							<br />
							<span style="font-size: 12px; color: #888"></span>
						</div>
						<div style="clear: both;"></div>
					</div>
				</li>
				<li style="margin: 6px 0; width: 100%; border: solid 1px #ddd;">
				</li>
				<li
					onclick="location = 'http://news.163.com/13/0609/07/90TM607B0001124J.html'">
					<div style="width: 100%">
						<div style="float: left; height: 50px">
							<img alt="" src="images/0130609134353.jpg" width="90px"
								height="50px">
						</div>
						<div style="float: left; height: 50px; margin-left: 5px;">
							刘志军被控受贿6460
							<br />
							万 法院将择期宣判
							<br />
							<span style="font-size: 12px; color: #888"></span>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</body>
</html>
