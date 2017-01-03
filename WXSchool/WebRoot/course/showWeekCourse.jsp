<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.wxschool.entity.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String[] cstr = { "Monday", "Tuesday ", "Wednesday", "Thursday",
			"Friday", "Saturday", "Sunday" };
	String[] difWeek = { "", "(单周)", "(双周)" };
	String[] colors = { "#A79303", "#FEA602", "#FC1F04", "#48793D",
			"#F5661E", "#F5661E", "#FEA602" };
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>周课表</title>

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
.dayt {
	padding: 10px;
	text-align: center;
	border-bottom: 1px solid #D5D5D5;
	font-weight: 800;
	font-size: 20px
}

th,td {
	border-bottom: 1px solid #D5D5D5;
}

th {
	border-right: 2px solid;
}
</style>
		<script type="text/javascript">
$(function() {
	checkMM();

	$("table").each(function() {
		$(this).find("tr").last().children().css("border-bottom", "0");
	});
});
</script>
	</head>

	<body>
		<div>
			<%
				List<CourseList> courseList = (List<CourseList>) request
						.getAttribute("courseList");
				if (courseList == null || courseList.size() == 0) {
			%>
			<div class="html5yj" style="padding: 5px 10px">
				显示课表出错咯，刷新试试；如果还不行，请稍后重试
			</div>
			<%
				} else {
					int nowDay = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);
					nowDay = nowDay == 1 ? 8 : nowDay;
					nowDay -= 1;
					int dayIndex = nowDay;
					int size = courseList.size();
					int index = 0;
					while (true) {
			%>
			<div class="html5yj">
				<div class="dayt">
					<%=cstr[dayIndex - 1]%>
				</div>
				<div>
					<%
						CourseList dayCourse = courseList.get(index);
								int day = dayCourse.getDay();
								if (dayIndex == day) {
									List<Course> courses = dayCourse.getCourses();
									int courseSize = courses.size();
					%>
					<table width="100%" cellpadding="0" cellspacing="0">
						<%
							for (int i = 0; i < courses.size(); i++) {
											Course cour = courses.get(i);
						%>
						<tr height="50px" align="center">
							<th width="26%" style="border-right-color: <%=colors[i]%>;">
								<%=cour.getStartLession()%>-<%=cour.getEndLession()%>
							</th>
							<td
								onclick="location='/mobile/course?ac=getCourseById&courseId=<%=cour.getCourseId()%>&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
								<%=cour.getCoureName()%><%=difWeek[cour.getIsDifWeek()]%>
								<br />
								@<%=cour.getTeacher()%>-<%=cour.getAddress()%>
							</td>
							<td width="15%">
								<img alt="" src="static_/go.png" height="14px">
							</td>
						</tr>
						<%
							}
						%>
					</table>
					<%
						index++;
								} else {
					%>
					<table width="100%" cellpadding="0" cellspacing="0">
						<tr height="50px" align="center">
							<th width="26%"
								style="border-right-color: <%=colors[dayIndex - 1]%>;">
								1-10
							</th>
							<td
								onclick="location='course/addCourse.jsp?day=<%=dayIndex%>&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
								没课咯
							</td>
							<td width="15%">
								<img alt="" src="static_/go.png" height="14px">
							</td>
						</tr>
					</table>
					<%
						}
					%>
				</div>
			</div>
			<%
				dayIndex++;
						if (dayIndex > 7) {
							dayIndex = 1;
						}
						if (index >= size - 1) {
							if (dayIndex == nowDay) {
								break;
							} else {
								index = size - 1;
							}
						}
					}
				}
			%>
		</div>

		<div id="showMenu"
			onclick="location='/mobile/course?ac=isExist&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>'">
		</div>

		<jsp:include page="../common/copyright.jsp" />		
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
