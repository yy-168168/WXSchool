<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String ua = request.getParameter("ua");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>求助区</title>

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
var wxaccount = '<%=wxaccount%>';
var userwx = '<%=userwx%>';
var ua = '<%=ua%>';
var page = 1;
var timer, curPst;

$(function() {
	checkMM();

	listQues();
});

function listQues() {
	if ($("#loadn").text() == '没有更多') {
		return false;
	}

	var url = "/mobile/reply?ac=listques&wxaccount=" + wxaccount + "&userwx=" + userwx
			+ "&cpg=" + page + "&ua=" + ua;
	$
			.ajax( {
				url : url,
				beforeSend : function() {
					$("#loadn").text("加载中...");
				},
				success : function(data) {
					var obj;
					try{
						obj = $.parseJSON(data);
					}catch(e){
						alert("出错啦");
					}
					if (obj == null || obj == "") {
						$("#loadn").text("没有更多");
						return false;
					}
					$
							.each(
									obj,
									function(i, n) {
										var lu = "/mobile/reply?ac=getReplys&quesId="
												+ n.quesId + "&userwx="
												+ userwx + "&wxaccount="
												+ wxaccount;
										var str = "<div style='padding:10px' onclick='location=\""
												+ lu
												+ "\"'>"
												+ "<div style='color: #4C4C4C;'>"
												+ n.content
												+ "</div>"
												+ "<div style='color: #999; font-size: 12px; padding: 6px 0 0 0'>"
												+ "<span>"
												+ n.replyNum
												+ "</span>回复<span style='float: right;'>"
												+ n.pubTime
												+ "</span></div>"
												+ "</div><div class='fgx' style='margin: 0 -8px'></div>";
										$("#con").append(str);
									});
					$("#loadn").html(
							"<img alt='' src='static_/down.png' "
									+ "height='12px'>点击加载更多…");
				}
			});
	page++;
}

function check() {
	var content = document.getElementsByName("content")[0].value;
	if ($.trim(content) == "") {
		$("#msg").text("不能为空");
		return false;
	}
	if (content.length > 200) {
		$("#msg").text("消息内容不能超过200字");
		return false;
	}
	$(":button").attr("disabled", true);
	$(":button").val("提交中...");
	$("form").submit();
}
</script>
	</head>
	<body>
		<div
			style="margin: -8px -8px 0 -8px; background-color: #4F4F4F; color: #fff; padding: 8px">
			<img alt="" src="static_/hand_right.png" height="14px">
			让生活变得更加简单，请自觉维护秩序
		</div>

		<div>
			<div id="con">
			</div>
			<div id="loadn" onclick="listQues();"
				style="text-align: center; padding: 8px">
				<img alt="" src="static_/down.png" height="12px">
				点击加载更多…
			</div>
		</div>

		<!-- 
		<div style="margin-top: 20px; line-height: 1.7">
			<form action="/mobile/reply?ac=addQues" method="post" name="form">
				<span style="font-size: 14px">您的问题:</span>
				<textarea rows="3" cols="" name="content" class="html5area"
					onclick="clearMsg();"></textarea>

				<div id="msg"></div>
				<input type="hidden" name="userwx" value="<%=userwx%>">
				<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
				<input type="button" value="提交" class="html5btn" onclick="check();">
			</form>
		</div>
		 -->

		<form action="/mobile/reply?ac=addQues" method="post" name="form" id="pubForm" style="display: none;">
			<div class="html5yj">
				<div class="formhead">
					发布问题
				</div>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="text">
							您的问题：
						</td>
						<td class="input">
							<textarea rows="3" cols="" name="content" class="html5area"
								onclick="clearMsg();"></textarea>
						</td>
					</tr>
				</table>
			</div>

			<div id="msg"></div>
			<input type="hidden" name="userwx" value="<%=userwx%>">
			<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
			<input type="button" value="提交" class="html5btn" onclick="check();">
		</form>

		<div id="pubBtn" style="margin-top: 20px;">
			<input type="button" value="发布问题" class="html5btn"
				onclick="showPubForm();">
			<script type="text/javascript">
function showPubForm() {
	$("#pubForm").slideDown();
	$("#pubBtn").hide();
	window.scrollTo(0, 9999);
}
</script>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
