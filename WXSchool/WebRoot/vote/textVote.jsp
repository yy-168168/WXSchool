<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String orderBy = request.getParameter("orderBy");
	String aId = request.getParameter("aId");
	String topicId = request.getParameter("topicId");
	String token = request.getParameter("token");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title></title>

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
.voteItems {
	display: table; border: 1px solid #ddd; width: 100%; margin-top: 15px;
	border-radius: 3px;
	text-align: center;
	background-color: #fff;
}

.voteItems .itemNum {
	display: table-cell;
	width: 90px;
	color: #666;
	font-size: 13px;
	background-color: #FFF5E0;
	vertical-align: middle;
}

.voteItems .itemContent {
	display: table-cell;
	font-size: 14px;
	padding: 10px 5px;
	vertical-align: middle;
}

.voteItems .itemSupport {
	display: table-cell;
	width: 90px;
	color: #666;
	font-size: 13px;
	background-color: #EDE8DE;
	vertical-align: middle;
}
</style>
<script type="text/javascript">
var userwx = '<%=userwx%>';
var wxaccount = '<%=wxaccount%>';
var orderBy = '<%=orderBy%>';
var flagId = -1;
var page = 1;
var visitPerson = 0;

$(function() {
	
	checkMM();

	setInfo();
	
	visitPerson = getArticleVisitPerson(wxaccount,'<%=aId%>');
	$("#useNum").text(visitPerson);

	showVoteList();

	if (page == 2 && orderBy == "null") {
		updateArticleVisitPerson(wxaccount, '<%=aId%>');
	}
});

function setInfo() {
	var topic = getTopic('<%=wxaccount%>', '<%=topicId%>');
	var obj = null;;
	try{
		obj = $.parseJSON(topic);
	}catch(e){
	}
	
	if (obj == null || obj == "") {
		document.title = "文字投票";
		$("#bbNum").text(0);
	} else {
		document.title = obj.title;
		var ot = obj.overTime;
		if (ot == '3000-01-01 00:00') {
			ot = "长期有效";
		}
		$("#topicRule #overTime").html(ot);
		$("#topicRule #topicDesc").html(obj.desc);
		$("#bbNum").text(obj.personNum);
		if(obj.info != ''){
			$("#topicInfo").html("<div style='padding: 4px 6px; margin-top: 5px'>"+obj.info+"</div>");
		}
		$("#subscribeQRcode img").attr("src", obj.qrcodeUrl);
	}
}

$(window).scroll(
		function() {
			var jl = document.body.scrollHeight - document.body.scrollTop
					- document.body.clientHeight;
			if (jl == 0) {
				showVoteList();
			}
		});

function showVoteList() {
	if ($("#loadn").text() == '没有更多') {
		return false;
	}

	var url = "/mobile/vote?ac=listVote&wxaccount=" + wxaccount + "&userwx="
			+ userwx + "&topicId=<%=topicId%>&orderBy=" + orderBy + "&cpg=" + page;
	$.ajax( {
		url : url,
		type : 'POST',
		beforeSend : function() {
			$("#loadn").html("<img src='/static_/loading.gif' height='30px' style='padding-top:8px'/>");
		},
		success : function(json) {
			$("#loadn").empty();
			var obj = null;
			try{
				obj = $.parseJSON(json);
			}catch(e){
				alert("出错啦");
			}
			
			if (obj == null || obj == "") {
				$("#loadn")
						.html("<div style='padding-top:8px;font-size:14px'>没有更多</div>");
				return false;
			}
			computeData(obj);
		}
	});
	page++;
}

	function searchVote() {
		var keyword = document.getElementsByName("keyword")[0].value;

		if ($.trim(keyword) == "") {
			return false;
		} else {
			var url = "/mobile/vote?ac=searchVote";
			$.post(url, {
				wxaccount : wxaccount,
				userwx : userwx,
				topicId : '<%=topicId%>',
				keyword : keyword
			}, function(data) {
				var obj = null;
				try {
					obj = $.parseJSON(data);
				} catch (e) {
					alert("出错啦");
				}

				if (obj == null || obj == "") {
					alert("没有搜索到相关信息");
				} else {
					computeData(obj, "pre");
					window.scrollTo(0, 0);
				}
				$("#search").hide();
			});
		}
	}

	function computeData(obj, loc) {
		var leftDIV = "";
		$.each(obj, function(i, n) {
			leftDIV += "<div class='voteItems' id='" + n.voteId + "'>";
			leftDIV += "<div class='itemNum'>#" + n.num + "</div>";
			leftDIV += "<div class='itemContent'>" + n.name + "&nbsp;&nbsp;"+n.content+"</div>";
			leftDIV += "<div class='itemSupport' onclick='support(this);'><span class='glyphicon glyphicon-heart'></span> (<span id='sn'>"+ n.supportNum + "</span>)</div>";
			leftDIV += "</div>";
		});
		if(loc == undefined){
			$("#content").append(leftDIV);
		}else {
			$("#content").prepend(leftDIV);
		}
	}
	
	function support(obj) {
		if(userwx == "null"){
			$("#subscribeQRcode").slideDown();
		}else{
			//var topicHasVote = getCookie("<%=wxaccount+topicId%>");
			//if(topicHasVote == ""){
			//	var curDate = new Date();
			//	var nightDate = new Date(curDate.getFullYear(), curDate.getMonth(), curDate.getDate(), 23, 59, 59); 
			//	var expireM = (nightDate.getTime() - curDate.getTime())/1000/60;
			//	addCookie("<%=wxaccount+topicId%>", "yes", expireM);
			//}else{
			//	showNotice('今天已投过啦');
			//}
			
			vote(obj, "support", '<%=topicId%>', userwx, wxaccount, '<%=token%>');
		}
		
	}

	function showRule() {
		var clientHeight = document.body.clientHeight;
		$("#topicRule").css("padding-top", 40);
		$("#topicRule #topicDesc").css("height", clientHeight - 40 - 30 - 40 - 30);
		$("#topicRule").slideDown();
	}
