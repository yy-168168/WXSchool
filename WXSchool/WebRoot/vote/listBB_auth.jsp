<%@ page import="com.wxschool.entity.Vote"%>
<%@ page import="com.wxschool.entity.Page"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String ac = request.getParameter("ac");
	String aId = request.getParameter("aId");
	String orderBy = request.getParameter("orderBy");
	String topicId = request.getParameter("topicId");
	String token = request.getParameter("token");

	Object o_p = request.getAttribute("page");
	int curPage = 1, totalPage = 1, totalRecord = 0;
	if (o_p != null) {
		Page p = (Page) o_p;
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
<meta name="format-detection" content="telphone=no, email=no"/>
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
<link href="<%=basePath %>static_/weui.css" type="text/css" rel="stylesheet">
<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

<style type="text/css">
.bbBox {
	margin-top: 10px;
	background-color: #fff;
	border-top: 1px solid #f1f1f1;
	border-bottom: 1px solid #f1f1f1;
}

.bbBox table {
	width: 100%;
	border-spacing: 0;
	border-collapse: 0;
}

.bbBox table img {
	width: 50px;
	height: 50px;
	border-radius: 25px;
}
</style>
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
		vote($(this), "support", -1, userwx, wxaccount, '<%=token%>');
	});

	$(".oppose").click(function() {
		vote($(this), "oppose", -1, userwx, wxaccount, '<%=token%>');
	});
	
	$("input[name='isTrueName']").click(function(){
		var val = $(this).attr("checked");
		if(val == undefined){
			document.getElementsByName("nickname")[0].style.display = 'block';
		}else{
			document.getElementsByName("nickname")[0].style.display = 'none';
			document.getElementsByName("nickname")[0].value = "";
		}
	});
});

function showPubForm() {
	var dsp = $("#pubForm").css("display");
	if (dsp == "block") {
		$("#pubForm").slideUp();
		$("body").css("overflow", "auto");
	} else {
		$("#pubForm").slideDown();
		window.scrollTo(0, 0);
	}
}

function check() {
	var content = document.getElementsByName("content")[0].value;
	var name = document.getElementsByName("nickname")[0].value;
	var isTrueName = document.getElementsByName("isTrueName")[0].checked;

	if ($.trim(content) == "") {
		alert("怎么能空呢？");
		return false;
	}
	
	if (content.length > 490) {
		alert("字数太多了哦");
		return false;
	}
	
	if(!isTrueName){
		if ($.trim(name) == "") {
			alert("怎么能空呢？");
			return false;
		}
		
		if (name.length > 20) {
			alert("昵称太长了啦");
			return false;
		}
	}
	
	$("#submit").addClass('weui_btn_disabled');
	
	var url = "/mobile/love?ac=addBB&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url, {
			topicId : '<%=topicId%>',
			content : content,
			name : name
		}, function(data) {
			if (data == "black") {
				showNotice("你已被拉入黑名单<br/>如有问题请联系管理员");
			} else if (data == "true") {
				showNotice("恭喜您表白成功");
				window.location.reload();
			} else {
				showNotice("发送失败，请重试");
				$("#submit").removeClass('weui_btn_disabled');
			}
		});
	}
</script>
</head>

