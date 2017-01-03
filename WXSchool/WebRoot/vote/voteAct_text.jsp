<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userwx = request.getParameter("userwx");
	String wxaccount = request.getParameter("wxaccount");
	String topicId = request.getParameter("topicId");

	boolean isVote = (Boolean) request.getAttribute("isVote");
	Topic topic = (Topic) request.getAttribute("topic");
	List<Vote> votes = (List<Vote>) request.getAttribute("votes");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微投票</title>

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
.cat {
	border-bottom: 1px solid #ccc;
	padding: 8px;
}

.barbox {
	margin-top: 10px;
}

.barline {
	float: left;
	height: 12px;
	width: 80%;
	border: 1px solid #ddd;
	background-color: #eee;
	border-radius: 8px;
}

.barline div {
	height: 12px;
	border-radius: 8px;
}

.last {
	float: right;
	font-size: 12px;
}
</style>
		<script type="text/javascript">
var wxaccount = '<%=wxaccount%>';
var page = 1;

$(function() {
	checkMM();
	
	if(<%=isVote%> == true){
		chart();
	}

	getQues();
});

function getQues() {
	var url = "/mobile/reply?ac=getQues_JSON&wxaccount=" + wxaccount+"&quesId=";
	$.get(url, function(data) {
		var obj;
		try{
			obj = $.parseJSON(data);
		}catch(e){
			alert("出错啦");
		}
		
		$("#quesTitle").text(obj.content);
		listReplys();
	});
}

function listReplys() {
	var url = "/mobile/reply?ac=getReplys_JSON&wxaccount="+wxaccount+"&quesId=&pg=" + page;
	$.ajax( {
		url : url,
		beforeSend : function() {
			$("#loadn").text("加载中...");
		},
		success : function(data) {
			var obj;
			try{
				obj = $.parseJSON(data);
			}catch(e){
				alert("出错啦");
			}
			
			if (obj == null || obj == "") {
				$("#loadn").text("没有更多");
				return false;
			}
			$.each(obj, function(i, n) {
				var str = "<div class='view_box_white' style='line-height: 1.6;'>"
						+ "<div style='color: #4C4C4C;'>" + n.content
						+ "</div><div style='text-align: right; "
						+ "font-size: 12px; color: #aaa;'>" + n.pubTime
						+ "</div></div>";
				$("#quesReply").append(str);
			});
			$("#loadn").html(
					"<img alt='' src='static_/down.png' "
							+ "height='12px'>点击加载更多…");
		}
	});
	page++;
}

function check1() {
	if ($(":checked").length == 0) {
		$("#msg1").text("您还未选择");
		return false;
	}
	
	var voteId = document.getElementsByName("voteId")[0].value;
	
	$(":button").attr("disabled", true);
	$(":button").val("提交中...");
	
	var url = "/mobile/vote?ac=addVotePerson&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url,{topicId:'<%=topicId%>',voteId:voteId},function(data){
		window.location.reload();
	});
}

function check2() {
	var content = document.getElementsByName("content")[0].value;
	
	if ($.trim(content) == "") {
		$("#msg2").text("不能为空");
		return false;
	}
	if (content.length > 100) {
		$("#msg2").text("消息内容不能超过100字");
		return false;
	}
	$(":button").attr("disabled", true);
	$(":button").val("提交中...");
	
	var url = "/mobile/reply?ac=addReply&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$.post(url,{quesId:'',content:content},function(data){
		page = 1;
		document.getElementsByName("content")[0].value = "";
		$("#quesReply").html("");
		listReplys();
	});
}

function clearMsg() {
	$("#msg1").text("");
	$("#msg2").text("");
}

function chart(){
	$(".cat").each(function(){
		var totalnum= <%=topic.getPersonNum()%>;
		var truesize = parseInt($(this).find(".truesize").text());
		var size = Math.round(truesize/totalnum*100);
		$(this).find(".last").text(size+"%");
		
		if (size >= 60) {
			$(this).find(".chart").css("background-color", "#FBA426");
			$(this).find(".last").css("color", "#FBA426");
		} else if (size >= 10 && size < 60) {
			$(this).find(".chart").css("background-color", "#FF6E24");
			$(this).find(".last").css("color", "#FF6E24");
		} else {
			$(this).find(".chart").css("background-color", "red");
			$(this).find(".last").css("color", "red");
		}
		var clientwidth = document.body.clientWidth;
		var barlinewidth = clientwidth * 80 / 100 * size / 100;
		$(this).find(".chart").css("width", barlinewidth);
	});
}
</script>

	</head>

	<body>
		<div class="html5yj" style="padding: 10px">
			<div style="font-size: 20px; text-align: center;">
				<%=topic.getTitle()%>
			</div>
			<!-- 时间
			<div
				style="font-size: 12px; color: #888; padding: 3px 0; text-align: right;">
			</div>
			 -->
			<div style="font-size: 14px; padding: 5px 0">
				<%=topic.getDesc()%>
			</div>
			<div
				style="border-top: 1px solid #D5D5D5; border-bottom: 1px solid #D5D5D5; background-color: #F5F5F5; text-align: center; padding: 5px 0; font-size: 14px; color: #666;">
				已有<%=topic.getPersonNum()%>人参与投票
			</div>

			<%
				if (isVote) {
			%>
			<div>
				<%
					for (int i = 0; votes != null && i < votes.size(); i++) {
							Vote vote = votes.get(i);
				%>
				<div class="cat">
					<%=vote.getName()%>(<%=vote.getContent()%>)
					<div style="float: right;">
						<span class="truesize" style="font-size: 12px;"><%=vote.getSupportNum()%></span>
						<img alt="" src="static_/support.png" height="13px">
					</div>
					<div class="barbox">
						<div class="barline">
							<div class="chart"></div>
						</div>
						<div class="last">
							<span class="size"></span>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<%
					}
				%>
			</div>
			<%
				} else {
			%>
			<form id="form1" name="form">
				<%
					for (int i = 0; votes != null && i < votes.size(); i++) {
							Vote vote = votes.get(i);
				%>
				<div class="cat">
					<label>
						<input type="radio" name="voteId" value="<%=vote.getVoteId()%>"
							onclick="clearMsg();">
						<%=vote.getName()%>(<%=vote.getContent()%>)
					</label>
				</div>
				<%
					}
				%>
				<div id="msg1" style="font-size: 12px; height: 18px; color: red;"></div>
				<input type="button" value="确认提交" class="html5btn"
					onclick="check1();">
			</form>
			<%
				}
			%>
		</div>

		<a name="ques"></a>
		<!-- 锚点 -->
		<div style="margin-top: 15px">
			<div id="quesTitle"
				style="margin: -8px -8px 0 -8px; background-color: #4F4F4F; text-align: center; color: #fff; padding: 8px">
			</div>
			<div id="quesReply">
			</div>
			<div id="loadn" onclick="listReplys();"
				style="text-align: center; padding: 8px">
			</div>
		</div>

		<div style="margin-top: 20px;">
			<div style="font-size: 13px">
			</div>
			<form id="form2">
				<textarea rows="3" cols="" name="content" class="html5area"
					onclick="clearMsg();"></textarea>
				<div id="msg2" style="font-size: 12px; height: 14px; color: red;"></div>
				<input type="button" value="吐槽一下" class="html5btn"
					onclick="check2();">
			</form>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
