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

		<title>微接口 - 照片活动</title>

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
	function delete_(topicId) {
		syncSubmit("/mngs/topic?ac=delete_&token=<%=token%>&topicId=" + topicId);
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
					照片活动管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th style="min-width: 180px">
									活动名称
								</th>
								<th width="90px">
									参与人数
								</th>
								<th width="80px">
									容量(张)
								</th>
								<th>
									简要说明
								</th>
								<th width="130px">
									创建/结束时间
								</th>
								<th width="90px">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Topic> topics = (List<Topic>) request.getAttribute("topics");
							for (int i = 0; topics != null && i < topics.size(); i++) {
								Topic topic = topics.get(i);
								
								if(topic.getCate() == 20){
									%>
									<tr align="center">
										<td align="left">
											<a href="/mngs/picw?ac=list&token=<%=token%>">照片收集库</a>
										</td>
										<td>
											无
										</td>
										<td>
											无
										</td>
										<td>
											收集用户在公众号聊天界面发送的所有照片
										</td>
										<td>
											永久
										</td>
										<td>
											无
										</td>
									</tr>
									<%
								}else{
									%>
									<tr align="center">
										<td align="left">
											<a
												href="/mngs/bygl?ac=list&token=<%=token%>&topicId=<%=topic.getTopicId()%>"><%=topic.getTitle()%></a>
										</td>
										<td>
											<%=topic.getPersonNum()%>
										</td>
										<td>
											<%=topic.getCapacity()%>
										</td>
										<td>
											<%=topic.getInfo()%>
										</td>
										<td>
											<%=topic.getPubTime()%><br />
											<%
												String ot = topic.getOverTime();
													if ("3000-01-01 00:00".equals(ot)) {
														ot = "长期有效";
													}
											%>
											<%=ot%>
										</td>
										<td>
											<a href="/mngs/topic?ac=getTopic&token=<%=token%>&topicId=<%=topic.getTopicId()%>">编辑</a>
											<a href="javascript:delete_('<%=topic.getTopicId()%>');">删除</a>
										</td>
									</tr>
									<%
								}
							}
						%>

					</table>

					<div style="margin-top: 15px;">
						<% if(edit != null && edit.indexOf("add") > -1){
								%>
								<input type="button" value="新增照片活动" class="input_button"
									onclick="location='/mngs/topic?ac=addTopic_&token=<%=token%>'">
								<%
							} 
						%>
						<div style="clear: both;"></div>
					</div>
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
