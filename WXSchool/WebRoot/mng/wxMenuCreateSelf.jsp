<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 自定义菜单</title>

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
	var appId = document.getElementsByName("appId")[0].value;
	var appSecret = document.getElementsByName("appSecret")[0].value;
	var body = document.getElementsByName("body")[0].value;

	if ($.trim(appId) == "" || $.trim(appSecret) == "" || $.trim(body) == "") {
		showNotice("不能为空！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/wxmn?ac=createSelf&token=<%=token%>";
	$.post(url, {
		appId : appId,
		appSecret : appSecret,
		body : body
	}, function(msg) {
		if (msg == "ok") {
			showNotice("提交成功！");
		} else if (msg == "wrong1") {
			showNotice("AppId或者AppSecret不正确！");
		} else if (msg == "wrong2") {
			showNotice("菜单数据格式不对！");
		} else {
			showNotice(msg);
		}
	});

	$(":button").attr("disabled", false);
	$(":button").val("创建");
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
					自定义菜单生成
				</div>
				<div style="padding: 20px;">

					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									AppId
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="appId" value="" class="input_text"
										size="50">
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									AppSecret
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="appSecret" value="" class="input_text"
										size="50">
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									菜单数据
									<span class="myrequired">*</span>
								</td>
								<td>
									<textarea rows="18" cols="60" name="body" style="resize: none"></textarea>
								</td>
							</tr>
							<tr>
								<td class="form_title">
								</td>
								<td>
									<input type="button" value="创建" class="input_button"
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
