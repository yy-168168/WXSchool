<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String aId = request.getParameter("aId");
%>
<%
	Student stu = (Student) request.getAttribute("stu");
	String stuName = "", stuNum = "", grade = "2016", depart = "", major = "", 
		province = "", city = "", county = "", find = "", sex = "1";
	if (stu != null) {
		stuName = stu.getStuName();
		stuName = stuName == null ? "" : stuName;
		stuNum = stu.getStuNum();
		stuNum = stuNum == null ? "" : stuNum;
		grade = stu.getGrade();
		grade = grade == null ? "" : grade;
		depart = stu.getDepart();
		depart = depart == null ? "" : depart;
		major = stu.getMajor();
		major = major == null ? "" : major;
		province = stu.getProvince();
		province = province == null ? "" : province;
		city = stu.getCity();
		city = city == null ? "" : city;
		county = stu.getCounty();
		county = county == null ? "" : county;
		find = stu.getFind();
		find = find == null ? "" : find;
		sex = stu.getSex() == 0 ? "1" : stu.getSex() + "";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>个人信息</title>

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
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=09191840">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/school_depart_major.js?v=09191840">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/province.js?v=09191840">
</script>

		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
});
		
function check() {
	//var personId = document.getElementsByName("personId")[0].value;
	//var password = document.getElementsByName("password")[0].value;
	var stuName = document.getElementsByName("stuName")[0].value;
	var stuNum = document.getElementsByName("stuNum")[0].value;
	var grade = document.getElementsByName("grade")[0].value;
	var depart = document.getElementsByName("depart")[0].value;
	var major = document.getElementsByName("major")[0].value;
	var province = document.getElementsByName("province")[0].value;
	var city = document.getElementsByName("city")[0].value;
	var county = document.getElementsByName("county")[0].value;
	var find = document.getElementsByName("find")[0].value;
	var sex = document.getElementsByName("sex")[0].value;

	//if ($.trim(personId) == "" || $.trim(password) == "") {
	//$("#msg").text("不能为空");
	//return false;
	//}

	//if ($.trim(stuNum).length != 10 || isNaN(stuNum)) {
	//	$("#msg").text("请正确输入学号");
	//	return false;
	//}
	
	if ($.trim(stuName) == "") {
		//$("#msg").text("请认真填写姓名");
		alert("请输入姓名");
		return false;
	}
	
	if ($.trim(stuNum) == "") {
		//$("#msg").text("请认真填写姓名");
		alert("请输入学号");
		return false;
	}
	
	if (depart == "" || depart == "院系") {
		//$("#msg").text("请选择院系");
		alert("请选择院系");
		return false;
	}

	if (province == "" || province == "省") {
		//$("#msg").text("请选择所在省");
		alert("请选择所在省");
		return false;
	}

	/*if ($.trim(find) == "") {
		$("#msg").text("请填写微信号");
		return false;
	}*/

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/stu?ac=updateStuAll&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		//personId : personId,
		//password : password,
		stuName : stuName,
		stuNum : stuNum,
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
			//window.history.go(-1);
			alert("注册完毕");
			WeixinJSBridge.invoke('closeWindow', {}, function(res) {});
		} else {
			//$("#msg").text("信息提交失败");
			alert("信息提交失败");
			$(":button").attr("disabled", false);
			$(":button").val("提交");
		}
	});
}

$(function() {
	checkMM();

	init_gradeInSchool($("#grade"));//初始化年级
	optionDefaultSelect($("#grade").children(), "<%=grade%>");

	var schoolId = '<%=wxaccount%>';
	init_depart($("#depart"), schoolId, "<%=depart%>");//设置学院的已选项
	var index = $("#depart option:selected").attr("label");
	init_major($("#major"), schoolId, index, "<%=major%>");//设置专业的已选项

	$("#depart").change(function() {
		var index = $("#depart option:selected").attr("label");
		$("#major").empty();
		init_major($("#major"), schoolId, index, "default");//初始化专业
		});

	init_province($("#province"), "<%=province%>");//设置省的已选项
	var provinceId = $("#province option:selected").attr("label");
	init_city($("#city"), provinceId, "<%=city%>");//设置市的已选项
	setTimeout(function(){
		var cityId = $("#city option:selected").attr("label");
		init_county($("#county"), provinceId, cityId, "<%=county%>");//设置县的已选项
	}, 2000);

	$("#province").change(function() {
		provinceId = $("#province option:selected").attr("label");
		$("#city").empty();
		init_city($("#city"), provinceId, "default");//初始化市
			init_county($("#county"), provinceId, null, "default");//初始化县
		});

	$("#city").change(function() {
		cityId = $("#city option:selected").attr("label");
		init_county($("#county"), provinceId, cityId, "default");//初始化县
		});

	optionDefaultSelect($("#sex").children(), "<%=sex%>");
	optionDefaultSelect($("#grade").children(), "<%=grade%>");
	
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
});
</script>
	</head>

	<body>
		<form name="form">
			<div class="html5yj">
				<div class="formhead_n">
					<div>
						<span class="glyphicon glyphicon-edit"></span>&nbsp;个人信息
					</div>
					<div>
						信息一旦提交将不可更改
					</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div class="text1">
						姓名
					</div>
					<input type="text" class="html5input_n" name="stuName" value="<%=stuName %>"
						onclick="clearMsg();" placeholder="">
					<hr />
					<div class="text1">
						学号
					</div>
					<input type="text" class="html5input_n" name="stuNum" value="<%=stuNum %>"
						onclick="clearMsg();" placeholder="">
					<hr />
					<div class="text1">
						年级
					</div>
					<select class="html5input_n" name="grade" id="grade"
						onclick="clearMsg();">
					</select>
					<hr />
					<div class="text1">
						院系
					</div>
					<select class="html5input_n" name="depart" id="depart"
						onclick="clearMsg();">
							<option value="">
								院系
							</option>
					</select>
					<hr />
					<div class="text1">
						专业
					</div>
					<select class="html5input_n" name="major" id="major"
						onclick="clearMsg();">
						<option value="">
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
					</select>
					<hr />
					<div class="text1">
						所在区县
					</div>
					<select class="html5input_n" name="county" id="county"
						onclick="clearMsg();">
					</select>
					<hr />
					<div class="text1">
						性别
					</div>
					<select class="html5input_n" name="sex" id="sex"
						onclick="clearMsg();">
						<option value="1">
							男
						</option>
						<option value="2">
							女
						</option>
					</select>
					<hr />
					<div class="text1">
						微信号(选填)
					</div>
					<input type="text" class="html5input_n" name="find"
						onclick="clearMsg();" value="<%=find%>">
					<hr />
					<input type="button" value="提交" class="html5btn"
						onclick="check();">
					<div id="msg"></div>
				</div>
			</div>
		</form>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
