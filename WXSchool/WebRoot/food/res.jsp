<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Res res = (Res) request.getAttribute("res");
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

		<style type="text/css">
.reshead {
	margin: -8px -8px 0 -8px;
	padding: 12px 8px;
	background: url("static_/head_bg.png") repeat-x;
}

.img {
	float: left;
	width: 33%
}

.img img {
	width: 95%;
	height: 65px;
	border-radius: 6px;
}

.allres_2 {
	float: right;
	width: 66%
}

.name {
	font-size: 20px;
	font-weight: 500;
}

.notice {
	color: #666;
	font-size: 13px;
	margin-top: 5px
}
</style>
		<script type="text/javascript">
$(function() {
	checkMM();

	//act();
});

function act() {
	$(".html5yj").each(function() {
		var $price = $(this).find(".price");
		var price = parseFloat($price.text());

		if ($price.text() == "") {

		} else if (price > 10) {
			$(this).css("color", "#ED0808");
		} else if (price > 8) {
			$(this).css("color", "#FF6501");
		} else {
			$(this).css("color", "#FFCC00");
		}
	});
}
</script>

	</head>

	<body>

		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideToolbar');
});
</script>
		<div class="reshead">
			<div class="img">
				<img alt="" src="<%=res.getPicPath()%>">
			</div>
			<div class="allres_2">
				<span class="name"><%=res.getResName()%></span>
				<span style="float: right; font-size: 12px; color: #999"><%=res.getVisitPerson()%></span>
				<%--<img alt="" src="static_/vp2.png" height="14px" style="float: right; vertical-align: middle; opacity: 0.4;">--%>
				<span class='glyphicon glyphicon-user'
					style='color: #999; font-size: 12px; float: right;'></span>
				<div class="notice"><%=res.getNotice()%></div>
			</div>
			<div style="clear: both;"></div>
		</div>

		<div id="content">
			<%
				List<Food> foods = (List<Food>) request.getAttribute("foods");
				if (foods == null || foods.size() == 0) {
			%>
			<div class="html5yj">
				<div style="padding: 10px">
					此店暂没推出任何菜品
				</div>
			</div>
			<%
				} else {
					for (int i = 0; i < foods.size(); i++) {
						Food food = foods.get(i);
						String locUrl = food.getLocUrl();
						if (locUrl != null && !locUrl.equals("")) {
			%>
			<div class="html5yj" onclick="location='<%=locUrl%>'">
				<%
					} else {
				%>
				<div class="html5yj">
					<%
						}
					%>
					<div style="padding: 6px 10px;">
						<%=food.getFoodName()%>
						<span style="float: right;"> <%
 	String s_price = food.getPrice();
 			if (Float.parseFloat(s_price) != 0) {
 %> ￥<span class="price"><%=s_price%></span> <%
 	}
 %> <span class="actprice" style="color: red"></span> </span>
						<div style="clear: both;"></div>
					</div>
				</div>
				<%
					}
					}
				%>
			</div>

			<jsp:include page="../common/copyright.jsp" />

			<div id="mybar_dis"></div>
			<div id="mybar">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td style="border-right: 1px solid #666"
							onclick="javascript:history.go(-1);">
							<img alt="" src="static_/pre2.png" height="22px">
						</td>
						<td width="80%">
							<label for="call">
								订餐请点击
							</label>
							<a href="tel:<%=res.getTel()%>" id="call"
								style="color: #fff; text-decoration: none;"><%=res.getTel()%></a>
						</td>
					</tr>
				</table>
			</div>

			<%@ include file="../common/tongji.html"%>
	</body>
</html>
