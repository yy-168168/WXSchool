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
	//String to = request.getParameter("to");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>我与Ta的纸条</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static_/jquery.scrollTo.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=840234893"></script>
<script type="text/javascript" src="<%=basePath %>static_/jquery.qqFace.js"></script>

<style type="text/css">
#chatBar {
	position: fixed;
	z-index: 99;
	bottom: 0px;
	left: 0px;
	right: 0px;
	display: block;
	background-color: #aaa;
	padding: 5px;
}

table {
	width: 100%
}

#chatContent img {
	width: 36px;
	height: 36px;
	border-radius: 18px;
}

#chatContent .detail_l {
	border-radius: 8px;
	border: 0px solid #ccc;
	padding: 5px 10px;
	white-space: normal;
	word-break: break-all;
	background-color: #fff;
}

#chatContent .detail_r {
	border-radius: 8px;
	border: 0px solid #ccc;
	padding: 5px 10px;
	white-space: normal;
	word-break: break-all;
	background-color: #C0F5B4;
}

#chatContent .addTime {
	text-align: center;
	font-size: 13px;
	color: #999;
	margin-bottom: 5px;
}

#loadChat {
	text-align: center;
	font-size: 13px;
	color: #666;
	margin: 8px 0;
}
</style>
<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
	});
	
	
	var status = "offLine"; // 是否在线，是否黑名单
	var toUserwx = ""; //对方openId

	$(function() {
		checkMM();
		
		if($("#isOnline").text().indexOf("在线")>-1){
			status = "onLine";
		}else if($("#isOnline").text().indexOf("黑名单")>-1){
			status = "black";
		}else if($("#isOnline").text().indexOf("取消关注")>-1){
			status = "unSubscribe";
		}
		
		toUserwx = document.getElementsByName("toUserwx")[0].value;
		
		getOldChatRecords("init");
		
		$('.qqfaceemotion').qqFace({
			id : 'facebox', 
			assign: 'chatContentInput', 
			path: 'static_/qqface/'	//表情存放的路径
		});
		
		setInterval('getCurChatRecords()', 5000); //每5秒刷新页面
		//setTimeout("setInterval('getCurChatRecords()', 5000)", 5000); //进入页面5秒后，每5秒刷新页面
	});
	
	function getMinDiff(preTime, curTime){
		var d_preTime = new Date(Date.parse(preTime.replace(/-/g, "/")));
		var d_curTime = new Date(Date.parse(curTime.replace(/-/g, "/")));
		var diffMin = (d_preTime.getTime() - d_curTime.getTime())/(1000*60);
		return diffMin;
	}
	
	var minMsgId = 10000000;
	var maxMsgId = -1;
	var preTime = "2030-01-01 00:00";
	function getOldChatRecords(flag){
		$.ajax({
			url : "/mobile/chat/text?ac=oldRecord&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>",
			type : "GET",
			data : "to="+toUserwx+"&msgId="+minMsgId,
			beforeSend : function(){
				$("#loadChat").html("加载中...");
			},
			success : function(data) {
				var obj;
				try{
					obj = $.parseJSON(data);
				}catch(e){
					alert("出错啦");
				}
				
				if (obj == null) {
					$("#loadChat").html("<span onclick='getOldChatRecords()'>点击加载更多</span>");
				}else if(obj.length == 0){
					$("#loadChat").html("");
				} else {
					var html = "";
					$.each(obj, function(i, m) {
						var imgUrl = m.wxUser.headImgUrl;
						var img_i = imgUrl.lastIndexOf('/');
						if(img_i > -1){
							imgUrl = imgUrl.substring(0, img_i)+ "/96";
						}
						var cont = replace_em(m.content);
						
						if(m.from == '<%=userwx%>'){
							html = "<tr><td></td><td><div class='detail_r' style='float: right'>"+cont+"</div></td><td width='42px' align='right'><img alt='' src='"+imgUrl+"'></td></tr><tr height=8px><td colspan='3'></td></tr>"+html;
						}else {
							html = "<tr><td width='42px'><img alt='' src='"+imgUrl+"'></td><td><div class='detail_l' style='float: left'>"+cont+"</div></td><td></td></tr><tr height=8px><td colspan='3'></td></tr>"+html;
						}
						
						if(getMinDiff(preTime, m.addTime) >= 30){ //每30分钟标记时间
							html = "<tr><td colspan='3' class='addTime'>"+m.addTime.substring(5)+"</td></tr>" + html;
							preTime = m.addTime;
						}
						
						if(m.msgId < minMsgId){
							minMsgId = m.msgId;
						}
						if(m.msgId > maxMsgId){
							maxMsgId = m.msgId;
						}
					});
					//html += "<tr><td colspan='3' id='loc'></td></tr>";
					$("#chatContent table").prepend(html);
					if(flag == "init"){$.scrollTo('100%', 1500);}
					$("#loadChat").html("<span onclick='getOldChatRecords()'>点击加载更多</span>");
				}
			}
		});
	}
	
	function getCurChatRecords(){
		if(status=="black" || status=="unSubscribe"){return false;}
		$.ajax({
			url : "/mobile/chat/text?ac=curRecord&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>",
			type : "GET",
			data : "to="+toUserwx+"&msgId="+maxMsgId,
			success : function(data) {
				var obj;
				try{
					obj = $.parseJSON(data);
				}catch(e){
					alert("出错啦");
				}
				
				if (obj == null || obj.length == 0) {
				} else {
					var html = "";
					$.each(obj, function(i, m) {
						var imgUrl = m.wxUser.headImgUrl;
						var img_i = imgUrl.lastIndexOf('/');
						if(img_i > -1){
							imgUrl = imgUrl.substring(0, img_i)+ "/96";
						}
						var cont = replace_em(m.content);
						
						if(m.from == '<%=userwx%>'){
							html = "<tr><td></td><td><div class='detail_r' style='float: right'>"+cont+"</div></td><td width='42px' align='right'><img alt='' src='"+imgUrl+"'></td></tr><tr height=8px><td colspan='3'></td></tr>"+html;
						}else {
							html = "<tr><td width='42px'><img alt='' src='"+imgUrl+"'></td><td><div class='detail_l' style='float: left'>"+cont+"</div></td><td></td></tr><tr height=8px><td colspan='3'></td></tr>"+html;
						}
						
						if(m.msgId > maxMsgId){
							maxMsgId = m.msgId;
						}
					});
					$("#chatContent table").append(html);
					// window.scrollTo(0, document.body.scrollHeight);
					$.scrollTo('100%', 1500);
				}
			}
		});
	}
	
	var isFirstSend = true;
	function check(){
		if(status=="offLine"){
			showNotice("对方离线中<br/>上线才可接受消息");
			// return false;
		}else if(status=="black"){
			showNotice("对方为黑名单用户<br/>无法接受消息");
			return false;
		}else if(status=="unSubscribe"){
			showNotice("对方已取消关注<br/>无法接受消息");
			return false;
		}
		
		var content = document.getElementsByName("content")[0].value;
		
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
			to : toUserwx,
			isFirstSend : isFirstSend
		}, function(data) {
			if(data == "black"){
				showNotice("你已被拉入黑名单<br/>如有问题请联系管理员");
			}else if (data == "true") {
				document.getElementsByName("content")[0].value = "";
				showNotice("发送成功");
			} else {
				showNotice("发送失败，请重试");
			}
			$(":button").attr("disabled", false);
		});
		isFirstSend = false;
	}
</script>
</head>

<body onload="">

	<div style="position: absolute; right: 10; top: 5; font-size: 14px;">
		<a href="/mobile/chat/text?ac=wxInfo&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>">设置</a>
	</div>

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
				<td align="center" style="padding: 5px 0"><span
					style="color: #103261; font-weight: bold; font-size: 16px;"><%=user[0]%></span>
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
	
	<div id="loadChat"></div>
	<div id="chatContent">
		<table cellpadding=0 cellspacing=0 border=0></table>
	</div>

	<div style="height: 50px"></div>
	<div id="chatBar">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td width="35px" align="center"><span id="fixed" class="qqfaceemotion"></span></td>
				<td><input id="chatContentInput" type="text" name="content" onclick="clearMsg();"
					class="html5input_n"></td>
				<td width="60px" style="padding-left: 10px">
					<input type="hidden" name="toUserwx" value="<%=user[2]%>">
					<input type="button" value="发送" onclick="check();" class="html5btn">
				</td>
			</tr>
		</table>
	</div>
	<%
		}
	%>

	<%--<jsp:include page="../copyright.jsp" />--%>
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
