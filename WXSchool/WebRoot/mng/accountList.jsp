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
					</div>
				</div>
				<div class="list">
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th>
									平台名称
								</th>
								<th width="11%">
									微信号
								</th>
								<th width="14%">
									原始ID
								</th>
								<th width="8%">
									关注量
								</th>
								<th width="18%">
									相关参数
								</th>
								<th width="6%">
									是否<br/>认证
								</th>
								<th width="19%">
									注册时间<br/>/状态
								</th>
								<th width="8%">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Account> accounts = (List<Account>) request.getAttribute("accounts");
							for (int i = 0; accounts != null && i < accounts.size(); i++) {
								Account account = accounts.get(i);
						%>
						<tr align="center">
							<td>
								<%=account.getWxName()%>
							</td>
							<td>
								<%=account.getWxNum()%>
							</td>
							<td>
								<%=account.getWxAccount()%>
							</td>
							<td>
								<%=account.getFans()%>
							</td>
							<td>
								appId:<%=account.getAppId()%>
							</td>
							<td>
								<%=account.isAuth()?"是":"否"%>
							</td>
							<td>
								<%=account.getRegTime()%>
								<br />
								<% int status = account.getStatus();%>
								<%= status==-1?"已删除":status==1?"部分接入":"全部接入" %>
							</td>
							<td>
								<a href="/mngs/admin?ac=list&token=<%=token%>&wxaccount=<%=account.getWxAccount()%>">管理员</a>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/account" name="loc" />
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
