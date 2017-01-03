<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String aId = request.getParameter("aId");
	String topicId = request.getParameter("topicId");

	Page p = (Page) request.getAttribute("page");
	int totalRecord = 0;
	if (p != null) {
		totalRecord = p.getTotalRecord();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>寻物/招领</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" /> 
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>
		<style type="text/css">
.cate_sty {
	color: #fff;
	padding: 3px 5px;
	font-size: 14px;
	border-radius: 5px;
}

.view_box_white {
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
}
</style>

		<script type="text/javascript">
$(function() {
	checkMM();

	var visitPerson = 0;
	if ('<%=topicId%>' != 'null') {
		var topic = getTopic('<%=wxaccount%>', '<%=topicId%>');
		visitPerson = $.parseJSON(topic).personNum;
	} else {
		visitPerson = getArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	}
	$("#useNum").text(visitPerson);
	
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
	updateTopicVisitPerson('<%=wxaccount%>', '<%=topicId%>');
});

function check() {
	var content = document.getElementsByName("content")[0].value;
	var contact = document.getElementsByName("contact")[0].value;
	var cate = $('input[name="cate"]:checked').val();

	if ($.trim(content) == "" || $.trim(contact) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	var re = new RegExp("^1[0-9]{10}$");
	if (!re.test($.trim(contact))) {
		$("#msg").text("请输入正确的手机号");
		return false;
	}

	if (content.length > 490) {
		$("#msg").text("消息内容不能超过500字");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/board?ac=addThing&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		content : content,
		contact : contact,
		cate : cate
	}, function(data) {
		window.location.reload();
	});
}
</script>

	</head>

	<body>
		<div
			style="margin: -8px -8px 0 -8px; background-color: #EA2534; padding: 8px 0; text-align: center;">
			<div style="font-size: 20px; font-weight: bold; color: #fff;">
				<%--<img alt="" src="static_/love.png" height="14px">--%>
				<%--<span class='glyphicon glyphicon-heart' style='font-size: 13px'></span>--%>
				寻物/招领
				<span style="font-size: 14px">--专注于校园公益事业</span>
			</div>
		</div>

		<div
			style="margin-top: 10px; font-size: 12px; color: #999; text-align: center;">
			<span class='glyphicon glyphicon-comment'></span><span id="bbNum"><%=totalRecord%></span>数据&nbsp;&nbsp;&nbsp;&nbsp;
			<span class='glyphicon glyphicon-user'></span><span id="useNum"></span>访问&nbsp;&nbsp;&nbsp;&nbsp;
			<span>仅列出最近10天数据</span>
		</div>

		<form method="post" id="pubForm" style="display: none;">
			<div class="html5yj">
				<div class="formhead_n">
					<div>
						<span class="glyphicon glyphicon-edit"></span>&nbsp;发布寻物招领信息
					</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div class="text1">
						信息详情
					</div>
					<textarea rows="4" cols="" name="content" class="html5area_n"
						onclick="clearMsg();"></textarea>
					<hr />
					<div class="text1">
						联系电话
					</div>
					<input type="text" name="contact" onclick="clearMsg();"
						class="html5input_n">
					<hr />
					<div class="text1">
						信息类别
					</div>
					<label>
						<input type="radio" name="cate" value="71" onclick="clearMsg();"
							checked="checked">
						寻物
					</label>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<label>
						<input type="radio" name="cate" value="72" onclick="clearMsg();">
						招领
					</label>
					<hr />
					<input type="button" value="提 交" class="html5btn"
						onclick="check();">
					<div id="msg"></div>
				</div>
			</div>
		</form>

		<div id="pubBtn" style="margin-top: 10px;">
			<input type="button" value="点此发布信息" class="html5btn"
				onclick="showPubForm();" style="background: #428BCA; color: #fff;">
			<script type="text/javascript">
function showPubForm() {
	$("#pubForm").slideDown();
	$("#pubBtn").slideUp();
}
</script>
		</div>

		<div>

			<%
				List<Board> boards = (List<Board>) request.getAttribute("boards");
				int size;
				if (boards == null || boards.size() == 0) {
			%>
			<div style="padding: 10px; font-size: 14px">
				暂无遗失信息『请保护好自己的财产』
			</div>
			<%
				} else {
					String[] cates = { "寻物", "招领" };
					String[] cateColors = { "#68A50F", "#EC971F" };
					for (int i = 0; i < boards.size(); i++) {
						Board thing = boards.get(i);
			%>
			<!-- 
			<div style="padding: 6px 10px">
				<div style="color: #4C4C4C;">
					<%=thing.getContent()%>
				</div>
				<div style="margin: 3px 0; font-size: 14px; color: #666;">
					tel：<%=thing.getContact()%>
				</div>
				<div style="text-align: right; font-size: 12px; color: #999;">
					<%=thing.getPubTime()%>
				</div>
			</div>
			<div class="fgx" style="margin: 0 -8px"></div>
			 -->

			<div class="view_box_white">
				<div style="line-height: 1.6">
					<span class="cate_sty"
						style="background-color: <%=cateColors[thing.getCate() - 71]%>"><%=cates[thing.getCate() - 71]%></span>&nbsp;<%=thing.getContent()%>
				</div>
				<div style="margin-top: 5px; font-size: 14px; color: #999;">
					Tel：
					<a href="tel:<%=thing.getContact()%>"><%=thing.getContact()%></a>
					<span style="float: right; font-size: 12px;"> <%=thing.getPubTime()%>
					</span>
				</div>
			</div>
			<%
				}
				}
			%>
		</div>

		<!-- 
		<div id="pubForm"
			style="margin-top: 20px; line-height: 1.7; display: none;">
			<form action="/mobile/board?ac=addThing" method="post">
				<span style="font-size: 14px">物品详细信息:</span>
				<textarea rows="3" cols="" name="content" class="html5area"
					onclick="clearMsg();"></textarea>
				<span style="font-size: 14px">联系方式:</span>
				<input type="text" name="contact" onclick="clearMsg();"
					class="html5input">

				<div id="msg" style="font-size: 12px; height: 18px; color: red;"></div>
				<input type="hidden" name="userwx" value="<%=userwx%>">
				<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
				<input type="hidden" name="way" value="tel">
				<input type="button" value="提交" class="html5btn" onclick="check();">
			</form>
		</div>
		 -->

		<!-- 
		<div id="showMenu"
			onclick="location='/mobile/board?ac=getBoards&userwx=<%=userwx%>&wxaccount=<%=wxaccount%>'">
		</div>
		 -->

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
