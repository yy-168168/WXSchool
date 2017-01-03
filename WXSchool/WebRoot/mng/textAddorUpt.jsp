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
	String ac = request.getParameter("ac");
	String key = "", value = "", textId = "-1";
	Text text = (Text) request.getAttribute("text");
	if (text != null) {
		key = text.getKey();
		value = text.getValue();
		textId = text.getTextId() + "";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 自定义文字回复</title>

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
function check() {
	var key = document.getElementsByName("key")[0].value;
	var value = document.getElementsByName("value")[0].value;

	if ($.trim(key) == "" || $.trim(value) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (key.length > 100 || value.length > 500) {
		showNotice("数据过长！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/text?ac=<%=ac%>&token=<%=token%>";
	$.post(url, {
		textId : '<%=textId%>',
		key : key,
		value : value
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
			$(":button").attr("disabled", false);
			$(":button").val("保存");
		} else {
			if ('<%=ac%>'.indexOf("add") >= 0) {
				isGoonUpt();
			} else {
				window.location.href = document.referrer;
			}
		}
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
					添加/更新文字回复
					<div style="float: right">
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div style="padding: 20px;">

					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									关键字
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="key" value="<%=key%>"
										class="input_text" size="30">
									<span class="textSpan">多个关键字之间用|隔开</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									回复内容
									<span class="myrequired">*</span>
								</td>
								<td>
									<textarea name="value" class="textarea" cols="50" rows="10"
										style="resize: none;"><%=value%></textarea>
								</td>
							</tr>
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
