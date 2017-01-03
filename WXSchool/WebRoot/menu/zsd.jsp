<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

		<title>浙师大助手</title>

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
.submenu {
	position: relative;
	margin-left: 115px;
	display: none;
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
var boxHeight = 40;
var maxClientHeight;

$(function() {
	checkMM();
	updateVisitPerson();
	maxClientHeight = document.body.clientHeight - 20;

	boxReady();

	$(".mainmenu").click(
			function() {
				$(".mainmenu").css("opacity", '1');
				var $submenu = $(this).next();
				if ($submenu.css("display") == "none"
						|| $submenu.css("display") == undefined) {
					$(".submenu").hide();
					subMenuLoc($(this));
					$(this).css("opacity", '0.6');
					$submenu.show();
				} else {
					$submenu.hide();
				}
			});
});

function boxReady() {
	var boxNum = $(".mybox").length;
	var maxOneBoxHeight = (maxClientHeight - (boxNum - 1) * 5) / boxNum;
	if (maxOneBoxHeight <= boxHeight) {
		boxHeight = maxOneBoxHeight;
	}

	$(".mybox .mainmenu").css("height", boxHeight);
	$(".submenu table").css("height", boxHeight);

	$(".mybox").each(function(i) {
		$(this).css("top", (boxHeight + 5) * i);
	});
}

function subMenuLoc($obj) {
	var index = $obj.parent().index();
	var subSize = $obj.next().children().length;
	var curTotalHeight = (index + subSize) * (boxHeight + 5) - 5;
	var i = 0;
	var margintop = 0;
	while (curTotalHeight > maxClientHeight) {
		curTotalHeight -= boxHeight + 5;
		i++;
	}
	margintop = boxHeight * (i + 1) + 5 * i;
	$obj.next().css("margin-top", -margintop);
}

function updateVisitPerson() {
	updateArticleVisitPerson('<%=aId%>','<%=wxaccount%>');
}

function updateUseAccount(tp, url) {
	$.get("/mobile/account?ac=updateUseAccount&wxaccount=<%=wxaccount%>&type=" + tp,
			function() {
				window.location.href = url;
			});
}
</script>
	</head>

	<body style="margin: 0px;">
		<div class="bg"
			style="background-image: url('http://bcs.duapp.com/yy-pic/pBKPe9uvVk.jpg');">
		</div>

		<div id="con"
			style="position: absolute; top: 10px; left: 10px; bottom: 10px;">

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='/mobile/food?ac=getRess&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=169'">
						<tr>
							<td align="center">
								<span class="text">订餐吧</span>
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
						border="0"
						onclick="location='vs?ac=listbiaobai&topicId=1002&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>&aId=170'">
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
								<span class="text">求助区</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>

				<div class="submenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='/mobile/board?ac=listthing&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>'">
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
						border="0"
						onclick="location='reply/listQues.jsp?userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
						<tr>
							<td align="center">
								<span class="text">你问我答</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='/mobile/board?ac=getBoards&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
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
						border="0"
						onclick="location='vote/listpic.jsp?topicId=1003&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&topicId=1003&aId=171'">
						<tr>
							<td align="center">
								<span class="text">校花榜</span>
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
						border="0"
						onclick="location='friend/listfellow.jsp?wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=281'">
						<tr>
							<td align="center">
								<span class="text">我的老乡</span>
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
								<span class="text">掌上查询</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>

				<div class="submenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='ss?ac=cet&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId='">
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
						border="0"
						onclick="location='http://m.kuaidi100.com/uc/index.html'">
						<tr>
							<td align="center">
								<span class="text">查快递</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0" onclick="location='http://m.mtime.cn/'">
						<tr>
							<td align="center">
								<span class="text">影视资讯</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0" onclick="location='http://gj.aibang.com/'">
						<tr>
							<td align="center">
								<span class="text">公交换乘</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0" onclick="location='tools/lifehelp.htm'">
						<tr>
							<td align="center">
								<span class="text">生活通</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<!-- 
			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='vote/listpic.jsp?userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
						<tr>
							<td align="center">
								<span class="text">校花欣赏</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			 -->

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='/mobile/article?ac=getArticles&cate=美文&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=168'">
						<tr>
							<td align="center">
								<span class="text">美文推荐</span>
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
						border="0" onclick="location='other.html'">
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
						border="0" onclick="location='menu/zsdus.html'">
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

		<%@ include file="../common/tongji.html"%>
	</body>
</html>
