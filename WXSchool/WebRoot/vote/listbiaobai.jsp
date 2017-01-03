<%@ page language="java"
	import="java.util.*,com.wxschool.entity.*,sun.misc.BASE64Encoder"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String ac = request.getParameter("ac");
	String aId = request.getParameter("aId");
	String orderBy = request.getParameter("orderBy");
	String topicId = request.getParameter("topicId");
	String token = request.getParameter("token"); 

	Object o_p = (Page) request.getAttribute("page");
	int curPage = 1, totalPage = 1, totalRecord = 0;
	if (o_p != null) {
		Page p = (Page)o_p;
		totalRecord = p.getTotalRecord();
		curPage = p.getCurPage();
		totalPage = p.getTotalPage();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>表白墙</title>

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

		<script type="text/javascript">
var userwx = '<%=userwx%>';
var wxaccount = '<%=wxaccount%>';
var orderBy = '<%=orderBy%>';
var flagId = -1;
var visitPerson = 0;

$(function() {
	checkMM();
	
	visitPerson = getArticleVisitPerson(wxaccount,'<%=aId%>');
	$("#useNum").text(visitPerson);
	
	if(<%=curPage%> == 1 && orderBy == "null" && "<%=ac%>" == "list"){
		updateArticleVisitPerson(wxaccount,'<%=aId%>');
	}	

	$(".support").click(function() {
		vote($(this), "support", -1, '<%=userwx %>', '<%=wxaccount %>', '<%=token%>');
	});

	$(".oppose").click(function() {
		vote($(this), "oppose", -1, '<%=userwx %>', '<%=wxaccount %>', '<%=token%>');
	});
});

function showPubBB() {
	var dsp = $("#pubBB").css("display");
	if (dsp == "block") {
		$("#pubBB").slideUp();
	} else {
		$("#pubBB").slideDown();
		window.scrollTo(0, 9999);
	}
}

function check() {
	var content = document.getElementsByName("content")[0].value;
	var name = document.getElementsByName("name")[0].value;

	if ($.trim(content) == "" || $.trim(name) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	if (name.length > 20) {
		$("#msg").text("昵称内容太长");
		return false;
	}
	
	if (content.length > 480) {
		$("#msg").text("消息内容太长");
		return false;
	}
	
	$(":button").attr("disabled", true);
	$(":button").val("提交中...");
	
	var url = "/mobile/love?ac=addBB&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
		topicId : '<%=topicId%>',
		content : content,
		name : name
	}, function(data) {
		window.location.reload();
	});
}
</script>
	</head>

	<body>
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideToolbar');
});
</script>
		<!-- #1FB615 -->
		<div style="margin: -8px -8px 15px -8px;">
			<div style="height: 70px; background-color: #FC88A2"></div>
			<div style="height: 25px;"></div>
			<table width="100%" cellpadding="0" cellspacing="0" border="0"
				style="position: absolute; top: 15px;">
				<tr>
					<td rowspan="2">
						<%--<img alt="" src="static_/bblogo.jpg" style="margin-left: 20px;" width="75px" height="75px">--%>
						<span class='glyphicon glyphicon-heart'
							style="margin-left: 10px; font-size: 90px; color: red"></span>
					</td>
					<td>
						<div
							style="color: #fff; font-size: 13px; padding: 0 3px 0 10px; font-family: '华文新魏'; text-align: right; overflow: hidden; white-space: nowrap;">
							螃蟹在剥我的壳 笔记本在写我
							<br />
							漫天的我落在枫叶上雪花上
							<br />
							而你在想我
						</div>
					</td>
				</tr>
				<tr>
					<td height="40px" width="100%" valign="middle">
						<div style="padding: 0 0 0 20px; font-size: 12px; color: #999;">
							<%--<img alt="" src="static_/topic.png" height="14px" style="opacity: 0.4; vertical-align: middle">--%>
							<span class='glyphicon glyphicon-comment'></span> <span id="bbNum"><%=totalRecord%></span>表白&nbsp;&nbsp;&nbsp;
							<%--<img alt="" src="static_/vp2.png" height="14px" style="opacity: 0.4; vertical-align: middle">--%>
							<span class='glyphicon glyphicon-user'></span> <span id="useNum"></span>访问
						</div>
					</td>
				</tr>
			</table>
		</div>

		<!-- 
		<div>
			<div style="float: left;">
				<div>
					<img alt="" src="static_/edit1.png" height="24px">
				</div>
				<div style="text-align: center">
					<img alt="" src="static_/square.png" height="20px" width="2px">
				</div>
			</div>
			<div
				style="float: left; margin-left: 7px; font-size: 20px; font-weight: bold; color: #FC88A2"
				onclick="showPubBB();">
				请点击这里发布表白
			</div>
			<div style="clear: both;"></div>
		</div>
		 -->

		<%
			List<Vote> vs = (List<Vote>) request.getAttribute("vs");
			if (vs == null || vs.size() == 0) {
		%>
		<div>
			<div style="float: left; margin-left: 4px">
				<div style="margin-left: 0.5px">
					<%--<img alt="" src="static_/doublering1.png" height="16px">--%>
					<div
						style="background-color: #DFDFDF;width:14px;height:14px;border-radius:8px;border: 2px solid #FC88A2">
						<div
							style="background-color: #FC88A2;width:4px;height:4px;border-radius:2px; margin: 5px 0 0 5px;">
						</div>
					</div>
				</div>
				<div style="border-left: 2px solid #FC88A2; margin-left: 8px; height: 10px"></div>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div style="border-left: 2px solid #FC88A2; margin-left: 12px">
			<div class="html5yj" style="margin-left: 13px; margin-top: 0px">
				<div style="padding: 8px 10px;">
					表白墙空空如也...
				</div>
			</div>
			<div style="height: 20px"></div>
		</div>
		<%
			} else {
				for (int i = 0; i < vs.size(); i++) {
					Vote vote = vs.get(i);
		%>
		<div>
			<div style="float: left; margin-left: 4px">
				<div style="margin-left: 0.5px">
					<%--<img alt="" src="static_/doublering1.png" height="16px">--%>
					<div
						style="background-color: #DFDFDF;width:14px;height:14px;border-radius:8px;border: 2px solid #FC88A2">
						<div
							style="background-color: #FC88A2;width:4px;height:4px;border-radius:2px; margin: 5px 0 0 5px;">
						</div>
					</div>
				</div>
				<div style="border-left: 2px solid #FC88A2; margin-left: 8px; height: 10px"></div>
			</div>
			<div style="float: left; margin-left: 8px; color: #FC88A2">
				<%=vote.getName()%>
			</div>
			<span style="float: right; color: #FC88A2; font-size: 13px;"><%
								if(vote.getUserwx().equals(userwx)){
									%>朕<%
								}else{
									%>#<%=vote.getNum()%><%
								}
							%></span>
			<div style="clear: both;"></div>
		</div>
		<div style="border-left: 2px solid #FC88A2; margin-left: 12px">
			<div style="margin-left: 13px; font-size: 12px; color: #999">
				<%=vote.getAddTime()%>
			</div>
			<div style="margin-left: 13px;" class="html5yj">
				<div style="padding: 15px 10px 10px 10px; word-wrap: break-word; word-break:break-all;">
					<%=vote.getContent()%>
				</div>
				<div>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						style="font-size: 13px; color: #666;">
						<tr align="center" height="28px" id="<%=vote.getVoteId()%>">
							<td
								style="width: 33%; border-top: 1px solid #EFEFEF; border-right: 1px solid #EFEFEF;"
								onclick="location='/mobile/love?ac=listReply&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&voteId=<%=vote.getVoteId()%>'">
								<span class='glyphicon glyphicon-comment'></span>
								<span id="rn"><%=vote.getReplyNum()%></span>
							</td>
							<td
								style="width: 33%; border-top: 1px solid #EFEFEF; border-right: 1px solid #EFEFEF;"
								class="support">
								<span class='glyphicon glyphicon-thumbs-up'></span>
								<span id="sn"><%=vote.getSupportNum()%></span>
							</td>
							<td style="border-top: 1px solid #EFEFEF;" class="oppose">
								<span class='glyphicon glyphicon-thumbs-down'></span>
								<span id="on"><%=vote.getOpposeNum()%></span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div style="height: 20px"></div>
		</div>
		<%
			}
			}
		%>
		<div>
			<div style="float: left; margin-left: 4px">
				<div style="margin-left: 0.5px">
					<%--<img alt="" src="static_/doublering1.png" height="16px">--%>
					<div
						style="background-color: #DFDFDF;width:14px;height:14px;border-radius:8px;border: 2px solid #FC88A2">
						<div
							style="background-color: #FC88A2;width:4px;height:4px;border-radius:2px; margin: 5px 0 0 5px;">
						</div>
					</div>
				</div>
				<div style="border-left: 2px solid #FC88A2; margin-left: 8px; height: 10px"></div>
			</div>
			<div style="clear: both;"></div>
		</div>
		<div style="border-left: 2px solid #FC88A2; margin-left: 12px">
			<%
				String url = "/mobile/love?ac="+ac+"&orderBy=" + orderBy + "&userwx="
						+ userwx + "&wxaccount=" + wxaccount + "&topicId="
						+ topicId + "&aId=" + aId;
			%>
			<div class="page" style="margin-left: 13px">
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
			<div style="height: 20px"></div>
		</div>

		<!-- 发布表白 -->
		<div id="pubBB" style="display: none">
			<div>
				<div style="float: left; margin-left: 4px">
					<div style="margin-left: 0.5px">
					<%--<img alt="" src="static_/doublering1.png" height="16px">--%>
					<div
						style="background-color: #DFDFDF;width:14px;height:14px;border-radius:8px;border: 2px solid #FC88A2">
						<div
							style="background-color: #FC88A2;width:4px;height:4px;border-radius:2px; margin: 5px 0 0 5px;">
						</div>
					</div>
				</div>
				</div>
				<div style="clear: both;"></div>
			</div>
			<div style="border-left: 2px solid #FC88A2; margin-left: 11px">
				<div style="margin-left: 13px;">
					<!-- 
					<form action="/mobile/love?ac=addBB" method="post" name="form">
						昵称：
						<input type="text" name="name" onclick="clearMsg();"
							class="html5input">
						表白内容：
						<textarea rows="3" cols="" name="content" class="html5area"
							onclick="clearMsg();"></textarea>

						<div id="msg"></div>
						<input type="hidden" name="userwx" value="<%=userwx%>">
						<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
						<input type="button" value="提交" onclick="check();"
							class="html5btn">
					</form>
					 -->

					<form method="post" name="form">
						<div class="html5yj" style="margin-top: 0px">
							<div class="formhead_n">
								<div>
									<span class="glyphicon glyphicon-edit"></span>&nbsp;发布表白信息
								</div>
							</div>
							<div style="padding: 10px 10px 3px 10px">
								<div class="text1">
									昵称
								</div>
								<input type="text" name="name" onclick="clearMsg();"
									class="html5input_n">
								<hr />
								<div class="text1">
									表白内容
								</div>
								<textarea rows="4" cols="" name="content" class="html5area_n"
									onclick="clearMsg();"></textarea>
								<hr />
								<input type="button" value="提 交" onclick="check();"
									class="html5btn">
								<div id="msg"></div>
							</div>
							<!-- 
							<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td class="text">
										昵称
									</td>
									<td class="input">
										<input type="text" name="name" onclick="clearMsg();"
											class="html5input">
									</td>
								</tr>
								<tr>
									<td class="text">
										表白内容
									</td>
									<td class="input">
										<textarea rows="3" cols="" name="content" class="html5area"
											onclick="clearMsg();"></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="btn">
										<input type="button" value="提 交" onclick="check();"
											class="html5btn">
										<div id="msg"></div>
									</td>
								</tr>
							</table>
							 -->
						</div>
					</form>
				</div>
				<div style="height: 8px"></div>
			</div>
		</div>

		<div>
			<div style="float: left;">
				<img alt="" src="static_/edit2.png" height="25px">
			</div>
			<div
				style="float: left; margin-left: 7px; font-size: 20px; font-weight: bold; color: #FC88A2"
				onclick="showPubBB();">
				请点击这里发布表白
			</div>
			<div style="clear: both;"></div>
		</div>


		<jsp:include page="../common/copyright.jsp" />

		<div id="mybar_dis"></div>
		<div id="mybar">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<%
						String urlsort1 = "/mobile/love?ac=list&wxaccount=" + wxaccount
								+ "&userwx=" + userwx + "&topicId=" + topicId + "&aId="
								+ aId + "&orderBy=";
						String urlsort2 = "/mobile/love?ac=my&wxaccount=" + wxaccount
							+ "&userwx=" + userwx + "&topicId=" + topicId + "&aId="
									+ aId;
					%>
					<td style="border-right: 1px solid #666"
						onclick="location='<%=urlsort1%>4'">
						神回复
					</td>
					<td width="24%" style="border-right: 1px solid #666"
						onclick="location='<%=urlsort1%>2'">
						支持
					</td>
					<td width="24%" style="border-right: 1px solid #666"
						onclick="location='<%=urlsort1%>3'">
						吐槽
					</td>
					<td width="24%" onclick="location='<%=urlsort2%>'">
						我的
					</td>
				</tr>
			</table>
		</div>

		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
