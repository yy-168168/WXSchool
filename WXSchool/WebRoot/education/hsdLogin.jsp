<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
	String aId = request.getParameter("aId");
	String bns = request.getParameter("bns");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>教务平台</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath%>static_/favicon.ico" />
		<link href="<%=basePath%>static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath%>static_/myfont.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath%>static_/weui.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath%>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/mycommon.js?v=756756">
</script>

<script type="text/javascript">
$(function(){
	checkEduAccess();
});

function checkEduAccess() {
	weui_loadingToast('正在检测教务平台是否可用');
	
	var url = "mobile/edun?ac=checkEduAccess&wxaccount=<%=wxaccount%>";
	$.get(url, function(data) {
		$("#loadingToast").hide();
		if (data != "wrong") {// 可用
			token = data;
			
			//获取并填充表单数据
			setPersonIdAndPassword('<%=wxaccount%>', '<%=userwx%>');
			
			//获取验证码
			document.getElementById('validateCode').src = 'mobile/edun?ac=getValidateCode&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&t='+Math.random();
			
			//显示表单
			$("#loginForm").show();
		} else {
			weui_dialogAlert('校教务平台服务器崩溃，请稍后再试', 'warn', 'exit');
		}
	});
}

var token;
function submit(){
	var isValid = weui_checkForm();
	if(isValid){
		var username = document.getElementsByName("username")[0].value;
		var password = document.getElementsByName("password")[0].value;
		var code = document.getElementsByName("code")[0].value;
	
		//$("#submit").addClass('weui_btn_disabled');
		weui_loadingToast('请求中...');
		var url = "mobile/edun?ac=login&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		$.post(url, {
			username : username,
			password : password,
			code : code,
			token: token
		}, function(data) {
			$("#loadingToast").hide();
			var obj;
			try{
				obj = $.parseJSON(data);
			}catch(e){
				alert("出错啦");
				return false;
			}
			
			if (obj == "ok") {
				if('<%=bns%>' == 'score'){
					location.href = "/mobile/edun?wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&ac=<%=bns%>&aId=<%=aId%>";
				}else if('<%=bns%>' == 'solve'){
					solve();
				}else if('<%=bns%>' == 'myCourse'){
					myCourse();
				}
			} else {
				if (obj == "wrong") {
					obj = "网络连接失败";
				}
				alert(obj);

				document.getElementsByName("code")[0].value = "";
				document.getElementById("validateCode").click();
				//$("#submit").removeClass('weui_btn_disabled');
			}
		});
	}
}

//评教
function solve() {
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	weui_loadingToast('请求中...');
	var url = "/mobile/edun?ac=solve&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, function(data) {
		$("#loadingToast").hide();
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
			alert("网络连接失败");
			document.getElementsByName("code")[0].value = "";
			document.getElementById("validateCode").click();
		}
	});
}

//我的校选修
function myCourse() {
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	weui_loadingToast('请求中...');
	var url = "/mobile/edun?ac=myCourse&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, function(data) {
		$("#loadingToast").hide();
		var obj;
		try{
			obj = $.parseJSON(data);
		}catch(e){
			alert("出错啦");
		}
		
		if (obj == null) {
			alert("网络连接失败");
			document.getElementsByName("code")[0].value = "";
			document.getElementById("validateCode").click();
		} else if (obj == "no") {
			alert("没选上，请重新选课");
			WeixinJSBridge.invoke('closeWindow', {}, function(res) {});
		} else {
			alert(obj);
		}
	});
}
</script>

	</head>

	<body ontouchstart>
		<div id="loginForm" style="display: none">
			<div class="hd">
			    <h1 class="weui_page_title">用户登录</h1>
			</div>
			<div class="weui_cells_title">账号</div>
			<div class="weui_cells weui_cells_form">
				<div class="weui_cell">
		            <div class="weui_cell_bd weui_cell_primary">
		                <input class="weui_input" type="text" name="username" placeholder="用户名/身份证号/邮箱"/>
		            </div>
		        	<div class="weui_cell_ft">
		                <i class="weui_icon_warn"></i>
		            </div>
		        </div>
			</div>
			<div class="weui_cells_title">密码</div>
			<div class="weui_cells weui_cells_form">
				<div class="weui_cell">
		            <div class="weui_cell_bd weui_cell_primary">
		                <input class="weui_input" type="password" name="password" placeholder="请输入教务平台密码"/>
		            </div>
		            <div class="weui_cell_ft">
		                <i class="weui_icon_warn"></i>
		            </div>
		        </div>
			</div>
			<div class="weui_cells_title">验证码</div>
			<div class="weui_cells weui_cells_form">
				<div class="weui_cell weui_vcode">
		            <div class="weui_cell_bd weui_cell_primary">
		                <input class="weui_input" type="text" name="code" placeholder="请输入验证码"/>
		            </div>
		            <div class="weui_cell_ft">
		            	<i class="weui_icon_warn"></i>
		                <img id="validateCode" alt="点击刷新" onclick="javascript:this.src=this.src" src="">
		            </div>
		        </div>
			</div>
		    <div class="weui_btn_area">
		        <a id="submit" href="javascript:submit();" class="weui_btn weui_btn_primary">提交</a>
		    </div>
			<div class="weui_cells_tips">请避开高峰期时段查询；点击验证码图片可刷新 </div>
		</div>
	</body>
</html>
