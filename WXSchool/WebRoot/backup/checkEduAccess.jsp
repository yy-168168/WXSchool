<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
	String aId = request.getParameter("aId");
	String bns = request.getParameter("bns");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>教务平台</title>

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

		<script type="text/javascript">
$(function() {
	checkEduAccess();
});

function checkEduAccess() {
	var url = "mobileT/edun?ac=checkEduAccess&wxaccount=<%=wxaccount%>";
	$.get(url, function(data) {
		if (data == "true") {// 可用
			$("showMsg").html("可用");
			setTimeout('skip()', 2000);
		} else {
			$("showMsg").html("不可用");
		}
	});
}

function skip(){
	window.location.href = "mobileT/edun?ac=login&wxaccount=<%=wxaccount %>&userwx=<%=userwx %>&aId=<%=aId %>&bns=<%=bns %>";
}
</script>
	</head>

	<body onload="checkMM();">
		<table width="100%" height="100%">
			<tr align="center">
				<td id="showMsg">
					正在检测教务平台是否可用
				</td>
			</tr>
		</table>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
