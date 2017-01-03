<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
	Res res = (Res) request.getAttribute("res");
	int tempOrderSize = (Integer) request.getAttribute("tempOrderSize");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title><%=res.getResName()%></title>

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
var resId = '<%=res.getResId()%>';
var wxaccount = '<%=wxaccount%>';
var userwx = '<%=userwx%>';
var flag = -1;
$(function() {
	checkMM();

	document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		WeixinJSBridge.call('hideToolbar');
	});
});

function addToCart(foodId) {
	if (flag != foodId) {
		flag = foodId;
		$.post("/mobile/food?ac=addtemporder&wxaccount=" + wxaccount + "&userwx="
				+ userwx + "&resId=" + resId + "&foodId=" + foodId, function(
				data) {
			if (data == 'true') {
				$("#amount").text(parseInt($("#amount").text()) + 1);
			}
		});
	}
}
</script>
	</head>

	<body>
		<table width="100%" cellpadding="0" cellspacing="0">
			<%
				List<Food> foods = (List<Food>) request.getAttribute("foods");
				if (foods == null || foods.size() == 0) {
			%>
			<tr>
				<td class="html5yj">
					此店暂没推出任何菜品
				</td>
			</tr>
			<%
				} else {
					for (int i = 0; i < foods.size(); i++) {
						Food food = foods.get(i);
			%>
			<tr>
				<td class="html5yj" style="padding: 8px 10px">
					<span><%=food.getFoodName()%></span>
					<span style="float: right;">￥<%=food.getPrice()%></span>
				</td>
				<td width="16%" align="center">
					<img alt="" src="static_/btn_inc.png"
						onclick="addToCart('<%=food.getFoodId()%>')">
				</td>
			</tr>
			<tr>
				<td colspan="2" height="10px">
				</td>
			</tr>
			<%
				}
				}
			%>
		</table>

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="20%" style="border-right: 1px solid #666">
						<img alt="" src="static_/pre2.png" height="22px"
							onclick="history.go(-1);">
					</td>
					<td
						onclick="location='/mobile/food?ac=gettemporder&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>'">
						购餐车(
						<span id="amount"><%=tempOrderSize%></span>)
					</td>
				</tr>
			</table>
		</div>		

		<jsp:include page="../common/copyright.jsp" />		
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
