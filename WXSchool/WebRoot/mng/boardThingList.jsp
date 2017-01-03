<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String token = request.getParameter("token");
	String wxid = (String) request.getAttribute("wxid");
	int topicId = (Integer) request.getAttribute("topicId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 寻物招领</title>

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
function deleteBT(id_) {
	syncSubmit("/mngs/board?ac=deleteBt&token=<%=token%>&boardId=" + id_);
	window.location.reload();
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
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<div
						style="margin-bottom: 15px; border-radius: 5px; padding: 8px 10px; background-color: #eee;">
						自定义回复寻物招领链接地址：<%=basePath_nop%>/mobile/board?ac=listthing&wxaccount=<%=wxid%>&topicId=<%=topicId%>
						<span style="float: right"></span>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th>
									内容
								</th>
								<th width="110px">
									手机号
								</th>
								<th width="130px">
									发布时间
								</th>
								<th width="70px">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Board> boards = (List<Board>) request.getAttribute("boards");
							for (int i = 0; boards != null && i < boards.size(); i++) {
								Board board = boards.get(i);
						%>
						<tr align="center">
							<td align="left">
								<%=board.getContent()%>
							</td>
							<td>
								<%=board.getContact()%>
							</td>
							<td>
								<%=board.getPubTime()%>
							</td>
							<td>
								<a href="javascript:deleteBT('<%=board.getBoardId()%>');">删除</a>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/board" name="loc" />
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
