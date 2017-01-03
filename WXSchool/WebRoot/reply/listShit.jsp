<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String ac = request.getParameter("ac");
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String aId = request.getParameter("aId");
	String orderBy = request.getParameter("orderBy");
	String topicId = request.getParameter("topicId");

	Page p = (Page) request.getAttribute("page");
	int curPage = 1, totalPage = 1, totalRecord = 0;
	if (p != null) {
		totalRecord = p.getTotalRecord();
		curPage = p.getCurPage();
		totalPage = p.getTotalPage();
	}
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
$(function() {
	checkMM();
	
	if(<%=curPage%> == 1 && '<%=orderBy%>' == "2" && "<%=ac%>" == "listshit"){
		updateArticleVisitPerson('<%=wxaccount%>','<%=aId%>');
	}
});

function showPubShit() {
	var dsp = $("#pubShit").css("display");
	if (dsp == "block") {
		$("#pubShit").slideUp();
	} else {
		$("#pubShit").slideDown();
	}
}

function check() {
	var content = document.getElementsByName("content")[0].value;
	var other = $('input[name="other"]:checked').val();

	if ($.trim(content) == "" ) {
		$("#msg").text("不能为空");
		return false;
	}
	
	if (other == undefined ) {
		$("#msg").text("请选择一个背景色");
		return false;
	}

	if (content.length > 496) {
		$("#msg").text("消息内容最多为500字");
		return false;
	}
	$(":button").attr("disabled", true);
	$(":button").val("提交中...");
	
	var url = "/mobile/reply?ac=addQues&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		topicId : '<%=topicId%>',
		content : content,
		other : other
	}, function(data) {
		window.location.reload();
	});
}
</script>
	</head>

	<body>
		<img class="bg_shit" src="static_/bg_shit.jpg"
			style="width: 100%; height: 100%" />

		<div
			style="background-color: #EA2534; padding: 8px 0; text-align: center; margin: -8px -8px 20px -8px;">
			<div style="font-size: 24px; font-weight: bold; color: #fff;">
				树洞
				<span style="font-size: 15px">--吐槽·心声·秘密</span>
				<div style="float: right; padding: 0 10px;" onclick="showPubShit();">
					<span class='glyphicon glyphicon-edit'></span>
				</div>
			</div>
		</div>

		<!-- 发布吐槽 -->
		<div id="pubShit" style="display: none">
			<form method="post" name="form">
				<div class="html5yj" style="margin-top: 0px">
					<div class="formhead_n">
						<div>
							<span class="glyphicon glyphicon-edit"></span>&nbsp;发布您的洞语
						</div>
					</div>
					<div style="padding: 10px 10px 3px 10px">
						<div class="text1">
							洞语内容
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
						<input type="button" value="提 交" onclick="check();"
							class="html5btn">
						<div id="msg"></div>
					</div>
				</div>
			</form>
		</div>

		<div>
			<%
				List<Question> shits = (List<Question>) request
						.getAttribute("shits");
				for (int i = 0; shits != null && i < shits.size(); i++) {
					Question shit = shits.get(i);
			%>
			<table width="100%" cellpadding="0" cellspacing="0" border="0"
				style="margin-top: 15px">
				<tr>
					<td valign="middle">
						<div
							style="height: 40px; line-height: 40px; width: 64px; border-radius: 32px/20px; text-align: center; background-color: <%=shit.getOther()%>">
							<span style="font-size: 13px; color: #fff"><%
								if(shit.getUserwx().equals(userwx)){
									%>朕<%
								}else{
									%>#<%=shit.getNum()%><%
								}
							%></span>
						</div>
					</td>
					<td width="100%">
						<div class="item_shit"
							onclick="location='/mobile/reply?ac=listshitreply&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&shitId=<%=shit.getQuesId()%>'">
							<div
								style="padding-bottom: 8px; font-family: '微软雅黑', Tahoma, Verdana, Arial, Helvetica, sans-serif;">
								<%=shit.getContent()%>
							</div>
							<div style="font-size: 13px; color: #666">
								<span><%=shit.getPubTime()%></span>
								<span style="float: right;"><span
									class='glyphicon glyphicon-comment'></span>&nbsp;<%=shit.getReplyNum()%>
									&nbsp;&nbsp;<span class='glyphicon glyphicon-user'></span>&nbsp;<%=shit.getVisitPerson()%>
								</span>
							</div>
						</div>
					</td>
				</tr>
			</table>
			<%
				}
			%>
		</div>

		<div style="margin-top: 20px;">
			<%
				String url = "/mobile/reply?ac="+ac+"&orderBy=" + orderBy + "&userwx="
						+ userwx + "&wxaccount=" + wxaccount + "&topicId="
						+ topicId;
			%>
			<div class="page">
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
		</div>

		<jsp:include page="../common/copyright.jsp" />

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<%
						String urlsort1 = "/mobile/reply?ac=listshit&wxaccount=" + wxaccount
								+ "&userwx=" + userwx + "&topicId=" + topicId + "&orderBy=";
						String urlsort2 = "/mobile/reply?ac=myShit&wxaccount=" + wxaccount
								+ "&userwx=" + userwx + "&topicId=" + topicId;
					%>
					<td style="border-right: 1px solid #666"
						onclick="location='<%=urlsort1%>2'">
						最新
					</td>
					<td width="35%" style="border-right: 1px solid #666"
						onclick="location='<%=urlsort1%>3'">
						热门
					</td>
					<td width="35%" onclick="location='<%=urlsort2%>'">
						我的
					</td>
				</tr>
			</table>
		</div>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
