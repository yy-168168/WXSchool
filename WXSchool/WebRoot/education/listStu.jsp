<%@ page import="com.wxschool.entity.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.net.URLEncoder"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String aId = request.getParameter("aId");

	String grade = request.getParameter("grade");
	grade = grade == null ? "" : grade;
	String sex = request.getParameter("sex");
	sex = sex == null ? "0" : sex;
	String province = request.getParameter("province");
	province = province == null ? "" : province;
	//String city = request.getParameter("city");
	String depart = request.getParameter("depart");
	depart = depart == null ? "" : depart;
	//String major = request.getParameter("major");

	Object o_p = request.getAttribute("page");
	int curPage = 1, totalPage = 1;
	if (o_p != null) {
		Page p = (Page) o_p;
		curPage = p.getCurPage();
		totalPage = p.getTotalPage();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>校内聊</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon"
			href="<%=basePath%>static_/favicon.ico" />
		<link href="<%=basePath%>static_/mycommon.css" type="text/css"
			rel="stylesheet">
		<link href="<%=basePath%>static_/myfont.css" type="text/css"
			rel="stylesheet">
		<script type="text/javascript"
			src="<%=basePath%>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/mycommon.js">
</script>

		<style type="text/css">
#bar_menu_dt li {
	height: 40px;
	line-height: 40px;
}
</style>
		<script type="text/javascript">
var wxaccount = '<%=wxaccount%>';
var userwx = '<%=userwx%>';
var page = 1;
var timer, curPst;

$(function() {
	checkMM();

	init_gradeInSchool($("#grade"));//初始化年级
	optionDefaultSelect($("#grade").children(), "default");
	var schoolId = '<%=wxaccount%>';
	init_depart($("#depart"), schoolId, "default");//初始化学院
	//var index = $("#depart option:selected").attr("label");
	//init_major($("#major"), schoolId, index, "");//初始化专业

	/*$("#depart").change(function() {
		var index = $("#depart option:selected").attr("label");
		init_major($("#major"), schoolId, index, "");//初始化专业
			$("#major").empty().prepend('<option value="">按专业查询</option>');
		});*/

	init_province($("#province"), "default");//初始化省
	//var provinceId = $("#province option:selected").attr("label");
	//init_city($("#city"), provinceId, "");//初始化市

	/*$("#province").change(function() {
		var provinceId = $("#province option:selected").attr("label");
		$("#city").empty().prepend('<option value="">按所在市查询</option>');
		init_city($("#city"), provinceId, "");//初始化市
		});*/
});

function showHideSearchForm() {
	if ($("#searchForm").css("display") == 'block') {
		$("#searchForm").slideUp();
	} else {
		$("#searchForm").slideDown();
	}
}

function search() {
	var grade = document.getElementsByName("grade")[0].value;
	var depart = document.getElementsByName("depart")[0].value;
	//var major = document.getElementsByName("major")[0].value;
	var province = document.getElementsByName("province")[0].value;
	//var city = document.getElementsByName("city")[0].value;
	var sex = document.getElementsByName("sex")[0].value;

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	location.href = "mobile/stu?ac=list&wxaccount=" + wxaccount + "&userwx="
			+ userwx + "&grade=" + grade + "&depart="
			+ encodeURI(encodeURI(depart)) + "&province="
			+ encodeURI(encodeURI(province)) + "&sex=" + sex;
}

