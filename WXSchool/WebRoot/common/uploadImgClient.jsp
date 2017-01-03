<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");

	Vote vote = (Vote) request.getAttribute("vote");
	String picUrl = "", desc = "";
	int status = 0, picId = -1, topicId = -1;
	if (vote != null) {
		picId = vote.getVoteId();
		picUrl = vote.getContent();
		status = vote.getStatus();
		desc = vote.getName();
		topicId = vote.getTopicId();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>照片上传</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
});
		
function check() {
	var content = document.getElementsByName("content")[0].value;

	if ($.trim(content) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	if (content.length > 190) {
		$("#msg").text("消息内容不能超过200字");
		return false;
	}
	if ('<%=status%>' == 1) {
		$("#msg").text("审核已通过，不可修改");
		return false;
	}

	$("#submit").attr("disabled", true);
	$("#submit").val("提交中...");

	var url = "/mobile/pic?ac=uptContentForPic&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		picId : '<%=picId%>',
		picUrl : '<%=picUrl%>',
		content : content
	}, function(data) {
		if (data == "true") {
			$("#msg").text("提交成功，请等待审核！");
		} else {
			$("#msg").text("提交失败，请重试！");
		}
		$("#submit").attr("disabled", false);
		$("#submit").val("提 交");
	});
}
</script>
	</head>

	<body onload="checkMM();">
		<%
			String[] statuss = { "照片已被删除", "审核中", "审核已通过" };
		%>
		<%--<span style="font-size: 14px;">状态：<%=statuss[status]%></span>--%>
		<input type="button" value="状态：<%=statuss[status + 1]%>"
			class="html5btn" style="background: #428BCA; color: #fff;">

		<form method="post" id="pubForm">
			<div class="html5yj">
				<div class="formhead_n">
					<div>
						<span class="glyphicon glyphicon-edit"></span>&nbsp;为照片提供相关信息
					</div>
					<div>
						提示：审核通过之前可多次修改
					</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div style="text-align: center;">
						<img alt="" src="<%=picUrl%>" style="max-width: 100%; border: 1px #efefef solid;">
					</div>
					<div class="text1">
						信息内容
					</div>
					<textarea rows="4" cols="" name="content" class="html5area_n"
						onclick="clearMsg();"><%=desc%></textarea>
					<hr />
					<input id="submit" type="button" value="提 交" class="html5btn"
						onclick="check();">
					<div id="msg"></div>
				</div>
				<!-- 
				<div class="formhead">
					为图片提供相关信息
				</div>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="text">
							内容
						</td>
						<td class="input">
							<textarea rows="3" cols="" name="content" class="html5area"
								onclick="clearMsg();"><%=desc%></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="btn">
							<input type="button" value="提 交" class="html5btn"
								onclick="check();">
							<div id="msg"></div>
						</td>
					</tr>
				</table>
				 -->
			</div>
		</form>

		<jsp:include page="copyright.jsp" />
		<%@ include file="toolbar.html"%>
		<%@ include file="tongji.html"%>
	</body>
</html>
