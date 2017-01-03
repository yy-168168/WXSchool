<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
	String topicId = request.getParameter("topicId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 表白墙</title>

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
		<script type="text/javascript" src="static_/mng.js?v=3.1">
</script>

		<script type="text/javascript">
function deleteBb(voteId) {
	syncSubmit("/mngs/bb?ac=deleteBb&token=<%=token%>&voteId=" + voteId);
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
					表白墙管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<div
						style="margin-bottom: 15px; border-radius: 5px; padding: 8px 10px; background-color: #eee;">
						自定义回复表白墙地址链接：/mobile/love?ac=list&topicId=<%=topicId%>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th width="70px">
									楼层
								</th>
								<th style="min-width: 130px">
									昵称
								</th>
								<th>
									表白内容
								</th>
								<th width="50px"
									onclick="location='/mngs/bb?ac=list&token=<%=token%>&orderBy=spn'">
									支持
								</th>
								<th width="50px"
									onclick="location='/mngs/bb?ac=list&token=<%=token%>&orderBy=opn'">
									反对
								</th>
								<th width="50px">
									回复
								</th>
								<th width="130px">
									发布时间
								</th>
								<th width="90px">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Vote> bbs = (List<Vote>) request.getAttribute("bbs");
							for (int i = 0; bbs != null && i < bbs.size(); i++) {
								Vote bb = bbs.get(i);
						%>
						<tr align="center">
							<td>
								#<%=bb.getNum()%>
							</td>
							<td>
								<%=bb.getName()%>
							</td>
							<td align="left">
								<%=bb.getContent()%>
							</td>
							<td>
								<%=bb.getSupportNum()%>
							</td>
							<td>
								<%=bb.getOpposeNum()%>
							</td>
							<td>
								<%=bb.getReplyNum()%>
							</td>
							<td>
								<%=bb.getAddTime()%>
							</td>
							<td>
								<a
									href="/mngs/bb?ac=listReply&token=<%=token%>&voteId=<%=bb.getVoteId()%>">回复管理</a>
								<br />
								<a href="javascript:deleteBb('<%=bb.getVoteId()%>');">删除</a>
								<a href="javascript:insertBlack('<%=token %>', '<%=bb.getUserwx()%>', 2)">拉黑</a>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/bb" name="loc" />
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
