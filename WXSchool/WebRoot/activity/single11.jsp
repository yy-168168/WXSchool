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
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>11.11</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery.mobile.custom.min.js">
</script>
<style type="text/css">
@keyframes hideToShow {
	0%{opacity: 0;}
	100%{opacity: 1;}
}

@-webkit-keyframes hideToShow {
	0%{opacity: 0;}
	100%{opacity: 1;}
}

@keyframes hideToShowDown{
	0%{opacity: 0; margin-top: -60px;}
	100%{opacity: 1; margin-top: 0px;}
}

@-webkit-keyframes hideToShowDown {
	0%{opacity: 0; margin-top: -60px;}
	100%{opacity: 1; margin-top: 0px;}
}

@keyframes hideToShowRight{
	0%{opacity: 0; margin-left: -200px;}
	100%{opacity: 1; margin-left: 0px;}
}

@-webkit-keyframes hideToShowRight {
	0%{opacity: 0; margin-left: -200px;}
	100%{opacity: 1; margin-left: 0px;}
}

@keyframes hideToShowTop{
	0%{opacity: 0; margin-bottom: -60px;}
	100%{opacity: 1; margin-bottom: 0px;}
}

@-webkit-keyframes hideToShowTop {
	0%{opacity: 0; margin-bottom: -60px;}
	100%{opacity: 1; margin-bottom: 0px;}
}

@keyframes hideToShowLeft{
	0%{opacity: 0; margin-left: 200px;}
	100%{opacity: 1; padding-left: 0px;}
}

@-webkit-keyframes hideToShowLeft {
	0%{opacity: 0; margin-left: 200px;}
	100%{opacity: 1; margin-left: 0px;}
}

.btn-prev {
	font-size: 20px;
	padding-bottom: 10px;
	position: fixed;
	top: 50%;
	right: 10px;
	margin-top: -10px
}

.tabItem{
	padding: 10px;
	border: 3px solid #fff;
	border-radius: 15px;
	width: 240px;
	margin: 0 auto;
	font-size: 16px;
	margin-top: 30px;
}

.item{
	font-size: 30px
}
</style>
		<script type="text/javascript">
$(function() {
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	
	$(".tab").live("swipe", function(){
		var p = $(this).parent();
		$(p).hide();
		var n = $(p).next();
		
		if($(n).attr("id") == "mainTab"){
			var hasSel = getCookie("<%=userwx%>@11");
			if(hasSel == ""){
				$(n).show();
			}else{
				select(hasSel);
			}
		}else{
			$(n).show();
		}
	});
});

