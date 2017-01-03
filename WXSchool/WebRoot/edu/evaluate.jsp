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

<title>JUST FOR YOU</title>

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
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
		WeixinJSBridge.call('hideOptionMenu');
		WeixinJSBridge.call('hideToolbar');
});

$(function(){
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	
	location.href = "/mobile/edun?bns=solve&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=<%=aId%>";
});

	//表单提交
	function check(type) {
		var stuNum = document.getElementsByName("stuNum")[0].value;
		var username = document.getElementsByName("username")[0].value;
		var password = document.getElementsByName("password")[0].value;
		var userwx = document.getElementsByName("userwx")[0].value;
		var code = document.getElementsByName("code")[0].value;
	
		if ($.trim(stuNum) == "" || $.trim(code) == "") {
			$("#msg").text("不能为空");
			return false;
		}
	
		$(":button").attr("disabled", true);
		$(":button").val("提交中...");
	
		var url = "/mobile/edu?ac=solve&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		$.post(url, {
			username : username,
			password : password,
			userwx : userwx,
			code : code,
			type : 1
		}, function(data) {
			var obj;
			try{
				obj = $.parseJSON(data);
			}catch(e){
				alert("出错啦");
			}
			
			if(obj == "ok"){
				alert("已OK！退出到聊天界面回复成绩即可！");
				WeixinJSBridge.invoke('closeWindow', {}, function(res) {});
			} else if(obj == "wrong"){
				alert("网络连接失败或系统出错");
			} else {
				alert(obj);
			}

			$(":button").attr("disabled", false);
			$(":button").val("DO IT");
		});
	}

	function getPersonIdAndPassword(val) {
		var url = "/mobile/stu?ac=getStuByStuNum&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		$.get(url, {
			stuNum : val
		}, function(data) {
			var obj;
			try{
				obj = $.parseJSON(data);
			}catch(e){
				alert("出错啦");
			}
			
			if(obj != null){
				if(obj.userwx != undefined && obj.userwx != null && obj.userwx != ""){
					document.getElementsByName("username")[0].value = obj.personId;
					document.getElementsByName("password")[0].value = obj.password;
					document.getElementsByName("userwx")[0].value = obj.userwx;
				}else {
					alert("请先使用哈师大助手查询成绩后再来重试");
					WeixinJSBridge.invoke('closeWindow', {}, function(res) {});
				}
			}else {
				alert("出错咯，请重试");
			}
		});
	}
</script>
</head>

<body onload="checkMM_new();">

	<form method="post">
		<div class="html5yj">
			<div class="formhead_n">
				<div>
					<span class="glyphicon glyphicon-edit"></span>&nbsp;解决查成绩问题
				</div>
				<div></div>
			</div>
			<div style="padding: 10px 10px 3px 10px">
				<div class="text1">学号</div>
				<input type="text" name="stuNum" value="" class="html5input_n"
					onclick="clearMsg();" onblur="getPersonIdAndPassword(this.value)">
				<hr />
				<div class="text1">验证码</div>
				<input type="text" name="code" class="html5input_n"
					style="width: 50%" onclick="clearMsg();"> <img
					id="validateCode" alt="点击刷新"
					src="/mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>"
					onclick="javascript:this.src='/mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>&t='+Math.random();"
					style="max-width: 48%; vertical-align: bottom; color: blue; font-size: 13px; cursor: pointer;">
				<hr />
				<input type="hidden" name="username" value="">
				<input type="hidden" name="password" value="">
				<input type="hidden" name="userwx" value="">
				<input type="button" value="DO IT" class="html5btn" onclick="check();">
				<div id="msg"></div>
			</div>
		</div>

	</form>

	<jsp:include page="../common/copyright.jsp" />
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
