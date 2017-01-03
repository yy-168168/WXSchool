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

		<title>微接口 - 照片活动</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
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

function delete_(voteId) {
	syncSubmit("/mngs/bygl?ac=delete_&token=<%=token%>&voteId=" + voteId);
	window.location.reload();
}
</script>
	</head>

	<body>
		<jsp:include page="../mng/head.jsp"></jsp:include>

		<div class="content">
			<div class="left">
				<jsp:include page="/mng/menuLeft.jsp">
					<jsp:param value="" name="id" />
				</jsp:include>
			</div>

			<div class="right">
				<div class="title">
					照片墙管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div class="list">
					<div style="text-align: right; margin-bottom: 15px;">
						<form id="search" method="get" action="/mngs/bygl">
							<input type="hidden" name="ac" value="search">
							<input type="hidden" name="token" value="<%=token%>">
							<input type="hidden" name="topicId" value="<%=topicId%>">
							<input type="text" size="20" maxlength="20" name="keyword">
							<input type="submit" value="搜索" onclick="return check();">
						</form>
					</div>
					<div
						style="margin-bottom: 15px; border-radius: 5px; padding: 8px 10px; background-color: #eee;">
						该照片墙链接地址：<%=basePath_nop%>/mobile/vote?ac=listpic&topicId=<%=topicId%>
						<span style="float: right">必须使用图文回复形式</span>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th>
									文字描述
								</th>
								<th>
									备注
								</th>
								<th width="10%"
									onclick="location='/mngs/bygl?ac=list&token=<%=token%>&topicId=<%=topicId%>&orderBy=spn'">
									票数
								</th>
								<th width="19%">
									上传时间
								</th>
								<th width="12%">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Vote> votes = (List<Vote>) request.getAttribute("votes");
							for (int i = 0; votes != null && i < votes.size(); i++) {
								Vote vote = votes.get(i);
						%>
						<tr align="center">
							<td align="left">
								<%=vote.getName()%>
							</td>
							<td align="left">
								<%=vote.getRemark()%>
							</td>
							<td>
								<%=vote.getSupportNum()%>
							</td>
							<td>
								<%=vote.getAddTime()%>
							</td>
							<td>
								<a
									href="/mngs/bygl?ac=getBg&token=<%=token%>&voteId=<%=vote.getVoteId()%>&topicId=<%=topicId%>">编辑</a>
								<a href="javascript:delete_('<%=vote.getVoteId()%>');">删除</a>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<input type="button" value="新增照片" class="input_button"
							onclick="location='/mngs/bygl?ac=addBg_&token=<%=token%>&topicId=<%=topicId%>'">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/bygl" name="loc" />
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