function select(index){
	if('<%=userwx%>' == ''){//判断是否能转发的入口进入
		alert('需要进入哈师大助手才能玩此活动哦');
		location= 'http://mp.weixin.qq.com/s?__biz=MjM5ODgxOTUyMQ==&mid=227050251&idx=2&sn=c7c87c8cbaa1e9c0aa1a58d765829178#rd';
		return false;
	}
	
	$('#mainTab').hide();
	index = parseInt(index);
	var selId = "#mainTab div:nth-child("+index+")";
	var bcl = $(selId).css("background-color");
	$("body").css("background-color", bcl);
	$('#item'+index).show();
	addCookie("<%=userwx%>@11", index, 7*24*60);
}
</script>
	</head>

	<body onload="checkMM();" style="margin: 0; background-color: #009966; color: #fff">
	
		<div id="">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowDown 1s ease 0.8s 1 both;; -webkit-animation: hideToShowDown 1s ease 0.8s 1 both; font-size: 30px">说好的</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowDown 1s ease 1.6s 1 both;; -webkit-animation: hideToShowDown 1s ease 1.6s 1 both; font-size: 50px; color: #FBCA58">汉子呢</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowDown 1s ease 2.4s 1 both;; -webkit-animation: hideToShowDown 1s ease 2.4s 1 both; font-size: 50px; color: #CB5858">妹子呢</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 0.8s 1 both;; -webkit-animation: hideToShowRight 1s ease 0.8s 1 both; font-size: 50px; color: #FBCA58">当光棍真好</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 1.6s 1 both;; -webkit-animation: hideToShowRight 1s ease 1.6s 1 both; font-size: 50px; color: #972C3A">还能有节过</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 2.4s 1 both;; -webkit-animation: hideToShowRight 1s ease 2.4s 1 both; font-size: 30px;">呵呵</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowDown 1s ease 0.8s 1 both;; -webkit-animation: hideToShowDown 1s ease 0.8s 1 both; font-size: 50px; color: #FBCA58">当光棍不难</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 1.6s 1 both;; -webkit-animation: hideToShowRight 1s ease 1.6s 1 both; font-size: 30px;">难的是</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowTop 1s ease 2.4s 1 both;; -webkit-animation: hideToShowTop 1s ease 2.4s 1 both; font-size: 30px;"><span style="font-size: 50px; color: #D66F98">一辈子</span>当光棍</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 0.8s 1 both;; -webkit-animation: hideToShowRight 1s ease 0.8s 1 both; font-size: 30px;">我不怕过光棍节</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowLeft 1s ease 1.6s 1 both;; -webkit-animation: hideToShowLeft 1s ease 1.6s 1 both; font-size: 30px;">我怕我喜欢的人</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 2.4s 1 both;; -webkit-animation: hideToShowRight 1s ease 2.4s 1 both; font-size: 50px; color: #FBED7A">不过光棍节</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowTop 1s ease 0.8s 1 both;; -webkit-animation: hideToShowTop 1s ease 0.8s 1 both; font-size: 40px;">每逢佳节</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowTop 1s ease 1.6s 1 both;; -webkit-animation: hideToShowTop 1s ease 1.6s 1 both; font-size: 50px; color: #D66F98">倍思春</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowTop 1s ease 2.4s 1 both;; -webkit-animation: hideToShowTop 1s ease 2.4s 1 both; font-size: 50px; color: #D66F98">......</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowLeft 1s ease 0.8s 1 both;; -webkit-animation: hideToShowLeft 1s ease 0.8s 1 both; font-size: 40px; color: #D66F98">但愿人长久</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowLeft 1s ease 1.6s 1 both;; -webkit-animation: hideToShowLeft 1s ease 1.6s 1 both; font-size: 30px; color: #D66F98"><span style="font-size: 50px; color: #FFCF4B">光棍</span>不再有</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowTop 1s ease 0.8s 1 both;; -webkit-animation: hideToShowTop 1s ease 0.8s 1 both; font-size: 50px; color: #D66F98">光棍节</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowLeft 1s ease 1.6s 1 both;; -webkit-animation: hideToShowLeft 1s ease 1.6s 1 both; font-size: 30px;">暗恋我的人</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowDown 1s ease 2.4s 1 both;; -webkit-animation: hideToShowDown 1s ease 2.4s 1 both; font-size: 30px;">还不<span style="color: #90B0CF; font-size: 50px">表白</span>么</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 0.8s 1 both;; -webkit-animation: hideToShowRight 1s ease 0.8s 1 both; font-size: 50px;">光棍们</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowLeft 1s ease 1.6s 1 both;; -webkit-animation: hideToShowLeft 1s ease 1.6s 1 both; font-size: 50px; color: #FEC073">燃烧吧</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<!-- 
		<div id="tab1" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowDown 1s ease 0.8s 1 both;; -webkit-animation: hideToShowDown 1s ease 0.8s 1 both;">每年</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowDown 1s ease 1.6s 1 both;; -webkit-animation: hideToShowDown 1s ease 1.6s 1 both;">都有</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowDown 1s ease 2.4s 1 both;; -webkit-animation: hideToShowDown 1s ease 2.4s 1 both;">光棍节</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="tab2" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 0.8s 1 both; -webkit-animation: hideToShowRight 1s ease 0.8s 1 both;">也许</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 1.6s 1 both; -webkit-animation: hideToShowRight 1s ease 1.6s 1 both; font-size: 40px">每年这一天</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 2.4s 1 both; -webkit-animation: hideToShowRight 1s ease 2.4s 1 both; font-size: 32px">我都平凡的过去了</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="tab3" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr><td align="center"></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowDown 1s ease 0.8s 1 both; -webkit-animation: hideToShowDown 1s ease 0.8s 1 both;">今年</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowRight 1s ease 1.6s 1 both; -webkit-animation: hideToShowRight 1s ease 1.6s 1 both;">我想</div></td></tr>
				<tr><td align="center" height="25%"><div style="animation: hideToShowTop 1s ease 2.4s 1 both; -webkit-animation: hideToShowTop 1s ease 2.4s 1 both; font-size: 40px">有所作为</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="tab4" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr>
					<td align="center">
						<div style="animation: hideToShowRight 1s ease 1.0s 1 both; -webkit-animation: hideToShowRight 1s ease 1.0s 1 both;"><img src="activity/image/singleDog.png"/></div>
					</td>
				</tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="tab5" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr>
					<td align="center">
						<div style="animation: hideToShowRight 1s ease 0.8s 1 both; -webkit-animation: hideToShowRight 1s ease 0.8s 1 both; font-size: 40px">那么，祝你</div>
						<div style="animation: hideToShowTop 1s ease 2.0s 1 both; -webkit-animation: hideToShowTop 1s ease 2.0s 1 both; margin-top: 30px"><img src="activity/image/msydx.png"/></div>
					</td>
				</tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		 -->
		 
		<div id="" style="display: none">
			<table width="100%" height="100%" border="0" class="tab">
				<tr>
					<td align="center">
						<div style="animation: hideToShow 1s ease 1.0s 1 both; -webkit-animation: hideToShow 1s ease 1.0s 1 both; font-size: 30px">
							<div>不管你是一个人</div>
							<div style="margin-top: 20px">还是两个人</div>
							<div style="margin-top: 20px">日子长了</div>
							<div style="margin-top: 20px">生活是否已平淡如水</div>
							<div style="margin-top: 20px">那么</div>
							<div style="margin-top: 20px">你应该做点什么</div>
						</div>
					</td>
				</tr>
			</table>
			<div class="btn-prev"><span class="glyphicon glyphicon-chevron-right"></span></div>
		</div>
		
		<div id="mainTab" style="display: none">
			<table width="100%" height="100%" border="0">
				<tr><td align="center">
					<div onclick="select(1)" class="tabItem" style="animation: hideToShow 1s ease 0.8s 1 both; -webkit-animation: hideToShow 1s ease 0.8s 1 both; background-color: #666699">寻找暗恋的人</div>
					<div onclick="select(2)" class="tabItem" style="animation: hideToShow 1s ease 1.6s 1 both; -webkit-animation: hideToShow 1s ease 1.6s 1 both; background-color: #CC6600">来一波美女/帅哥</div>
					<div onclick="select(3)" class="tabItem" style="animation: hideToShow 1s ease 2.6s 1 both; -webkit-animation: hideToShow 1s ease 2.6s 1 both; background-color: #99CC00">给Ta买份早餐</div>
					<div onclick="select(4)" class="tabItem" style="animation: hideToShow 1s ease 3.6s 1 both; -webkit-animation: hideToShow 1s ease 3.6s 1 both; background-color: #FF6666">为Ta定制礼物</div>
					<div onclick="select(5)" class="tabItem" style="animation: hideToShow 1s ease 4.6s 1 both; -webkit-animation: hideToShow 1s ease 4.6s 1 both; background-color: #009999">调戏助手君</div>
					<div onclick="select(6)" class="tabItem" style="animation: hideToShow 1s ease 5.6s 1 both; -webkit-animation: hideToShow 1s ease 5.6s 1 both; background-color: #CCCC99">******</div>
					<div style="animation: hideToShow 1s ease 6.6s 1 both; -webkit-animation: hideToShow 1s ease 6.6s 1 both; margin-top: 20px">你只有一次选择机会</div>
					<div style="animation: hideToShow 1s ease 7.6s 1 both; -webkit-animation: hideToShow 1s ease 7.6s 1 both; margin-top: 20px; margin-bottom: 20px; font-size: 13px"><span style="text-decoration: underline;" onclick="showScreenNotice_img('static_/gztx.jpg')">分享</span>&nbsp;&nbsp;<span style="text-decoration: underline;" onclick="showScreenNotice_img('static_/gztx.jpg')">转发</span></div>
				</td></tr>
			</table>
		</div>
		
		<div id="item1" style="display: none">
			<table width="100%" height="100%" border="0" class="item">
				<tr><td align="center"></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 0.8s 1 both; -webkit-animation: hideToShow 1s ease 0.8s 1 both;">给我一点信息</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 1.6s 1 both; -webkit-animation: hideToShow 1s ease 1.6s 1 both;">我帮你找找看</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 2.4s 1 both; -webkit-animation: hideToShow 1s ease 2.4s 1 both;">我不是万能的</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 3.2s 1 both; -webkit-animation: hideToShow 1s ease 3.2s 1 both;">但希望达你所愿</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 4.0s 1 both; -webkit-animation: hideToShow 1s ease 4.0s 1 both;"><a href="/reply/chatSearchUser.jsp?wxaccount=<%=wxaccount %>&userwx=<%=userwx %>">Let's Go!</a></div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
		</div>
		
		<div id="item2" style="display: none">
			<table width="100%" height="100%" border="0" class="item">
				<tr><td align="center"></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 0.8s 1 both; -webkit-animation: hideToShow 1s ease 0.8s 1 both;">不要压抑自己的天性</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 1.6s 1 both; -webkit-animation: hideToShow 1s ease 1.6s 1 both;">尽情约吧</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 2.4s 1 both; -webkit-animation: hideToShow 1s ease 2.4s 1 both;">也请保持自己高贵的素养</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 3.2s 1 both; -webkit-animation: hideToShow 1s ease 3.2s 1 both;"><a href="mobile/chat?ac=chatUser&wxaccount=<%=wxaccount %>&userwx=<%=userwx %>">Let's Go!</a></div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
		</div>
		
		<div id="item3" style="display: none">
			<table width="100%" height="100%" border="0" class="item">
				<tr><td align="center"></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 0.8s 1 both; -webkit-animation: hideToShow 1s ease 0.8s 1 both;">一个鸡蛋</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 1.6s 1 both; -webkit-animation: hideToShow 1s ease 1.6s 1 both;">一屉包子</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 2.4s 1 both; -webkit-animation: hideToShow 1s ease 2.4s 1 both;">很简单</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 3.2s 1 both; -webkit-animation: hideToShow 1s ease 3.2s 1 both;">但这是爱的体现</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 4.0s 1 both; -webkit-animation: hideToShow 1s ease 4.0s 1 both;"><a href="http://front.lewaimai.com/index.php?r=lewaimaishow/lewaimaigod&adminId=37125&shopId=101163">Let's Go!</a></div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
		</div>
		
		<div id="item4" style="display: none">
			<table width="100%" height="100%" border="0" class="item">
				<tr><td align="center"></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 0.8s 1 both; -webkit-animation: hideToShow 1s ease 0.8s 1 both;">这是你第几次给Ta买礼物</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 1.6s 1 both; -webkit-animation: hideToShow 1s ease 1.6s 1 both;">记得么</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 2.4s 1 both; -webkit-animation: hideToShow 1s ease 2.4s 1 both;">浪漫</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 3.2s 1 both; -webkit-animation: hideToShow 1s ease 3.2s 1 both;">从此刻开始</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 4.0s 1 both; -webkit-animation: hideToShow 1s ease 4.0s 1 both;"><a href="http://u367466.zhichiwangluo.com/zhichi/index.php?r=Invitation/showNewInvitation&id=94675">Let's Go!</a></div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
		</div>
		
		<div id="item5" style="display: none">
			<table width="100%" height="100%" border="0" class="item">
				<tr><td align="center"></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 0.8s 1 both; -webkit-animation: hideToShow 1s ease 0.8s 1 both;">最疼爱助手的人</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 1.6s 1 both; -webkit-animation: hideToShow 1s ease 1.6s 1 both;"><img alt="" src="static_/hsdaide.png" width="300px"></div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 2.4s 1 both; -webkit-animation: hideToShow 1s ease 2.4s 1 both;">长按，可识别</div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
		</div>
		
		<div id="item6" style="display: none">
			<table width="100%" height="100%" border="0" class="item">
				<tr><td align="center"></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 0.8s 1 both; -webkit-animation: hideToShow 1s ease 0.8s 1 both;">哈哈</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 1.6s 1 both; -webkit-animation: hideToShow 1s ease 1.6s 1 both;">也许你被调戏了</div></td></tr>
				<tr><td align="center"><div style="animation: hideToShow 1s ease 4.6s 1 both; -webkit-animation: hideToShow 1s ease 4.6s 1 both;"><img alt="" src="static_/bossWechat.png" width="160px"></div></td></tr>
				<tr><td align="center"></td></tr>
			</table>
		</div>

		<div style="margin-top: -40px"></div>
		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
		
		<script type="text/javascript"
			src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js">
