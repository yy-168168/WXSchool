<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
	String to = request.getParameter("to");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>小纸条</title>

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
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>
<script type="text/javascript" src="<%=basePath %>static_/jquery.qqFace.js"></script>

<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
	});
	
	$(function(){
		$('.qqfaceemotion').qqFace({
			id : 'facebox', 
			assign: 'contentInput', 
			path: 'static_/qqface/'	//表情存放的路径
		});
	});

	function check(){
		if($("#isOnline").text().indexOf("离线")>-1){
			showNotice("对方离线中<br/>无法接受消息");
			return false;
		}else if($("#isOnline").text().indexOf("黑名单")>-1){
			showNotice("对方为黑名单用户<br/>无法接受消息");
			return false;
		}else if($("#isOnline").text().indexOf("取消关注")>-1){
			showNotice("对方已取消关注<br/>无法接受消息");
			return false;
		}
		
		var content = document.getElementsByName("content")[0].value;
		var toUserwx = document.getElementsByName("toUserwx")[0].value;
		
		if ($.trim(content) == "") {
			return false;
		}

		if (content.length > 480) {
			return false;
		}
		
		$(":button").attr("disabled", true);
		
		var url = "/mobile/chat/text?ac=addRecord&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		$.post(url, {
			content : content,
			to : toUserwx
		}, function(data) {
			if (data == "black") {
				showNotice("你已被拉入黑名单<br/>如有问题请联系管理员");
			} else if (data == "true") {
				document.getElementsByName("content")[0].value = "";
				showNotice("小纸条已传到对方微信中");
			} else {
				showNotice("发送失败，请重试");
			}
			$(":button").attr("disabled", false);
		});
	}
</script>
</head>

<body onload="checkMM();">

	<%
		String[] user = (String[]) request.getAttribute("user");
		if (user == null || user[1].equals("")) {
	%>
	<div
		style="background-color: #d6d6d6; border-bottom: 1px dotted #ccc; margin: -8px -8px 0 -8px;">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td height="40px" align="center"><span style="font-size: 14px"
					id="isOnline">没有获取到任何信息</span>
				</td>
			</tr>
		</table>
	</div>
	<%
		} else {
			if (Integer.parseInt(user[9]) >= 8) {
	%>
	<div style="position: absolute; right: 10; top: 5; font-size: 14px;">
		已被偷窥<%=user[9]%>次
	</div>
	<%
		}
	%>
	<div
		style="background-color: #eaeaea; border-bottom: 1px dotted #ccc; margin: -8px -8px 0 -8px;">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td align="center" style="padding: 5px 0"><img
					onclick="screenImg(this)"
					style="width: 80px; height: 80px; border-radius: 40px" alt=""
					src="<%=user[1]%>"> <br /> <span
					style="font-size: 12px; color: #666;">(点击放大)</span>
				</td>
			</tr>
			<%
				if (!user[5].equals("")) {
			%>
			<tr>
				<td align="center" style="padding: 5px 0"><span
					style="font-size: 14px"><%=user[4]%>级<%=user[5]%><%=user[6]%>专业</span>
				</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td align="center" style="padding: 5px 0">
					<span style="color: #103261; font-weight: bold; font-size: 16px;"><%=user[0]%></span>
					<% if(user[7].equals("1")){
						%><img alt='' src='static_/boy2.png' style='vertical-align: middle; height: 14px'><%
					}else if(user[7].equals("2")){
						%><img alt='' src='static_/girl2.png' style='vertical-align: middle; height: 14px'><%
					} %>
					<span style="font-size: 14px" id="isOnline"><%=user[10]%></span>
				</td>
			</tr>
		</table>
	</div>

	<div id="pubForm" style="margin-top: 15px">
		<div>
			<span class="qqfaceemotion"></span>
		</div>
		<form method="post" name="form">
			<textarea id="contentInput" rows="5" cols="" name="content"
				class="html5area_n" onclick="clearMsg();"></textarea>
			<input type="hidden" name="toUserwx" value="<%=user[2]%>"> <input
				type="button" value="传个纸条" onclick="check();" class="html5btn"
				style="margin-top: 10px">
			<div id="msg"></div>
		</form>
	</div>

	<div style="font-size: 13px; margin-top: 20px; text-align: center;">
		<a href="/mobile/chat/text?ac=list&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&to=<%=to%>">查看与Ta传过的纸条</a>
	</div>
	<%
		}
	%>

	<jsp:include page="../common/copyright.jsp" />
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
