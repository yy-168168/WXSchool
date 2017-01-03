<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微店 - 订单验证</title>

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

.ord_list:nth-child(odd) {
	background-color: #F9F9F9;
}

.ord_list td {
	padding: 10px;
}
</style>
		<script type="text/javascript">
var orderNum;

function use_() {
	var url = "/wd/order?ac=addWdo&token=<%=token%>";
	$.post(url, 
			{orderNum : orderNum}, 
			function(data){
				show_hide();//隐藏
				if (data == "ok") {
					showNotice("验证通过！");
					document.getElementsByName("orderNum")[0].value = "";
					setTimeout("window.location.reload()", 1000);
				} else if (data == "wrong") {
					showNotice("订单号错误！");
				} else {
					showNotice("操作失败，请稍后重试！");
				}
	});
}

function search_() {
	orderNum = document.getElementsByName("orderNum")[0].value;

	if ($.trim(orderNum) == "" || orderNum.length < 5) {
		showNotice("请正确输入订单号！");
		return false;
	}

	var url = "/wd/order?ac=getWdoInDb&token=<%=token%>";
	$.post(url, {orderNum : orderNum}, function(data){
		var obj;
		try{
			obj = $.parseJSON(data);
		}catch(e){
			alert("出错啦");
		}
		

		if (obj == null) {
			showNotice("卡壳了，请稍后重试！");
		} else if (obj == "") {
			url = "/wd/order?ac=getWdoInWd&token=<%=token%>";
			$.post(url, {orderNum : orderNum}, function(data){
				try{
					obj = $.parseJSON(data);
				}catch(e){
					alert("出错啦");
				}
				

				if (obj == null) {
					showNotice("卡壳了，请稍后重试！");
				} else if (obj == "") {
					showNotice("订单号错误，或者不存在该订单号！");
				} else {
					var buyer, orderInfo = '', allPrice = 0, statusDesc;
					$.each(obj, function(i, order) {
						orderNum = order.orderNum;
						buyer = order.buyer;
						orderInfo += order.itemName + '/数量:' + order.amount + '/单价:'
								+ order.unitPrice;
						if (i > 0) {
							orderInfo += '-----';
						}
						allPrice += parseInt(order.totalPrice);
						statusDesc = order.statusDesc;
					});
					var html = "<div style='margin: 10px 0'><span style='font-weight: bold'>订单编号：</span>"
							+ orderNum
							+ "</div>"
							+ "<div style='margin: 10px 0'><span style='font-weight: bold'>用户信息：</span>"
							+ buyer
							+ "</div>"
							+ "<div style='margin: 10px 0'><span style='font-weight: bold'>商品信息：</span>"
							+ orderInfo
							+ "</div>"
							+ "<div style='margin: 10px 0'><span style='font-weight: bold'>消费总价：</span>￥"
							+ allPrice + "</div>";

					if (statusDesc == '已付款') {
						html += "<div style='text-align: center;'><input type='button' value='使 用' class='input_button_special' style='width: 200px;' onclick='use_();'>"
								+ "&nbsp;&nbsp;&nbsp;<a href='javascript:show_hide();' style='vertical-align: bottom;'>取消</a></div>";
					} else {
						html += "<div style='text-align: center;'><span style='color:red'>请成功付款后再使用！</span>"
								+ "&nbsp;&nbsp;&nbsp;<a href='javascript:show_hide();' style='vertical-align: bottom;'>取消</a></div>";
					}

					$(".infoOfScreenCenter div").html(html);
					show_hide();
				}
			});
		} else {
			var buyer, orderInfo = '', allPrice = 0;
			$.each(obj, function(i, order) {
				orderNum = order.orderNum;
				buyer = order.buyer;
				orderInfo += order.itemName + '/单价:' + order.unitPrice + '/数量:'
						+ order.amount;
				if (i > 0) {
					orderInfo += '-----';
				}
				allPrice += parseInt(order.totalPrice);
			});
			var html = "<div style='margin: 10px 0'><span style='font-weight: bold'>订单编号：</span>"
					+ orderNum
					+ "</div>"
					+ "<div style='margin: 10px 0'><span style='font-weight: bold'>用户信息：</span>"
					+ buyer
					+ "</div>"
					+ "<div style='margin: 10px 0'><span style='font-weight: bold'>商品信息：</span>"
					+ orderInfo
					+ "</div>"
					+ "<div style='margin: 10px 0'><span style='font-weight: bold'>消费总价：</span>￥"
					+ allPrice
					+ "</div>"
					+ "<div style='margin-top: 20px'><span style='color: red'>该订单号已经被使用，请慎重处理！</span>"
					+ "<a	href='javascript:show_hide();'>点此退出</a></div>";
			$(".infoOfScreenCenter div").html(html);
			show_hide();
		}
	});
}

function show_hide() {
	var display = $(".screenShadow").css("display");
	if (display == 'none') {
		$(".screenShadow").show();
		$(".infoOfScreenCenter").show();
	} else {
		$(".screenShadow").hide();
		$(".infoOfScreenCenter").hide();
	}
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
									style="font-weight: normal;">|</span>订单验证</span>
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
				<tr>
					<td height="150px" colspan="5">
						<div
							style="display: table; background-color: #FF5500; margin: 0px auto;">
							<div style="display: table-cell; vertical-align: middle;">
								<input type="text" name="orderNum"
									style="text-align: center; margin-left: 2px; width: 300px; height: 42px; line-height: 40px; border: 0; font-size: 20px; padding: 0 5px;">
							</div>
							<div style="display: table-cell; vertical-align: middle;">
								<input type="button" value="查 询" onclick="search_();"
									style="border: 0; background: transparent; height: 46px; width: 100px; cursor: pointer; color: #fff; font-weight: bold; font-size: 20px;">
							</div>
						</div>
					</td>
				</tr>
				<%
					List<WdOrder> wdos = (List<WdOrder>) request.getAttribute("wdos");
					if (wdos != null && wdos.size() > 0) {
				%>
				<tr>
					<td colspan="5"
						style="border-bottom: 1px solid #e5e5e5; height: 1px">
						&nbsp;
					</td>
				</tr>
				<%
					for (int i = 0; i < wdos.size(); i++) {
							WdOrder order = wdos.get(i);
				%>
				<tr class="ord_list">
					<td width="18%"><%=order.getOrderNum()%></td>
					<td align="left">
						用户信息：<%=order.getBuyer()%><br />
						商品信息：<%=order.getItemName()%>
					</td>
					<td width="8%">
						<%=order.getAmount()%></td>
					<td width="10%">
						￥<%=order.getTotalPrice()%></td>
					<td width="18%"><%=order.getPubTime()%></td>
				</tr>
				<%
					}
					}
				%>
				<tr>
					<td colspan="5"></td>
				</tr>
				<tr height="50px">
					<td colspan="5" align="center"
						style="border-top: 1px solid #E5E5E5;">
						<%
							int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
							int day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
						%>
						<a href="/wd/order?ac=list&token=<%=token%>&m=<%=month%>&d=<%=day%>"
							target="_blank">查看所有订单</a>
					</td>
				</tr>
			</table>
		</div>

		<div
			style="margin: 40px -8px -8px -8px; background: #727171; min-width: 970px;">
			<div
				style="width: 80%; margin: auto; height: 40px; line-height: 40px; text-align: center; color: #DDD; font-size: 14px;"></div>
		</div>

		<div class="screenShadow"></div>
		<div class="infoOfScreenCenter">
			<div style="padding: 30px;">
			</div>
		</div>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
