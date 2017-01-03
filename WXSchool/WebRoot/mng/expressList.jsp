<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
	String type = request.getParameter("type");
	String company = request.getParameter("company");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 快递清单</title>

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
	syncSubmit("/mngs/bookbns?ac=delete_&token=<%=token%>&orderId=" + id_);
	window.location.reload();
}
</script>
	</head>

	<body>
		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div class="left">
				<jsp:include page="/mng/menuLeft.jsp"></jsp:include>
			</div>

			<div class="right">
				<div class="title">
					清单管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th width="15%">
									姓名<br />手机号
								</th>
								<th width="7.5%">
									快递<br />公司
								</th>
								<th>
									取件地址
								</th>
								<th width="12%">
									物品信息
								</th>
								<th width="12.5%">
									配送地址
								</th>
								<th width="14%">
									配送时间
								</th>
								<th width="13%">
									下单时间
								</th>
								<th width="9%">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Dqorder> orders = (List<Dqorder>) request
																	.getAttribute("orders");
															for (int i = 0; orders != null && i < orders.size(); i++) {
																Dqorder order = orders.get(i);
						%>
						<tr align="center">
							<td>
								<%=order.getName()%><br /><%=order.getTel()%>
							</td>
							<td>
								<%=order.getCompany()%>
							</td>
							<td>
								<%=order.getLoc_time()%>
							</td>
							<td>
								<%=order.getInfo()%>
							</td>
							<td>
								<%=order.getAddress()%>
							</td>
							<td>
								<%=order.getSendTime()%>
							</td>
							<td>
								<%=order.getPubTime()%>
							</td>
							<td>
								<%
									if (order.getStatus() == 1) {
								%>
								<span>已取件</span>
								<%
									} else {
								%>
								<a href="javascript:delete_('<%=order.getOrderId()%>');">删除</a>
								<%
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
								<jsp:param value="/mngs/bookbns" name="loc" />
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
