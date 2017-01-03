<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String day = request.getParameter("day");
	int dayIndex;
	if (day == null) {
		dayIndex = 0;
	} else {
		dayIndex = Integer.parseInt(day);
	}
	String[] colors = { "#A6A42E", "#F0B813", "#EB6F29", "#F0B813",
			"#A6A42E" };
	String[] difWeek = { "", "(单周)", "(双周)" };
	String[] dayName = { "Today", "Monday", "Tuesday ", "Wednesday",
			"Thursday", "Friday", "Saturday", "Sunday" };
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title><%=dayName[dayIndex]%></title>

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
th,td {
	border-bottom: 1px solid #aaa;
}

th {
	border-right: 3px solid;
}
</style>
		<script type="text/javascript">
$(function() {
	checkMM();

	$("table tr").last().children().css("border-bottom", "0");
});
</script>
	</head>

	<body onclick="hideMenu(event);">
		<%
			List<Course> courses = (List<Course>) request
					.getAttribute("courses");
			Student stu = (Student) request.getAttribute("stu");
			if (courses == null) {
		%>
		<div class="html5yj" style="padding: 10px">
			显示课表出错了,刷新试试吧
		</div>
		<%
			} else if (courses.size() == 0) {
		%>
		<div class="html5yj"
			style="margin-top: 70px; height: 100px; line-height: 100px; text-align: center;">
			今日没课
		</div>
		<div style="margin-top: 6px">
			注：
			<span id="nowWeek"></span>
		</div>
		<%
			} else {
		%>
		<div class="html5yj">
			<table width="100%" cellpadding="0" cellspacing="0">
				<%
					for (int i = 0; i < courses.size(); i++) {
							Course cour = courses.get(i);
				%>
				<tr height="65px" align="center">
					<th width="26%" style="border-right-color: <%=colors[i]%>;">
						<%=cour.getStartLession()%>-<%=cour.getEndLession()%>
					</th>
					<td
						onclick="location='/mobile/course?ac=getCourseById&courseId=<%=cour.getCourseId()%>&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
						<%=cour.getCoureName()%><%=difWeek[cour.getIsDifWeek()]%>
						<br />
						@<%=cour.getTeacher()%>-<%=cour.getAddress()%>
					</td>
					<td>
						<img alt="" src="static_/go.png" height="14px">
					</td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>

		<div id="showMenu" onclick="showMenu();">
		</div>

		<div id="bar_menu" style="width: 60%; left: 20%;">
			<div id="bar_menu_dt">
				<%
					String url = "/mobile/course?ac=getCoursesByDay&wxaccount=" + wxaccount
							+ "&userwx=" + userwx + "&major=" + stu.getMajor()
							+ "&grade=" + stu.getGrade() + "&day=";
				%>
				<ul style="list-style: none; margin: 0; padding: 0">
					<li
						onclick="menuClick(this,'course/addCourse.jsp?userwx=<%=userwx%>&wxaccount=<%=wxaccount%>');">
						添加课程
					</li>
					<li onclick="menuClick(this,'<%=url%>7');"
						style="float: left; width: 49.9%; border-right: 1px solid #666">
						星期日
					</li>
					<li onclick="menuClick(this,'<%=url%>6');">
						星期六
					</li>
					<li onclick="menuClick(this,'<%=url%>5');"
						style="float: left; width: 49.9%; border-right: 1px solid #666">
						星期五
					</li>
					<li onclick="menuClick(this,'<%=url%>4');">
						星期四
					</li>
					<li onclick="menuClick(this,'<%=url%>3');"
						style="float: left; width: 49.9%; border-right: 1px solid #666">
						星期三
					</li>
					<li onclick="menuClick(this,'<%=url%>2');">
						星期二
					</li>
					<li onclick="menuClick(this,'<%=url%>1');"
						style="float: left; width: 49.9%; border-right: 1px solid #666">
						星期一
					</li>
					<li onclick="menuClick(this,'/mobile/course?ac=getWeekCourses&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>');">
						周课表
					</li>
				</ul>
			</div>
		</div>

		<jsp:include page="../common/copyright.jsp" />		
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
