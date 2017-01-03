<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
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

<title>纸条记录</title>

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
#chatList {
	background-color: #fff;
}

#chatList table {
	padding: 5px 10px;
	border-bottom: 1px solid #ddd;
}

#chatList img {
	width: 50px;
	height: 50px;
	border-radius: 25px;
}
</style>
<script type="text/javascript">
	var curPage = 1;
	
	$(function(){
		getChatList();
	});
	
	$(window).scroll(
			function() {
				var jl = document.body.scrollHeight - document.body.scrollTop - document.body.clientHeight;
				if (jl == 0) {
					getChatList();
				}
			});

	function getChatList() {
		if ($("#loadn").text() == '没有更多') {
			return false;
		}

		var url = "/mobile/chat/text?ac=chatList&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&c_p=" + curPage;
				$.ajax( {
					url : url,
					beforeSend : function() {
						$("#loadn").html("<img src='/static_/loading.gif' height='30px' style='padding-top:8px'/>");
					},
					success : function(json) {
						$("#loadn").empty();
						var obj;
						try{
							obj = $.parseJSON(json);
						}catch(e){
							alert("出错啦");
						}
						
						if (obj == null || obj == "") {
							$("#loadn").html("<div style='padding-top:8px;font-size:14px'>没有更多</div>");
							return false;
						}
						$
								.each(
										obj,
										function(i, n) {
											var imgUrl = n.wxUser.headImgUrl;
											var img_i = imgUrl.lastIndexOf("/");
											var imgUrl_46 = imgUrl;
											if (img_i > -1) {
												imgUrl_46 = imgUrl.substring(0, img_i) + "/96";
											}
											var to = '<%=UUID.randomUUID().toString()%>'+n.to;
											
											var sex = "";
											if(n.wxUser.sex == 1){
												sex = "<img alt='' src='static_/boy2.png' style='vertical-align: middle; width: 14px; height: 14px'>";
											}else if(n.wxUser.sex == 2){
												sex = "<img alt='' src='static_/girl2.png' style='vertical-align: middle; width: 14px; height: 14px'>";
											}
											
											var str = "<table width='100%' border='0' onclick='location=\"/mobile/chat/text?ac=list&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&to="
													+ to
													+ "\"'>"
													+ "<tr><td rowspan='2' width='55px'><img alt='' src='"+imgUrl_46+"'></td><td><span style='font-weight: bold;'>"
													+ n.wxUser.nickname
													+ "</span> " + sex + " <span style='font-size: 13px; color: blue;'>"
													+ (n.wxUser.online ? '(在线)' : '')
													+ "</span></td>"
													+ "<td align='right' width='70px'><span style='font-size: 13px; color: #888;'>"
													+ n.addTime.substring(5, 10)
													+ "</span></td></tr>"
													+ "<tr><td colspan='2'><span style='font-size: 13px; color: #888;'>"
													+ n.content
													+ "</span></td></tr></table>";
											$("#chatList").append(str);
										});
					}
				});
		curPage++;
	}
</script>
</head>

<body onload="checkMM();" style="margin: 0">
	<script type="text/javascript">
		document.addEventListener('WeixinJSBridgeReady',
				function onBridgeReady() {
					WeixinJSBridge.call('hideOptionMenu');
					// WeixinJSBridge.call('hideToolbar');
				});
	</script>

	<div id="chatList"></div>
	<div id="loadn" style="text-align: center;"></div>

	<jsp:include page="../common/copyright.jsp" />
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
