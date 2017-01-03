<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String cate = request.getParameter("cate");
	String orderBy = request.getParameter("orderBy");
	String aId = request.getParameter("aId");

	Page p = (Page) request.getAttribute("page");
	int curPage = 1, totalPage = 0;
	if (p != null) {
		curPage = p.getCurPage();
		totalPage = p.getTotalPage();
	}

	String title = cate;
	if (cate != null && cate.equals("all")) {
		title = "所有文章";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title><%=title%></title>

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
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<style type="text/css">
.artbox img {
	border-radius: 3px;
}

.artbox .text {
	position: absolute;
	z-index: 10;
	font-size: 14px;
	bottom: 0px;
	background-color: #000;
	opacity: 0.6;
	color: #fff;
	border-bottom-left-radius: 3px;
	border-bottom-right-radius: 3px;
	width: 100%;
}
</style>
		<script type="text/javascript">
$(function(){
	checkMM();
	
	if(<%=curPage%> == 1 && '<%=orderBy%>' == "null"){
		updateArticleVisitPerson('<%=wxaccount%>','<%=aId%>');
	}
});
</script>
	</head>

	<body>
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideToolbar');
});
</script>

		<%
			List<Article> articles = (List<Article>) request
					.getAttribute("articles");

			for (int i = 0; i < 0; i++) {//之前的展示方式
				Article art = articles.get(i);
		%>
		<div class="view_box_white"
			onclick="location='/mobile/article?ac=getArticleDt&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=<%=art.getArticleId()%>'">
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td rowspan="2" width="33%">
						<img alt="" src="<%=art.getPicUrl()%>" width="90%" height="56px">
					</td>
					<td>
						<span style="color: #103261;"><%=art.getTitle()%></span>
					</td>
				</tr>
				<tr>
					<td align="right" valign="bottom"
						style="font-size: 12px; color: #999;">
						<%--<img alt="" src="static_/vp2.png" height="14px" style="vertical-align: middle; opacity: 0.4;">--%>
						<span class='glyphicon glyphicon-user'></span>
						<span><%=art.getVisitPerson()%></span>
					</td>
				</tr>
			</table>
		</div>
		<%
			}
		%>

		<%
			if (articles != null) {
				int size = articles.size();
		%>
		<div id="left" style="float: left; width: 49%; margin-top: -10px;">
			<%
				for (int i = 0; i < size; i += 2) {
						Article art = articles.get(i);
			%>
			<div class="artbox" style="margin-top: 10px;"
				onclick="location='/mobile/article?ac=getArticleDt&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=<%=art.getArticleId()%>'">
				<div style="position: relative;">
					<img alt='' src='<%=art.getPicUrl()%>' width='100%'>
					<div class="text">
						<div style="padding: 5px">
							<span><%=art.getTitle()%></span>
							<%--<span style="float: right; padding-left: 8px;"> <span
								class='glyphicon glyphicon-user' style="font-size: 11px;"></span><span
								style="font-size: 12px;"><%=art.getVisitPerson()%></span> </span>--%>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<div id="right" style="float: right; width: 49%; margin-top: -10px;">
			<%
				for (int i = 1; i < size; i += 2) {
						Article art = articles.get(i);
			%>
			<div class="artbox" style="margin-top: 10px;"
				onclick="location='/mobile/article?ac=getArticleDt&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=<%=art.getArticleId()%>'">
				<div style="position: relative;">
					<img alt='' src='<%=art.getPicUrl()%>' width='100%'>
					<div class="text">
						<div style="padding: 5px">
							<span><%=art.getTitle()%></span>
							<%--<span style="float: right; padding-left: 8px;"> <span
								class='glyphicon glyphicon-user' style="font-size: 11px;"></span><span
								style="font-size: 12px;"><%=art.getVisitPerson()%></span> </span>--%>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<div style="clear: both;"></div>
		<%
			}
		%>

		<%
			String url = "/mobile/article?ac=getArticles&cate=" + cate + "&userwx="
					+ userwx + "&wxaccount=" + wxaccount + "&orderBy="
					+ orderBy;
		%>
		<div class="page" style="margin-top: 10px">
			<div class="page_left">
				<div class="page_first"
					onclick="return paging('first','<%=curPage%>','<%=totalPage%>','<%=url%>');">
					首页
				</div>
				<div class="page_pre"
					onclick="return paging('pre','<%=curPage%>','<%=totalPage%>','<%=url%>');">
					上一页
				</div>
			</div>
			<div class="page_cen">
				<%=curPage%>/<%=totalPage%>
			</div>
			<div class="page_right">
				<div class="page_next"
					onclick="return paging('next','<%=curPage%>','<%=totalPage%>','<%=url%>');">
					下一页
				</div>
				<div class="page_end"
					onclick="return paging('end','<%=curPage%>','<%=totalPage%>','<%=url%>');">
					尾页
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>

		<jsp:include page="copyright.jsp" />

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<%
						String url_ = "/mobile/article?ac=getArticles&cate=all&wxaccount="
								+ wxaccount + "&userwx=" + userwx + "&orderBy=";
					%>
					<td width="35%" style="border-right: 1px solid #666"
						onclick="location='<%=url_%>1'">
						随便看看
					</td>
					<td width="35%" style="border-right: 1px solid #666"
						onclick="location='<%=url_%>2'">
						最热
					</td>
					<td
						onclick="showScreenNotice_text('『分享是一种精神  感谢您的来稿』<br/>投稿方式：<br />1、如果你在朋友圈、公众号、网页上看到优质文章，可将原文链接转发给我们；<br />2、如果你手头有优质文章，在聊天界面回复【投稿】获取投稿邮箱。<br />	投稿请注明：姓名+专业+联系方式');">
						投稿
					</td>
				</tr>
			</table>
		</div>

		<%@ include file="toolbar.html"%>
		<%@ include file="tongji.html"%>
	</body>
</html>
