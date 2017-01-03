
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

		<title>微接口</title>

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

	</head>

	<body>

		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div class="left">
				<jsp:include page="menuLeft.jsp">
					<jsp:param value="" name="id" />
				</jsp:include>
			</div>

			<div class="right">
				<div class="title">
					欢迎使用
				</div>
				<div style="padding: 30px 100px; line-height: 2; color: #555;">
					<div style="font-size: 30px;">
						平台正在完善中...
						<br />
						已开通功能请放心使用
					</div>
					<!-- 
					<a href="javascript:void(0);">使用说明</a>
					<div>
						<span style="">2014-04-18 --</span>
						<span style="">校花校草管理模块上线</span>
					</div>
					<div>
						<span style="">2014-04-17 --</span>
						<span style="">二手交易模块上线(包括管理员端，商户管理端，手机端)</span>
					</div>
					<div>
						<span style="">2014-04-12 --</span>
						<span style="">订餐管理模块上线</span>
					</div>
					<div>
						<span style="">2014-04-10 --</span>
						<span style="">文章管理模块上线</span>
					</div>
					 -->
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