</script>
		<script type="text/javascript">
var wxSign = {appId: '', timestamp: '', nonceStr: '', signature: '' };
$.ajax({
	url: "mobile/other?ac=wxSign&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>",
	data: {pageUrl : window.location.toString()},
	async: false,
	type: 'POST',
	success: function(data){
		var obj = $.parseJSON(data);
		wxSign.appId = obj[0];
		wxSign.timestamp = obj[1];
		wxSign.nonceStr = obj[2];
		wxSign.signature = obj[3];
	}
});

wx.config( {
	debug : false,
	appId : wxSign.appId,
	timestamp : wxSign.timestamp,
	nonceStr : wxSign.nonceStr,
	signature : wxSign.signature,
	jsApiList : [ 'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage',
			'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone',
			'hideMenuItems', 'showMenuItems', 'hideAllNonBaseMenuItem',
			'showAllNonBaseMenuItem', 'translateVoice', 'startRecord',
			'stopRecord', 'onVoiceRecordEnd', 'playVoice', 'onVoicePlayEnd',
			'pauseVoice', 'stopVoice', 'uploadVoice', 'downloadVoice',
			'chooseImage', 'previewImage', 'uploadImage', 'downloadImage',
			'getNetworkType', 'openLocation', 'getLocation', 'hideOptionMenu',
			'showOptionMenu', 'closeWindow', 'scanQRCode', 'chooseWXPay',
			'openProductSpecificView', 'addCard', 'chooseCard', 'openCard' ]
});

