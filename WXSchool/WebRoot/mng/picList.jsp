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
	String edit = (String)request.getAttribute("edit");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 自定义图片回复</title>

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
					图片回复
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<div style="text-align: right; margin-bottom: 15px;">
						<form id="search" method="get" action="/mngs/pic">
							<input type="hidden" name="ac" value="search">
							<input type="hidden" name="token" value="<%=token%>">
							<input type="text" size="20" maxlength="20" name="keyword">
							<input type="submit" value="搜索" onclick="return check();">
						</form>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th style="min-width: 180px">
									关键字
								</th>
								<th>
									标题
								</th>
								<th width="70px">
									访问量
								</th>
								<th width="130px">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Pic> pics = (List<Pic>) request.getAttribute("pics");
							for (int i = 0; pics != null && i < pics.size(); i++) {
								Pic pic = pics.get(i);
						%>
						<tr align="center">
							<td>
								<%=pic.getKeyword()%>
							</td>
							<td align="left">
								<%=pic.getTitle()%>
							</td>
							<td>
								<%=pic.getVisitPerson()%>
							</td>
							<td>
								<a
									href="/mngs/pic?ac=getPic&token=<%=token%>&picId=<%=pic.getPicId()%>">编辑</a>
								<a href="javascript:delete_('<%=pic.getPicId()%>');">删除</a>
								<script type="text/javascript">
function delete_(id) {
	syncSubmit("/mngs/pic?ac=delete_&token=<%=token%>&picId=" + id);
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
						<% if(edit != null && edit.indexOf("add") > -1){
							%>
							<input type="button" value="新增图片回复" class="input_button" onclick="location='/mngs/pic?ac=addPic_&token=<%=token%>'">
							<%
							} 
						%>
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/pic" name="loc" />
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
