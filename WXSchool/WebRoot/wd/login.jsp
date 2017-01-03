<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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

		<script type="text/javascript">
var token;

document.ready = function() {
	document.getElementById("pwd").focus();
};

function check1() {
	var pwd = document.getElementsByName("pwd")[0].value;

	if ($.trim(pwd) != "") {
		var url = "/wd/user?ac=login&pwd=" + pwd;
		$.post(url, function(data){
			var obj;
			try{
				obj = $.parseJSON(data);
			}catch(e){
				alert("出错啦");
			}
			
			if (obj == null || obj == "") {
				$("#erromsg1").text("卡壳了，请稍后重试！");
			} else if (obj.token == null || obj.token == "") {
				$("#erromsg1").text("抱歉，您没有权限！");
			} else if (obj.wdaccount == null || obj.wdaccount == "") {
				token = obj.token;
				$("#login").hide();
				$("#bind").show();
			} else {
				token = obj.token;
				window.location.href = "/wd/order?token=" + token;
			}
		});
	}
	return false;
}

function check2() {
	var wdaccount = document.getElementsByName("wdaccount")[0].value;
	var wdpwd = document.getElementsByName("wdpwd")[0].value;

	if ($.trim(wdaccount) != "" && $.trim(wdpwd) != "") {
		var url = "/wd/user?token=" + token + "&ac=bind";
		$.post(url, {wdaccount : wdaccount, wdpwd : wdpwd}, function(data){
			if (data == "false") {
				$("#erromsg2").text("账号或密码不正确！");
			} else if (data == "true") {
				window.location.href = "/wd/order?token=" + token;
			} else {
				$("#erromsg2").text("操作失败，请重试！");
			}
		});
	}
	return false;
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
			&nbsp;
		</div>

		<div
			style="margin: 40px -8px -8px -8px; background: #727171; min-width: 970px;">
			<div
				style="width: 80%; margin: auto; height: 40px; line-height: 40px; text-align: center; color: #DDD; font-size: 14px;">
			</div>
		</div>

		<!-- 登陆框 -->
		<div class="screenShadow" style="display: block;"></div>
		<div id="login" class="infoOfScreenCenter" style="display: block;">
			<div style="padding: 30px 70px;">
				<form style="padding: 0; margin: 0">
					<h2 style="color: #444;">
						请输入密码
					</h2>
					<input type="password" name="pwd" id="pwd"
						style="width: 280px; height: 46px; line-height: 46px; border: 1px solid #CCC; text-align: center; font-size: 25px; padding: 0 5px; border-radius: 8px;">
					<br />
					<br />
					<input type="submit" value="登 录" onclick="return check1();"
						style="width: 280px;" class="input_button_special">
					<div class="erromsg" id="erromsg1"></div>
				</form>
			</div>
		</div>
		<!-- 绑定框 -->
		<div id="bind" class="infoOfScreenCenter" style="margin-top: -200px;">
			<div style="padding: 30px 60px 20px;">
				<form style="padding: 0; margin: 0">
					<table cellpadding="0" cellspacing="0" width="100%" border="0">
						<tr height="70px;">
							<td colspan="2">
								<span style="font-size: 20px; color: #666; font-weight: bold;">第一次使用需要配置微店账户,配置成功才能从微店后台获取订单信息.<span
									style="font-size: 14px; color: red; font-weight: bold;">(配置成功后请修改微店账户密码)</span>
								</span>
							</td>
						</tr>
						<tr height="70px;">
							<td width="20%">
								账号：
							</td>
							<td>
								<input type="text" name="wdaccount"
									style="width: 100%; height: 40px; line-height: 40px; border: 1px solid #CCC; font-size: 25px; padding: 0 5px; border-radius: 8px;">
							</td>
						</tr>
						<tr height="70px;">
							<td>
								密码：
							</td>
							<td>
								<input type="password" name="wdpwd"
									style="width: 100%; height: 40px; line-height: 40px; border: 1px solid #CCC; font-size: 25px; padding: 0 5px; border-radius: 8px;">
							</td>
						</tr>
						<tr height="70px;" align="center">
							<td colspan="2">
								<input type="submit" value="提 交" onclick="return check2();"
									class="input_button_special">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="erromsg" id="erromsg2"></div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