<body onload="checkMM();" style="margin: 0">
	<script type="text/javascript">
		document.addEventListener('WeixinJSBridgeReady',
				function onBridgeReady() {
					WeixinJSBridge.call('hideToolbar');
				});
	</script>

	<div style="height: 3px; background-color: #FC88A2;"></div>

	<div style="margin-top: 10px; font-size: 12px; color: #999; text-align: center">
		<span class='glyphicon glyphicon-comment'></span> <span id="bbNum"><%=totalRecord%></span>表白&nbsp;&nbsp;&nbsp;
		<span class='glyphicon glyphicon-user'></span> <span id="useNum"></span>访问
	</div>
	
	<%
		List<Vote> vs = (List<Vote>) request.getAttribute("vs");
		for (int i = 0; vs != null && i < vs.size(); i++) {
			Vote vote = vs.get(i);
	%>
	<div class="bbBox">
		<table border="0" style="padding: 10px 10px 0 10px">
			<tr>
				<%
					if(vote.getName().equals("")){
						%>
							<td rowspan="2" width="55px">
								<%
									String headImgUrl = vote.getHeadImgUrl();
									int img_i = headImgUrl.lastIndexOf("/");
									if (img_i > -1) {
										headImgUrl = headImgUrl.substring(0, img_i) + "/96";
									}
								%>
								<img alt="" src="<%=headImgUrl %>">
							</td>
							<td style="color: #FC88A2"><%=vote.getNickname() %></td>
						<%
					}else{
						%><td style="color: #FC88A2"><%=vote.getName() %></td><%
					}
				%>
				<td align="right" style="color: #FC88A2; font-size: 13px;"><%="#"+vote.getNum() %></td>
			</tr>
			<tr>
				<td colspan="2" style="font-size: 12px; color: #999"><%=vote.getAddTime()%></td>
			</tr>
		</table>
		<div style="padding: 10px 10px 0 10px; word-wrap: break-word; word-break:break-all;">
			<%=vote.getContent()%>
		</div>
		<table style="padding-top: 10px; font-size: 13px; color: #bbb;">
			<tr align="center" height="28px" id="<%=vote.getVoteId()%>">
				<td
					style="width: 33%; border-top: 1px solid #EFEFEF; border-right: 1px solid #EFEFEF;"
					onclick="location='mobile/love?ac=listReply&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>&voteId=<%=vote.getVoteId()%>'">
					<span class='glyphicon glyphicon-comment'></span> <span id="rn"><%=vote.getReplyNum()%></span>
				</td>
				<td
					style="width: 33%; border-top: 1px solid #EFEFEF; border-right: 1px solid #EFEFEF;"
					class="support"><span class='glyphicon glyphicon-thumbs-up'></span>
					<span id="sn"><%=vote.getSupportNum()%></span>
				</td>
				<td style="border-top: 1px solid #EFEFEF;" class="oppose"><span
					class='glyphicon glyphicon-thumbs-down'></span> <span id="on"><%=vote.getOpposeNum()%></span>
				</td>
			</tr>
		</table>
	</div>
	<%
		}
	%>

	<div class="page" style="margin: 10px 10px 0 10px">
		<%
			String url = "/mobile/love?ac=" + ac + "&orderBy=" + orderBy
					+ "&userwx=" + userwx + "&wxaccount=" + wxaccount
					+ "&topicId=" + topicId + "&aId=" + aId;
		%>
		<div class="page_left">
			<div class="page_first"
				onclick="return paging('first','<%=curPage%>','<%=totalPage%>','<%=url%>');">
				首页</div>
			<div class="page_pre"
				onclick="return paging('pre','<%=curPage%>','<%=totalPage%>','<%=url%>');">
				上一页</div>
		</div>
		<div class="page_cen">
			<%=curPage%>/<%=totalPage%>
		</div>
		<div class="page_right">
			<div class="page_next"
				onclick="return paging('next','<%=curPage%>','<%=totalPage%>','<%=url%>');">
				下一页</div>
			<div class="page_end"
				onclick="return paging('end','<%=curPage%>','<%=totalPage%>','<%=url%>');">
				尾页</div>
		</div>
		<div style="clear: both;"></div>
	</div>

	<jsp:include page="../common/copyright.jsp" />

	<div id="mybar_dis"></div>
	<div id="mybar">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<%
					String urlsort1 = "/mobile/love?ac=list&wxaccount="
							+ wxaccount + "&userwx=" + userwx + "&topicId=" + topicId
							+ "&aId=" + aId + "&orderBy=";
					String urlsort2 = "/mobile/love?ac=my&wxaccount=" + wxaccount
							+ "&userwx=" + userwx + "&topicId=" + topicId + "&aId="
							+ aId;
				%>
				<td width="22%" style="border-right: 1px solid #666"
					onclick="location='<%=urlsort1%>4'">热门</td>
				<td width="22%" style="border-right: 1px solid #666"
					onclick="location='<%=urlsort1%>2'">支持</td>
				<td style="border-right: 1px solid #666" onclick="showPubForm()">
					<span class='glyphicon glyphicon-plus'></span></td>
				<td width="22%" style="border-right: 1px solid #666"
					onclick="location='<%=urlsort1%>3'">吐槽</td>
				<td width="20%" onclick="location='<%=urlsort2%>'">我</td>
			</tr>
		</table>
	</div>
	
	<!-- 发布框 -->
	<div id="pubForm" class="screenNotice" style="background-color: #DFDFDF; opacity: 1;">
		<form method="post" name="form">
			<table class="flatFormHead"><tr>
				<td width="60px"></td>
				<td class="pubTitle"><span class="glyphicon glyphicon-edit"></span>&nbsp;发布内容</td>
				<td width="60px" align="right"><span class="cancel" onclick="hideScreenNotice()">取消</span></td>
			</tr></table>
			<div style="margin: 10px 10px 0 10px">是否显示微信头像<input type="checkbox" name="isTrueName" checked="checked"></div>
			<input type="text" name="nickname" class="htmlFlatText" placeholder="输入昵称" style="display: none">
			<textarea rows="10" cols="" name="content" class="htmlFlatArea" placeholder="输入内容..."></textarea>
			<%--<div class="htmlFlatBtn" onclick="check();">发 送</div>--%>
			<a id="submit" href="javascript:check();" class="weui_btn weui_btn_primary weui_btn_my">发送</a>
			<div id="msg"></div>
		</form>
	</div>
	
	<%@ include file="../common/toolbar.html"%>
	<%@ include file="../common/tongji.html"%>
</body>
</html>
