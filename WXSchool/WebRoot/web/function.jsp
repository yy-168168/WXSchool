<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String ac = request.getParameter("ac");
	String num = request.getParameter("num");
	int i_num = 0;
	if(num != null){
		i_num = Integer.parseInt(num);
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>微接口 - 功能介绍</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/mng.js">
</script>

</head>

<body>
	<jsp:include page="/web/head.jsp"></jsp:include>

	<div class="content pc_global_width" style="margin-top: 30px">
		<div class="left">
			<jsp:include page="/web/menuLeft.jsp">
				<jsp:param value="" name="id" />
			</jsp:include>
		</div>

		<div class="right">
			<div class="title"></div>
			<div class="list" style="line-height: 1.6; font-size: 16px;">
				<div>欢迎光临，该版块将展示平台主要功能。</div>
				<div>我们可以以接口的形式为您提供任何一个您需要的功能。</div>
				<div>可以扫描以下二维码，体验平台功能。</div>
				<div>不定期推出新功能，敬请期待。</div>
				<div><img alt="" src="static_/qrcode_for_hsdzs.jpg" width="200px"> </div>
			</div>
		</div>
	</div>

	<%@ include file="/common/foot.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
