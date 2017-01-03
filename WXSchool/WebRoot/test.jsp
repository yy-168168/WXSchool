<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.URLDecoder"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String cate = request.getParameter("cate");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>DEMO</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link href="static_/mycommon.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="static_/jquery-1.8.2.min.js"></script>
<link rel="stylesheet" href="static_/myfont.css">
<script type="text/javascript" src="static_/jquery.scrollTo.min.js"></script>
<script type="text/javascript" src="static_/mycommon.js"></script>
<script type="text/javascript" src="static_/jquery.qqFace.js"></script>

<style type="text/css">
.html5yj1 {
	opacity: 0.85;
	color: #fff;
	font: 16px '微软雅黑', Tahoma, Verdana, Arial, Helvetica, sans-serif;
}

.html5yj1 table td {
	color: #fff;
	font: 11px '微软雅黑', Tahoma, Verdana, Arial, Helvetica, sans-serif;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#uag").text(navigator.userAgent);

		$("#uag").click(function() {
			$.scrollTo("#loc", 1500);

			try {
				showNotice("对方离线中，无法接受消息");
			} catch (e) {
				alert(e);
			}
			alert("a");
		});

		$('.qqfaceemotion').qqFace({
			id : 'facebox',
			assign : 'tel',
			path : 'static_/qqface/' //表情存放的路径
		});

		$("#btn").click(function() {
			var str = $("#tel").val();
			$("#uag").html(replace_em(str));
		});

	});

	function test1() {
		var obj;
		alert(obj == null);
		if (obj == null) {
			alert("a");
		} else {
			alert("b");
		}
	}
</script>
</head>

<body onload="">

	<div id="uag"></div>

	<div>
		<img height="22px" src="static_/qqface/1.gif" border="0" />
	</div>

	<div>
		<img height="22px" src="static_/bblogo.jpg" border="0"
			onclick="screenImg(this)" />
	</div>
	
	<div onclick="showScreenNotice_text('测试', 'center');">测试</div>

	<form name="form">
		<div class="html5yj">
			<div class="formhead_n">
				<div>
					<span class="glyphicon glyphicon-edit"></span>&nbsp;标题标题标题
				</div>
			</div>
			<div style="padding: 10px 10px 3px 10px">
				<div class="text1">联系方式</div>
				<input id="tel" type="text" name="t" value="" class="html5input_n"
					onclick="clearMsg();">
				<hr />
				<input id="btn" type="button" value="提交" class="html5btn"
					onclick="check();">
				<div id="msg"></div>
			</div>
		</div>
	</form>
	<br />

	<form name="form">
		<div class="html5yj">
			<div class="formhead">分布启示</div>
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="text">联系方式</td>
					<td class="input"><input type="text" name="t" value=""
						class="html5input" onclick="clearMsg();">
					</td>
				</tr>
				<tr>
					<td class="text">联系</td>
					<td class="input"><input type="text" class="html5input"
						onclick="clearMsg();">
					</td>
				</tr>
				<tr>
					<td class="text">发布内容</td>
					<td class="input"><textarea rows="4" cols="" class="html5area"
							onclick="clearMsg();"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="btn"><input type="button" value="提交"
						class="html5btn" onclick="check();">
						<div id="msg"></div>
					</td>
				</tr>
			</table>
		</div>
	</form>

	<div style="height: 400px;"></div>

	<div id="loc">111111111111111111111111</div>

	<%
		for (int i = 0; i < 2; i++) {
			String[] colors = {"#FA7CF8", "#00AFD7"};
	%>
	<div>
		<div style="float: left; margin-left: 5px;">
			<div>
				<img alt="" src="static_/doublering.png" height="14px">
			</div>
			<div style="text-align: center">
				<img alt="" src="static_/square.png" height="6px" width="2px">
			</div>
		</div>
		<div style="float: left; margin-left: 7px; color: #1FB615">昵称</div>
		<span style="float: right; color: #1FB615; font-size: 13px;">#111</span>
		<div style="clear: both;"></div>
	</div>
	<div style="border-left: 2px solid #1FB615; margin-left: 11px">
		<div style="margin-left: 13px; font-size: 12px; color: #B9DCAF">
			2014-10-10 10:10</div>
		<div class="html5yj"
			style="margin-left: 13px;background-color: <%=colors[i % 2]%>;">
			<div style="padding: 15px 10px 10px 10px;">内容内容内容内容内容内容内容内容</div>
			<div>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					style="font-size: 13px; color: #666;">
					<tr align="center" height="28px" id="11">
						<td
							style="width: 50%; border-top: 1px solid #EFEFEF; border-right: 1px solid #EFEFEF;"
							class="support"><img alt="" src="static_/2.png"
							height="15px" style="vertical-align: bottom;"> &nbsp;( <span>22</span>)
						</td>
						<td style="border-top: 1px solid #EFEFEF;" class="oppose"><span
							class="glyphicon glyphicon-thumbs-down" style="color: #000;"></span>
							&nbsp;( <span>33</span>)</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="height: 20px"></div>
	</div>
	<%
		}
	%>

	<div>
		<span class="qqfaceemotion">表情</span>
	</div>

	<div id="con" style="word-break: break-all;"></div>

	<div></div>

	<div id="search"
		style="position: absolute; left: 0; display: none; margin-top: 10px; width: 100%;">
		<div style="padding: 0 10px">
			<input type="text" name="keyword" class="html5input"
				style="width: 70%;"> <input type="button" value="搜索"
				class="html5btn" onclick="search();"
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
				String loc = "/mobile/bns?ac=list&wxaccount=&cate=";
			%>
			<ul style="list-style: none; margin: 0; padding: 0">
				<li onclick="menuClick(this,'<%=loc%>1');">生活用品</li>
				<li onclick="menuClick(this,'<%=loc%>2');">电子产品</li>
				<li onclick="menuClick(this,'<%=loc%>3');">书籍资料</li>
				<li onclick="menuClick(this,'<%=loc%>4');">鞋包服装</li>
				<li onclick="menuClick(this,'<%=loc%>5');">运动户外</li>
				<li onclick="menuClick(this,'<%=loc%>10');">其它</li>
			</ul>
			<div style="clear: both;"></div>
		</div>
	</div>

	<div id="loc" onclick="showNotice('aa');">jsaflkjskfjsdklfjsdk</div>

	<jsp:include page="/common/copyright.jsp" />

	<div id="mybar_dis"></div>
	<div id="mybar">
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr align="center" height="40px"
				style="line-height: 40px; color: #fff">
				<td style="border-right: 1px solid #666"
					onclick="javascript:history.go(-1);"><img alt=""
					src="static_/pre2.png" height="22px">
				</td>
				<td width="25%" style="border-right: 1px solid #666"
					onclick="showMenu();">类别</td>
				<td width="25%" style="border-right: 1px solid #666;"
					onclick="showSearch();">搜索</td>
				<td width="25%"
					onclick="showScreenNotice_text('1、在电脑端打开网址：<br/>http://schoolhand.duapp.com/mng<br/>2、点击获取密钥<br/>3、按照页面操作步骤进行<br/>4、关键字为：<br/><br/>请任何问题请咨询微信yy_168168');">
					发布1</td>
				<td width="20%" onclick="showScreenNotice_img('static_/gztx.jpg');">发布2</td>
			</tr>
		</table>
	</div>

	<%@ include file="/common/toolbar.html"%>
	<%@ include file="/common/tongji.html"%>
</body>
</html>
