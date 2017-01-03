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

		<title>哈师大助手</title>

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
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	maxClientHeight = document.body.clientHeight - 10;

	boxReady();

	$(".mainmenu").click(
			function() {
				$(".mainmenu").css("opacity", '1');
				var $submenu = $(this).next();
				if ($submenu.css("display") == "none"
						|| $submenu.css("display") == undefined) {
					$(".submenu").hide();
					subMenuLoc($(this));
					$(this).css("opacity", '0.9');
					$submenu.show();
				} else {
					$submenu.hide();
				}
			});
});

function boxReady() {
	var boxNum = $(".mybox").length;
	var maxOneBoxHeight = (maxClientHeight - 10 - (boxNum - 1) * 5) / boxNum;
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
			style="background-image: url('http://bcs.duapp.com/yy-pic/9NjLGEDz4w.jpg');">
		</div>

		<div id="con"
			style="position: absolute; top: 10px; left: 10px; bottom: 10px;">

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">个人中心</span>
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
						onclick="location='/mobile/stu?ac=uptInfo&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>'">
						<tr>
							<td align="center">
								<span class="text">个人信息</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<!--
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">正在调试</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					  -->
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='/mobile/edu?ac=score&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=275'">
						<tr>
							<td align="center">
								<span class="text">我的成绩</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='friend/listfellow.jsp?wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=280'">
						<tr>
							<td align="center">
								<span class="text">我的老乡</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<!-- 
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="updateUseAccount('course','cours?ac=isExist&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>')">
						<tr>
							<td align="center">
								<span class="text">我的课表</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					 -->
				</div>
			</div>

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0" onclick="location='http://wx.wsq.qq.com/181791394'">
						<tr>
							<td align="center">
								<span class="text">师大圈</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<!-- http://www.apiwx.com/wxapi.php?ac=cate18&tid=28997&c=fromUsername 
			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='/mobile/article?ac=getArticleDt&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=127'">
						<tr>
							<td align="center">
								<span class="text">鲜果汇</span>
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
						border="0" onclick="location='http://wx.wsq.qq.com/253816096'">
						<tr>
							<td align="center">
								<span class="text">淘二手</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>

				<!-- 
				<div class="submenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='bns?ac=list&type=1&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=176'">
						<tr>
							<td align="center">
								<span class="text">二手交易</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='bns?ac=list&type=2&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=178'">
						<tr>
							<td align="center">
								<span class="text">创业格子</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
				</div>
				 -->
			</div>

			<div class="mybox">
				<div class="mainmenu">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">购身边</span>
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
						onclick="location='/mobile/article?ac=getArticleDt&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=293'">
						<tr>
							<td align="center">
								<span class="text">影票预定</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='/mobile/article?ac=getArticleDt&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=295'">
						<tr>
							<td align="center">
								<span class="text">在线购书</span>
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
								<span class="text">订餐吧</span>
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
						onclick="location='/mobile/food?ac=getRess&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=56'">
						<tr>
							<td align="center">
								<span class="text">江北校区</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0"
						onclick="location='/mobile/food?ac=getRess&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&area=2&aId=244'">
						<tr>
							<td align="center">
								<span class="text">江南校区</span>
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
						onclick="updateUseAccount('card','bns?ac=isExist&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>')">
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
			 -->

			<!-- 
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
						onclick="location='/mobile/article?ac=getArticles&cate=攻略&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>'">
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
						border="0"
						onclick="location='reply/listQues.jsp?userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
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
						border="0" onclick="location='http://wx.wsq.qq.com/181791394'">
						<tr>
							<td align="center">
								<span class="text">微社区</span>
							</td>
							<td width="15px">
								<div class="arrow-right"></div>
							</td>
						</tr>
					</table>
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0" onclick="location='http://wx.wsq.qq.com/181791394'">
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
		-->

			<!-- 
			<div class="mybox">
				<div class="mainmenu" style="background-color: #DD0800;">
					<table width="100%" height="100%" cellpadding="0" cellspacing="0"
						border="0">
						<tr>
							<td align="center">
								<span class="text">助手服务</span>
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
					onclick="updateUseAccount('computer','shownews.jsp?url=http://mp.weixin.qq.com/mp/appmsg/show?__biz=MjM5ODgxOTUyMQ==&appmsgid=10000288&itemidx=2&sign=36363517b91615b12157a759e5469dd8#wechat_redirect')">
					<tr>
						<td align="center">
							<span class="text">电脑/手机</span>
						</td>
						<td width="15px">
							<div class="arrow-right"></div>
						</td>
					</tr>
				</table>
				<table width="100%" height="100%" cellpadding="0" cellspacing="0"
					border="0"
					onclick="updateUseAccount('abroad','shownews.jsp?url=http://mp.weixin.qq.com/mp/appmsg/show?__biz=MjM5ODgxOTUyMQ==&appmsgid=10000288&itemidx=3&sign=b3629bd07f53a788a74b8db4fdb832bc#wechat_redirect')">
					<tr>
						<td align="center">
							<span class="text">留学必备</span>
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
						onclick="location='vs?ac=listbiaobai&topicId=1007&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=62'">
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
						border="0"
						onclick="location='vote/listpic.jsp?topicId=1008&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&topicId=1008&aId=61'">
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
						onclick="location='ss?ac=cet&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=249'">
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
						onclick="location='/mobile/article?ac=getArticles&cate=美文&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&aId=60'">
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
			 -->

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
						border="0" onclick="location='aboutus.html'">
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
		<%@ include file="../common/toolbar.html"%>
	</body>
</html>
