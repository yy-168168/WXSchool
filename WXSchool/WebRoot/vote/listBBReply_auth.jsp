<%@page import="com.wxschool.entity.Reply"%>
<%@ page import="com.wxschool.entity.Vote"%>
<%@ page import="com.wxschool.entity.Page"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String voteId = request.getParameter("voteId");
	String token = request.getParameter("token");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>表白墙</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="format-detection" content="telphone=no, email=no" />
<meta name="viewport"
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
<link href="<%=basePath %>static_/weui.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

<style type="text/css">
.bbBox {
	margin-top: 10px;
	margin-bottom: 10px;
	background-color: #fff;
	border-top: 1px solid #f1f1f1;
	border-bottom: 1px solid #f1f1f1;
}

.replyBox {
	background-color: #fff;
	border-bottom: 1px solid #f1f1f1;
}

.replyBox:first-child {
	border-top: 1px solid #f1f1f1;
}

.bbBox table,.replyBox table {
	width: 100%;
	border-spacing: 0;
	border-collapse: 0;
}

.bbBox table img,.replyBox table img {
	width: 50px;
	height: 50px;
	border-radius: 25px;
}
</style>
<script type="text/javascript">
var flagId = -1;
$(function() {
	checkMM();
	
	$(".support").click(function() {
		vote($(this), "support", -1, '<%=userwx %>', '<%=wxaccount %>', '<%=token%>');
	});

	$(".oppose").click(function() {
		vote($(this), "oppose", -1, '<%=userwx %>', '<%=wxaccount %>', '<%=token%>');
	});
});

var receiver = "";
function showPubForm(r) {
	receiver = r;
	
	var dsp = $("#pubForm").css("display");
	if (dsp == "block") {
		$("#pubForm").slideUp();
	} else {
		$("#pubForm").slideDown();
		window.scrollTo(0, 0);
	}
}

var isBusy = false;
function check() {
	if(isBusy){return false;}
	var content = document.getElementsByName("content")[0].value;
	// var receiver = document.getElementsByName("receiver")[0].value;
	var isTrueName = document.getElementsByName("isTrueName")[0].checked;
	isTrueName = isTrueName ? 1 : 0;

	if ($.trim(content) == "" ) {
		// $("#msg").text("不能为空");
		alert("怎么能空呢？");
		return false;
	}

	if (content.length > 490) {
		// $("#msg").text("消息内容不能过长");
		alert("字数太多了哦");
		return false;
	}
	
	//$("#submit").addClass('weui_btn_disabled');
	isBusy = true;
	var url = "mobile/love?ac=addBReply&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
			voteId : '<%=voteId%>',
			content : content,
			receiver : receiver,
			isTrueName : isTrueName
		}, function(data) {
			if (data == "black") {
				showNotice("你已被拉入黑名单<br/>如有问题请联系管理员");
			} else if (data == "true") {
				window.location.reload();
			} else {
				showNotice("发送失败，请重试");
				//$("#submit").removeClass('weui_btn_disabled');
				isBusy = false;
			}
		});
	}
</script>
</head>

