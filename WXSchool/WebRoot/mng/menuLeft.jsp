<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String id = request.getParameter("id");
	String token = request.getParameter("token");
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
		<link rel="stylesheet" href="static_/bootstrap.min.css">
		<%-- 
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		--%>

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

#menu .second-menu {
	width: 100%;
	border-bottom: 1px solid #e8e8e8;
	cursor: pointer;
	height: 35px;
	line-height: 35px;
	display: none;
	text-align: right;
	background-color: #fefefe;
}

#menu .first-menu:first-child {
	border-top-left-radius: 5px;
}

.first-menu .img {
	display: table-cell;
	text-align: right;
	border: 0px solid red;
}

.first-menu .img span {
	margin-right: 5px;
	color: #333;
}

.first-menu .text {
	display: table-cell;
	text-align: left;
	width: 62%;
	font-weight: bold;
	color: #555;
	font-size: 17px;
}

.second-menu .text {
	display: table-cell;
	text-align: left;
	width: 62%;
	color: #888;
	font-size: 14px;
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

.select .img span {
	color: #fff;
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
		if (document.title.indexOf($(this).prop("title")) >= 0) {
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
	});
	if (flag == 0) {
		$("#menu li:first-child").addClass("select");
	}
}

function handle(obj, url) {
	$("#menu li").removeClass("select");
	$(obj).addClass("select");
	if (url.indexOf("default") > -1) {
		var $next_ = $(obj);
		while (true) {
			$next_ = $next_.next();
			var class_ = $next_.prop("class");
			if (class_ == "second-menu") {
				$next_.css("display", 'table');
			} else {
				return false;
			}
		}
	} else {
		if (url.indexOf("?") > -1) {
			url += "&token=<%=token%>";
		} else {
			url += "?token=<%=token%>";
		}
		window.location = url;
	}
}
</script>
	</head>

	<body onload="init()">
		<%
			List<Module> modules = (List<Module>) request
					.getAttribute("modules");
		%>
		<ul id="menu">
			<li class="first-menu" title="首页"
				onclick="handle(this,'/mngs/account?ac=index');">
				<div class="img">
					<span class="glyphicon glyphicon-home"></span>
				</div>
				<div class="text">
					首页
				</div>
			</li>
			<%
				int pre_id = 0;
				for (int i = 0; modules != null && i < modules.size(); i++) {
					Module module = modules.get(i);

					String url = module.getLocUrl() + "&mId=" + module.getModuleId();
					int cur_id = module.getParentId();
					if (cur_id != pre_id) {
			%>
			<li class="first-menu" title="<%=module.getName()%>"
				onclick="handle(this,'<%=url%>');">
				<div class="img">
					<span class="<%=module.getPicUrl()%>"></span>
				</div>
				<div class="text">
					<%=module.getName()%>
				</div>
			</li>
			<%
				} else {
			%>
			<li class="second-menu" title="<%=module.getName()%>"
				onclick="handle(this,'<%=url%>');">
				<div></div>
				<div class="text">
					<div style="display: table-cell;">
						<div class="boder_arrow"></div>
					</div>
					<div style="display: table-cell;">
						&nbsp;<%=module.getName()%>
					</div>
				</div>
			</li>
			<%
				}
					pre_id = module.getParentId();
				}
			%>
		</ul>
		<div style="min-height: 100px"></div>
	</body>
</html>
