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
		<link type="image/x-icon" rel="shortcut icon" href="static_/favicon.ico" />
		<link href="static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath%>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/province.js">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/school_depart_major.js">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">
function check() {
	var stuName = document.getElementsByName("stuName")[0].value;
	var grade = document.getElementsByName("grade")[0].value;
	var depart = document.getElementsByName("depart")[0].value;
	var major = document.getElementsByName("major")[0].value;
	var province = document.getElementsByName("province")[0].value;
	var city = document.getElementsByName("city")[0].value;
	var county = document.getElementsByName("county")[0].value;
	var find = document.getElementsByName("find")[0].value;
	var sex = document.getElementsByName("sex")[0].value;

	if ($.trim(stuName) == "") {
		$("#msg").text("请认真填写姓名");
		return false;
	}

	if (depart == "" || depart == "院系") {
		$("#msg").text("请选择院系");
		return false;
	}

	if (province == "省") {
		$("#msg").text("请选择所在省");
		return false;
	}

	if ($.trim(find) == "") {
		$("#msg").text("请填写微信号");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/friend?ac=updateStu&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";

	$.post(url, {
		stuName : stuName,
		grade : grade,
		depart : depart,
		major : major,
		province : province,
		city : city,
		county : county,
		find : find,
		sex : sex
	}, function(data) {
		if (data == "true") {
			document.form.reset();
			window.location.href = "/friend/listfellow.jsp?"
					+ "wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		} else {
			$("#msg").text("信息提交失败，请稍后重试");
			$(":button").attr("disabled", false);
			$(":button").val("提交");
		}
	});
}

$(function() {
	checkMM();

	init_gradeInSchool($("#grade"));//初始化年级

	var sh = '<%=wxaccount%>';
	init_depart($("#depart"), sh, "default");//初始化系别

	$("#depart").change(function() {
	var index = $("#depart option:selected").attr("label");
	init_major($("#major"), sh, index, "default");//初始化专业
	});
	
	init_province($("#province"), "default");//初始化省
	var provinceId;

	$("#province").change(function() {
		provinceId = $("#province option:selected").attr("label");
		init_city($("#city"), provinceId, "default");//初始化市
			init_county($("#county"), provinceId, provinceId.substr(0, 2)
					+ "0100", "default");//初始化县
		});

	$("#city").change(function() {
		var cityId = $("#city option:selected").attr("label");
		init_county($("#county"), provinceId, cityId, "default");//初始化县
		});
});
</script>
	</head>

	<body>

		<form name="form">
			<div class="html5yj">
				<div class="formhead_n">
					<div>
						<span class="glyphicon glyphicon-edit"></span>&nbsp;注册个人信息
					</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div class="text1">
						姓名
					</div>
					<input type="text" class="html5input_n" name="stuName"
						onclick="clearMsg();" placeholder="姓名一旦填写不可修改">
					<hr />
					<div class="text1">
						年级
					</div>
					<select id="grade" class="html5input_n" name="grade"
						onclick="clearMsg();">
					</select>
					<hr />
					<div class="text1">
						院系
					</div>
					<select class="html5input_n" name="depart" id="depart"
						onclick="clearMsg();"></select>
					<hr />
					<div class="text1">
						专业
					</div>
					<select class="html5input_n" name="major" id="major" 
						onclick="clearMsg();">
						<option value="1">
							专业
						</option>
					</select>
					<hr />
					<div class="text1">
						所在省
					</div>
					<select class="html5input_n" name="province" id="province"
						onclick="clearMsg();">
						<option value="省">
							省
						</option>
					</select>
					<hr />
					<div class="text1">
						所在市
					</div>
					<select class="html5input_n" name="city" id="city"
						onclick="clearMsg();">
						<option value="市">
							市
						</option>
					</select>
					<hr />
					<div class="text1">
						所在县区
					</div>
					<select class="html5input_n" name="county" id="county"
						onclick="clearMsg();">
						<option value="区县">
							区县
						</option>
					</select>
					<hr />
					<div class="text1">
						微信号
					</div>
					<input type="text" class="html5input_n" name="find"
						onclick="clearMsg();">
					<hr />
					<div class="text1">
						性别
					</div>
					<select class="html5input_n" name="sex" onclick="clearMsg();">
						<option value="1">
							男
						</option>
						<option value="2">
							女
						</option>
					</select>
					<hr />
					<input type="button" value="提 交" class="html5btn"
						onclick="check();">
					<div id="msg"></div>
				</div>
				<!-- 
				<div class="formhead">
					信息绑定
				</div>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="text">
							姓名：
						</td>
						<td class="input">
							<input type="text" class="html5input" name="stuName"
								onclick="checkName(this)" value="姓名一旦填写不可修改">
						</td>
					</tr>
					<tr>
						<td class="text">
							年级：
						</td>
						<td class="input">
							<select id="grade" class="html5input" name="grade"
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
					<tr>
						<td class="text">
							所在省：
						</td>
						<td class="input">
							<select class="html5input" name="province" id="province"
								onclick="clearMsg();">
								<option value="省">
									省
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="text">
							所在市：
						</td>
						<td class="input">
							<select class="html5input" name="city" id="city"
								onclick="clearMsg();">
								<option value="市">
									市
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="text">
							所在县区：
						</td>
						<td class="input">
							<select class="html5input" name="county" id="county"
								onclick="clearMsg();">
								<option value="区县">
									区县
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="text">
							微信号：
						</td>
						<td class="input">
							<input type="text" class="html5input" name="find"
								onclick="clearMsg();">
						</td>
					</tr>
					<tr>
						<td class="text">
							性别：
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
							<input type="button" value="提交" class="html5btn"
								onclick="check();">
							<div id="msg"></div>
						</td>
					</tr>
				</table>
				 -->
			</div>
		</form>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
