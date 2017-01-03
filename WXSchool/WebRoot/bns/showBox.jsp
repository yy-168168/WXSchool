<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String cate = request.getParameter("cate");
	String type = request.getParameter("type");
	String aId = request.getParameter("aId");
	
	Page p = (Page) request.getAttribute("page");
	int curPage = p.getCurPage();
	int totalPage = p.getTotalPage();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>校园创业格子铺</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" /> 
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<style type="text/css">
.boxout {
	float: left;
	width: 50%;
	background-color: #FFF;
}

.boxin {
	border-bottom: 1px solid #FF9900;
	border-right: 1px solid #FF9900;
	background-color: #FFF;
	padding: 10px;
}

.boxin .img {
	text-align: center;
	vertical-align: middle;
	width: 100%;
	height: 140px;
}

.boxin img {
	width: 100%;
	height: 140px;
}

.boxin .text {
	margin-top: 10px;
	color: #555;
	line-height: 1.5;
	font-size: 15px;
	height: 42px;
	overflow: hidden;
	word-break: break-all;
}

.boxin .price_old {
	margin-top: 6px;
	font-size: 13px;
	color: #555;
	word-break: break-all;
}

.boxout:nth-child(odd) .boxin {
	border-left: 1px solid #FF9900;
}

.boxout:first-child .boxin {
	border-top: 1px solid #FF9900;
}

.boxout:nth-child(2) .boxin {
	border-top: 1px solid #FF9900;
}
</style>
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideToolbar');
});

function search() {
	var keyword = document.getElementsByName("keyword")[0].value;

	if ($.trim(keyword) == "") {
		return false;
	}

	window.location.href = '/mobile/bns?ac=search&wxaccount=<%=wxaccount%>&type=<%=type%>&keyword=' + keyword;
}
</script>
	</head>

	<body onload="checkMM();" onclick="hideMenu(event);">
		<div
			style="margin: -8px -8px 10px -8px; box-shadow: 0px 0px 1px 1px #ff9900;">
			<div style="background-color: #1FB615; height: 2px"></div>
			<div
				style="background-color: #ff9900; text-align: center; color: #fff; padding: 5px 10px;">
				<span style="font-size: 20px;">校园创业格子铺</span>
				<br />
				<span style="font-size: 14px;">JUST FOR YOU</span>
			</div>
		</div>
		<div>
			<%
				List<Goods> goodses = (List<Goods>) request.getAttribute("goodses");
				if (goodses == null || goodses.size() == 0) {
			%>
			<div class="html5yj" style="padding: 10px">
				没有可展示商品
			</div>
			<%
				} else {
					for (int i = 0; i < goodses.size(); i++) {
						Goods goods = goodses.get(i);
			%>
			<div class="boxout"
				onclick="location='/mobile/bns?ac=getGs&wxaccount=<%=wxaccount%>&gsId=<%=goods.getGoodsId()%>&type=<%=type %>'">
				<div class="boxin">
					<div class="img">
						<img alt="" src="<%=goods.getPicUrl()%>" alt="该图片太大，已被删除。为了节约用户流量，请修改图片大小。">
					</div>
					<div class="text">
						<%=goods.getSimDesc()%>
					</div>
					<div class="price_old">
						<span style="color: red; font-size: 18px;">￥<%=goods.getPrice()%></span>
					</div>
				</div>
			</div>
			<%
				}
				}
			%>
			<div style="clear: both;"></div>
		</div>

		<%
			String url = "/mobile/bns?ac=list&wxaccount=" + wxaccount + "&type="+type+"&cate=" + cate;
		%>
		<div class="page" style="margin-top: 15px">
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

		<div id="search"
			style="position: absolute; left: 0; display: none; margin-top: 10px; width: 100%;">
			<div style="padding: 0 10px">
				<input type="text" name="keyword" class="html5input"
					style="width: 70%;">
				<input type="button" value="搜索" class="html5btn" onclick="search();"
					style="width: 28%; float: right;">
			</div>
			<script type="text/javascript">
function showSearch() {
	var display = $("#search").css("display");
	if (display == "none") {
		if (document.body.scrollHeight > document.body.clientHeight) {
			$("#search").css("padding-bottom", 50);
		} else {
			$("#search").css("bottom", 50);
		}
		$("#search").show();
		window.scrollTo(0, 9999);
	} else {
		$("#search").hide();
	}
}
</script>
		</div>

		<div id="bar_menu" style="bottom: 50px;">
			<div id="bar_menu_dt">
				<%
					String loc = "/mobile/bns?ac=list&wxaccount=" + wxaccount + "&type="+type+"&cate=";
				%>
				<ul style="list-style: none; margin: 0; padding: 0">
					<li onclick="menuClick(this,'<%=loc%>1');">
						鞋包服装
					</li>
					<li onclick="menuClick(this,'<%=loc%>2');">
						护肤彩妆
					</li>
					<li onclick="menuClick(this,'<%=loc%>3');">
						美食特产
					</li>
					<li onclick="menuClick(this,'<%=loc%>4');">
						日用百货
					</li>
					<li onclick="menuClick(this,'<%=loc%>5');">
						珠饰镜表
					</li>
					<li onclick="menuClick(this,'<%=loc%>6');">
						电子产品
					</li>
					<li onclick="menuClick(this,'<%=loc%>10');">
						其它
					</li>
				</ul>
			</div>
		</div>

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td style="border-right: 1px solid #666"
						onclick="javascript:history.go(-1);">
						<img alt="" src="static_/pre2.png" height="22px">
					</td>
					<td width="27%" style="border-right: 1px solid #666" id="showMenu_"
						onclick="showMenu();">
						类别
					</td>
					<td width="27%" style="border-right: 1px solid #666"
						onclick="showSearch();">
						搜索
					</td>
					<td width="27%"
						onclick="showScreenNotice_text('1、在聊天界面回复getkey获取密钥<br/>2、在电脑端打开网址(不支持IE)：<br/>&nbsp;&nbsp;&nbsp;&nbsp;http://schoolhand.duapp.com/mng<br/>3、输入密钥进入管理平台即可<br/><br/>微信不支持图片上传，所以采用电脑端操作/手机端浏览。有任何问题请咨询微信yy_168168');">
						发布
					</td>
				</tr>
			</table>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
		
		<script type="text/javascript">
			if('<%=curPage%>' == 1 && '<%=cate%>' == "null"){
				updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
			}
		</script>
	</body>
</html>
