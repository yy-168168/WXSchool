<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
	String month = request.getParameter("m");
	String day = request.getParameter("d");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微店 - 订单统计</title>

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

		<style type="text/css">
.ord_list {
	text-align: center;
	color: #666;
	font-size: 15px;
	height: 30px;
}

.ord_list:nth-child(even) {
	background-color: #F9F9F9;
}

.ord_list td {
	padding: 10px;
}

#statisticData td {
	background-color: #73AFD9;
	border-radius: 5px;
	color: #fff;
	text-align: center;
	font-size: 24px;
	font-weight: bold;
	padding: 10px 0;
}

#statisticData #detail td {
	border-radius: 0px;
	font-size: 14px;
	font-weight: normal;
	padding: 6px 0;
	border-bottom: 1px solid #fff;
}

#statisticData #detail tr:last-child td {
	border-bottom: 0px solid #fff;
}
</style>
		<script type="text/javascript">
$(function() {
	optionDefaultSelect($("#month").children(), '<%=month%>');

	setDayOfSelect('<%=month%>');

	optionDefaultSelect($("#day").children(), '<%=day%>');

	$("#month").change(function() {
		var month = $(this).val();
		location.href = "/wd/order?ac=list&token=<%=token%>&m=" + month + "&d=0";
	});

	$("#day").change(
			function() {
				var month = $("#month").val();
				var day = $(this).val();
				location.href = "/wd/order?ac=list&token=<%=token%>&m=" + month
						+ "&d=" + day;
			});
});

function setDayOfSelect(month) {
	var totalDay = new Date(new Date().getFullYear(), month, 0).getDate();
	var opts = "<option value='0'>所有</option>";
	if (month != 0) {
		for (i = 1; i <= totalDay; i++) {
			opts += "<option value='" + i + "'>" + i + "</option>";
		}
	}
	$("#day").html(opts);
}
</script>
	</head>

	<body>
		<div
			style="margin: -8px -8px 0 -8px; background-color: #F3F3F3; box-shadow: 0px 1px 6px #B6B6B6; min-width: 970px;">
			<div style="width: 100%; height: 5px; background-color: #67AD03;"></div>
			<div style="width: 1000px; margin: auto; padding: 10px 0;">
				<div style="float: left;">
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<img alt="" src="static_/wdlogo.png"
									style="vertical-align: middle" height="40px">
							</td>
							<td>
								<span style="font-size: 24px; font-weight: bold; color: #777;">&nbsp;微店<span
									style="font-weight: normal;">|</span>订单统计</span>
							</td>
						</tr>
					</table>
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>

		<div class="content" style="height: 450px;">
			<table width="100%" height="100%" border="0" cellpadding="0"
				cellspacing="0">
				<tr height="50px">
					<td colspan="5" align="center">
						日期：
						<select id="month" name="month"
							style="width: 80px; text-align: center;">
							<option value="0">
								所有
							</option>
							<option value="1">
								一月
							</option>
							<option value="2">
								二月
							</option>
							<option value="3">
								三月
							</option>
							<option value="4">
								四月
							</option>
							<option value="5">
								五月
							</option>
							<option value="6">
								六月
							</option>
							<option value="7">
								七月
							</option>
							<option value="8">
								八月
							</option>
							<option value="9">
								九月
							</option>
							<option value="10">
								十月
							</option>
							<option value="11">
								十一月
							</option>
							<option value="12">
								十二月
							</option>
						</select>
						<select id="day" name="day"
							style="width: 80px; text-align: center;">
						</select>
					</td>
				</tr>
				<tr height="50px">
					<td colspan="5">
						<table id="statisticData" width="100%" cellpadding="0"
							cellspacing="3" border="0">
							<tr>
								<td width="15%">
									<div style="">
										数据<br />统计
									</div>
								</td>
								<td>
									<table id="detail" width="100%" cellpadding="0" cellspacing="0"
										border="0">
										<%
											int allAmount = 0;
											double allPrice = 0;
											Object[][] datas = (Object[][]) request.getAttribute("datas");
											if (datas == null) {
										%>
										<tr>
											<td>
												出错咯，请刷新重试！
											</td>
										</tr>
										<%
											} else if (datas.length == 0) {
										%>
										<tr>
											<td>
												没有订单数据！
											</td>
										</tr>
										<%
											} else {
												for (int i = 0; datas != null && i < datas.length; i++) {
													allAmount += Integer.parseInt(datas[i][1].toString());
													allPrice += Double.parseDouble(datas[i][2].toString());
										%>
										<tr>
											<td><%=datas[i][0]%></td>
											<td width="10%"><%=datas[i][1]%></td>
											<td>
												￥<%=datas[i][2]%></td>
										</tr>
										<%
											}
											}
										%>
									</table>
								</td>
								<td width="15%">
									总数量<br /><%=allAmount%>
								</td>
								<td width="15%">
									总消费<br />￥<%=allPrice%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="10px">
					<td colspan="5"></td>
				</tr>
				<tr bgcolor="#F5F5F5" height="40px">
					<th width="18%">
						订单号
					</th>
					<th>
						订单详情
					</th>
					<th width="8%">
						数量
					</th>
					<th width="10%">
						消费
					</th>
					<th width="18%">
						验证时间
					</th>
				</tr>
				<%
					List<WdOrder> wdos = (List<WdOrder>) request.getAttribute("wdos");
					for (int i = 0; wdos != null && i < wdos.size(); i++) {
						WdOrder order = wdos.get(i);
				%>
				<tr class="ord_list">
					<td><%=order.getOrderNum()%></td>
					<td align="left">
						用户信息：<%=order.getBuyer()%><br />
						商品信息：<%=order.getItemName()%>
					</td>
					<td><%=order.getAmount()%></td>
					<td>
						￥<%=order.getTotalPrice()%></td>
					<td><%=order.getPubTime()%></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td colspan="5"></td>
				</tr>
				<tr height="50px">
					<td colspan="5" align="center"
						style="border-top: 1px solid #E5E5E5;">
						<jsp:include page="../mng/page.jsp">
							<jsp:param value="/wd/order" name="loc" />
						</jsp:include>
					</td>
				</tr>
			</table>
		</div>

		<div
			style="margin: 40px -8px -8px -8px; background: #727171; min-width: 970px;">
			<div
				style="width: 80%; margin: auto; height: 40px; line-height: 40px; text-align: center; color: #DDD; font-size: 14px;">
			</div>
		</div>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
