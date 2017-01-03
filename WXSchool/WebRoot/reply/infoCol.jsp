<%@ page language="java" import="java.util.*,java.util.Map.*,com.wxschool.entity.*"
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
	String aId = request.getParameter("aId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>信息反馈</title>

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
$(function() {
	checkMM();
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
});

	function check() {
		var info = document.getElementsByName("info")[0].value;
		var tel = document.getElementsByName("tel")[0].value;
	
		if ($.trim(info) == "") {
			$("#msg").text("请认真填写后再提交");
			return false;
		}
	
		$("#infoSubmit").attr("disabled", true);
		$("#infoSubmit").val("提交中...");
	
		var url = "/mobile/reply?ac=addQues&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		$.post(url, {
			topicId : -66,
			content : info,
			other : tel
		}, function(data) {
			window.location.reload();
		});
	}
	
	function checkReply(obj){
		var fm = $(obj).parentsUntil("form");
		var content = fm.find("textarea[name='content']").val();
		var infoId = fm.find("input[name='infoId']").val();
	
		if ($.trim(content) == "") {
			fm.find("#msg").text("请认真填写后再提交");
			return false;
		}
	
		fm.find("input[type='button']").attr("disabled", true);
		fm.find("input[type='button']").val("提交中...");
	
		var url = "/mobile/reply?ac=addInfoColReply&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		$.post(url, {
			infoId : infoId,
			content : content
		}, function(data) {
			window.location.reload();
		});
	}

	function showPub(obj) {
		$(obj).css("display", "none");
		$(obj).next().css("display", "block");
	}
</script>
</head>

<body>

	<form method="post" name="form">
		<div class="html5yj">
			<div class="formhead_n">
				<div>
					<span class="glyphicon glyphicon-edit"></span>&nbsp;信息反馈
				</div>
				<div>咨询求助，鼓励支持，吐槽咒骂，想法建议...均可在此发表，我们会第一时间处理</div>
			</div>
			<div style="padding: 10px 10px 3px 10px">
				<div class="text1">信息内容</div>
				<textarea rows="4" cols="" name="info" class="html5area_n"
					onclick="clearMsg();"></textarea>
				<hr />
				<div class="text1">手机号(可不填)</div>
				<input type="text" name="tel" class="html5input_n" value=""
					onclick="clearMsg();">
				<hr />
				<input id="infoSubmit" type="button" value="提  交" class="html5btn"
					onclick="check();">
				<div id="msg"></div>
			</div>
		</div>
	</form>

	<table width="100%" border="0" style="margin-top: 20px;">
		<tr>
			<td><hr style="border: 1px dotted #666;" /></td>
			<td width="100px" align="center">我的历史反馈</td>
			<td><hr style="border: 1px dotted #666;" /></td>
		</tr>
	</table>

	<%
	
		Map<Question, List<Reply>> infoCols = (Map<Question, List<Reply>>)request.getAttribute("infoCols");
		
		if(infoCols == null || infoCols.size() == 0){
			%>
			<div class="html5yj" style="padding: 10px">你没有提交任何反馈</div>
			<%
		}else{
			Set<Entry<Question, List<Reply>>> entrys =  infoCols.entrySet();
			Iterator<Entry<Question, List<Reply>>> iterators = entrys.iterator();
			
			//Set<Question> quess =  infoCols.keySet();
			//Iterator<Question> i_quess =  quess.iterator();
			while(iterators.hasNext()) {
				Entry<Question, List<Reply>> entry = iterators.next();
				Question ques = entry.getKey();
	%>

	<div class="html5yj">
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<div style="padding: 10px 10px 6px 10px; font-weight: bold;">
						<%=ques.getContent() %></div>
					<div
						style="text-align: right; padding: 0px 10px 6px 10px; font-size: 13px; color: 666;">
						<%=ques.getPubTime() %></div>
				</td>
			</tr>
			<%
				List<Reply> replys = entry.getValue();
				for (int i = 0; i < replys.size(); i++) {
					Reply reply = replys.get(i);
					String rt = "<span style='color: red'>平台回复：</span>";
					if(reply.getUserwx().equals(userwx)){
						rt = "<span style='color: green'>我的回复：</span>";
					}
			%>
			<tr>
				<td>
					<div class="fgx"></div>
					<div style="padding: 10px 10px 6px 10px;">
						<%=rt%><%=reply.getContent() %>
					</div>
					<div
						style="text-align: right; padding: 0px 10px 6px 10px; font-size: 13px; color: 666;">
						<%=reply.getPubTime() %></div>
				</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td>
					<div class="fgx"></div>
					<div style="text-align: center; padding: 6px 10px 6px 10px;"
						onclick="showPub(this);">回复</div>
					<form method="post" name="form" style="display: none">
						<div style="padding: 10px 10px 3px 10px">
							<div class="text1">回复内容</div>
							<textarea rows="4" cols="" name="content" class="html5area_n"
								onclick="clearMsg();"></textarea>
							<hr />
							<input type="hidden" name="infoId" value="<%=ques.getQuesId()%>">
							<input type="button" value="提  交" class="html5btn" onclick="checkReply(this);">
							<div id="msg"></div>
						</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
	<%
		}}
	%>

	<jsp:include page="../common/copyright.jsp" />
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
