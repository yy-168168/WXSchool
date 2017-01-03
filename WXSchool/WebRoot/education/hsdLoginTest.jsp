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
		<script type="text/javascript" src="<%=basePath%>static_/mycommon.js?v=5354">
</script>

<script type="text/javascript">
var cookieStr = "";
$(function(){
	//checkEduAccess();
	$.get("test?ac=getCookie&t=<%=Math.random()%>", function(data){
		cookieStr = data;
		alert(cookieStr);
	});
	document.getElementById('validateCode').src = 'test?ac=getValidateCode&t=<%=Math.random()%>';
});

function submit(){
	//var isValid = weui_checkForm();
	if(true){
		var username = document.getElementsByName("username")[0].value;
		var password = document.getElementsByName("password")[0].value;
		var code = document.getElementsByName("code")[0].value;
	
		//$("#submit").addClass('weui_btn_disabled');
		var url = "test?ac=getScore";
		$.post(url, {
			username : username,
			password : password,
			code : code,
			cookieStr: cookieStr
		}, function(data) {
			alert(data);
		});
	}
}
</script>

	</head>

	<body ontouchstart>
		<div id="loginForm">
			<div class="hd">
			    <h1 class="weui_page_title">用户登录</h1>
			</div>
			<div class="weui_cells_title">账号</div>
			<div class="weui_cells weui_cells_form">
				<div class="weui_cell">
		            <div class="weui_cell_bd weui_cell_primary">
		                <input class="weui_input" type="text" name="username" value="DUMINGYU2014" placeholder="用户名/身份证号/邮箱"/>
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
		                <input class="weui_input" type="text" name="password" value="DMY13683241570" placeholder="请输入教务平台密码"/>
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
