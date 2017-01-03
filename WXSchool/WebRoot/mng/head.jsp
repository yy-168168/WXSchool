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

		<title>微接口管理平台</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<%--
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		--%>

		<script type="text/javascript">
function tuchuang() {
	/*
	 * 
	alert("请为你的用户考虑，请为你的用户节约流量！\n上传图片之前请修改图片长和宽，在需要填写图片外链的地方已经给出长宽大小。\n有的同学上传的图片都在1M以上，多浪费用户流量。\n图片太大的一律删除，请看仔细了！！！");
	alert("图床：用于上传图片，获取图片链接地址的系统\n\n使用时请注意：\n"
			+ "1、上传图片之前，请一定修改图片长和宽，在需要填写图片外链的地方均有注明图片所需大小；\n"
			+ "2、图片名称不要有中文，中文的无法上传；\n"
			+ "3、有些浏览器不支持上传(如IE)，就使用其它浏览器，建议Chrome、火狐等；\n"
			+ "4、对图片审核时，如有图片太大的，一律被删除，如出问题，将不负责。\n\n"
			+ "使用方法说明：\n将新弹出的网页窗口缩小-->将大小已经修改的图片拖拽进图床-->上传成功后复制链接-->OVER");
	window.open("http://wyzhwx.duapp.com/home");
	*/
	alert("系统自带图床暂可用，请使用腾讯微博图片外链");
}
</script>
	</head>
	<body>
		<div class="pc_screen_width" style="background-color: #F3F3F3; box-shadow: 0px 1px 6px #B6B6B6">
			<div style="height: 5px; background-color: #67AD03;"></div>
			<div style="width: 80%; margin: auto; padding: 10px 0;">
				<div style="float: left;">
					<img alt="" src="static_/logo.png" style="vertical-align: bottom;"
						height="50px" onclick="location='#'">
					<span style="font-size: 28px; font-weight: bold; color: #333;">微接口</span>
					<%
						if (wxid != null) {
					%>
					<span style="font-size: 28px; font-weight: bold; color: #333;"><span
						style="font-weight: normal; font-size: 24px;">|</span>管理平台</span>
					<%
						} else {
					%>
					<span style="font-family: '华文行楷'; color: #113C64;">只为校园而生</span>
					<%
						}
					%>
				</div>
				<div style="float: right; text-align: right;">
					<%
						if (wxid != null) {
					%>
					WXID:<%=wxid%>&nbsp;|
					<a href="/mngs/login?ac=exit&wxid=<%=wxid%>">退出</a>
					<%
						}
					%>
					<div style="text-decoration: none; font-size: 13px; margin-top: 10px;">
						<%--
						<a href="javascript:tuchuang();">图床|获取图片外链</a>
						<a href="https://mp.weixin.qq.com" target="_blank">公众平台</a>
						<a href="http://mp.wsq.qq.com" target="_blank">微社区</a>
						--%>
					</div>
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
	</body>
</html>
