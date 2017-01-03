<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String aId = request.getParameter("aId");
	String province = request.getParameter("province");
	String city = request.getParameter("city");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>同城老乡</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath%>static_/jquery-1.8.2.min.js">
</script>
<script type="text/javascript" src="<%=basePath%>static_/mycommon.js">
</script>
<script type="text/javascript" src="<%=basePath%>static_/province.js">
</script>

<style type="text/css">
#bar_menu_dt li {
	height: 40px;
	line-height: 40px;
}

.address {
	background-color: #777;
	color: #fff;
	font-size: 12px;
	border-radius: 10px;
	padding: 4px 10px;
	float: right;
	max-width: 100px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.name {
	font-size: 20px;
	font-weight: 700;
	color: #103261;
}

.major_wx {
	font-size: 13px;
	margin-top: 5px;
}
</style>
<script type="text/javascript">
var p = '<%=province%>';
var c = '<%=city%>';
var wxaccount = '<%=wxaccount%>';
var userwx = '<%=userwx%>';
var page = 1;
var timer, curPst;

$(function() {
	checkMM();

	if (page == 1 && c == "null") {
		updateArticleVisitPerson(wxaccount, '<%=aId%>');
	}

	showFellow();
});

//滚动条到底自动加载
$(window).scroll(function() {
	var jl = document.body.scrollHeight - document.body.scrollTop
			- document.body.clientHeight;
	if (jl == 0) {
		showFellow();
	}
});

function showFellow() {
	if ($("#loadn").text() == '没有更多') {
		return false;
	}

	var url = "mobile/friend?ac=getFellow&wxaccount=<%=wxaccount%>&province=" + p
			+ "&city=" + c + "&page=" + page;
	$.ajax( {
		url : url,
		type : 'POST',
		beforeSend : function() {
			$("#loadn").html("<img src='/static_/loading.gif' height='30px' " + "style='padding-top:8px' />");
		},
		success : function(data) {
			$("#loadn").empty();
			var json = null;
			try{
				json = $.parseJSON(data);
			}catch(e){
				alert("出错啦");
			}
			
			if (json == null || json == "") {
				$("#loadn").html("<div style='padding-top:8px;font-size:14px'>没有更多</div>");
				return false;
			}
			$.each(json,
				function(i, n) {
					var cont = "<div class='view_box_white'><table width='100%' cellpadding='0' cellspacing='0' border='0'><tr>";
					if (n.sex == '2') {
						cont += "<td rowspan='3'><img src='/static_/woman.png' width='66px' style='margin: 0 16px 0 8px'></td>";
					} else {
						cont += "<td rowspan='3'><img src='/static_/man.png' width='66px' style='margin: 0 16px 0 8px'></td>";
					}
					cont += "<td colspan='2' width='100%'><div><span class='name'>" + n.stuName + "</span>";
					cont += "<div class='address'>" + n.city + n.county + "</div></div></tr>";
					cont += "<tr class='major_wx'><td style='white-space: nowrap; padding-top: 8px'>专业：</td>";
					if(n.major == ""){//没有专业信息
						cont += "<td width='100%' style='padding-top: 8px'>" + n.grade + "级" + n.depart + "</td></tr>";
					}else{
						cont += "<td width='100%' style='padding-top: 8px'>" + n.grade + "级" + n.major + "</td></tr>";
					}
					cont += "<tr class='major_wx'><td style='white-space: nowrap'>微信：</td><td width='100%'>" + n.find + "</td></tr></table></div>";
					$("#content").append(cont);
				});
			if (page != 1 && page != 2) {
				//var curTop = document.body.scrollTop;
				//timer = setInterval("runToLoc(" + curTop + ")", 1);
			}
		}
	});
	page++;
}

function runToLoc(curTop) {
	curPst = document.body.scrollTop;
	curPst += 4;
	window.scrollTo(0, curPst);
	if (curPst >= curTop + document.body.clientHeight - 50 - 32
			|| curPst >= document.body.scrollHeight
					- document.body.clientHeight) {
		clearInterval(timer);
		return false;
	}
}

function showCityList() {
	$.each(province, function(i, n) {
		if (p == n[0]) {
			$.get("static_/province_city/" + i + ".js", function(msg1) {
				var num = 0;
				var ops = "";
				$.each(province_city,
						function(j, m) {
							var url = "mobile/friend?ac=list&wxaccount=" + wxaccount + "&userwx=" + userwx + "&province=" + p + "&city=";
							if (i == m[1]) {
								url += m[0];
								var str = "<li onclick='menuClick(this,\""
										+ url + "\");' style='float: left; "
										+ "width: 49%'>" + m[0] + "</li>";
								ops += str;
								num++;
							}
						});
				if (num % 2 == 1) {
					ops += "<li style='float: left;width: 49%'></li>";
				}
				var url = "mobile/friend?ac=list&wxaccount=" + wxaccount + "&userwx=" + userwx + "&province=" + p;
				ops += "<li style='clear:both; width: 98%' " + "onclick='menuClick(this,\"" + url + "\");'>" + p + "</li>";
				$("#bar_menu_dt ul").html(ops);
				$("#bar_menu_dt ul li:nth-child(odd)").css("border-right", "1px solid #666");
				$("#bar_menu_dt ul li:last-child").css("border", "0");
			});
		}
	});
}

function isExist() {
	if (p == null || p == 'null') {
		var url = "mobile/friend?ac=isExist&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
		$.post(url, function(data) {
			if (data == 'error') {
				return false;
			} else if (data == 'notExist') {
				window.location.href = "mobile/stu?ac=stuInfo&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
			} else {
				p = data;
				showCityList();
				showMenu();
			}
		});
	} else {
		showCityList();
		showMenu();
	}
}
</script>

</head>

<body onclick="hideMenu(event);">
	<script type="text/javascript">
		document.addEventListener('WeixinJSBridgeReady',
				function onBridgeReady() {
					WeixinJSBridge.call('hideToolbar');
				});
	</script>

	<div id="content"></div>
	<div id="loadn" style="text-align: center;"></div>

	<jsp:include page="../common/copyright.jsp" />

	<div id="mybar_dis"></div>
	<div id="mybar">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<%
					String url = "mobile/friend?ac=list&wxaccount=" + wxaccount
							+ "&userwx=" + userwx;
				%>
				<td style="border-right: 1px solid #666"
					onclick="location='<%=url%>'">随便看看</td>
				<td width="50%" style="border-right: 1px solid #666"
					onclick="return isExist();" id="showMenu_">同城</td>
			</tr>
		</table>
	</div>


	<div id="bar_menu" style="width: 60%; left: 20%; bottom: 50px;">
		<div id="bar_menu_dt">
			<ul style="list-style: none; margin: 0; padding: 0"></ul>
			<div style="clear: both;"></div>
		</div>
	</div>

	<div style="display: none">
		<img alt="" src="/static_/man.png"> <img alt=""
			src="/static_/woman.png">
	</div>

	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
