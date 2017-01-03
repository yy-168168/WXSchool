<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
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

		<title>成绩查询</title>

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
.score th {
	border-bottom: 1px solid #ccc;
}

.score td {
	border-bottom: 1px solid #ccc;
}
</style>
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
	});

$(function() {
	showScoreResult();

	$("#yearTerm").change(function() {
		var val = $("#yearTerm option:selected").val();
		showScoreResult(val);
	});
});

//不及格
function noPass() {
	$(".zcj").each(function() {
		var zcj = parseInt($(this).text());
		if (zcj < 60) {
			$(this).parent().css("color", "red");
		}
	});
}

//成绩结果
function showScoreResult(yearTerm) {
	// yearTerm = yearTerm == undefined ? 14 : yearTerm;
	if(yearTerm == undefined){
		yearTerm = $("#yearTerm option:selected").val();
	}
	var url = "/mobile/mdjmu?ac=getScore&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$
			.post(url, {
				yearTerm : yearTerm
			}, function(data) {
				//alert(data);
					var obj;
					try {
						obj = $.parseJSON(data);
					} catch (e) {
						alert("出错啦");
					}

					if (obj == null) {
						alert("查询出错");
					} else {//查询成绩成功
						// 课程性质 课程号 课程名称 考试类型 学时 学分 成绩类型 期末成绩 总评成绩
					var content = "<table class='score' width='100%' cellpadding='0' cellspacing='0'>"
							+ "<tr height='36px' align='center'><th>课程名称</th><th>期末成绩</th><th>总评成绩</th></tr>";
					for (i = obj.length - 1; i >= 0; i--) {
						content += "<tr height='30px' align='center'><td>" + obj[i][2]
								+ "</td><td>" + obj[i][7]
								+ "</td><td class='zcj'>" + obj[i][8]
								+ "</td></tr>";
					}
					content += "</table>";

					$("#result #content").html(content);
					noPass();
					$("#result").show();
				}
			});
}
</script>
	</head>

	<body onload="checkMM();" onunload="resetAll();">
		<div>
			<select class="html5input_n" name="yearTerm" id="yearTerm">
				<option value="16">
					2016-2017学年第二学期
				</option>
				<option value="15" selected="selected">
					2016-2017学年第一学期
				</option>
				<option value="14">
					2015-2016学年第二学期
				</option>
				<option value="13">
					2015-2016学年第一学期
				</option>
				<option value="12">
					2014-2015学年第二学期
				</option>
				<option value="11">
					2014-2015学年第一学期
				</option>
				<option value="10">
					2013-2014学年第二学期
				</option>
				<option value="9">
					2013-2014学年第一学期
				</option>
				<option value="8">
					2012-2013学年第二学期
				</option>
				<option value="7">
					2012-2013学年第一学期
				</option>
				<option value="6">
					2011-2012学年第二学期
				</option>
				<option value="5">
					2011-2012学年第一学期
				</option>
				<option value="4">
					2010-2011学年第二学期
				</option>
				<option value="3">
					2010-2011学年第一学期
				</option>
				<option value="2">
					2009-2010学年第二学期
				</option>
				<option value="1">
					2009-2010学年第一学期
				</option>
			</select>
		</div>

		<div id="result" class='html5yj'
			style='margin-top: 20px; display: none;'>
			<div class='formhead' style='text-align: center;'>
				由教务查询接口提供
			</div>
			<div id="content" style='padding: 10px; line-height: 1.5;'>
			</div>
		</div>
		
		<div style="position: fixed; z-index: 10; right: 20px; bottom: 30px; background-color: #000; opacity: 0.6; border-radius: 5px;">
			<img alt='' src='static_/refresh2.png' onclick="javascript: window.location.reload()">
		</div>

		<jsp:include page="../../common/copyright.jsp" />
		<%@ include file="../../common/toolbar.html"%>
		<%@ include file="../../common/tongji.html"%>
	</body>
</html>
