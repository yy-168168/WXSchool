<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String token = request.getParameter("token");

	String wxAccount = "", wxNum = "", wxName = "", guideUrl = "";
	int accountId = -1, status = -1;
	boolean robotChat = true, translate = true, weather = true, express = true, textChat = true;
	Account account = (Account) request.getAttribute("account");
	if (account != null) {
		accountId = account.getAccountId();
		wxAccount = account.getWxAccount();
		wxNum = account.getWxNum();
		wxName = account.getWxName();
		guideUrl = account.getGuideUrl();
		robotChat = account.isRobotChat();
		translate = account.isTranslate();
		weather = account.isWeather();
		express = account.isExpress();
		status = account.getStatus();
		textChat = account.isTextChat();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 基本配置</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/mng.js">
</script>

		<script type="text/javascript">
$(function() {
	if ('<%=status%>' == 2) {
		optionDefaultSelect(document.getElementsByName("robotChat"), '<%=robotChat%>');
		optionDefaultSelect(document.getElementsByName("translate"),
				'<%=translate%>');
		optionDefaultSelect(document.getElementsByName("weather"),
				'<%=weather%>');
		optionDefaultSelect(document.getElementsByName("express"),
				'<%=express%>');
		optionDefaultSelect(document.getElementsByName("textChat"),
				'<%=textChat%>');
	} else {
		$(":button").attr("disabled", true);
	}

	$("input[type=radio]").change(function() {
		open_Close(this.name, this.value);
	});
});

function open_Close(filed, value) {
	var url = "/mngs/account?ac=openOrClose&token=<%=token%>";
	$.post(url, {
		accountId : '<%=accountId%>',
		filed : filed
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			optionDefaultSelect(document.getElementsByName(filed), !value);
			optionDefaultSelect(document.getElementsByName(filed),
					!eval(value) + '');
		}
	});
}

function check() {
	var wxAccount = document.getElementsByName("wxAccount")[0].value;
	var wxName = document.getElementsByName("wxName")[0].value;
	var wxNum = document.getElementsByName("wxNum")[0].value;
	var guideUrl = document.getElementsByName("guideUrl")[0].value;

	if (guideUrl.length > 300) {
		showNotice("数据过长！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/account?ac=uptAccount&token=<%=token%>";
	$.post(url, {
		accountId : '<%=accountId%>',
		wxAccount : wxAccount,
		wxName : wxName,
		wxNum : wxNum,
		guideUrl : guideUrl
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
		} else {
			showNotice("提交成功！");
		}

		$(":button").attr("disabled", false);
		$(":button").val("保存");
	});
}
</script>
	</head>
	<body>
		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div class="left">
				<jsp:include page="/mng/menuLeft.jsp">
					<jsp:param value="" name="id" />
				</jsp:include>
			</div>

			<div class="right">
				<div class="title">
					基本配置
				</div>
				<div style="padding: 20px;">

					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									原始ID
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="wxAccount" value="<%=wxAccount%>"
										class="input_text" size="30" readonly="readonly">
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									微信号
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="wxNum" value="<%=wxNum%>"
										class="input_text" size="30" readonly="readonly">
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									账号名称
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="wxName" value="<%=wxName%>"
										class="input_text" size="30" readonly="readonly">
									<span class="textSpan"></span>
								</td>
							</tr>
							<%
								if (status == 2) {
							%>
							<tr>
								<td class="form_title">
									引导关注的文章地址
								</td>
								<td>
									<input type="text" name="guideUrl" value="<%=guideUrl%>"
										class="input_text" size="50">
									<br />
									<span class="textSpan">用于引导用户关注账号</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									搭讪
								</td>
								<td>
									<input type="radio" name="textChat" value="true">
									开
									<input type="radio" name="textChat" value="false">
									关
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									陪聊
								</td>
								<td>
									<input type="radio" name="robotChat" value="true">
									开
									<input type="radio" name="robotChat" value="false">
									关
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									天气
								</td>
								<td>
									<input type="radio" name="weather" value="true">
									开
									<input type="radio" name="weather" value="false">
									关
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									快递
								</td>
								<td>
									<input type="radio" name="express" value="true">
									开
									<input type="radio" name="express" value="false">
									关
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									翻译
								</td>
								<td>
									<input type="radio" name="translate" value="true">
									开
									<input type="radio" name="translate" value="false">
									关
									<span class="textSpan"></span>
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<td class="form_title">
								</td>
								<td>
									<input type="button" value="保存" class="input_button"
										onclick="check();">
									<div id="erromsg" style="display: inline;"></div>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
