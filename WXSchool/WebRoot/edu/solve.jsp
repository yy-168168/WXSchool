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

<title>管理员专用</title>

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

	//表单提交
	function check(type) {
		var username = document.getElementsByName("username")[0].value;
		var password = document.getElementsByName("password")[0].value;
		var code = document.getElementsByName("code")[0].value;
	
		if ($.trim(username) == "" || $.trim(password) == "" || $.trim(code) == "") {
			$("#msg").text("不能为空");
			return false;
		}
	
		$(".noscore").attr("disabled", true);
		if(type == 1){
			$("#pj").val("提交中...");
		}else{
			$("#qf").val("提交中...");
		}
	
		var url = "/mobile/edu?ac=solve&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		$.post(url, {
			username : username,
			password : password,
			code : code,
			type : type
		}, function(data) {
			var obj;
			try{
				obj = $.parseJSON(data);
			}catch(e){
				alert("出错啦");
			}
			
			/*if(obj == "ok"){
				if(type == 1){
					if(cj_loc == ""){
						alert("评教完毕！退出到聊天界面回复成绩即可！");
					} else {
						alert("评教完毕");
					}
				}else{
					if(cj_loc == ""){
						alert("学费刷新完毕！退出到聊天界面回复成绩即可！");
					} else {
						alert("学费刷新完毕");
					}
				}
			} else */
			if(obj == "wrong"){
				alert("网络连接失败或系统出错");
			} else {
				alert(obj);
			}

			$(".noscore").attr("disabled", false);
			if(type == 1){
				$("#pj").val("评教");
			}else{
				$("#qf").val("欠费");
			}
		});
	}

	var cj_loc = "", xk_loc = "";
	function getPersonIdAndPassword(val) {
		var url = "/mobile/edu?ac=getStuByStuNum&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
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
					cj_loc = "/mobile/edu?ac=score&wxaccount=<%=wxaccount%>&userwx="+obj.userwx;
					xk_loc = "/mobile/edu?ac=course&wxaccount=<%=wxaccount%>&userwx="+obj.userwx;
					document.getElementById("cxcjrk").style.display = "block";
					document.getElementById("jrxkrk").style.display = "block";
				}
			}else {
				$("#msg").text("出错咯");
			}
		});
	}
	
	function cxcjrk(){
		window.location.href = cj_loc;
	}
	
	function jrxkrk(){		
		window.location.href = xk_loc;
	}
</script>
</head>

<body onload="checkM();">

	<form method="post">
		<div class="html5yj">
			<div class="formhead_n">
				<div>
					<span class="glyphicon glyphicon-edit"></span>&nbsp;问题解决及代办查询
				</div>
				<div></div>
			</div>
			<div style="padding: 10px 10px 3px 10px">
				<div class="text1">学号(可不填)</div>
				<input type="text" name="stuNum" value="" class="html5input_n"
					onclick="clearMsg();" onblur="getPersonIdAndPassword(this.value)">
				<hr />
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
					style="max-width: 48%; vertical-align: bottom; color: blue; font-size: 13px; cursor: pointer;">
				<hr />
				<input id="pj" type="button" value="评教" class="html5btn noscore"
					onclick="check(1);" style="width: 49%">
				<input id="qf" type="button" value="欠费" class="html5btn noscore"
					onclick="check(2);" style="float: right; width: 49%">
				<div id="msg"></div>
			</div>
		</div>

	</form>

	<input id="cxcjrk" type="button" value="点此查询成绩" class="html5btn" onclick="cxcjrk()" style="margin-top: 20px; display: none">
	<input id="jrxkrk" type="button" value="点此进入选课" class="html5btn" onclick="jrxkrk()" style="margin-top: 20px; display: none">

	<jsp:include page="../common/copyright.jsp" />
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
