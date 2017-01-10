<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.wxschool.entity.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>设置</title>

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

<style type="text/css">
#beSearch input{
	height: 35px;
	line-height: 35px;
	width: 40px;
	padding: 0 5px;
	color: #fff;
	border: 0;
	text-align: center;
}

#beSearch #input1{
	border-top-left-radius: 5px; 
	border-bottom-left-radius: 5px;
}

#beSearch #input2{
	border-top-right-radius: 5px; 
	border-bottom-right-radius: 5px;
}

.on #input1 {
	background-color: #1FB615;
}

.on #input2 {
	background-color: #999;
}

.off #input1 {
	background-color: #999;
}

.off #input2 {
	background-color: #bbb;
}

.oneFun {margin: 20px -8px 0 -8px; background-color: #fff; padding: 0 6px}
</style>

<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
	});
	
	function updateWxInfo(){
		$("#updateWxInfo").attr("disabled", true);
		$.get("/mobile/chat/text?ac=updateWxUserInfo&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>",
			function(data){
				if(data == 'true'){
					showNotice("更新成功");
					window.location.reload();
				}else {
					showNotice("更新失败");
				}
		});
	}
	
	function beSearch(obj){
		var cn = obj.className;
		var st = -1;
		if(cn == 'off'){//此时是关
			st = 1;
		}
		
		var url = "/mobile/chat/text?ac=beSearch&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		$.get(url,{
				status: st
			},function(data){
				if(data == 'true'){
					if(cn == 'off'){
						obj.className = 'on';
					}else{
						obj.className = 'off';
					}
				}else {
					showNotice("修改失败");
				}
		});
	}
</script>
</head>

<body onload="checkMM();">
	<%
		WxUser user = (WxUser)request.getAttribute("user");
		if(user != null) {
			%>
			<div>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td align="center" style="padding: 5px 0">
							<img onclick="screenImg(this)" style="width: 80px; height: 80px; border-radius: 40px" alt="" src="<%=user.getHeadImgUrl()%>"> 
							<br/><span style="font-size: 12px; color: #666;">(点击放大)</span>
						</td>
					</tr>
					<tr>
						<td align="center" style="padding: 5px 0">
							<span style="color: #103261; font-weight: bold; font-size: 16px;"><%=user.getNickname()%></span></td>
					</tr>
				</table>
			</div>
			<%
		}
	%>
	
	<div class="oneFun">
		<table width="100%" border="0">
			<tr>
				<td><span>更新微信信息</span></td>
				<td align="right" width='80px'>
					<input id="updateWxInfo" type="button" value="更新" onclick="updateWxInfo()"
						class="html5btn" style="height: 35px; line-height: 35px"></td>
			</tr>
		</table>
	</div>
	
	<%
		if(user != null) {
		boolean beSearch = user.isBeSearch();
		String cn = beSearch ? "on" : "off";
			%>
			<div class="oneFun" id="beSearch">
				<table width="100%" border="0">
					<tr>
						<td><span>接收搭讪消息</span></td>
						<td align="right" width='80px' onclick="beSearch(this)" class="<%=cn%>">
							<input id="input1" type="button" value=""><input id="input2" type="button" value="">
						</td>
					</tr>
				</table>
			</div>
			<%
		}
	%>
	
	<div class="oneFun">
		<table width="100%" border="0">
			<tr onclick="location='/reply/chatRecord.jsp?wxaccount=<%=wxaccount%>&userwx=<%=userwx%>'">
				<td><span>查看所有记录</span></td>
				<td align="center" height="35px" width='80px'><img alt="" src="static_/go.png" height="16px"> </td>
			</tr>
		</table>
	</div>

	<jsp:include page="../common/copyright.jsp" />
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
