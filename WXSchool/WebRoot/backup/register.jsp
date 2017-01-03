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
		<link href="static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/mycommon.js">
</script>
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/school_depart_major.js">
</script>

		<script type="text/javascript">
function check() {
	var personId = document.getElementsByName("personId")[0].value;
	var password = document.getElementsByName("password")[0].value;
	var grade = document.getElementsByName("grade")[0].value;
	var depart = document.getElementsByName("depart")[0].value;
	var major = document.getElementsByName("major")[0].value;
	var sex = document.getElementsByName("sex")[0].value;

	if ($.trim(personId) == "" || $.trim(password) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	if ($.trim(grade).length != 10 || isNaN(grade)) {
		$("#msg").text("请正确输入学号");
		return false;
	}

	if (depart == "院系") {
		$("#msg").text("请选择院系");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/stu?ac=addStu&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$
			.post(
					url,
					{
						personId : personId,
						password : password,
						grade : grade,
						depart : depart,
						major : major,
						sex : sex
					},
					function(data) {
						if (data == "true") {
							document.form.reset();
							window.location.href = '/mobile/score?ac=myscore&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>';
						} else if (data == "wrong") {
							$("#msg").text("登录名或密码错误");
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
	var a = init_depart($("#depart"), sh, "default");//初始化系别

	$("#depart").change(function() {
		var index = $("#depart option:selected").attr("label");
		init_major($("#major"), sh, index, "default");//初始化专业
		});
});
</script>
	</head>

	<body>

		<!-- 
		<div>
			<form name="form">
				<div style="line-height: 1.8">
					登录名
					<span style="font-size: 13px;">(用户名/邮箱/身份证号)</span>：
					<input type="text" name="personId" class="html5input"
						onclick="clearMsg();">
					教务平台(新版)密码:
					<input type="text" name="password" class="html5input"
						onclick="clearMsg();">
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
					性别：
					<select class="html5input" name="sex" onclick="clearMsg();">
						<option value="1">
							男
						</option>
						<option value="2">
							女
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
				注：请认真填写，一旦填错，将影响成绩查询或其它查询！
			</div>
		</div>
		 -->

		<form name="form">
			<div class="html5yj">
				<div class="formhead">
					<span class="glyphicon glyphicon-edit"></span>&nbsp;信息绑定
				</div>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="text">
							用户名
						</td>
						<td class="input">
							<input type="text" name="personId" class="html5input"
								onclick="clearMsg();">
						</td>
					</tr>
					<tr>
						<td class="text">
							密码
						</td>
						<td class="input">
							<input type="text" name="password" class="html5input"
								onclick="clearMsg();">
						</td>
					</tr>
					<tr>
						<td class="text">
							学号
						</td>
						<td class="input">
							<input type="text" name="grade" class="html5input"
								onclick="clearMsg();">
						</td>
					</tr>
					<tr>
						<td class="text">
							院系
						</td>
						<td class="input">
							<select class="html5input" name="depart" id="depart"
								onclick="clearMsg();">
							</select>
						</td>
					</tr>
					<tr>
						<td class="text">
							专业
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
					<tr>
						<td class="text">
							性别
						</td>
						<td class="input">
							<select class="html5input" name="sex" onclick="clearMsg();">
								<option value="1">
									男
								</option>
								<option value="2">
									女
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="btn">
							<input type="button" value="绑定" class="html5btn"
								onclick="check();">
							<div id="msg"></div>
						</td>
					</tr>
				</table>
			</div>

		</form>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
