<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
	String aId = request.getParameter("aId");
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>代取火车票</title>

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
	var info = document.getElementsByName("info")[0].value;

	if ($.trim(name) == "" || $.trim(tel) == "" || $.trim(address) == "") {
		$("#msg").text("请认真填写后再提交");
		return false;
	}

	if (name.length > 20 || tel.length > 20 || address.length > 100
			|| info.length > 200) {
		$("#msg").text("数据过长");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/bookbns?ac=addOrder&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&type=2";
	$.post(url, {
		name : name,
		tel : tel,
		address : address,
		info : info,
		company : "",
		loc_time : "",
		sendTime : ""
	}, function(data) {
		var obj;
		try{
			obj = $.parseJSON(data);
		}catch(e){
			alert("出错啦");
		}
		
		if (obj == true) {
			$("#msg").text("信息已提交，请等待上门取证件！");
		} else {
			$("#msg").text("信息提交失败，请重试！");
			$(":button").attr("disabled", false);
		}
		$(":button").val("提  交");
	});
}
</script>
	</head>

	<body>

		<form name="form">

			<div style="color: #EA2534; line-height: 1.3">
				<span style="font-weight: bold">下单必读：</span><span
					style="font-size: 15px;">该表单信息将做为服务生上门取证件依据，请认真填写；具体事宜请在服务生上门取件时告知。</span>
					<br>
				<span style="font-weight: bold">咨询电话：</span><span
					style="font-size: 15px;">18045037959</span>
			</div>
			<div class="html5yj">
				<div class="formhead_n">
					<div>
						<span class="glyphicon glyphicon-edit"></span>&nbsp;代取信息
					</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div class="text1">
						姓名
					</div>
					<input type="text" name="name" class="html5input_n" value=""
						onclick="clearMsg();">
					<hr />
					<div class="text1">
						手机号
					</div>
					<input type="text" name="tel" class="html5input_n" value=""
						onclick="clearMsg();">
					<hr />
					<div class="text1">
						楼栋及寝号
					</div>
					<input type="text" name="address" class="html5input_n" value=""
						onclick="clearMsg();">
					<hr />
					<div class="text1">
						备注
					</div>
					<textarea rows="2" cols="" name="info" class="html5area_n"
						onclick="clearMsg();"></textarea>
					<hr />
					<input type="button" value="提  交" class="html5btn"
						onclick="check();">
					<div id="msg"></div>
				</div>
			</div>
		</form>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