</script>
</head>

<body>
	<script type="text/javascript">
		document.addEventListener('WeixinJSBridgeReady',
				function onBridgeReady() {
					WeixinJSBridge.call('hideToolbar');
				});
	</script>

	<div style="margin: -8px -8px 0 -8px; height: 3px; background-color: #EE9A00"></div>

	<div style="margin-top: 10px; font-size: 12px; color: #999; text-align: center;">
		<span class='glyphicon glyphicon-heart'></span> <span id="bbNum"></span>投票&nbsp;&nbsp;&nbsp;&nbsp;
		<span class='glyphicon glyphicon-user'></span> <span id="useNum"></span>访问&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	
	<div id="topicInfo" style='font-size: 13px; color: #666; background-color: #ccc; border-radius: 5px; text-align: center;'></div>

	<div id="content"></div>
	<div id="loadn" style="text-align: center;"></div>

	<!-- 搜索 -->
	<div id="search"
		style="position: fixed; left: 0; bottom: 50px; z-index: 999; display: none; width: 100%;">
		<div style="padding: 0 10px">
			<input type="text" name="keyword" class="html5input"
				style="width: 70%;"> <input type="button" value="搜索"
				class="html5btn" onclick="searchVote();"
				style="width: 27%; float: right;">
		</div>
		<script type="text/javascript">
			function showSearch() {
				var display = $("#search").css("display");
				if (display == "block") {
					$("#search").hide();
				} else {
					$("#search").show();
				}
			}
		</script>
	</div>

	<jsp:include page="../common/copyright.jsp" />

	<div id="mybar_dis"></div>
	<div id="mybar">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<%
					String url = "/mobile/vote?ac=textVote&wxaccount=" + wxaccount
							+ "&userwx=" + userwx + "&aId="+aId+"&topicId=" + topicId + "&orderBy=";
				%>
				<td width="40%" style="border-right: 1px solid #666"
					onclick="location='<%=url%>2'">排行</td>
				<td width="40%" style="border-right: 1px solid #666"
					onclick="showRule()">规则</td>
				<td onclick="showSearch();"><span
					class="glyphicon glyphicon-search"></span>
				</td>
			</tr>
		</table>
	</div>

	<!-- 细则 -->
	<div id="topicRule" class='screenNotice'>
		<div class="html5yj" style="margin: 0 30px; padding: 3px 10px" onclick="hideScreenNotice()">
			<div style="overflow: auto" id="topicDesc"></div>
			<div style="height: 30px; line-height: 30px; text-align: center;">截止时间：<span id="overTime"></span></div>
		</div>
	</div>
	
	<!-- 二维码  -->
	<div id="subscribeQRcode" class='screenNotice' onclick="hideScreenNotice()">
		<div class="html5yj1" style="background-color: #fff; height: 70%; margin: 0 60px; margin-top: 15%; ">
			<table width='100%' height='100%' cellpadding='0' cellspacing='0'>
				<tr><td align='center'>
					<div style="font-weight: bold">进入公众号才可投票</div>
					<img alt='' src='' width="200px" style="margin: 5px 0">
					<div style="font-size: 13px">长按可识别二维码</div>
				</td></tr>
			</table>
		</div>
	</div>

	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
	
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript" src="<%=basePath%>static_/wxjsSDK.js?v=44"></script>
	<script type="text/javascript">
	
		initJsSDK('<%=wxaccount%>', '<%=userwx%>');

		wx.ready(function() {
			setShareInfo('<%=wxaccount%>', '<%=aId%>');
			shareData.link = changeParam("userwx", "null");
			shareData.title = document.title;
			 
			shareTimeline(shareData);
			shareAppMessage(shareData);
			shareQQ(shareData);
			shareWeibo(shareData);
			shareQZone(shareData);
		});
	</script>
</body>
</html>
