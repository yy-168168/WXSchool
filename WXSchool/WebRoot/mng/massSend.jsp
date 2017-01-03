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
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 群发助手</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico"
			type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico"
			type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/mng.js">
</script>

		<script type="text/javascript">
function check() {
	var content = document.getElementsByName("content")[0].value;
	var condition = document.getElementsByName("condition")[0].value;

	if (content == "") {
		return false;
	}

	if (!window.confirm("群发信息很耗性能，群发过程需要一段时间，并且可能对用户造成影响，请慎重操作")) {
		return false;
	}

	if (content.length > 500) {
		showNotice("群发内容不能超过500字");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/mass?ac=send&token=<%=token%>";
	$.post(url, {
		content : content,
		condition : condition
	}, function(msg) {
		document.getElementsByName("content")[0].value = "";
		$(":button").val("群发成功");
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
					群发助手
				</div>
				<div style="padding: 20px;">

					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									群发内容
								</td>
								<td>
									<textarea name="content" class="textarea" cols="50" rows="10"
										style="resize: none;"></textarea>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									群发条件
								</td>
								<td>
									<textarea name="condition" class="textarea" cols="50" rows="5"
										style="resize: none;"></textarea>
									<br/>
									<span class="textSpan">可不填，不填时给48小使用了平台的用户群发</span>
								</td>
							</tr>
							<tr>
								<td class="form_title"></td>
								<td>
									<input type="button" value="群发" class="input_button"
										onclick="check();">
									<span class="textSpan">（建议少群发）</span>
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
