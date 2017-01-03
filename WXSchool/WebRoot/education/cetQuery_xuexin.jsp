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
<%
	Student stu = (Student) request.getAttribute("stu");
	String cetNum = "", cetName = "";
	if (stu != null) {
		cetNum = stu.getCetNum();
		cetNum = cetNum == null ? "" : cetNum;
		cetName = stu.getCetName();
		cetName = cetName == null ? "" : cetName;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>四六级查询</title>

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
		<script type="text/javascript">
$(function() {
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
});

function check() {
	var cetNum = document.getElementsByName("cetNum")[0].value;
	var cetName = document.getElementsByName("cetName")[0].value;

	if ($.trim(cetNum) == "" || $.trim(cetName) == "") {
		alert("请认真填写");
		return false;
	}

	if (cetNum.length != 15) {
		alert("准考证号为15位");
		return false;
	}

	if (cetName.length > 3) {
		alert("只能输入姓名前三位");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "mobile/edun?ac=getCet&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		cetNum : cetNum,
		cetName : cetName
	}, function(data) {
		var cet;
		try{
			cet = $.parseJSON(data);
		}catch(e){
			alert("出错啦");
		}
		
		var content = "";
		if (cet == null || cet == "") {
			content = "<span>1、请确保准考证号输入正确</span><br/><span>2、信息已经保存，下次可直接查询</span>";
		} else {
			content = cet;
		}
		$("#result #content").html(content);
		$("#result").slideDown();

		$(":button").attr("disabled", false);
		$(":button").val("提  交");
	});
}
</script>
	</head>

	<body onload="checkMM();" onunload="resetAll();">

		<form method="post" name="form">
			<div class="html5yj">
				<div class="formhead_n">
					<div><span class="glyphicon glyphicon-edit"></span>&nbsp;四六级成绩查询</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div class="text1">
						15位准考证号
					</div>
					<input type="text" name="cetNum" class="html5input_n"
						value="<%=cetNum%>" onclick="clearMsg();">
					<hr />
					<div class="text1">
						姓名的前三个字
					</div>
					<input type="text" name="cetName" class="html5input_n"
						value="<%=cetName%>" onclick="clearMsg();">
					<hr />
					<input type="button" value="提  交" class="html5btn"
						onclick="check();">
					<div id="msg"></div>
				</div>
			</div>
		</form>

		<div id="result" class='html5yj'
			style='margin-top: 20px; display: none'>
			<div class='formhead' style='text-align: center;'>
				由助手教务查询接口提供
			</div>
			<div id="content" style='padding: 10px; line-height: 1.5;'></div>
		</div>

		<div style="text-align: center; margin-top: 10px">
			<a href="mobile/article?ac=getArticleDt&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=672">免证查询</a>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
