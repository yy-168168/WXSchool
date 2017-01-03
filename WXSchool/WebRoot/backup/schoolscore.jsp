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

		<title>个人成绩</title>
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

		<style type="text/css">
.detail td {
	border-top: 1px solid #D5D5D5;
}
</style>

		<script type="text/javascript">
$(function() {
	checkMM();

	$(".zcj").each(function() {
		var zcj = parseInt($(this).text());
		if (zcj < 60) {
			$(this).parentsUntil(".html5yj").find("table").css("color", "red");
		}
	});

	$(".html5yj").click(function() {
		var $detail = $(this).find(".detail");
		if ($detail.css("display") == 'block') {
			$detail.hide();
		} else {
			$detail.show();
		}
	});
});

var flag = 0;
function spread() {
	if (flag == 0) {
		$(".detail").show();
		flag = 1;
	} else {
		$(".detail").hide();
		flag = 0;
	}
}
</script>
	</head>

	<body>
		<div>
			<%
				Object[][] myScore = (Object[][]) request.getAttribute("myscore");
				if (myScore == null || myScore.length == 0) {
			%>
			<div class="html5yj" style="padding: 10px; margin-top: 10px">
				<!-- 
				没有任何数据 ，可能的原因有：
				<br />
				1.未完成教学评价；
				<br />
				2.欠缴学费；
				<br />
				3.网络信号不好。
				 -->
				 新学期教务平台改版，暂时查不了成绩，后续会整好，抱歉。
			</div>
			<%
				} else {
					for (int i = myScore.length - 1; i >= 0; i--) {
						String pscj = myScore[i][4].equals("null") ? 0 + ""
								: myScore[i][4].toString();
						String bk = myScore[i][7].equals("null") ? 0 + ""
								: myScore[i][7].toString();
						String cx = myScore[i][8].equals("null") ? 0 + ""
								: myScore[i][8].toString();
			%>

			<div class="html5yj" style="margin-top: 10px">
				<div style="padding: 10px">
					<table border="0" width="100%" cellpadding="0" cellspacing="0">
						<tr align="center">
							<td width="40%">
								<%=myScore[i][0]%>
							</td>
							<td style="padding: 0 3px 0 8px;">
								<%=myScore[i][1]%>
							</td>
							<td width="15%" class="zcj">
								<%=myScore[i][6]%>
							</td>
						</tr>
					</table>
					<div class="detail" style="display: none;">
						<table width="100%" cellpadding="0" cellspacing="0">
							<tr align="center" height="25px">
								<td>
									性质
								</td>
								<td>
									学分
								</td>
								<td>
									平时
								</td>
								<td>
									期末
								</td>
								<td>
									补考/重修
								</td>
							</tr>
							<tr align="center" height="22px">
								<td>
									<%=myScore[i][2]%>
								</td>
								<td>
									<%=myScore[i][3]%>
								</td>
								<td>
									<%=pscj%>
								</td>
								<td>
									<%=myScore[i][5]%>
								</td>
								<td>
									<%=bk%>/<%=cx%>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<%
				}
				}
			%>

		</div>

		<div id="showMenu" onclick="spread();">
		</div>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
