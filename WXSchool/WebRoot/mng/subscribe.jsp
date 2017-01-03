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
%>
<%
	String title = "", picUrl = "", locUrl = "", desc = "", cont = "", type = "text";
	Article article = (Article) request.getAttribute("article");
	Text text = (Text) request.getAttribute("text");
	if (article != null) {
		title = article.getTitle();
		picUrl = article.getPicUrl();
		locUrl = article.getLocUrl();
		desc = article.getDesc();
		type = article.getStatus() == 1 ? "news" : "text";
	}
	if (text != null) {
		cont = text.getValue();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 关注时回复</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<meta http-equiv="description" content="This is my page">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/mng.js">
</script>

		<script type="text/javascript">
$(function() {
	optionDefaultSelect($("input[type=radio]"), '<%=type%>');

	$("input[type=radio]").change(
			function() {
				$.post("/mngs/subscribe?ac=changeType&token=<%=token%>&type="
						+ this.value);
			});
});

function check() {
	var title = document.getElementsByName("title")[0].value;
	var picUrl = document.getElementsByName("picUrl")[0].value;
	var locUrl = document.getElementsByName("locUrl")[0].value;
	var desc = document.getElementsByName("desc")[0].value;
	var cont = document.getElementsByName("cont")[0].value;

	if (title.length > 100 || picUrl.length > 200 || locUrl.length > 200
			|| desc.length > 200 || cont.length > 500) {
		showNotice("数据过长！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/subscribe?ac=updateSubscribe&token=<%=token%>";
	$.post(url, {
		title : title,
		picUrl : picUrl,
		locUrl : locUrl,
		desc : desc,
		cont : cont
	}, function(msg) {
		$(":button").attr("disabled", false);
		window.location.reload();
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
					关注时回复
				</div>
				<div style="padding: 20px;">

					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									图文标题
								</td>
								<td>
									<input type="text" name="title" value="<%=title%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									图片外链地址
								</td>
								<td>
									<input type="text" name="picUrl" value="<%=picUrl%>"
										class="input_text" size="50">
									<br />
									<span class="textSpan">图片大小：270*150px</span>
									<a href="javascript:tuchuang();" style="font-size: 13px">获取外链</a>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									图文地址
								</td>
								<td>
									<input type="text" name="locUrl" value="<%=locUrl%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									图文描述
								</td>
								<td>
									<textarea name="desc" class="textarea" cols="50" rows="5"
										style="resize: none;"><%=desc%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<hr style="border: 1px solid #ddd; margin: 40px 50px;" />
								</td>
							</tr>
							<tr>
								<td class="form_title">
									文字回复
								</td>
								<td>
									<textarea name="cont" class="textarea" cols="50" rows="10"
										style="resize: none;"><%=cont%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<hr style="border: 1px solid #ddd; margin: 40px 50px 0px;" />
								</td>
							</tr>
							<tr>
								<td class="form_title">
									回复方式
								</td>
								<td>
									<input type="radio" name="type" value="text">
									文字回复
									<input type="radio" name="type" value="news">
									图文回复
									<span class="textSpan">(默认为文字回复)</span>
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
