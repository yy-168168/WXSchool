<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>模板三</title>

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
.mybox {
	position: absolute;
}

.mybox .mainmenu {
	background-color: #000;
	opacity: 0.5;
	width: 110px;
	height: 36px;
}

.submenu {
	position: relative;
	margin-left: 115px;
	margin-top: -36px;
	display: none;
}

.submenu table {
	background-color: #000;
	opacity: 0.5;
	width: 100px;
	height: 36px;
	margin-bottom: 5px;
}

.mybox .text {
	color: #fff;
	font-size: 15px;
}

.mybox .arrow-right {
	width: 0px;
	height: 0px;
	border-bottom: 5px solid transparent; /* left arrow slant */
	border-top: 5px solid transparent; /* right arrow slant  */
	border-left: 5px solid #fff; /* bottom, add background color here */
	font-size: 0px;
	line-height: 0px;
}
</style>
		<script type="text/javascript">
$(function() {
	//checkMM();

	$(".mybox").each(function(i) {
		var bh = parseInt($(".mainmenu").css("height").replace("px", ""));
		$(this).css("top", (bh + 5) * i);
	});

	$(".mainmenu").click(
			function() {
				var $submenu = $(this).next();
				if ($submenu.css("display") == "none"
						|| $submenu.css("display") == undefined) {
					$(".submenu").hide();
					$submenu.show();
				} else {
					$submenu.hide();
				}
			});
});

function updateUseAccount1() {
	//$.post("/mobile/account?ac=updateUseAccount&wxaccount=<%=wxaccount%>&type=" + type, function() {
	//window.location.href = url;
	//});
}
</script>
	</head>

	<body>
		<div>
			<jsp:include page="images_move_bg.jsp"></jsp:include>
		</div>

		<div id="con"
			style="position: absolute; top: 10px; left: 10px; bottom: 10px;">

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">订餐</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">会员卡</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">求助/告示板</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>

				<div class="submenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">寻物/招领</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">攻略</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">求助</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">告示板</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">校花/老乡</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>

				<div class="submenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">校花</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">老乡</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">表白墙</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">成绩/课表</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>

				<div class="submenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">期末成绩</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">四六级</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">课表</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">功能/关于</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>

				<div class="submenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">其它功能</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">关于我们</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

		</div>
	</body>
</html>
