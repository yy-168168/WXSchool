<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String aId = request.getParameter("aId");
	String status = request.getParameter("status");
	String type = request.getParameter("type");
	String company = request.getParameter("company");

	Page p = (Page) request.getAttribute("page");
	int curPage = 1, totalPage = 1, totalRecord = 0;
	if (p != null) {
		totalRecord = p.getTotalRecord();
		curPage = p.getCurPage();
		totalPage = p.getTotalPage();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>物流清单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<style type="text/css">
.title {
	width: 90px;
	vertical-align: top;
	font-weight: bold;
}

.con {
	line-height: 1.4
}
</style>
		<script type="text/javascript">
$(function() {
	checkMM();

	optionDefaultSelect($("#company").children(), '<%=company%>');

	if ('<%=curPage%>' == 1 && '<%=status%>' == "null") {
		updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	}
});

function selectCompany(obj) {
	if (obj.value != "") {
		window.location.href = "/mobile/bookbns?ac=list&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>&company="
				+ obj.value + "&type=<%=type%>&status=<%=status%>";
	}
}

function changeStatus(id_, obj) {
	var url = "/mobile/bookbns?ac=toHasPickup&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.get(url, {
		orderId : id_
	}, function(data) {
		if (data == "true") {
			$(obj).parent().html("已取件");
		}
	});
}
</script>
	</head>

	<body>
		<div>
			<select class="html5input_n" name="company" id="company"
				onchange="selectCompany(this);">
				<option value="">
					快递公司
				</option>
				<%
					String[] expressCompany = Dqorder.getExpressCompany();
					for (int i = 0; i < expressCompany.length; i++) {
						String companyName = expressCompany[i];
				%>
				<option value="<%=companyName%>">
					<%=companyName%>
				</option>
				<%
					}
				%>
			</select>
		</div>

		<%
			List<Dqorder> orders = (List<Dqorder>) request
					.getAttribute("orders");
			for (int i = 0; orders != null && i < orders.size(); i++) {
				Dqorder order = orders.get(i);
		%>
		<div class="html5yj" style="padding: 8px 10px;">
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="title">
						下单时间：
					</td>
					<td class="con">
						<%=order.getPubTime()%>
					</td>
				</tr>
				<tr>
					<td class="title">
						快递信息：
					</td>
					<td class="con">
						<%=order.getName()%>→<%=order.getTel()%>→<%=order.getCompany()%>→<%=order.getInfo()%>→<%=order.getLoc_time()%>
					</td>
				</tr>
				<tr>
					<td class="title">
						配送信息：
					</td>
					<td class="con">
						<%=order.getAddress()%>→<%=order.getSendTime()%>
					</td>
				</tr>
				<tr>
					<td class="title">
						状态：
					</td>
					<td class="con">
						<%
							if (order.getStatus() == 0) {
						%>
						<input type="button" value="领单"
							onclick="changeStatus('<%=order.getOrderId()%>',this);">
						<%
							} else {
						%>
						已取件
						<%
							}
						%>
					</td>
				</tr>
			</table>
		</div>
		<%
			}
		%>

		<div style="margin-top: 20px;">
			<%
				String url = "/mobile/bookbns?ac=list&userwx=" + userwx
						+ "&wxaccount=" + wxaccount + "&company=" + company
						+ "&type=" + type + "&status=" + status;
			%>
			<div class="page">
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
		</div>

		<jsp:include page="../common/copyright.jsp" />

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<%
						String urlsort = "/mobile/bookbns?ac=list&wxaccount=" + wxaccount
								+ "&userwx=" + userwx + "&type=" + type + "&status=";
					%>
					<td width="32%" style="border-right: 1px solid #666"
						onclick="location='<%=urlsort%>no'">
						未取件
					</td>
					<td width="32%" style="border-right: 1px solid #666"
						onclick="location='<%=urlsort%>my'">
						我的取件
					</td>
					<td onclick="location='<%=urlsort%>all'">
						所有订单
					</td>
				</tr>
			</table>
		</div>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
