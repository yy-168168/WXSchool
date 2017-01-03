<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>四六级查询</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link href="static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/mycommon.js">
</script>
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">
function check() {
	var card = document.getElementsByName("card")[0].value;
	var username = document.getElementsByName("username")[0].value;

	if ($.trim(card) == "" || $.trim(username) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	if (card.length != 15) {
		$("#msg").text("准考证号为15位");
		return false;
	}

	if (username.length > 3) {
		$("#msg").text("只能输入姓名前三位");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");
	$("form").submit();
}
</script>
	</head>

	<body onload="checkMM();" onunload="resetAll();">

		<!-- 
		<div style="margin-top: 10px">
			<form action="ss?ac=cet&tp=2" method="post" name="form">
				<div style="line-height: 1.7">
					准考证号：
					<input type="text" name="card" class="html5input"
						onclick="clearMsg();">
					姓名的前三个字:
					<input type="text" name="username" class="html5input"
						onclick="clearMsg();">
				</div>

				<div id="msg" style="font-size: 13px; height: 20px; color: red;"></div>
				<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
				<input type="button" value="提交" class="html5btn" onclick="check();">
			</form>
		</div>
		 -->

		<form action="ss?ac=cet&tp=2" method="post" name="form">
			<div class="html5yj">
				<div class="formhead">
					四六级查询
				</div>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="text">
							准考证号：
						</td>
						<td class="input">
							<input type="text" name="card" class="html5input"
								onclick="clearMsg();">
						</td>
					</tr>
					<tr>
						<td class="text">
							姓名的前三个字：
						</td>
						<td class="input">
							<input type="text" name="username" class="html5input"
								onclick="clearMsg();">
						</td>
					</tr>
				</table>
			</div>

			<div id="msg"></div>
			<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
			<input type="button" value="提交" class="html5btn" onclick="check();">
		</form>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
