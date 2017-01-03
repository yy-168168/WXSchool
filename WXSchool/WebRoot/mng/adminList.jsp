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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 账号管理</title>

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
function delete_(id_) {
	syncSubmit("/mngs/admin?ac=delete_&token=<%=token%>&userwx=" + id_);
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
					账号管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div class="list">
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th>
									密码
								</th>
								<th width="10%">
									级别
								</th>
								<th width="14%">
									限量
								</th>
								<th width="20%">
									注册/最终时间
								</th>
								<th width="8%">
									状态
								</th>
								<th width="13%">
									操作
								</th>
								<th width="13%">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Admin> admins = (List<Admin>) request.getAttribute("admins");
							for (int i = 0; admins != null && i < admins.size(); i++) {
								Admin admin = admins.get(i);
						%>
						<tr align="center">
							<td>
								<%=admin.getKey()%>
							</td>
							<td>
								<%=admin.getType()%>
							</td>
							<td>
								二手：<%=admin.getMaxUsedNum()%>
								<br />
								新品：<%=admin.getMaxBoxNum()%>
								<br />
								餐馆：<%=admin.getMaxResNum()%>
							</td>
							<td>
								<%=admin.getRegTime()%>
								<br />
								<%=admin.getLastTime()%>
							</td>
							<td>
								<% int status = admin.getStatus();%>
								<%= status==-1?"已删除":status==0?"离线":"在线" %>
							</td>
							<td>
								<% if(status != -1){
										%>
										<a href="/mngs/login?ac=index&token=<%=admin.getToken()%>"
										target="_blank">进入平台</a>
										<br />
										<a href="javascript:void();">权限分配</a>
										<%
									} else {
										%>进入平台<br/>权限分配<%
									}
								%>
							</td>
							<td>
								<%
									if(status != -1 ){
										%>
											<a href="javascript:void();">编辑</a>
											<a href="javascript:delete_('<%=admin.getUserwx()%>');">删除</a>
										<%
									}else {
										%>编辑&nbsp;&nbsp;删除<%
									}
								%>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/admin" name="loc" />
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
