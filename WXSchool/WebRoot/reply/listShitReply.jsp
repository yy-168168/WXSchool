<%@ page language="java"
	import="java.util.*,java.text.*,com.wxschool.entity.*"
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
	String shitId = request.getParameter("shitId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>树洞</title>

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
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<style type="text/css">
.bg_shit {
	position: fixed;
	top: 0px;
	left: 0px;
	z-index: -10;
}

.item_shit {
	margin-left: 15px;
	padding: 10px 10px 5px 10px;
	opacity: 0.8;
	border-radius: 3px;
	background-color: #fff;
	box-shadow: 0px 2px 2px #eee;
	word-wrap: break-word;
	word-break:break-all;
}

#shit_bgcolor {
	list-style: none;
	padding: 0;
	margin: 0;
}

#shit_bgcolor li {
	width: 30px;
	height: 30px;
	line-height: 30px;
	float: left;
	margin-left: 15px;
	text-align: center;
}
</style>

		<script type="text/javascript">
function check() {
	var content = document.getElementsByName("content")[0].value;
	var parentUserwx = document.getElementsByName("parentUserwx")[0].value;
	var other = $('input[name="other"]:checked').val();

	if ($.trim(content) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	if (other == undefined) {
		$("#msg").text("请选择一个背景色");
		return false;
	}

	if (content.length > 480) {
		$("#msg").text("消息内容不能过长");
		return false;
	}
	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mobile/reply?ac=addReply&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		shitId : '<%=shitId%>',
		content : content,
		other : other,
		parentUserwx : parentUserwx
	}, function(data) {
		window.location.reload();
	});
}
</script>
	</head>

	<body onload="checkMM()">
		<img class="bg_shit" src="static_/bg_shit.jpg"
			style="width: 100%; height: 100%" />

		<div
			style="background-color: #EA2534; padding: 8px 0; text-align: center; margin: -8px -8px 20px -8px;">
			<div style="font-size: 24px; font-weight: bold; color: #fff;">
				树洞
				<span style="font-size: 15px">--吐槽·心声·秘密</span>
			</div>
		</div>

		<%
			Question shit = (Question) request.getAttribute("ques");
			String parentUserwx = "";
			if(shit == null){
				%>
				<table width="100%" cellpadding="0" cellspacing="0" border="0"
					style="margin-top: 15px">
					<tr>
						<td valign="middle">
							<div
								style="height: 40px; line-height: 40px; width: 64px; border-radius: 32px/20px; text-align: center; background-color: #fff">
								<span style="font-size: 13px; color: #fff">洞主</span>
							</div>
						</td>
						<td width="100%">
							<div class="item_shit">
								出错啦，未获取到数据
							</div>
						</td>
					</tr>
				</table>
				<%
			}else{
				parentUserwx = shit.getUserwx();
				%>
				<table width="100%" cellpadding="0" cellspacing="0" border="0"
					style="margin-top: 15px">
					<tr>
						<td valign="middle">
							<div
								style="height: 40px; line-height: 40px; width: 64px; border-radius: 32px/20px; text-align: center; background-color: <%=shit.getOther()%>">
								<span style="font-size: 13px; color: #fff"><%
										if(parentUserwx.equals(userwx)){
											%>朕<%
										}else{
											%>洞主<%
										}
								%></span>
							</div>
						</td>
						<td width="100%">
							<div class="item_shit">
								<div
									style="padding-bottom: 6px; font-family: '微软雅黑', Tahoma, Verdana, Arial, Helvetica, sans-serif;">
									<%=shit.getContent()%>
								</div>
								<div style="font-size: 13px; color: #666">
									&nbsp;
									<span style="float: right;"><%=shit.getPubTime()%></span>
								</div>
							</div>
						</td>
					</tr>
				</table>
				<%
			}
		%>

		

		<div style="height: 0px; border: 1px dotted #eee; margin: 15px 0;"></div>

		<div>
			<%
				List<Reply> replys = (List<Reply>) request.getAttribute("replys");
				for (int i = 0; replys != null && i < replys.size(); i++) {
					Reply reply = replys.get(i);

					String curUserwx = reply.getUserwx();
					String putTime = reply.getPubTime();
					String beginTime = "2014-11-17 00:00";
					String num = "#" + reply.getNum();

					try {
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
						boolean isAfter = df.parse(putTime).after(
								df.parse(beginTime));

						if (isAfter && curUserwx.equals(parentUserwx)) {
							num = "洞主";
						}
						
						if(curUserwx.equals(userwx)){
							num = "朕";
						}
					} catch (ParseException e) {
					}
			%>
			<table width="100%" cellpadding="0" cellspacing="0" border="0"
				style="margin-top: 15px">
				<tr>
					<td valign="middle">
						<div
							style="height: 40px; line-height: 40px; width: 64px; border-radius: 32px/20px; text-align: center;background-color: <%=reply.getOther()%>">
							<span style="font-size: 13px; color: #fff"><%=num%></span>
						</div>
					</td>
					<td width="100%">
						<div class="item_shit">
							<div
								style="padding-bottom: 8px; font-family: '微软雅黑', Tahoma, Verdana, Arial, Helvetica, sans-serif;">
								<%=reply.getContent()%>
							</div>
							<div style="font-size: 13px; color: #666">
								&nbsp;
								<span style="float: right;"><%=reply.getPubTime()%></span>
							</div>
						</div>
					</td>
				</tr>
			</table>
			<%
				}
			%>
		</div>

		<!-- 发布吐槽回复 -->
		<div id="pubForm" style="margin-top: 15px; display: none">
			<form method="post" name="form">
				<div class="html5yj" style="margin-top: 0px">
					<div class="formhead_n">
						<div>
							<span class="glyphicon glyphicon-edit"></span>&nbsp;评论此条洞语
						</div>
					</div>
					<div style="padding: 10px 10px 3px 10px">
						<div class="text1">
							评论内容
						</div>
						<textarea rows="4" cols="" name="content" class="html5area_n"
							onclick="clearMsg();"></textarea>
						<hr />
						<div class="text1">
							背景色
						</div>
						<ul id="shit_bgcolor">
							<li style="background-color: #1A531E;">
								<input type="radio" name="other" value="1A531E" />
							</li>
							<li style="background-color: #1E0155;">
								<input type="radio" name="other" value="1E0155" />
							</li>
							<li style="background-color: #FF7F00;">
								<input type="radio" name="other" value="FF7F00" />
							</li>
							<li style="background-color: #AB291C;">
								<input type="radio" name="other" value="AB291C" />
							</li>
							<li style="background-color: #8E8460;">
								<input type="radio" name="other" value="8E8460" />
							</li>
							<li style="background-color: #017BBE;">
								<input type="radio" name="other" value="017BBE" />
							</li>
						</ul>
						<div style="clear: both"></div>
						<hr />
						<input type="hidden" name="parentUserwx" value="<%=parentUserwx %>">
						<input type="button" value="提 交" onclick="check();"class="html5btn">
						<div id="msg"></div>
					</div>
				</div>
			</form>
		</div>

		<div id="pubBtn" style="margin-top: 15px;">
			<input type="button" value="点此发布评论" class="html5btn"
				onclick="showPubForm();" style="background: #428BCA; color: #fff;">
			<script type="text/javascript">
function showPubForm() {
	$("#pubForm").slideDown();
	$("#pubBtn").slideUp();
}
</script>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
