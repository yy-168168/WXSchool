<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.wxschool.entity.Dqorder"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
	String aId = request.getParameter("aId");
%>
<%
	Dqorder order = (Dqorder) request.getAttribute("order");
	String name = "", tel = "", address = "";
	if (order != null) {
		name = order.getName();
		name = name == null ? "" : name;
		tel = order.getTel();
		tel = tel == null ? "" : tel;
		address = order.getAddress();
		address = address == null ? "" : address;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>快递代取</title>

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
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<style type="text/css">
#result span {
	display: block;
}
</style>
		<script type="text/javascript">
$(function() {
	checkMM();

	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
});

function check() {
	var name = document.getElementsByName("name")[0].value;
	var tel = document.getElementsByName("tel")[0].value;
	var address = document.getElementsByName("address")[0].value;
	var company = document.getElementsByName("company")[0].value;
	var info = document.getElementsByName("info")[0].value;
	var loc_time = document.getElementsByName("loc_time")[0].value;
	var sendTime = document.getElementsByName("sendTime")[0].value;

	if ($.trim(name) == "" || $.trim(tel) == "" || $.trim(address) == ""
			|| $.trim(loc_time) == "") {
		$("#msg").text("请认真填写后再提交");
		return false;
	}

	if ($.trim(company) == "") {
		$("#msg").text("请选择快递公司");
		return false;
	}

	if ($.trim(sendTime) == "") {
		$("#msg").text("请选择配送时间");
		return false;
	}

	if (name.length > 20 || tel.length > 20 || address.length > 100
			|| info.length > 200 || loc_time.length > 100) {
		$("#msg").text("数据过长");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/bookbns?ac=addOrder&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&type=1";
	$.post(url, {
		name : name,
		tel : tel,
		company : company,
		address : address,
		info : info,
		loc_time : loc_time,
		sendTime : sendTime,
	}, function(data) {
		var obj;
		try{
			obj = $.parseJSON(data);
		}catch(e){
			alert("出错啦");
		}
		
		if (obj == true || obj == "true") {
			$(":button").val("信息已提交，请通知快递哥取件");
		} else {
			$("#msg").text("信息提交失败，请重试！");
			$(":button").attr("disabled", false);
			$(":button").val("提  交");
		}

	});
}
</script>
	</head>

	<body onunload="resetAll();">

		<form method="post" name="form">

			<div style="color: #EA2534; line-height: 1.3">
				<span style="font-weight: bold">下单必读：</span><span
					style="font-size: 15px;">该表单信息将作为快递哥取快递依据，为防止恶意下单，提交完后请短信告知快递哥。</span>
				<br />
				<span style="font-weight: bold">快递哥：</span><span
					style="word-wrap: break-word; word-break: break-all;"><a
					href="tel:18646348190">18646348190</a>/<a href="tel:18704624883">18704624883</a>/<a
					href="tel:18745064182">18745064182</a>/<a href="tel:18745113930">18745113930</a>
				</span>
			</div>
			<div class="html5yj">
				<div class="formhead_n">
					<div>
						<span class="glyphicon glyphicon-edit"></span>&nbsp;所取快递信息
					</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div class="text1">
						快递上的姓名
					</div>
					<input type="text" name="name" class="html5input_n"
						value="<%=name%>" onclick="clearMsg();">
					<hr />
					<div class="text1">
						快递上的手机号
					</div>
					<input type="text" name="tel" class="html5input_n" value="<%=tel%>"
						onclick="clearMsg();">
					<hr />
					<div class="text1">
						取件位置及时间
					</div>
					<input type="text" name="loc_time" class="html5input_n" value=""
						onclick="clearMsg();">
					<hr />
					<div class="text1">
						快递公司
					</div>
					<select class="html5input_n" name="company" id="company"
						onclick="clearMsg();">
						<option value="">
							请选择
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
					<hr />
					<div class="text1">
						所取物品信息及备注
					</div>
					<textarea rows="2" cols="" name="info" class="html5area_n"
						onclick="clearMsg();"></textarea>
					<hr />
					<div class="text1">
						楼栋及寝号
					</div>
					<input type="text" name="address" class="html5input_n"
						value="<%=address%>" onclick="clearMsg();">
					<hr />
					<div class="text1">
						配送时间
					</div>
					<select class="html5input_n" name="sendTime" id="sendTime"
						onclick="clearMsg();">
						<option value="20:00--22:00">
							20:00--22:00
						</option>
					</select>
					<hr />
					<input type="button" value="提  交" class="html5btn"
						onclick="check();">
					<div id="msg"></div>
				</div>
			</div>
		</form>

		<div style="margin-top: 10px; font-size: 14px;">
			1、提交之前请认真核实信息，以免造成不必要的麻烦；
			<br />
			2、为减少取件及配送人员的工作量，请不要重复提交，感谢支持！
			<br />
			3、申通无法代取，请自行去领取。
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
