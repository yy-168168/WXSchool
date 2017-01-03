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
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
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
	showScore();
	
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
});

// 获取学分
function getScoreNum(){
	var scoreList = new Array();
	$(".score").each(function(i, m){
		var zcj = $(this).find(".zcj").text();
		var tr2 = $(this).children(".detail").find("tr:nth-child(2)");
		var xz = tr2.children("td:nth-child(1)").text();
		var xf = tr2.children("td:nth-child(2)").text();
		
		//是否及格
		if(parseInt(zcj) < 60){
			xf = 0;
		}
		
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
			var $main = $(this).parentsUntil("#content");
			$main.find('table').css("color", "red");
		}
	});
}

//显示成绩
function showScore() {
	var url = "mobile/edun?ac=getScore&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, function(data) {
			//alert(data);
			var obj;
			try{
				obj = $.parseJSON(data);
			}catch(e){
				alert("出错啦");
			}
			
			if(obj == "wrong"){
				$("#flush").show();
			}else if(obj == "gradeOne"){
				$("#gradeOne").show();
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
				$("#score #content").html(content);
				noPass();//不及格处理
				$("#score").show();
				$("#point").show();
			}

			$("#submit").attr("disabled", false);
			$("#submit").val("提  交");
		});
}
</script>
	</head>

	<body onload="checkMM();">
	
		<!-- 成绩显示 -->
		<div id="score" class='html5yj' style="display: none">
			<div class='formhead' style='text-align: center;'>
				由助手教务查询接口提供
			</div>
			<div id="content" style='padding: 10px; line-height: 1.5;'></div>
			
			<!-- 展开按钮 -->
			<div id="showMenu" onclick="spreadAll();"></div>
		</div>
		
		<!-- 学分显示 -->
		<div id="point" style='margin-top: 20px; display: none'>
			<input type='button' value="学分统计" class='html5btn' onclick='getScoreNum()' style="margin-bottom: 15px">
		</div>

		<!-- 轻触屏幕刷新 -->
		<div id="flush" style="display: none">
			<table width="100%" height="90%">
				<tr align="center">
					<td style="color: #aaa; line-height: 1.7" onclick="window.location.reload()">
						网络出错<br/>轻触屏幕以刷新
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 大一新生 -->
		<div id="gradeOne" style="display: none">
			<table width="100%" height="90%">
				<tr align="center">
					<td style="color: #333; line-height: 1.7">
						么么哒<br/>你是大一新生吧<br/>老师们太慢了<br/>一科成绩都没出来！<br/>请明天再来查询(^_^)
					</td>
				</tr>
			</table>
		</div>
		
		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
