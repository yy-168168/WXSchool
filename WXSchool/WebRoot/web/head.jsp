<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxid = (String) request.getAttribute("wxid");
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
<link rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" type="imagend.microsoft.icon">
<link rel="icon" href="<%=basePath %>static_/favicon.ico" type="imagend.microsoft.icon">
<meta http-equiv="keywords" content="微接口,校园微信,校园微信第三方，校园微信服务平台">
<meta http-equiv="description"
	content="微接口，专为校园量身定制的一款服务平台，为个人或学校提供基于微信公众平台的一系列功能。
			贴近学生，贴近生活，只为校园而生。一流的服务，一流的宣传，一流的策划，让您脱颖而出。">
<style type="text/css">
#menuBar a {
	text-decoration: none;
	font-size: 17px;
	margin-right: 15px;
	color: #402A2E
}

#menuBar a:hover, #menuBar .selectMenuBar {
	color: #67AD03
}
</style>
<script type="text/javascript">
$(function() {

	initHeadMenuBar();
});

function initHeadMenuBar(){
	var flag = 0;
	var tt = document.title;
	$("#menuBar a").each(function(i){
		if(tt.indexOf($(this).text())>-1){
			$(this).addClass("selectMenuBar");
			flag = 1;
		}
	});
	if(flag == 0){
		$("#menuBar a:first-child").addClass("selectMenuBar");
	}
}
</script>

</head>
<body>
	<div class="pc_screen_width" style="background-color: #F3F3F3; box-shadow: 0px 1px 6px #B6B6B6">
		<div style="height: 5px; background-color: #67AD03;"></div>
		<div style="padding: 10px 0;" class="pc_global_width">
			<div style="float: left;">
				<img alt="" src="static_/logo.png" height="50px"
					style="vertical-align: bottom;"> <span
					style="font-size: 28px; font-weight: bold; color: #333;">微接口</span>
				<span style="font-family: '华文行楷'; color: #113C64;">只为校园而生</span>
			</div>
			<div style="float: right; text-align: right;">
				<div id="menuBar" style="margin-top: 20px;">
					<a href="">首页</a> 
					<a href="web/function.jsp">功能介绍</a> 
					<a href="mng">管理平台</a>
					<a href="https://mp.weixin.qq.com" target="_blank">公众平台</a> 
					<a href="web/tool.jsp">运营工具</a> 
					<a href="web/about.jsp">联系我们</a>
					<%--<a href="http://mp.wsq.qq.com" target="_blank">微社区</a>--%>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
	</div>
</body>
</html>
