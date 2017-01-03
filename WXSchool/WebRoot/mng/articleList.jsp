<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
%>
<%
	String wxid = (String) request.getAttribute("wxid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 素材管理</title>

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

	if (keyword == "") {
		return false;
	}
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
					素材管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<div style="text-align: right; margin-bottom: 15px;">
						<form id="search" method="get" action="/mngs/article">
							<input type="hidden" name="ac" value="search">
							<input type="hidden" name="token" value="<%=token%>">
							<input type="text" size="20" maxlength="20" name="keyword">
							<input type="submit" value="搜索" onclick="return check();">
						</form>
					</div>
					<div
						style="margin-bottom: 15px; border-radius: 5px; padding: 8px 10px; background-color: #eee;">
						自定义回复分类文章地址链接：/articles?ac=getArticles&wxaccount=<%=wxid%>&cate=类别名称
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th style="min-width: 180px">
									关键字
								</th>
								<th>
									文章标题
								</th>
								<th width="70px">
									访问量
								</th>
								<th width="80px">
									类别
								</th>
								<th width="130px">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Article> articles = (List<Article>) request
									.getAttribute("articles");
							for (int i = 0; articles != null && i < articles.size(); i++) {
								Article article = articles.get(i);
						%>
						<tr align="center">
							<td>
								<%=article.getKeyword()%>
							</td>
							<td align="left">
								<%=article.getTitle()%>
							</td>
							<td>
								<%=article.getVisitPerson()%>
							</td>
							<td>
								<%=article.getCate()%>
							</td>
							<td>
								<a title="编辑详细信息"
									href="/mngs/article?ac=getArt&token=<%=token%>&artId=<%=article.getArticleId()%>">编辑</a>
								<%
									if (article.getStatus() == 1) {
								%>
								<a title="关闭之后，不会自动回复此消息，可用于暂时不用以后要启用的消息"
									href="javascript:changeStatus_('<%=article.getArticleId()%>',0);">关闭</a>
								<%
									} else if (article.getStatus() == 0) {
								%>
								<a title="开启之后，会自动回复此消息，用于开启关闭过的消息"
									href="javascript:changeStatus_('<%=article.getArticleId()%>',1);">开启</a>
								<%
									}
								%>
								<a title="永久删除"
									href="javascript:changeStatus_('<%=article.getArticleId()%>',-1);">删除</a>
								<script type="text/javascript">
function changeStatus_(id, status) {
	syncSubmit("/mngs/article?ac=changeStatus&token=<%=token%>&artId=" + id
			+ "&status=" + status);
	window.location.reload();
}
</script>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<input type="button" value="新增素材" class="input_button"
							onclick="location='/mngs/article?ac=addArt_&token=<%=token%>'">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/article" name="loc" />
							</jsp:include>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
