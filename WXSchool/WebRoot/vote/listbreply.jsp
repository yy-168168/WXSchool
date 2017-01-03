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
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

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

function showPubBB(obj, receiver) {
	if(receiver != undefined){
		document.getElementsByName("receiver")[0].value = receiver;
		$(obj).parents(".bbbox").after($("#pubBB"));
	}else {
		document.getElementsByName("receiver")[0].value = document.getElementsByName("receiver")[0].defaultValue;
		$(obj).parents(".pubReplyText").before($("#pubBB"));
	}
	$("#pubBB").slideDown();
}

function check() {
	var content = document.getElementsByName("content")[0].value;
	var receiver = document.getElementsByName("receiver")[0].value;

	if ($.trim(content) == "" ) {
		$("#msg").text("不能为空");
		return false;
	}

	if (content.length > 480) {
		$("#msg").text("消息内容不能过长");
		return false;
	}
	$(":button").attr("disabled", true);
	$(":button").val("提交中...");
	
	var url = "/mobile/love?ac=addBReply&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		voteId : '<%=voteId%>',
		content : content,
		receiver : receiver
	}, function(data) {
		window.location.reload();
	});
}
</script>
	</head>

	<body>
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideToolbar');
});
</script>
		<div style="margin: -8px -8px 15px -8px;">
			<div style="height: 70px; background-color: #FC88A2"></div>
			<div style="height: 25px;"></div>
			<table width="100%" cellpadding="0" cellspacing="0" border="0"
				style="position: absolute; top: 15px;">
				<tr>
					<td rowspan="2">
						<%--<img alt="" src="static_/bblogo.jpg" style="margin-left: 20px;" width="75px" height="75px">--%>
						<span class='glyphicon glyphicon-heart'
							style="margin-left: 10px; font-size: 90px; color: red"></span>
					</td>
					<td>
						<div
							style="color: #fff; font-size: 13px; padding: 0 3px 0 10px; font-family: '华文新魏'; text-align: right; overflow: hidden; white-space: nowrap;">
							螃蟹在剥我的壳 笔记本在写我
							<br />
							漫天的我落在枫叶上雪花上
							<br />
							而你在想我
						</div>
					</td>
				</tr>
				<tr>
					<td height="40px" width="100%" valign="middle">
						<div style="padding: 0 0 0 20px; font-size: 12px; color: #999;"></div>
					</td>
				</tr>
			</table>
		</div>
		
		<%
			Vote vote = (Vote) request.getAttribute("vote");
			String parentUserwx = vote.getUserwx();
		%>
		<div>
			<div style="float: left; margin-left: 4px">
				<div style="margin-left: 0.5px">
					<%--<img alt="" src="static_/doublering1.png" height="16px">--%>
					<div
						style="background-color: #DFDFDF;width:14px;height:14px;border-radius:8px;border: 2px solid #FC88A2">
						<div
							style="background-color: #FC88A2;width:4px;height:4px;border-radius:2px; margin: 5px 0 0 5px;">
						</div>
					</div>
				</div>
				<div style="border-left: 2px solid #FC88A2; margin-left: 8px; height: 18px"></div>
			</div>
			<div style="float: left; margin-left: 8px; color: #FC88A2">
				<%=vote.getAddTime()%>
			</div>
			<span style="float: right; color: #FC88A2; font-size: 13px;">楼主</span>
			<div style="clear: both;"></div>
		</div>
		<div style="border-left: 2px solid #FC88A2; margin-left: 12px">
			<div style="margin-left: 13px; margin-top: 0px" class="html5yj">
				<div style="padding: 15px 10px 15px 10px;">
					<%=vote.getContent()%>
				</div>
				<div>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						style="font-size: 13px; color: #666;">
						<tr align="center" height="28px" id="<%=vote.getVoteId()%>">
							<td
								style="width: 33%; border-top: 1px solid #EFEFEF; border-right: 1px solid #EFEFEF;">
								<span class='glyphicon glyphicon-comment'></span>
								<span id="rn"><%=vote.getReplyNum()%></span>
							</td>
							<td
								style="width: 33%; border-top: 1px solid #EFEFEF; border-right: 1px solid #EFEFEF;" class="support">
								<span class='glyphicon glyphicon-thumbs-up'></span>
								<span id="sn"><%=vote.getSupportNum()%></span>
							</td>
							<td style="border-top: 1px solid #EFEFEF;" class="oppose">
								<span class='glyphicon glyphicon-thumbs-down'></span>
								<span id="on"><%=vote.getOpposeNum()%></span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div style="height: 20px"></div>
		</div>

		<%
			List<Reply> vs = (List<Reply>) request.getAttribute("replys");
			if (vs == null || vs.size() == 0) {
		%>
		<div>
			<div style="float: left; margin-left: 4px">
				<div style="margin-left: 0.5px">
					<%--<img alt="" src="static_/doublering1.png" height="16px">--%>
					<div
						style="background-color: #DFDFDF;width:14px;height:14px;border-radius:8px;border: 2px solid #FC88A2">
						<div
							style="background-color: #FC88A2;width:4px;height:4px;border-radius:2px; margin: 5px 0 0 5px;">
						</div>
					</div>
				</div>
				<div style="border-left: 2px solid #FC88A2; margin-left: 8px; height: 18px"></div>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div style="border-left: 2px solid #FC88A2; margin-left: 12px">
			<div class="html5yj" style="margin-left: 13px; margin-top: 0px">
				<div style="padding: 15px 10px;">
					要不您来说两句
				</div>
			</div>
			<div style="height: 20px"></div>
		</div>
		<%
			} else {
				for (int i = 0; i < vs.size(); i++) {
					Reply reply = vs.get(i);
					String curUserwx = reply.getUserwx();
					String num = "#" + reply.getNum();
					
					if(curUserwx.equals(parentUserwx)){
						num = "楼主";
					}
					
					if(curUserwx.equals(userwx)){
						num = "朕";
					}
		%>
		<div class="bbbox">
		<div>
			<div style="float: left; margin-left: 4px">
				<div style="margin-left: 0.5px">
					<%--<img alt="" src="static_/doublering1.png" height="16px">--%>
					<div
						style="background-color: #DFDFDF;width:14px;height:14px;border-radius:8px;border: 2px solid #FC88A2">
						<div
							style="background-color: #FC88A2;width:4px;height:4px;border-radius:2px; margin: 5px 0 0 5px;">
						</div>
					</div>
				</div>
				<div style="border-left: 2px solid #FC88A2; margin-left: 8px; height: 18px"></div>
			</div>
			<div style="float: left; margin-left: 8px; color: #FC88A2">
				<%=reply.getPubTime()%>
			</div>
			<span style="float: right; color: #FC88A2; font-size: 13px;"><%=num%></span>
			<div style="clear: both;"></div>
		</div>
		<div style="border-left: 2px solid #FC88A2; margin-left: 12px">
			<div style="margin-left: 13px; margin-top: 0px" class="html5yj">
				<div style="padding: 15px 10px 15px 10px;">
					<%=reply.getContent()%>
				</div>
				<div>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						style="font-size: 13px; color: #666;">
						<tr align="center" height="28px">
							<td style="border-top: 1px solid #EFEFEF;" onclick="showPubBB(this, '<%=reply.getUserwx()%>');">
								<span>@Ta</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div style="height: 20px"></div>
		</div>
		</div>
		<%
			}
			}
		%>

		<!-- 发布表白 -->
		<div id="pubBB" style="display: none">
			<div>
				<div style="float: left; margin-left: 4px">
					<div style="margin-left: 0.5px">
					<%--<img alt="" src="static_/doublering1.png" height="16px">--%>
					<div
						style="background-color: #DFDFDF;width:14px;height:14px;border-radius:8px;border: 2px solid #FC88A2">
						<div
							style="background-color: #FC88A2;width:4px;height:4px;border-radius:2px; margin: 5px 0 0 5px;">
						</div>
					</div>
				</div>
				</div>
				<div style="clear: both;"></div>
			</div>
			<div style="border-left: 2px solid #FC88A2; margin-left: 12px">
				<div style="margin-left: 13px;">
					<form method="post" name="form">
						<div class="html5yj" style="margin-top: 0px">
							<div class="formhead_n">
								<div>
									<span class="glyphicon glyphicon-edit"></span>&nbsp;发布表白评论
								</div>
							</div>
							<div style="padding: 10px 10px 3px 10px">
								<div class="text1">
									评论内容
								</div>
								<textarea rows="4" cols="" name="content" class="html5area_n"
									onclick="clearMsg();"></textarea>
								<hr />
								<input type="hidden" name="receiver" value="<%=parentUserwx %>">
								<input type="button" value="提 交" onclick="check();" class="html5btn">
								<div id="msg"></div>
							</div>
						</div>
					</form>
				</div>
				<div style="height: 8px"></div>
			</div>
		</div>

		<div class="pubReplyText">
			<div style="float: left;">
				<img alt="" src="static_/edit2.png" height="25px">
			</div>
			<div
				style="float: left; margin-left: 7px; font-size: 20px; font-weight: bold; color: #FC88A2"
				onclick="showPubBB(this);">
				请点击这里发布评论
			</div>
			<div style="clear: both;"></div>
		</div>


		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
