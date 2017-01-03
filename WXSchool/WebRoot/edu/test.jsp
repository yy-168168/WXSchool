<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
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

<title>模拟登录</title>

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
	$(function() {
		// setPersonIdAndPassword();	
	});
	//表单提交
	function check() {
		var username = document.getElementsByName("username")[0].value;
		var password = document.getElementsByName("password")[0].value;
		var code = document.getElementsByName("code")[0].value;

		if ($.trim(username) == "" || $.trim(password) == ""
				|| $.trim(code) == "") {
			$("#msg").text("不能为空");
			return false;
		}

		//$("#submit").attr("disabled", true);
		$("#submit").val("提交中...");

		var url = "/mobile/edu?ac=test";
		$.get(url, {
			username : username,
			password : password,
			code : code
		}, function(data) {
			alert(data);
			// var obj = $.parseJSON(data);

			$("#submit").attr("disabled", false);
			$("#submit").val("提  交");
		});
	}
</script>
</head>

<body onload="checkM();" onunload="resetAll();">

	<form method="post">
		<div class="html5yj">
			<div class="formhead_n">
				<div>
					<span class="glyphicon glyphicon-edit"></span>&nbsp;一键评教
				</div>
				<div></div>
			</div>
			<div style="padding: 10px 10px 3px 10px">
				<div class="text1">用户名</div>
				<input type="text" name="username" value="" class="html5input_n"
					onclick="clearMsg();">
				<hr />
				<div class="text1">密码</div>
				<input type="text" name="password" value="" class="html5input_n"
					onclick="clearMsg();">
				<hr />
				<div class="text1">验证码</div>
				<input type="text" name="code" class="html5input_n"
					style="width: 50%" onclick="clearMsg();"> <img
					id="validateCode" alt="点击刷新"
					src="/mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>"
					onclick="javascript:this.src='/mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>&t='+Math.random();"
					style="max-width: 48%; vertical-align: bottom; color: blue; font-size: 13px;">
				<hr />
				<input id="submit" type="button" value="提 交" class="html5btn"
					onclick="check()">
				<div id="msg"></div>
			</div>
		</div>
	</form>

	<jsp:include page="../common/copyright.jsp" />
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
