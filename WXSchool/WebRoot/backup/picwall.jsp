<%@ page language="java"
	import="java.util.*,com.wxschool.entity.*,sun.misc.BASE64Encoder"
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
%>
<%
	String token = request.getParameter("token");
	Object o_totalRecord = request.getAttribute("totalRecord");
	int totalRecord = 0;
	if (o_totalRecord != null) {
		totalRecord = (Integer) o_totalRecord;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>随手拍照片分享</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link type="image/x-icon" rel="shortcut icon" href="static_/favicon.ico" />
<link href="static_/mycommon.css" type="text/css" rel="stylesheet">
<link href="static_/myfont.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="/static_/mycommon.js"></script>
<script type="text/javascript" src="/static_/jquery-1.8.2.min.js"></script>

<style type="text/css">
.support_old {
	position: absolute;
	z-index: 10;
	font-size: 14px;
	bottom: 0px;
	background-color: #000;
	opacity: 0.6;
	color: #fff;
	width: 100%;
	text-align: center;
	padding: 8px 0;
}

.text_old {
	text-align: center;
	font-weight: bold;
	font-size: 16px;
	margin: 10px 10px 30px 10px;
}
</style>
<script type="text/javascript">
var userwx = '<%=userwx%>';
var wxaccount = '<%=wxaccount%>';
var orderBy = '<%=orderBy%>';
var flagId = -1;
var page = 1;
var timer, curPst;

$(function() {
	checkMM();

	showPicWall();

	if (page == 2 && orderBy == "null") {
		updateArticleVisitPerson(wxaccount, '<%=aId%>');
	}
	
	var visitPerson = getArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	$("#useNum").text(visitPerson);
});

$(window).scroll(
		function() {
			var jl = document.body.scrollHeight - document.body.scrollTop
					- document.body.clientHeight;
			if (jl == 0) {
				showPicWall();
			}
		});

function showPicWall() {
	if ($("#loadn").text() == "没有更多") {
		return false;
	}

	var url = "/mobile/vote?ac=listpicwall&wxaccount=" + wxaccount + "&userwx="
			+ userwx + "&orderBy=" + orderBy + "&cpg=" + page;
	$
			.ajax({
				url : url,
				beforeSend : function() {
					$("#loadn").html("<img src='/static_/loading.gif' height='30px' style='padding-top:8px'/>");
				},
				success : function(data) {
					$("#loadn").empty();
					var obj;
					try{
						obj = $.parseJSON(data);
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
										var str = "<div style='box-shadow: 0px 0px 5px #aaa; margin-top: 15px'><div style='padding: 15px; background-color: #fff'><img onclick='screenImg(this)' alt='' src='"+n.content+"' data-s='300,640' data-src='"+n.content+"' width='100%'></div><div style='padding: 15px 20px; background-color: #EDE8DE;'>";
										if(n.name != ""){
											str += "<div style='margin-bottom: 10px'>" + n.name + "</div>";
										}
										str += "<div style='color: #ED603A; text-align: right' class='support' id='"+n.voteId+"' onclick='support(this);'><span class='glyphicon glyphicon-heart'></span> (<span id='sn'>"+ n.supportNum + "</span>)</div></div></div>";
										$("#img-content-box").append(str);
									});
				}
			});
	page++;
}

function support(obj) {
	var id = obj.id;
	if (flagId != id) {
		flagId = id;
		var $span = $(obj).find("#sn");
		$.get("/mobile/vote?ac=addSupportNum", {
			topicId : '-1',
			voteId : id,
			userwx : userwx,
			wxaccount : wxaccount,
			token : '<%=token%>'
			}, function(data) {
				if (data == 'yes') {
					var num = parseInt($span.text());
					$span.text(num + 1);
				}else if(data == 'expire'){
					showNotice('活动已过期');
				}else if(data == 'wrong'){
					showNotice('出错啦');
				}else if(data == 'hasVote'){
					showNotice('今天已投过啦');
				}
			});
		}
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

	<div
			style="margin: -8px -8px 0 -8px; background-color: #8DB6CD; padding: 8px 0; text-align: center;">
			<div style="font-size: 20px; font-weight: bold; color: #fff;">
				照片墙
				<span style="font-size: 14px">--想您的日子 找您的影子</span>
			</div>
		</div>

		<div
			style="margin-top: 10px; font-size: 12px; color: #999; text-align: center;">
			<span class='glyphicon glyphicon-comment'></span>
			<span id="bbNum"><%=totalRecord%></span>照片&nbsp;&nbsp;&nbsp;&nbsp;
			<span class='glyphicon glyphicon-user'></span>
			<span id="useNum"></span>访问&nbsp;&nbsp;&nbsp;&nbsp;
		</div>

	<div id="content">
		<div id="img-content-box"></div>
	</div>
	<div id="loadn" style="text-align: center;"></div>

	<jsp:include page="../common/copyright.jsp" />

	<div id="mybar_dis"></div>
	<div id="mybar">
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr align="center" height="40px"
				style="line-height: 40px; color: #fff">
				<%
					String url = "/mobile/vote?ac=picwall&wxaccount=" + wxaccount + "&userwx="
							+ userwx + "&aId="+aId+"&orderBy=";
				%>
				<td width="30%" style="border-right: 1px solid #666"
					onclick="location='<%=url%>1'">最新</td>
				<td style="border-right: 1px solid #666"
					onclick="location='<%=url%>2'">最美</td>
				<td width="30%"
					onclick="showScreenNotice_text('在聊天界面直接发送图片即可，在返回的消息中提交姓名、联系方式、文字描述等信息<br/><br/>说明：素材均为自主上传，不涉及版权问题.','center');">
					投稿</td>
			</tr>
		</table>
	</div>

	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