function isReg(toId) {
	var url = "mobile/stu?ac=isReg&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$
			.post(
					url,
					function(data) {
						if (data == 'false') {
							if (window.confirm("你还未注册信息，不可与他人沟通，是否前往注册？")) {
								window.location.href = "mobile/stu?ac=stuInfo&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
							}
						} else if (data == 'true') {
							window.location.href = "mobile/chat/text?ac=chat&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&to="
									+ toId;
						}
					});
}
</script>

	</head>

	<body onclick="hideMenu(event);">
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideToolbar');
});
</script>

		<div id="content">
			<%
				List<Student> stus = (List<Student>) request.getAttribute("stus");
				if (stus == null) {
			%>
			<div align="center">
				暂无任何记录
			</div>
			<%
				} else {
					for (int i = 0, len = stus.size(); i < len; i++) {
						Student stu = stus.get(i);
						WxUser wxUser = stu.getWxUser();
			%>
			<div class='view_box_white'>
				<table width='100%' cellpadding='0' cellspacing='0' border='0'>
					<tr>
						<td>
							<img src='<%=wxUser.getHeadImgUrl()%>'
								style='width: 60px; height: 60px; border-radius: 100%; margin-right: 10px'>
						</td>
						<td width='100%'>
							<div>
								<span style="font-size: 20px; font-weight: 700; color: #103261;"><%=wxUser.getNickname()%></span>
								<span style='font-size: 13px; color: blue'><%=wxUser.isOnline() ? "(在线)" : ""%></span>
							</div>
							<div style="margin-top: 5px; font-size: 13px; color: #888">
								<div>
									<%=stu.getGrade().equals("") ? "" : stu.getGrade()
							+ "级"%>
									<%=stu.getDepart().equals("") ? "" : stu
									.getDepart()%>
									<%=stu.getMajor().equals("") ? "" : stu.getMajor()%>
								</div>
								<div>
									<%=stu.getProvince().equals("") ? "" : stu
							.getProvince()%>
									<%=stu.getCity().equals("") ? "" : stu.getCity()%>
								</div>
								<%--
								<div>
									<%=stu.getFind().equals("") ? "" : stu.getFind()%>
								</div>
								--%>
							</div>
							<%
								if (wxUser.isOnline()) {
							%>
							<div style="text-align: right; font-size: 13px; color: #ccc">
								<a onclick='isReg("<%=UUID.randomUUID().toString()
								+ wxUser.getUserId()%>");'>打个招呼</a>
							</div>
							<%
								}
							%>
						
					</tr>
				</table>
			</div>
			<%
				}
				}
			%>
		</div>

		<!-- 分页 -->
		<div class="page" style="margin: 10px 10px 0 10px">
			<%
				String url = "mobile/stu?ac=list" + "&userwx=" + userwx
						+ "&wxaccount=" + wxaccount + "&grade=" + grade + "&sex="
						+ sex + "&depart=" + URLEncoder.encode(depart, "utf-8")
						+ "&province=" + URLEncoder.encode(province, "utf-8");
			%>
			<div class="page_left">
				<div class="page_first"
					onclick="return paging('first','<%=curPage%>','<%=totalPage%>','<%=url%>');">
					首页
				</div>
				<div class="page_pre"
					onclick="return paging('pre','<%=curPage%>','<%=totalPage%>','<%=url%>');">
					上一页
				</div>
			</div>
			<div class="page_cen">
				<%=curPage%>/<%=totalPage%>
			</div>
			<div class="page_right">
				<div class="page_next"
					onclick="return paging('next','<%=curPage%>','<%=totalPage%>','<%=url%>');">
					下一页
				</div>
				<div class="page_end"
					onclick="return paging('end','<%=curPage%>','<%=totalPage%>','<%=url%>');">
					尾页
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>

		<!-- 搜索 -->
		<div onclick="showHideSearchForm()"
			style="position: fixed; bottom: 70px; right: 20px; width: 50px; height: 50px; border-radius: 100%; background-color: #ccc; text-align: center;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"
				style="margin-top: 15px; color: #fff"></span>
		</div>
		<div id="searchForm" style="display: none">
			<div
				style="position: fixed; left: 0; top: 0; width: 100%; height: 100%; z-index: 10; background: #000; opacity: 0.5"></div>
			<div
				style="position: fixed; z-index: 20; bottom: 50px; left: 50%; width: 300px; margin-left: -150px; background: #fff; border-radius: 5px">
				<form name="form" style="margin: 10px">
					<table width='100%' cellpadding='0' cellspacing='10' border='0'>
						<tr>
							<td style="width: 50%">
								<select class="html5input_n" name="grade" id="grade"
									onclick="clearMsg();">
									<option value="">
										按年级查询
									</option>
								</select>
							</td>
							<td>
								<select class="html5input_n" name="sex" id="sex"
									onclick="clearMsg();">
									<option value="">
										按性别查询
									</option>
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
							<td>
								<select class="html5input_n" name="province" id="province"
									onclick="clearMsg();">
									<option value="">
										按省份查询
									</option>
								</select>
								<%--<select class="html5input_n" name="city" id="city"
									onclick="clearMsg();">
									<option value="">
										按所在市查询
									</option>
								</select>
								--%>
							</td>
							<td>
								<select class="html5input_n" name="depart" id="depart"
									onclick="clearMsg();">
									<option value="">
										按院系查询
									</option>
								</select>
								<%--<select class="html5input_n" name="major" id="major"
									onclick="clearMsg();">
									<option value="">
										按专业查询
									</option>
								</select>
								--%>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<hr />
								<input type="button" value="查询" class="html5btn"
									style="width: 100px; margin-left: 35px" onclick="search();">
								<a onclick="showHideSearchForm()"
									style="font-size: 13px; color: blue; vertical-align: bottom;">&nbsp;&nbsp;取消</a>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>

		<script type="text/javascript"
			src="<%=basePath%>static_/school_depart_major.js?v=09191840">
</script>
		<script type="text/javascript" src="<%=basePath%>static_/province.js?v=09191840">
</script>
	</body>
</html>
