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

		<title>成绩查询</title>

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
		<link href="<%=basePath%>static_/weui.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=54905">
</script>

		<style type="text/css">
.score {
	border-top: 1px solid blue;
	border-bottom: 1px solid blue;
	margin-bottom: 8px;
}

.detail {
	border-top: 1px solid #ddd;
	display: none;
}

.main table {
	font-size: 16px;
}

.detail table {
	font-size: 14px;
}
</style>
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
});

$(function(){
	checkEduAccess();
	
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
});

function checkEduAccess() {
	weui_loadingToast('正在检测教务平台是否可用');
	
	var url = "mobile/edun?ac=checkEduAccess&wxaccount=<%=wxaccount%>";
	$.get(url, function(data) {
		$("#loadingToast").hide();
		if (data == "true") {// 可用
			
			//获取并填充表单数据
			setPersonIdAndPassword('<%=wxaccount%>', '<%=userwx%>');
			
			//获取验证码
			document.getElementById('validateCode').src = 'mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>&t='+Math.random();
		} else {
			weui_dialogAlert('校教务平台服务器崩溃，请稍后再试', 'warn', 'exit');
		}
	});
}


function getScoreNum(){
	var scoreList = new Array();
	$(".score").each(function(i, m){
		var tr2 = $(this).children(".detail").find("tr:nth-child(2)");
		var xz = tr2.children("td:nth-child(1)").text();
		var xf = tr2.children("td:nth-child(2)").text();
		
		var isExist = false;
		for(x in scoreList){
			if(x == xz){
				isExist = true;
				scoreList[x] = parseFloat(scoreList[x]) + parseFloat(xf);
			}
		}

		if(!isExist){
			scoreList[xz] = xf;
		}
	});
	
	var str = "<div>";
	for(x in scoreList){
		str += x + "：" + scoreList[x] + "<br/>";
	}
	str += "</div>";
	showScreenNotice_text(str, "center");
}
		
function bookTicket() {
	updateArticleVisitPerson('<%=wxaccount%>', '293');
	window.location.href = 'http://wd.koudai.com/?userid=207521446';
	//window.open("http://wd.koudai.com/?userid=207521446");
}

//展开/收缩
var flag = 0;
function spreadAll() {
	if (flag == 0) {
		$(".detail").slideDown();
		flag = 1;
	} else {
		$(".detail").slideUp();
		flag = 0;
	}
}

//展开当前
function spreadThis(obj) {
	var $detail = $(obj).find(".detail");
	if ($detail.css("display") == 'block') {
		$detail.slideUp();
	} else {
		$detail.slideDown();
	}
}

//不及格
function noPass() {
	$(".zcj").each(function() {
		var zcj = parseInt($(this).text());
		if (zcj < 60) {
			//var $main = $(this).parent().parent().parent().parent().parent();
			var $main = $(this).parentsUntil("#content");
			$main.find('table').css("color", "red");
		}
	});
}

