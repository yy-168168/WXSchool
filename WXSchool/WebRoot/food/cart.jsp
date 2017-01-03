<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>购餐车</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">
var flag = true;
$(function() {
	checkMM();

	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		WeixinJSBridge.call('hideToolbar');
	});

	computeSinglePrice();
	computeTotalNum();
	computeTotalPrice();
});

function computeSinglePrice() {
	$(".tempOrderBox").each(function() {
		var num = $(this).find(".num").val();
		var price = $(this).find(".price").val();
		$(this).find(".singlelTotal").text((num * price).toFixed(1));
	});
}

function computeTotalNum() {
	var totalNum = 0;
	$(".num").each(function() {
		var num = $(this).val();
		totalNum += parseInt(num);
	});
	$("#totalNum").text(totalNum);
}

function computeTotalPrice() {
	var totalPrice = 0;
	$(".singlelTotal").each(function() {
		var num = $(this).text();
		totalPrice += parseFloat(num);
	});
	$("#totalPrice").text(totalPrice.toFixed(1));
}

function updateOrderAmount(tempOrderId, num) {
	if (flag == true) {
		flag = false;
		var curnum = parseInt($("#num" + tempOrderId).val());
		if (curnum == 1 && num == -1) {
			flag = true;
		} else if (curnum == 4 && num == 1) {
			flag = true;
		} else {
			$.get(
					"/mobile/food?ac=updateOrderAmount&wxaccount=<%=wxaccount%>&tempOrderId="
							+ tempOrderId + "&num=" + num, function(data) {
						if (data == 'true') {
							var totalNum = curnum + num;
							$("#num" + tempOrderId).val(totalNum);

							var price = $("#price" + tempOrderId).val();
							$("#singlelTotal" + tempOrderId).text(
									(totalNum * price).toFixed(1));

							computeTotalNum();
							computeTotalPrice();
						}
						flag = true;
					});
		}
	}
}

function deleteTempOrder(tempOrderId) {
	$.get("/mobile/food?ac=deleteTempOrder&wxaccount=<%=wxaccount%>&tempOrderId="
			+ tempOrderId, function() {
		window.location.reload();
	});
}
</script>
	</head>

	<body>
		<table width="100%" cellpadding="0" cellspacing="0"
			style="font-size: 14px">
			<%
				List<Order> tempOrders = (List<Order>) request
						.getAttribute("tempOrders"); 
				if (tempOrders == null || tempOrders.size() == 0) {
			%>
			<tr>
				<td colspan="3" style="padding: 10px">
					您的购餐车还是空的，赶紧行动吧！
				</td>
			</tr>
			<tr height="14px">
				<td colspan="3">
					<div class="fgx"></div>
				</td>
			</tr>
			<%
				} else {
					for (int i = 0; i < tempOrders.size(); i++) {
						Order tempOrder = tempOrders.get(i);
			%>
			<tr height="26px">
				<td style="padding-left: 10px">
					<%=tempOrder.getShopName()%>
				</td>
				<td width="42%">
					<%=tempOrder.getGoodsName()%>
				</td>
				<td rowspan="2" width="16%" align="center">
					<img alt="" src="static_/btn_del.png" height="20px"
						onclick="deleteTempOrder('<%=tempOrder.getOrderId()%>');">
				</td>
			</tr>
			<tr class="tempOrderBox">
				<td style="padding-left: 10px">
					<img alt="" src="static_/btn_dec.png" height="22px"
						style="vertical-align: middle; margin-bottom: 2px"
						onclick="updateOrderAmount('<%=tempOrder.getOrderId()%>',-1);">
					<input class="num" id="num<%=tempOrder.getOrderId()%>"
						readonly="readonly" size="2" value="<%=tempOrder.getAmount()%>"
						style="height: 24px; border: 1px solid #D5D5D5; text-align: right;">
					<img alt="" src="static_/btn_inc.png" height="22px"
						style="vertical-align: middle; margin-bottom: 2px"
						onclick="updateOrderAmount('<%=tempOrder.getOrderId()%>',1);">
				</td>
				<td>
					<input class="price" id="price<%=tempOrder.getOrderId()%>"
						type="hidden" value="<%=tempOrder.getPrice()%>">
					￥
					<span class="singlelTotal"
						id="singlelTotal<%=tempOrder.getOrderId()%>"></span>
				</td>
			</tr>
			<tr height="14px">
				<td colspan="3">
					<div class="fgx"></div>
				</td>
			</tr>
			<%
				}
				}
			%>
			<tr height="30px">
				<td style="padding-left: 10px">
					总计：
				</td>
				<td>
					<span id="totalNum"></span>份
				</td>
				<td>
					<span id="totalPrice"></span>元
				</td>
			</tr>
		</table>

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="20%" style="border-right: 1px solid #666">
						<img alt="" src="static_/pre2.png" height="22px"
							onclick="history.go(-1);">
					</td>
					<td width="20%" style="border-right: 1px solid #666">
						<img alt="" src="static_/home2.png" height="22px" onclick="">
					</td>
					<td style="border-right: 1px solid #666"
						onclick="location='food/fillinfo.jsp?wxaccount=<%=wxaccount%>&userwx=<%=userwx%>'">
						点击下一步
					</td>
				</tr>
			</table>
		</div>

		<jsp:include page="../common/copyright.jsp" />		
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
