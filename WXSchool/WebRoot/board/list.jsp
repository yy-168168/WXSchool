<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>告示板</title>

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

		<script type="text/javascript">
function check() {
	var cate = document.getElementsByName("cate")[0].value;
	var way = document.getElementsByName("way")[0].value;
	var content = document.getElementsByName("content")[0].value;
	var contact = document.getElementsByName("contact")[0].value;

	if (cate == "1") {
		$("#msg").text("请选择告示类别");
		return false;
	}

	if ($.trim(content) == "" || $.trim(contact) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	if (content.length > 200) {
		$("#msg").text("消息内容不能超过200字");
		return false;
	}
	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/board?ac=addBoard&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		content : content,
		contact : contact,
		way : way,
		cate : cate
	}, function(data) {
		window.location.reload();
	});
}
</script>
	</head>

	<body onload="checkMM();">
		<div>
			<%
				List<Board> boards = (List<Board>) request.getAttribute("boards");

				if (boards == null || boards.size() == 0) {
			%>
			<div class="html5yj">
				<div style="padding: 10px">
					<span>暂无任何资讯 </span>
				</div>
			</div>
			<%
				} else {
					for (int i = 0; i < boards.size(); i++) {
						Board board = boards.get(i);
			%>
			<div class="html5yj">
				<div style="padding: 10px 10px 3px 10px">
					<span><%=board.getContent()%></span>
				</div>
				<div
					style="text-align: right; color: #999; font-size: 12px; padding: 0 10px 3px 10px">
					<span><%=board.getPubTime()%></span>
				</div>
				<div class="fgx"></div>
				<div style="padding: 5px 10px 6px 10px">
					<span><%=board.getWay()%>:<%=board.getContact()%></span>
				</div>
			</div>
			<%
				}
				}
			%>
		</div>

		<form method="post" name="form" id="pubForm" style="display: none;">
			<div class="html5yj">
				<div class="formhead">
					发布告示
				</div>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="text">
							告示类别：
						</td>
						<td class="input">
							<select name="cate" onclick="clearMsg();" class="html5input">
								<option value="1" selected="selected">
									请选择
								</option>
								<option value="2">
									招聘/兼职
								</option>
								<option value="3">
									代理/代课
								</option>
								<option value="4">
									求租/出租
								</option>
								<option value="5">
									求购/甩卖
								</option>
								<option value="6">
									拼车/团游
								</option>
								<option value="10">
									其它
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="text">
							告示内容：
						</td>
						<td class="input">
							<textarea rows="4" cols="" name="content" class="html5area"
								onclick="clearMsg();"></textarea>
						</td>
					</tr>
					<tr>
						<td class="text">
							<select name="way" onclick="clearMsg();" class="html5input">
								<option value="tel">
									tel
								</option>
								<option value="qq">
									qq
								</option>
								<option value="wxin">
									wxin
								</option>
							</select>
						</td>
						<td class="input">
							<input type="text" name="contact" onclick="clearMsg();"
								class="html5input">
						</td>
					</tr>
				</table>
			</div>

			<div id="msg"></div>
			<input type="hidden" name="userwx" value="<%=userwx%>">
			<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
			<input type="button" value="提交" onclick="check();" class="html5btn">
		</form>

		<div id="pubBtn" style="margin-top: 20px;">
			<input type="button" value="发布告示" class="html5btn"
				onclick="showPubForm();">
			<script type="text/javascript">
function showPubForm() {
	$("#pubForm").show();
	$("#pubBtn").hide();
	window.scrollTo(0, 9999);
}
</script>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
