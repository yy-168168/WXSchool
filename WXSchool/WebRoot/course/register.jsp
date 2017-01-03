<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>信息绑定</title>

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
		<script type="text/javascript" src="<%=basePath %>static_/school_depart_major.js">
</script>

		<script type="text/javascript">
function check() {
	var grade = document.getElementsByName("grade")[0].value;
	var depart = document.getElementsByName("depart")[0].value;
	var major = document.getElementsByName("major")[0].value;

	if (depart == "院系") {
		$("#msg").text("请选择院系");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/course?ac=updateStu&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		depart : depart,
		major : major,
		grade : grade
	}, function(data) {
		if (data == "true") {
			//document.form.reset();
			//window.location.href = "/mobile/course?ac=isExist&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
			$("#msg").text("信息提交成功，请返回主菜单");
		} else {
			$("#msg").text("信息提交失败，请稍后重试");
		}

		$(":button").attr("disabled", false);
		$(":button").val("绑定");
	});
}

$(function() {
	checkMM();

	var sh = '<%=wxaccount%>';
	init_depart($("#depart"), sh, "default");//初始化系别

	$("#depart").change(function() {
		var index = $("#depart option:selected").attr("label");
		init_major($("#major"), sh, index, "default");//初始化专业
		});

	init_gradeInSchool($("#grade"));//初始化年级
});
</script>
	</head>

	<body>

		<!-- 
		<div>
			<form name="form">
				<div style="line-height: 1.7">
					学号:
					<input type="text" name="grade" class="html5input"
						onclick="clearMsg();">
					院系：
					<select class="html5input" name="depart" id="depart"
						onclick="clearMsg();">
					</select>
					专业：
					<select class="html5input" name="major" id="major"
						onclick="clearMsg();">
						<option value="1">
							专业
						</option>
					</select>
				</div>

				<div id="msg" style="font-size: 13px; height: 20px; color: red;"></div>
				<div style="text-align: center;">
					<input type="hidden" name="userwx" value="<%=userwx%>">
					<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
					<input type="button" value="绑定" class="html5btn" onclick="check();">
				</div>
			</form>
			<div style="color: red; font-size: 14px">
				注：请认真填写，一旦填错，就找不到本专业的课表咯！
			</div>
		</div>
		 -->

		<form name="form">
			<div class="html5yj">
				<div class="formhead">
					信息绑定
				</div>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="text">
							年级：
						</td>
						<td class="input">
							<select class="html5input" name="grade" id="grade"
								onclick="clearMsg();">
							</select>
						</td>
					</tr>
					<tr>
						<td class="text">
							院系：
						</td>
						<td class="input">
							<select class="html5input" name="depart" id="depart"
								onclick="clearMsg();"></select>
						</td>
					</tr>
					<tr>
						<td class="text">
							专业：
						</td>
						<td class="input">
							<select class="html5input" name="major" id="major"
								onclick="clearMsg();">
								<option value="1">
									专业
								</option>
							</select>
						</td>
					</tr>
				</table>
			</div>

			<div id="msg"></div>
			<div style="text-align: center;">
				<input type="hidden" name="userwx" value="<%=userwx%>">
				<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
				<input type="button" value="绑定" class="html5btn" onclick="check();">
			</div>
		</form>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
