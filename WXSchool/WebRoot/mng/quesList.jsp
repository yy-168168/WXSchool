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

		<title>微接口 - 树洞</title>

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
function deleteQues(quesId) {
	syncSubmit("/mngs/shit?ac=deleteQues&token=<%=token%>&quesId=" + quesId);
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
					帖子管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<div
						style="margin-bottom: 15px; border-radius: 5px; padding: 8px 10px; background-color: #eee;">
						自定义回复树洞地址链接：/mobile/reply?ac=listshit&topicId=<%=topicId%>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th width="">
									帖子内容
								</th>
								<th width="10%"
									onclick="location='/mngs/shit?ac=list&token=<%=token%>&topicId=<%=topicId%>&orderBy=2'">
									回复数
								</th>
								<th width="10%"
									onclick="location='/mngs/shit?ac=list&token=<%=token%>&topicId=<%=topicId%>&orderBy=3'">
									点击数
								</th>
								<th width="19%">
									发布/更新时间
								</th>
								<th width="12%">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Question> quess = (List<Question>) request
									.getAttribute("quess");
							for (int i = 0; quess != null && i < quess.size(); i++) {
								Question ques = quess.get(i);
						%>
						<tr align="center">
							<td align="left">
								<%=ques.getContent()%>
							</td>
							<td>
								<%=ques.getReplyNum()%>
							</td>
							<td>
								<%=ques.getVisitPerson()%>
							</td>
							<td>
								<%=ques.getPubTime()%>
								<br />
								<%=ques.getUptTime()%>
							</td>
							<td>
								<a
									href="/mngs/shit?ac=listReply&token=<%=token%>&quesId=<%=ques.getQuesId()%>">回复管理</a>
								<br />
								<a href="javascript:deleteQues('<%=ques.getQuesId()%>');">删除</a>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/shit" name="loc" />
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