<body onload="checkMM();" style="margin: 0">
	<script type="text/javascript">
		document.addEventListener('WeixinJSBridgeReady',
				function onBridgeReady() {
					WeixinJSBridge.call('hideToolbar');
				});
	</script>

	<div style="height: 3px; background-color: #FC88A2;"></div>

	<%
		Vote vote = (Vote) request.getAttribute("vote");
		String parentUserwx = "";
	%>
	<div class="bbBox">
		<%
			if(vote == null){
				%>
				<div style="padding: 10px; word-wrap: break-word; word-break:break-all;">出错啦，未获取到数据</div>
				<%
			}else{
				parentUserwx = vote.getUserwx();
				%>
				<table border="0" style="padding: 10px 10px 0 10px">
					<tr>
						<%
							if(vote.getName().equals("")){
								%>
									<td rowspan="2" width="55px">
										<%
											String headImgUrl = vote.getHeadImgUrl();
											int img_i = headImgUrl.lastIndexOf("/");
											if (img_i > -1) {
												headImgUrl = headImgUrl.substring(0, img_i) + "/96";
											}
										%>
										<img alt="" src="<%=headImgUrl %>">
									</td>
									<td style="color: #FC88A2"><%=vote.getNickname() %></td>
								<%
							}else{
								%><td style="color: #FC88A2"><%=vote.getName() %></td><%
							}
						%>
						<td align="right" style="color: #FC88A2; font-size: 13px;">楼主</td>
					</tr>
					<tr>
						<td colspan="2" style="font-size: 12px; color: #999"><%=vote.getAddTime()%></td>
					</tr>
				</table>
				<div style="padding: 10px; word-wrap: break-word; word-break:break-all;"><%=vote.getContent()%></div>
				<%
			}
		%>
	</div>

	<%
		List<Reply> replys = (List<Reply>) request.getAttribute("replys");
		for (int i = 0; replys != null && i < replys.size(); i++) {
			Reply reply = replys.get(i);
			String curUserwx = reply.getUserwx();
			
			String num = "#" + reply.getNum();
			if(curUserwx.equals(parentUserwx)){
				num = "楼主";
			}
			
			String headImgUrl = reply.getHeadImgUrl();
			int img_i = headImgUrl.lastIndexOf("/");
			if (img_i > -1) {
				headImgUrl = headImgUrl.substring(0, img_i) + "/96";
			}
			
			String nickname = reply.getNickname();
			if(reply.getOther().equals("0")){// 不显示微信头像
				nickname = "匿名";
				headImgUrl = "static_/bbDefaultImg.jpg";
			}
	%>
	<div class="replyBox">
		<table border="0" style="padding: 10px">
			<tr>
				<td rowspan="3" width="55px" valign="top" onclick="showPubForm('<%=reply.getUserwx() %>')">
					<img alt="" src="<%=headImgUrl %>">
					<span style="font-size: 12px; color: #999; margin-left: 12px">@Ta</span>
				</td>
				<td style="color: #FC88A2"><%=nickname %></td>
				<td align="right" style="color: #FC88A2; font-size: 13px;"><%=num %></td>
			</tr>
			<tr>
				<td colspan="2" style="font-size: 12px; color: #999"><%=reply.getPubTime()%></td>
			</tr>
			<tr>
				<td colspan="2" valign="top">
					<div style="padding-top: 5px; word-wrap: break-word; word-break:break-all;"><%=reply.getContent()%></div>
				</td>
			</tr>
		</table>
	</div>
	<%
		}
	%>

	<jsp:include page="../common/copyright.jsp" />

	<div id="mybar_dis"></div>
	<div id="mybar">
		<table cellpadding="0" cellspacing="0">
			<tr id="<%=vote.getVoteId()%>">
				<td width="33%" style="border-right: 1px solid #666" class="support"><span
					class='glyphicon glyphicon-thumbs-up'></span> <span id="sn"><%=vote.getSupportNum()%></span>
				</td>
				<td width="33%" style="border-right: 1px solid #666" class="oppose"><span
					class='glyphicon glyphicon-thumbs-down'></span> <span id="on"><%=vote.getOpposeNum()%></span>
				</td>
				<td style="border-right: 1px solid #666" onclick="showPubForm('<%=parentUserwx%>')">评论</td>
			</tr>
		</table>
	</div>
	
	<div id="pubForm" class="screenNotice" style="background-color: #DFDFDF; opacity: 1;">
		<form method="post" name="form">
			<table class="flatFormHead"><tr>
				<td width="60px"></td>
				<td class="pubTitle"><span class="glyphicon glyphicon-edit"></span>&nbsp;发布内容</td>
				<td width="60px" align="right"><span class="cancel" onclick="hideScreenNotice()">取消</span></td>
			</tr></table>
			<div style="margin: 10px 10px 0 10px">是否显示微信头像<input type="checkbox" name="isTrueName" checked="checked"></div>
			<textarea rows="10" cols="" name="content" class="htmlFlatArea"></textarea>
			<%--<div class="htmlFlatBtn" onclick="check();">发 送</div>--%>
			<a id="submit" href="javascript:check();" class="weui_btn weui_btn_primary weui_btn_my">发送</a>
			<div id="msg"></div>
		</form>
	</div>
	
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
