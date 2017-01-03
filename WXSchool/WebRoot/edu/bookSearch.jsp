<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.wxschool.entity.Student"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
	String aId = request.getParameter("aId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>图书查询</title>

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
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<style type="text/css">
#content table {
	width: 100%;
	cellpadding: 0;
	celeespacing: 0;
	border: 1;
}

#content table tr {
	height: 30px;
	text-align: center;
	font-size: 14px;
}
</style>
		<script type="text/javascript">
function borrow_expire_div(div) {
	var dp = $("#borrowdiv").css("display");
	if (dp == "block" && div == "expirediv") {
		$("#result #content").html("");
		$("#result").slideUp();
		$("#borrowdiv").slideUp();
		$("#expirediv").slideDown();
	} else if (dp == "none" && div == "borrowdiv") {
		$("#result #content").html("");
		$("#result").slideUp();
		$("#expirediv").slideUp();
		$("#borrowdiv").slideDown();
	}
	return false;
}

function check1() {
	var stuNum = document.getElementsByName("stuNum1")[0].value;

	if ($.trim(stuNum) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	$("#borrowbtn").attr("disabled", true);
	$("#borrowbtn").val("提交中...");

	var url = "/mobile/edu?ac=getBorrowList&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.get(url, {
		stuNum : stuNum
	}, function(data) {
		var borrowList;
		try{
			borrowList = $.parseJSON(data);
		}catch(e){
			alert("出错啦");
		}
		
		var content = "";
		if (borrowList == null) {
			content = "亲，网络出错咯，请稍后重试";
		} else if (borrowList == "") {
			content += "亲，您还没有借过书";
		} else {
			content += "<table><tr><th>书名</th>"
					+ "<th width=160px>时间</th>"
					+ "<th width=36px align=right>操作</th></tr>";
			$.each(borrowList, function(i, m) {
				content += "<tr><td>" + m[0] + "</td><td>" + m[1] + "</td><td>"
						+ m[2] + "</td></tr>";
			});
			content += "</table>";
		}
		$("#result #content").html(content);
		$("#result").slideDown();

		$("#borrowbtn").attr("disabled", false);
		$("#borrowbtn").val("提  交");
		updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	});
}

function check2() {
	var stuNum = document.getElementsByName("stuNum2")[0].value;

	if ($.trim(stuNum) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	$("#borrowbtn").attr("disabled", true);
	$("#borrowbtn").val("提交中...");

	var url = "/mobile/edu?ac=getExpireList&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.get(url, {
		stuNum : stuNum
	}, function(data) {
		var expireList;
		try{
			expireList = $.parseJSON(data);
		}catch(e){
			alert("出错啦");
		}
		
		var content = "";
		if (expireList == null) {
			content = "亲，网络出错咯，请稍后重试";
		} else if (expireList == "") {
			content += "亲，您没有超期记录";
		} else {
			content += "<table><tr><th>书名</th>"
					+ "<th style='min-width:80px'>借书/还书时间</th></tr>";
			$.each(expireList, function(i, m) {
				content += "<tr><td>" + m[0] + "</td><td>" + m[1] + "<br/>"
						+ m[2] + "</td></tr>";
			});
			content += "</table>";
		}
		$("#result #content").html(content);
		$("#result").slideDown();

		$("#borrowbtn").attr("disabled", false);
		$("#borrowbtn").val("提  交");
		updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	});
}
</script>
	</head>

	<body onload="checkMM();" onunload="resetAll();">

		<div id="borrowdiv">
			<form method="post" name="form">
				<div class="html5yj">
					<div class="formhead_n">
						<div><span class="glyphicon glyphicon-edit"></span>&nbsp;借阅查询</div>
					</div>
					<div style="padding: 10px 10px 3px 10px">
						<div class="text1">
							您的学号
						</div>
						<input type="text" name="stuNum1" class="html5input_n" value=""
							onclick="clearMsg();">
						<hr />
						<input id="borrowbtn" type="button" value="提  交" class="html5btn"
							onclick="check1();">
						<div id="msg"></div>
					</div>
				</div>
			</form>
		</div>

		<div id="expirediv" style="display: none">
			<form method="post" name="form">
				<div class="html5yj">
					<div class="formhead_n">
						<div><span class="glyphicon glyphicon-edit"></span>&nbsp;超期查询</div>
					</div>
					<div style="padding: 10px 10px 3px 10px">
						<div class="text1">
							您的学号
						</div>
						<input type="text" name="stuNum2" class="html5input_n" value=""
							onclick="clearMsg();">
						<hr />
						<input id="expirebtn" type="button" value="提  交" class="html5btn"
							onclick="check2();">
						<div id="msg"></div>
					</div>
				</div>
			</form>
		</div>

		<div id="result" class='html5yj'
			style='margin-top: 20px; display: none'>
			<div class='formhead' style='text-align: center;'>
				由助手教务查询接口提供
			</div>
			<div id="content" style='padding: 10px; line-height: 1.5;'></div>
		</div>

		<jsp:include page="../common/copyright.jsp" />

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="50%" style="border-right: 1px solid #666"
						onclick="borrow_expire_div('borrowdiv')">
						借阅查询
					</td>
					<td onclick="borrow_expire_div('expirediv')">
						超期查询
					</td>
				</tr>
			</table>
		</div>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
