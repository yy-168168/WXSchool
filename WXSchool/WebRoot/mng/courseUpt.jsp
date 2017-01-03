<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String token = request.getParameter("token");
	String grade = "", major = "", picUrl = "", courseId = "-1";
	Course course = (Course) request.getAttribute("course");
	if (course != null) {
		grade = course.getGrade() + "";
		major = course.getMajor();
		picUrl = course.getPicUrl();
		courseId = course.getCourseId() + "";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 课表管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/mng.js">
</script>

		<script type="text/javascript">
function check() {
	var grade = document.getElementsByName("grade")[0].value;
	var major = document.getElementsByName("major")[0].value;
	var picUrl = document.getElementsByName("picUrl")[0].value;

	if ($.trim(grade) == "" || $.trim(major) == "" || $.trim(picUrl) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (grade.length > 10 || major.length > 50 || locUrl.length > 200) {
		showNotice("数据过长！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/course?ac=uptCourse&token=<%=token%>";
	$.post(url, {
		courseId : '<%=courseId%>',
		grade : grade,
		major : major,
		picUrl : picUrl
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
			$(":button").attr("disabled", false);
			$(":button").val("保存");
		} else {
			window.location.href = document.referrer;
		}
	});
}
</script>
	</head>
	<body>
		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div class="left">
				<jsp:include page="/mng/menuLeft.jsp">
					<jsp:param value="" name="id" />
				</jsp:include>
			</div>

			<div class="right">
				<div class="title">
					更新课表
					<div style="float: right">
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div style="padding: 20px;">

					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									年级
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="grade" value="<%=grade%>"
										class="input_text" size="30">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									专业
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="major" value="<%=major%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									课表图片外链地址
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="picUrl" value="<%=picUrl%>"
										class="input_text" size="50">
									<br />
									<span class="textSpan">图片大小：宽度为800px，高度不限； 建议用左旋转图</span>
									<a href="javascript:tuchuang();" style="font-size: 13px">获取外链</a>
								</td>
							</tr>
							<%
								if (picUrl != null && !picUrl.equals("")) {
							%>
							<tr>
								<td></td>
								<td>
									<img alt="" src="<%=picUrl%>" width="360px"
										style="border: 1px solid #EEE">
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<td class="form_title">
								</td>
								<td>
									<input type="button" value="保存" class="input_button"
										onclick="check();">
									<div id="erromsg" style="display: inline;"></div>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