//成绩表单提交
function check() {
	var username = document.getElementsByName("username")[0].value;
	var password = document.getElementsByName("password")[0].value;
	var code = document.getElementsByName("code")[0].value;

	if ($.trim(username) == "" || $.trim(password) == "" || $.trim(code) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	$("#submit").attr("disabled", true);
	$("#submit").val("提交中...");

	var url = "/mobile/edu?ac=getScore&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(
					url,
					{
						username : username,
						password : password,
						code : code
					},
					function(data) {
						//alert(data);
						var obj;
						try{
							obj = $.parseJSON(data);
						}catch(e){
							alert("出错啦");
						}
						
						if(obj == "wrong"){
							alert("网络连接失败");
							document.getElementsByName("code")[0].value = "";
							document.getElementById("validateCode").click();
						}else if(obj == "noone"){
							alert("么么哒，你是大一的吧，老师们太慢了，一科成绩都没出来！");
						} else if(obj[0][1] == undefined){
							alert(obj);
						} else {//查询成绩成功
							var content = "";
							for (i = obj.length - 1; i >= 0; i--) {
								content += "<div class='score' onclick='spreadThis(this)'><div class='main'>"
										+ "<table width='100%' cellpadding='0' cellspacing='0'>"
										+ "<tr align='center'><td width='40%'>"
										+ obj[i][0]
										+ "</td><td style='padding: 10px 3px 10px 8px'>"
										+ obj[i][1]
										+ "</td><td width='15%' class='zcj'>"
										+ obj[i][6]
										+ "</td></tr></table></div>"
										+ "<div class='detail'><table width='100%' cellpadding='0' cellspacing='0'>"
										+ "<tr align='center' height='25px'><td>性质</td><td>学分</td>"
										+ "<td>平时</td><td>期末</td><td>补考/重修</td>"
										+ "</tr><tr align='center' height='25px'><td>"
										+ obj[i][2]
										+ "</td><td>"
										+ obj[i][3]
										+ "</td><td>"
										+ obj[i][4]
										+ "</td><td>"
										+ obj[i][5]
										+ "</td><td>"
										+ obj[i][7]
										+ "/"
										+ obj[i][8]
										+ "</td></tr></table></div></div>";
							}

							content += "<div style='font-size:14px;text-align:right;'>注：点击按钮或界面可展开详细信息</div>";
							$("form").slideUp();//如果成功获取到成绩则隐藏表单
							$("#result #content").html(content);
							noPass();
							$("#result").slideDown();
						}

						$("#submit").attr("disabled", false);
						$("#submit").val("提  交");
					});
}
</script>
	</head>

	<body onload="checkMM();" onunload="resetAll();" style="padding: 10px">

		<!-- 
		<div>
			<form action="/mobile/edu?ac=otherscore" method="post">
				<div style="line-height: 1.8">
					登录名：
					<span style="color: #888; font-size: 13px">(用户名/邮箱/身份证)</span>
					<input type="text" name="username" class="html5input"
						onclick="clearMsg();">
					密码：
					<input type="password" name="password" class="html5input"
						onclick="clearMsg();">
					验证码：
					<br />
					<input type="text" name="code" class="html5input"
						style="width: 50%" onclick="clearMsg();">
					<img alt=""
						src="http://jwc.hrbnu.edu.cn:8000/account/access/GetValidateCode?id=<%=Math.random()%>"
						style="vertical-align: bottom;"
						onclick="javascript:this.src='http://jwc.hrbnu.edu.cn:8000/account/access/GetValidateCode?id=<%=Math.random()%>'">
				</div>

				<div id="msg" style="font-size: 13px; height: 20px; color: red;"></div>
				<div style="text-align: center;">
					<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
					<input type="button" value="提交" class="html5btn" onclick="check();">
				</div>
			</form>
		</div>
		 -->

		<form method="post">
			<div class="html5yj">
				<div class="formhead_n">
					<div>
						<span class="glyphicon glyphicon-edit"></span>&nbsp;教务平台成绩查询
					</div>
					<div>
						1.请避开高峰期时段查询<br/>
						2.点击验证码图片可刷新
					</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div class="text1">
						登录名(用户名/身份证号/邮箱)
					</div>
					<input type="text" name="username" value=""
						class="html5input_n" onclick="clearMsg();">
					<hr />
					<div class="text1">
						密码
					</div>
					<input type="password" name="password" value=""
						class="html5input_n" onclick="clearMsg();">
					<hr />
					<div class="text1">
						验证码
					</div>
					<input type="text" name="code" class="html5input_n"
						style="width: 50%" onclick="clearMsg();">
					<img id="validateCode" alt="点击刷新" src="" onclick="javascript:this.src=this.src"
						style="max-width: 48%; vertical-align: bottom; color: blue; font-size: 13px;">
					<hr />
					<input id="submit" type="button" value="提 交" class="html5btn"
						onclick="check();">
					<div id="msg"></div>
				</div>
				<!-- 
				<div class="formhead">
					成绩查询
				</div>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="text">
							登录名
						</td>
						<td class="input">
							<input type="text" name="username" value=""
								class="html5input" onclick="clearMsg();">
						</td>
					</tr>
					<tr>
						<td class="text">
							密码
						</td>
						<td class="input">
							<input type="password" name="password" value=""
								class="html5input" onclick="clearMsg();">
						</td>
					</tr>
					<tr>
						<td class="text">
							验证码
						</td>
						<td class="input">
							<input type="text" name="code" class="html5input"
								style="width: 50%" onclick="clearMsg();">
				<img id="validateCode" alt="点击刷新"
					src="/mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>"
					onclick="javascript:this.src='/mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>&t='+Math.random();"
					style="max-width: 48%; vertical-align: bottom; color: blue; font-size: 13px;">

				</td>
				</tr>
				<tr>
					<td colspan="2" class="btn">
						<input id="submit" type="button" value="提 交" class="html5btn"
							onclick="check();">
						<div id="msg"></div>
					</td>
				</tr>
				</table>
				-->
			</div>
		</form>

		<!-- 
		<input type="button" value="电影票在线订 比半价还优惠" class="html5btn"
			style="margin-top: 15px" onclick="bookTicket();">
 		-->

		<div id="result" class='html5yj' style='display: none;'>
			<div class='formhead' style='text-align: center;'>
				由助手教务查询接口提供
			</div>
			
			<div id="content" style='padding: 10px; line-height: 1.5;'></div>
			
			<input type='button' value="学分统计" class='html5btn' onclick='getScoreNum()' style="margin-top: 15px">
			
			<div id="showMenu" onclick="spreadAll();"></div>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
