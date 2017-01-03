<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.wxschool.entity.Course"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	Course course = (Course) request.getAttribute("course");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>课程详细信息</title>

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
</style>
		<script type="text/javascript">
$(function() {
	checkMM();
	
	var ops = init_select(1, 9);
	$("#startLession").append(ops);
	ops = init_select(2, 10);
	$("#endLession").append(ops);
	ops = init_select(1, 24);
	$("#startWeek").append(ops);
	ops = init_select(2, 25);
	$("#endWeek").append(ops);
	
	var day = <%=course.getDay()%>;
	var startLession = <%=course.getStartLession()%>;
	var endLession = <%=course.getEndLession() - 1%>;
	var startWeek = <%=course.getStartWeek()%>;
	var endWeek = <%=course.getEndWeek() - 1%>;
	var isDifWeek = <%=course.getIsDifWeek()%>;
	
	$("#day option:nth-child("+day+")").attr("selected",true);
	$("#startLession option:nth-child("+startLession+")").attr("selected",true);
	$("#endLession option:nth-child("+endLession+")").attr("selected",true);
	$("#startWeek option:nth-child("+startWeek+")").attr("selected",true);
	$("#endWeek option:nth-child("+endWeek+")").attr("selected",true);
	$("#isDifWeek option:nth-child("+(isDifWeek+1)+")").attr("selected",true);
	
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

function updateCourse() {
	var cId = <%=course.getCourseId()%>;
	var d = document.getElementsByName("day")[0].value;
	var cn = document.getElementsByName("courseName")[0].value;
	var t = document.getElementsByName("teacher")[0].value;
	var add = document.getElementsByName("address")[0].value;
	var sl = document.getElementsByName("startLession")[0].value;
	var el = document.getElementsByName("endLession")[0].value;
	var sw = document.getElementsByName("startWeek")[0].value;
	var ew = document.getElementsByName("endWeek")[0].value;
	var idw = document.getElementsByName("isDifWeek")[0].value;

	if ($.trim(cn) == "" || $.trim(t) == ""
			|| $.trim(add) == "") {
		$("#msg").text("不能为空");
		return false;
	}
	
	$("#upd_btn").attr("disabled",true);
	$("#upd_btn").val("更新中...");
	
	$.post("/mobile/course?ac=updateCourse", {
		courseId:cId,
		day:d,
		courseName:cn,
		teacher:t,
		address:add,
		startLession:sl,
		endLession:el,
		startWeek:sw,
		endWeek:ew,
		isDifWeek:idw},
		function(data){
			if(data == "true"){
				window.location.href = '/mobile/course?ac=getWeekCourses&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>';
			}else{
				$("#msg").text("保存失败，请稍后重试");
				$("#upd_btn").attr("disabled",false);
				$("#upd_btn").val("如果信息有误，修改后点击保存");
			}
		});
}

function deleteCourse() {
	var cId = <%=course.getCourseId()%>;
	
	$("#del_btn").attr("disabled",true);
	$("#del_btn").val("删除中...");
	
	$.post("/mobile/course?ac=deleteCourse", {
		courseId:cId},
		function(data){
			if(data == "true"){
				window.location.href = '/mobile/course?ac=getWeekCourses&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>';
			}else{
				$("#msg").text("删除失败，请稍后重试");
				$("#del_btn").attr("disabled",false);
				$("#del_btn").val("如果确定此课程多余，点击删除");
			}
		});
}
</script>
	</head>

	<body>

		<form action="">
			<div class="html5yj">
				<div class="formhead">
					修改信息
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
							<input class="html5input" name="courseName" onclick="clearMsg();"
								value="<%=course.getCoureName()%>">
						</td>
					</tr>
					<tr>
						<th class="text">
							老师：
						</th>
						<td class="input">
							<input class="html5input" name="teacher" onclick="clearMsg();"
								value="<%=course.getTeacher()%>">
						</td>
					</tr>
					<tr>
						<th class="text">
							地点：
						</th>
						<td class="input">
							<input class="html5input" name="address" onclick="clearMsg();"
								value="<%=course.getAddress()%>">
						</td>
					</tr>
					<tr>
						<th class="text">
							课节数：
						</th>
						<td class="input">
							<select class="html5input" style="width: 49%" name="startLession"
								id="startLession" onclick="clearMsg();">
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
							<select class="html5input" name="isDifWeek" id="isDifWeek"
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
				<input type="button" value="如果信息有误，修改后点击保存" class="html5input"
					id="upd_btn" onclick="updateCourse();">
				<input type="button" value="如果确定此课程多余，点击删除" class="html5input"
					id="del_btn" onclick="deleteCourse();" style="margin-top: 10px">
			</div>
		</form>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
