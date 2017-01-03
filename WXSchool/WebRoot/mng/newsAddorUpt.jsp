<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%@page import="java.net.URLDecoder"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String token = request.getParameter("token");
	String ac = request.getParameter("ac");
	String keyword = "", title = "", picUrl = "", locUrl = "", desc = "", artId = "-1", rank = "1";
	Article article = (Article) request.getAttribute("article");
	if (article != null) {
		keyword = article.getKeyword();
		title = article.getTitle();
		picUrl = article.getPicUrl();
		locUrl = article.getLocUrl();
		locUrl = URLDecoder.decode(locUrl, "UTF-8");
		desc = article.getDesc();
		rank = article.getRank() + "";
		artId = article.getArticleId() + "";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 自定义图文回复</title>

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
	var keyword = document.getElementsByName("keyword")[0].value;
	var title = document.getElementsByName("title")[0].value;
	var picUrl = document.getElementsByName("picUrl")[0].value;
	var locUrl = document.getElementsByName("locUrl")[0].value;
	var desc = document.getElementsByName("desc")[0].value;
	var rank = document.getElementsByName("rank")[0].value;

	if ($.trim(keyword) == "" || $.trim(title) == "" || $.trim(locUrl) == "" || $.trim(rank) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (keyword.length > 50 || title.length > 100 || picUrl.length > 400
			|| locUrl.length > 400 || desc.length > 200 || rank > 100) {
		showNotice("数据过长！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/ns?ac=<%=ac%>&token=<%=token%>";
	$.post(url, {
		artId : '<%=artId%>',
		keyword : keyword,
		title : title,
		picUrl : picUrl,
		locUrl : encodeURI(locUrl),
		desc : desc,
		rank : rank
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
					添加/更新图文回复
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
									<input type="text" name="keyword" value="<%=keyword%>"
										class="input_text" size="30">
									<span class="textSpan">多个关键字之间用|隔开</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									图文标题
									<span class="myrequired">*</span>
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
							<%
								if (picUrl != null && !picUrl.equals("")) {
							%>
							<tr>
								<td></td>
								<td>
									<img alt="" src="<%=picUrl%>" width="260px"
										style="border: 1px solid #EEE">
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<td class="form_title">
									图文地址<span class="myrequired">*</span>
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
									<textarea name="desc" class="textarea" cols="50" rows="6"
										style="resize: none;"><%=desc%></textarea>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									顺序
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="rank" value="<%=rank%>"
										class="input_text" size="50">
									<br />
									<span class="textSpan">数字(0-100)越大越排在前面</span>
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
