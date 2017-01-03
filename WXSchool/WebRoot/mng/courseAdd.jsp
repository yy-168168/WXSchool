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
	String wxaccount = request.getParameter("wxid");
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
		<script type="text/javascript" src="static_/school_depart_major.js">
</script>

		<script type="text/javascript">
$(function() {
	init_gradeInSchool($("#grade"));//初始化年级

	var schoolId = '<%=wxaccount%>';
	init_depart($("#depart"), schoolId, "default");//初始化系别

	$("#depart").change(function() {
		var index = $("#depart option:selected").attr("label");
		init_major($("#major"), schoolId, index, "default");//初始化专业
		});
});

function check() {
	var grade = document.getElementsByName("grade")[0].value;
	var depart = document.getElementsByName("depart")[0].value;
	var major = document.getElementsByName("major")[0].value;
	var picUrl = document.getElementsByName("picUrl")[0].value;

	if ($.trim(picUrl) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (depart == "院系") {
		showNotice("请选择院系");
		return false;
	}

	if (picUrl.length > 200) {
		showNotice("数据过长！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/course?ac=addCourse&token=<%=token%>";
	$.post(url, {
		grade : grade,
		major : major,
		picUrl : picUrl
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
			$(":button").attr("disabled", false);
			$(":button").val("保存");
		} else {
			isGoonUpt();
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
					添加课表
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
									<select name="grade" id="grade"
										style="width: 300px; padding: 0" class="input_text">
									</select>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									院系
									<span class="myrequired">*</span>
								</td>
								<td>
									<select name="depart" id="depart"
										style="width: 300px; padding: 0" class="input_text">
									</select>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									专业
									<span class="myrequired">*</span>
								</td>
								<td>
									<select name="major" id="major"
										style="width: 300px; padding: 0" class="input_text">
										<option value="1">
											专业
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									课表图片外链地址
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="picUrl" value="" class="input_text"
										size="50">
									<br />
									<span class="textSpan">图片大小：宽度为800px，高度不限； 建议用左旋转图</span>
									<a href="javascript:tuchuang();" style="font-size: 13px">获取外链</a>
								</td>
							</tr>
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