wx.ready(function(){
	wx.onMenuShareTimeline({
	    title: '光棍节，我觉得就该这么玩，哈哈哈...', // 分享标题
	    desc: '光棍节，我觉得就该这么玩，哈哈哈...', //描述
	    link: 'http://www.jingl520.com/activity/single11.jsp?wxaccount=<%=wxaccount%>&userwx=', // 分享链接
	    imgUrl: 'http://www.jingl520.com/activity/image/single11.png', // 分享图标
	    success: function () { 
	        // 用户确认分享后执行的回调函数
	        updateTopicVisitPerson('gh_b315c2abe8ce',2057);
	    },
	    cancel: function () { 
	        // 用户取消分享后执行的回调函数
	    }
	});
	
	wx.onMenuShareAppMessage({
	    title: '光棍节，我觉得就该这么玩，哈哈哈...', // 分享标题
	    desc: '光棍节，我觉得就该这么玩，哈哈哈...', //描述
	    link: 'http://www.jingl520.com/activity/single11.jsp?wxaccount=<%=wxaccount%>&userwx=', // 分享链接
	    imgUrl: 'http://www.jingl520.com/activity/image/single11.png', // 分享图标
	    type: '', // 分享类型,music、video或link，不填默认为link
	    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
	    success: function () { 
	        // 用户确认分享后执行的回调函数
	        updateTopicVisitPerson('gh_b315c2abe8ce',2058);
	    },
	    cancel: function () { 
	        // 用户取消分享后执行的回调函数
	    }
	});
});

wx.error(function (res) {
  alert(res.errMsg);
});</script>
	</body>
</html>
