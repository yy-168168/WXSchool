<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String ac = request.getParameter("ac");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>导航条</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<style type="text/css">
#menu {
	list-style: none;
	margin: 0;
	padding: 0;
	width: 100%;
}

#menu .first-menu {
	width: 100%;
	border-bottom: 1px solid #D7DDE6;
	cursor: pointer;
	height: 45px;
	line-height: 45px;
	display: table;
	text-align: right;
}

#menu .first-menu:first-child {
	border-top-left-radius: 5px;
}

.first-menu .text {
	display: table-cell;
	text-align: center;
	font-weight: bold;
	color: #555;
	font-size: 15px;
}

.over {
	background-color: #E5F2E3;
}

.select {
	background: -webkit-gradient(linear, 0 0, 0 100%, from(#9CCE94),
		to(#78BC6D) );
	background: -moz-linear-gradient(top, #9CCE94, #78BC6D);
	background: -o-linear-gradient(top, #9CCE94, #78BC6D);
	background: -ms-linear-gradient(top, #9CCE94, #78BC6D);
}

.select .text {
	color: #fff;
}

.select .boder_arrow {
	border-left: 5px solid #fff;
}

.boder_arrow {
	width: 0px;
	height: 0px;
	border-bottom: 5px solid transparent; /* left arrow slant */
	border-top: 5px solid transparent; /* right arrow slant  */
	border-left: 5px solid #bbb; /* bottom, add background color here */
	font-size: 0px;
	line-height: 0px;
}
</style>
<script type="text/javascript">
	$(function() {

		init();

		$("#menu li").mouseover(function() {
			$(this).addClass("over");
		}).mouseout(function() {
			$(this).removeClass("over");
		});
	});

	function init() {
		var flag = 0;
		$("#menu li").each(function(i) {
			// if (document.title.indexOf($(this).prop("title")) >= 0) {
				try{
			if ($(this).prop("onclick").toString().indexOf('<%=ac%>') >= 0) {
				if ($(this).prop("class") == "second-menu") {
					$(this).css("display", 'table');
					var $next_ = $(this);
					var $pre_ = $(this);
					while (true) {
						$pre_ = $pre_.prev();
						var class1_ = $pre_.prop("class");
						if (class1_ == "second-menu") {
							$pre_.css("display", 'table');
						} else {
							break;
						}
					}
					while (true) {
						$next_ = $next_.next();
						var class2_ = $next_.prop("class");
						if (class2_ == "second-menu") {
							$next_.css("display", 'table');
						} else {
							break;
						}
					}
				}
				$(this).addClass("select");
				flag = 1;
			}
				}catch(e){alert(e);}
		});
		if (flag == 0) {
			$("#menu li:first-child").addClass("select");
		}
	}
</script>
</head>

<body>
	<ul id="menu">
		<li class="first-menu" title="首页" onclick="location='web/function.jsp'">
			<div class="text">首页</div></li>
		<li class="first-menu" title="成绩查询" onclick="location='web/functionDetail.jsp?ac=score&num=3'">
			<div class="text">成绩查询</div></li>
		<li class="first-menu" title="四六级" onclick="location='web/functionDetail.jsp?ac=cet&num=1'">
			<div class="text">四六级</div></li>
		<li class="first-menu" title="随手拍" onclick="location='web/functionDetail.jsp?ac=pic&num=3'">
			<div class="text">随手拍</div></li>
		<li class="first-menu" title="外卖订餐" onclick="location='web/functionDetail.jsp?ac=food&num=2'">
			<div class="text">外卖订餐</div></li>
		<li class="first-menu" title="寻物招领" onclick="location='web/functionDetail.jsp?ac=thing&num=2'">
			<div class="text">寻物招领</div></li>
		<li class="first-menu" title="随机搭讪" onclick="location='web/functionDetail.jsp?ac=chat&num=4'">
			<div class="text">随机搭讪</div></li>
		<li class="first-menu" title="照片墙" onclick="location='web/functionDetail.jsp?ac=wall&num=3'">
			<div class="text">照片墙</div></li>
		<li class="first-menu" title="表白墙" onclick="location='web/functionDetail.jsp?ac=biaobai&num=4'">
			<div class="text">表白墙</div></li>
		<li class="first-menu" title="树洞" onclick="location='web/functionDetail.jsp?ac=hole&num=4'">
			<div class="text">树洞</div></li>
		<li class="first-menu" title="老乡" onclick="location='web/functionDetail.jsp?ac=friend&num=2'">
			<div class="text">老乡</div></li>
		<li class="first-menu" title="快递" onclick="location='web/functionDetail.jsp?ac=express&num=2'">
			<div class="text">快递</div></li>
	</ul>
	<div style="min-height: 100px"></div>
</body>
</html>
