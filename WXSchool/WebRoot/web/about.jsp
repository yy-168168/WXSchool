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

		<title>微接口 - 联系我们</title>

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
				
		<div class="pc_global_width content" style="margin-top: 30px">
			<div class="web_left" style="width: 269px;">
				<div style="background: url('static_/aboutusbg.png') no-repeat scroll 0% 0% transparent; width: 100%; height: 419px;">
					<dl style="margin: 0">
						<dt style="font-size: 24px; color: #402A2E; padding: 38px 0px 0px 50px;">联系我们</dt>
						<dd style="margin: 0"><img alt="" src="static_/bossWechat.png" width="119px" style="vertical-align: middle; margin: 195px auto 0px; display: block"></dd>
					</dl>
				</div>
			</div>
			<div class="right">
				<div style="padding: 6px 15px">
					<div style="widfont-size: 16px">
						<p style="text-align: center;"><img width="100%" src="static_/aboutusshow1.jpg"/></p>
						<p style="text-indent: 2em">我们是一支由90后大学生自发组成的校园民间团队，我们很低调，我们有共同的兴趣，我们都心怀梦想，我们热爱移动互联，我们始终致力于为大学生打造最贴心，实用，便捷，趣味的校园服务平台。</p>
						<p style="text-indent: 2em">我们秉承着服务于校园的理念，坚持简单实用的原则，不放过任何一个细节，尽量让每一个功能都贴近学生，尽量少使用图片以降低用户流量，尽量简化操作流程让功能更加易用。我们的每一步都与学生息息相关。关注社会，热心公益，年轻的队伍在大家的关注下正茁壮成长……</p>
						<p style="text-indent: 2em">任何问题，请扫描左边二维码，或加平台创建者微信：yy_168168。</p>
					</div>
				</div>
			</div>
		</div>

		<%@ include file="/common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
