<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String day = request.getParameter("day");
	if (day == null) {
		day = "1";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>添加课程</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<style type="text/css">
table tr {
	height: 40px;
}

table th {
	text-align: right;
}

#addSuccess {
	border: 5px solid #aaa;
	display: none;
	position: absolute;
	z-index: 5;
	background-color: #ccc;
	width: 240px;
	text-align: center;
	padding: 15px 0 10px 0;
}
</style>
		<script type="text/javascript">
$(function() {
	checkMM();
	
	var day = <%=day%>;
	$("#day option:nth-child("+day+")").attr("selected",true);
	
	var ops = init_select(1, 9);
	$("#startLession").append(ops);
	ops = init_select(2, 10);
	$("#endLession").append(ops);
	ops = init_select(1, 24);
	$("#startWeek").append(ops);
	ops = init_select(2, 25);
	$("#endWeek").append(ops);
	
	$("#endWeek option:nth-child(17)").attr("selected",true);

	$("#startLession").change(function() {
		var sl = $("#startLession option:selected").val();
		var ops = init_select(parseInt(sl) + 1, 10);
		$("#endLession").empty();
		$("#endLession").append(ops);
	});

	$("#startWeek").change(function() {
		var sl = $("#startWeek option:selected").val();
		var ops = init_select(parseInt(sl) + 1, 25);
		$("#endWeek").empty();
		$("#endWeek").append(ops);
	});
});

function init_select(start, end) {
	var ops = "";
	for ( var i = start; i <= end; i++) {
		ops += "<option value=" + i + ">" + i + "</option>";
	}
	return ops;
}

function addCourse() {
	var d = document.getElementsByName("day")[0].value;
	var cn = document.getElementsByName("courseName")[0].value;
	var t = document.getElementsByName("teacher")[0].value;
	var add = document.getElementsByName("address")[0].value;
	var sl = document.getElementsByName("startLession")[0].value;
	var el = document.getElementsByName("endLession")[0].value;
	var sw = document.getElementsByName("startWeek")[0].value;
	var ew = document.getElementsByName("endWeek")[0].value;
	var idw = document.getElementsByName("isDifWeek")[0].value;
	var u = '<%=userwx%>';
	var acc = '<%=wxaccount%>';

	if ($.trim(cn) == "" || $.trim(t) == "" || $.trim(add) == "") {
		$("#msg").text("不能为空");
		return false;
	}
	
	$("#add_btn").attr("disabled",true);
	$("#add_btn").val("添加中...");

	$.post("/mobile/courseac=addCourse", {
		userwx : u,
		wxaccount : acc,
		day : d,
		courseName : cn,
		teacher : t,
		address : add,
		startLession : sl,
		endLession : el,
		startWeek : sw,
		endWeek : ew,
		isDifWeek : idw
	}, function(data) {
		if (data == "true") {
			resetAll();
			var stw = $("#addSuccess").css("width");
			var left = (document.body.clientWidth - 20 - parseInt(stw)) / 2;
			var top = document.body.scrollTop;
			$("#addSuccess").css("left", (left + 5));
			$("#addSuccess").css("top", (top + 100));
			$("#addSuccess").show();
		} else {
			$("#msg").text("添加失败，请稍后重试");
			$("#add_btn").attr("disabled",false);
			$("#add_btn").val("添加");
		}
	});
}
</script>
	</head>

	<body onunload="resetAll();">
		<div>

			<form action="" method="post" name="form">
				<div class="html5yj">
					<div class="formhead">
						添加课程
					</div>
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<th class="text">
								星期：
							</th>
							<td class="input">
								<select class="html5input" name="day" id="day"
									onclick="clearMsg();">
									<option value="1">
										星期一
									</option>
									<option value="2">
										星期二
									</option>
									<option value="3">
										星期三
									</option>
									<option value="4">
										星期四
									</option>
									<option value="5">
										星期五
									</option>
									<option value="6">
										星期六
									</option>
									<option value="7">
										星期日
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<th class="text">
								课程名：
							</th>
							<td class="input">
								<input class="html5input" name="courseName"
									onclick="clearMsg();">
							</td>
						</tr>
						<tr>
							<th class="text">
								老师：
							</th>
							<td class="input">
								<input class="html5input" name="teacher" onclick="clearMsg();">
							</td>
						</tr>
						<tr>
							<th class="text">
								地点：
							</th>
							<td class="input">
								<input class="html5input" name="address" onclick="clearMsg();">
							</td>
						</tr>
						<tr>
							<th class="text">
								课节数：
							</th>
							<td class="input">
								<select class="html5input" style="width: 49%"
									name="startLession" id="startLession" onclick="clearMsg();">
								</select>
								<select class="html5input" style="width: 49%" name="endLession"
									id="endLession" onclick="clearMsg();">
								</select>
							</td>
						</tr>
						<tr>
							<th class="text">
								学时周：
							</th>
							<td class="input">
								<select class="html5input" style="width: 49%" name="startWeek"
									id="startWeek" onclick="clearMsg();">
								</select>
								<select class="html5input" style="width: 49%" name="endWeek"
									id="endWeek" onclick="clearMsg();">
								</select>
							</td>
						</tr>
						<tr>
							<th class="text">
								单双周：
							</th>
							<td class="input">
								<select class="html5input" name="isDifWeek"
									onclick="clearMsg();">
									<option value="0" selected="selected">
										单双周
									</option>
									<option value="1">
										单周
									</option>
									<option value="2">
										双周
									</option>
								</select>
							</td>
						</tr>
					</table>
					
					<div id="msg"></div>
					<input type="button" value="添加" class="html5input" id="add_btn"
						onclick="addCourse();">
				</div>
			</form>

			<!-- 添加课程成功的div -->
			<div id="addSuccess">
				<span style="color: green">添加课程成功！<br />最好一次性添加完所有课程</span>
				<input type="button" value="继续添加" class="html5input"
					style="width: 90%; margin-top: 6px"
					onclick="location='course/addCourse.jsp?userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
				<input type="button" value="已全部完成" class="html5input"
					style="width: 90%; margin-top: 10px"
					onclick="location='/mobile/course?ac=getWeekCourses&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
			</div>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
