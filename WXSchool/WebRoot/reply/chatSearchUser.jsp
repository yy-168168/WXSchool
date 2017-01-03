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

		<title>查找匹配</title>

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
#chatUser {
	background-color: #fff;
}

#chatUser table {
	padding: 5px 10px;
	border-bottom: 1px solid #ddd;
}

#chatUser img {
	width: 50px;
	height: 50px;
	border-radius: 25px;
}
</style>
		<script type="text/javascript">
function searchUser() {
	var keyword = document.getElementsByName("keyword")[0].value;
	if ($.trim(keyword) == "") {
		return false;
	}
		
	var url = "/mobile/chat/text?ac=searchUser&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.ajax( {
		url: url,
		data: {keyword : keyword},
		beforeSend : function() {
			$("#chatUser").html("");
			$("#loadn").html("<img src='/static_/loading.gif' height='30px' style='padding-top:8px'/>");
		},
		success : function(json) {
			$("#loadn").empty();
			var obj;
			try {
				obj = $.parseJSON(json);
			} catch (e) {
				alert("出错啦");
			}

			if (obj == null || obj == "") {
				$("#loadn").html("<div style='padding-top:8px;font-size:14px'>没有匹配的数据</div>");
				return false;
			}
			$.each(obj, function(i, n) {
				var imgUrl = n[1];
				var img_i = imgUrl.lastIndexOf("/");
				var imgUrl_46 = imgUrl;
				if (img_i > -1) {
					imgUrl_46 = imgUrl.substring(0, img_i) + "/96";
				}
				var to = '<%=UUID.randomUUID().toString()%>' + n[2];
				var sexImgUrl = n[7] == 2 ? 'static_/girl2.png' : "static_/boy2.png";

				var str = "<table width='100%' border='0' onclick='location=\"mobile/chat/text?ac=chat&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&to="+to+"\"'><tr>";
				str += "<td rowspan='2' width='60px'><img alt='' src='"+imgUrl_46+"'></td>";
				str += "<td><span style='font-weight: bold'>"+n[0]+"</span><img alt='' src='"+sexImgUrl+"' style='vertical-align: middle; width: 14px; height: 14px'>";
				str += "</td></tr>";
				if(n[5] != ''){
					str += "<tr><td><span style='font-size: 13px; color: #888;'>"+n[3]+"-"+n[4]+"级"+n[5]+n[6]+"专业</span></td></tr>";
				}
				str += "</table>";
				$("#chatUser").append(str);
			});
		}
	});
}
</script>
	</head>

	<body onload="checkMM();" style="margin: 0">
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
	});
</script>
		<div id="search">
			<div style="margin: 10px">
				<input type="text" name="keyword" class="html5input" style="width: 70%;" placeholder="姓名/学号/专业"> 
				<input type="button" value="搜索" class="html5btn" onclick="searchUser();" style="width: 27%; float: right;">
			</div>
		</div>
	
		<div id="chatUser"></div>
		<div id="loadn" style="text-align: center;"></div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
