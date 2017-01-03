<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String quesId = request.getParameter("quesId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>所有回复</title>

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
function check() {
	var content = document.getElementsByName("content")[0].value;
	if ($.trim(content) == "") {
		$("#msg").text("不能为空");
		return false;
	}
	if (content.length > 100) {
		$("#msg").text("消息内容不能超过100字");
		return false;
	}
	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/reply?ac=addReply&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		quesId : '<%=quesId%>',
		content : content
	}, function(data) {
		window.location.reload();
	});
}
</script>
	</head>

	<body onload="checkMM();" onunload="resetAll();">
		<%
			Question ques = (Question) request.getAttribute("ques");
			List<Reply> replys = (List<Reply>) request.getAttribute("replys");
		%>

		<div>
			<div class="html5yj">
				<table width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<div style="padding: 8px 10px; color: red">
								<%=ques.getContent()%>
							</div>
						</td>
					</tr>
					<%
						if (replys == null || replys.size() == 0) {
					%>
					<tr>
						<td>
							<div class="fgx"></div>
							<div style="padding: 8px 10px;">
								还没有人给予帮助 T_T
							</div>
						</td>
					</tr>
					<%
						} else {
							for (int i = 0; i < replys.size(); i++) {
								Reply reply = replys.get(i);
					%>
					<tr>
						<td>
							<div class="fgx"></div>
							<div style="padding: 8px 10px">
								<%=reply.getContent()%>
							</div>
							<div
								style="color: #666; font-size: 12px; margin: -4px 10px 4px 10px">
								&nbsp;
								<span style="float: right;"><%=reply.getPubTime()%></span>
							</div>
						</td>
					</tr>
					<%
						}
						}
					%>
				</table>
			</div>

			<!--  
			<div style="margin-top: 20px">
				<div style="font-size: 13px">
					『予人玫瑰 手有余香』希望您的回复对Ta有所帮助
				</div>
				<form action="/mobile/reply?ac=addReply" method="post" name="form">
					<textarea rows="3" cols="" name="content" class="html5area"
						onclick="clearMsg();"></textarea>

					<div id="msg" style="font-size: 11px; height: 15px; color: red;"></div>
					<input type="hidden" name="quesId" value="<%=ques.getQuesId()%>">
					<input type="hidden" name="userwx" value="<%=userwx%>">
					<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
					<input type="button" value="提交" class="html5btn" onclick="check();">
				</form>
			</div>
			-->
		</div>
		

			<form name="form" id="pubForm" style="display: none;">
				<div class="html5yj">
					<div class="formhead">
						我的回复
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td class="text">
								回复内容：
							</td>
							<td class="input">
								<textarea rows="3" cols="" name="content" class="html5area"
									onclick="clearMsg();"></textarea>
							</td>
						</tr>
					</table>
				</div>

				<div id="msg"></div>
				<input type="button" value="提交" class="html5btn" onclick="check();">
			</form>

			<div id="pubBtn" style="margin-top: 20px;">
				<input type="button" value="回复" class="html5btn"
					onclick="showPubForm();">
				<script type="text/javascript">
function showPubForm() {
	$("#pubForm").slideDown();
	$("#pubBtn").hide();
	window.scrollTo(0, 9999);
}
</script>
			</div>

			<div id="showMenu"
				onclick="location='reply/listQues.jsp?userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
			</div>

			<jsp:include page="../common/copyright.jsp" />
			<%@ include file="../common/toolbar.html"%>
			<%@ include file="../common/tongji.html"%>
	</body>
</html>
