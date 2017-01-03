<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String ac = request.getParameter("ac");
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>选课系统</title>

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
.oneCourse {
	margin: 10px -8px 0 -8px;
	background-color: fff;
	padding: 8px 0;
}

.oneCourse td {
	padding: 0 5px;
}
</style>
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
	});

function selCourse(kh, name) {
	if (window.confirm("你确定选择【" + name + "】？退选请去教务平台")) {
		var url = "/mobile/edu?ac=confirmCourse&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		if('<%=ac %>'.indexOf('port') > -1){
			url = "/mobile/edu?ac=confirmSport&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		}
		$.post(url, {
			xkkh : kh
		}, function(data) {
			var obj;
			try{
				obj = $.parseJSON(data);
			}catch(e){
				alert("出错啦");
			}
			
			if (obj == null) {
				alert("网络连接出错");
			} else if (obj == "ok") {
				alert("选课成功，点击下方我的选课，以确保选上");
			} else {
				alert(obj);
			}
		});
	}
}

function hasSelCourse() {
	var url = "/mobile/edu?ac=showMyCourse&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	if('<%=ac %>'.indexOf('port') > -1){
		url = "/mobile/edu?ac=showMySport&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	}
	$.get(url, function(data) {
		var obj;
		try{
			obj = $.parseJSON(data);
		}catch(e){
			alert("出错啦");
		}
		
		if (obj == null) {
			alert("网络连接出错");
		} else if (obj == "no") {
			alert("没选上，请重新选课");
		} else {
			alert(obj);
		}
	});
}
</script>
	</head>

	<body onload="checkMM();">

		<%
			String[][] courses = (String[][]) request.getAttribute("courses");
			if (courses == null) {
		%>
		<div style="margin-top: 20px; text-align: center; font-size: 15px">
			加载出错咯，请刷新重试
		</div>
		<%
			} else if (courses.length == 0) {
		%>
		<div style="margin-top: 20px; text-align: center; font-size: 15px">
			所有课程已经全部选完
		</div>
		<%
			} else if (courses[0][0] == null) {
		%>
		<div style="margin-top: 20px; text-align: center; font-size: 15px">
			所有课程已经全部选完
		</div>
		<%
			} else {
		%>
		<div id='allCourse'>
			<table width='100%' cellpadding='0' cellspacing='0'>
				<tr align='center'>
					<td>
						课程名称
					</td>
					<td>
						上课时间
					</td>
					<td>
						教师名称
					</td>
					<td>
						上课地点
					</td>
				</tr>
			</table>
			<%
				for (int i = 0; i < courses.length; i++) {
						if (courses[i][0] == null)
							break;
			%>
			<div class='oneCourse'
				onclick="selCourse('<%=courses[i][0]%>','<%=courses[i][1]%>')">
				<table width='100%' cellpadding='0' cellspacing='0'>
					<tr align='center'>
						<td>
							<%=courses[i][1]%>
						</td>
						<td width='20%'>
							<%=courses[i][2]%>
						</td>
						<td width='20%'>
							<%=courses[i][5]%>
						</td>
						<td width='25%'>
							<%=courses[i][4] + courses[i][3]%>
						</td>
					</tr>
				</table>
			</div>
			<%
				}
			%>
			<div style="font-size: 14px; margin-top: 10px; text-align: right;">
				注：仅显示未选满课程，点击课程即可
			</div>
			<%
				}
			%>
		</div>

		<jsp:include page="../common/copyright.jsp" />

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="50%" style="border-right: 1px solid #666"
						onclick="window.location.reload()">
						刷新
					</td>
					<td onclick="hasSelCourse()">
						我的选课
					</td>
				</tr>
			</table>
		</div>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
