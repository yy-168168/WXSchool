<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
	String topicId = request.getParameter("topicId");
	String s_status = request.getParameter("s_t");
	int status = s_status == null ? 1 : Integer.parseInt(s_status);
%>
<%
	String edit = (String)request.getAttribute("edit");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 照片活动</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/mng.js">
</script>

<style type="text/css">
.picWall_box {
	padding: 3px;
	border: 1px #efefef solid;
	border-radius: 5px;
	margin: 0 5px 5px 0;
}

.picWall_box_text {
	font-size: 13px;
	word-wrap: break-word;
	word-break: break-all;
	margin-top: 5px;
	text-align: left;
}

.picWall_box_info {
	text-align: left;
	font-size: 12px;
	margin-top: 5px;
}

.picWall_box_opt {
	text-align: right;
	font-size: 12px;
	margin-top: 5px;
}
</style>
		<script type="text/javascript">
$(function() {
	$(".picWall_box img").click(function() {
			var src = this.src;
			window.open("/mng/showPic.jsp?url=" + src);
		});

});
		
function check() {
	var keyword = document.getElementsByName("keyword")[0].value;

	if (keyword == "") {
		return false;
	}
}

function delete_(obj, id) {
	var r = window.confirm("此操作将彻底删除图片，是否确认删除？");
	if (r == true) {
		var picWall_box = obj.parentNode.parentNode;
		var src = $(picWall_box).find('img').attr('src');
		var url = "/mngs/picw?ac=delete_&token=<%=token%>";
		$.post(url, {
			picId : id,
			picUrl : src,
			status : '<%=status %>'
		}, function(data) {
			if (data == "deltrue") {
				picWall_box.style.display = 'none';
			} else {
				showNotice("操作失败，请重试！");
			}
		});
	}
}

function isPass(obj, id) {
	var r = window.confirm("是否确认审核通过？");
	if (r == true) {
		var picWall_box = obj.parentNode.parentNode;
		var src = $(picWall_box).find('img').attr('src');
		var url = "/mngs/picw?ac=isPass&token=<%=token%>";
		$.post(url, {
			picId : id,
			picUrl : src,
			topicId : '<%=topicId %>'
		}, function(data) {
			if (data == "true") {
				obj.style.display = 'none';
			} else if (data == "over") {
				showNotice("照片存储容量不够，请联系管理员");
			} else {
				showNotice("操作失败，请重试！");
			}
		});
	}
}
</script>
	</head>

	<body>
		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div class="left">
				<jsp:include page="/mng/menuLeft.jsp">
					<jsp:param value="" name="id" />
				</jsp:include>
			</div>

			<div class="right">
				<div class="title">
					照片墙管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div style="padding: 30px">
					<div
						style="margin-bottom: 15px; border-radius: 5px; padding: 8px 10px; background-color: #eee;">
						自定义回复照片墙链接地址：/mobile/vote?ac=listpic&topicId=<%=topicId%>
					</div>
					<div  class="list_cate" style="margin-bottom: 15px;">
						<%
							String url = "/mngs/bygl?ac=list&token=" + token + "&topicId="+topicId+"&s_t=";
						%>
						<ul>
							<li onclick="location='<%=url%>1'">
								已审核
							</li>
							<li onclick="location='<%=url%>0'"> 
								未审核
							</li>
						</ul>
						<script type="text/javascript">
							if('<%=status%>' == 0){
								$('.list_cate li:nth-child(2)').addClass('active');
							}else{
								$('.list_cate li:nth-child(1)').addClass('active');
							}
						</script>
						<ul>
							<li style="margin-left: 20px" onclick="location='/mngs/bygl?ac=list&token=<%=token %>&topicId=<%=topicId %>&s_t=<%=status %>&orderBy=spn'">
								按票数降序
							</li>
						</ul>
						<div style="float: right">
							<form id="search" method="get" action="/mngs/bygl">
								<input type="hidden" name="ac" value="search">
								<input type="hidden" name="token" value="<%=token%>">
								<input type="hidden" name="topicId" value="<%=topicId%>">
								<input type="text" size="20" maxlength="20" name="keyword">
								<input type="submit" value="搜索" onclick="return check();">
							</form>
						</div>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0">
						<tr>
						<%
							List<Vote> votes = (List<Vote>) request.getAttribute("votes");
							int i = 0;
							for (; votes != null && i < votes.size(); i++) {
								Vote vote = votes.get(i);
								if (i != 0 && i % 4 == 0) {
									%></tr><tr><%
								}
						%>
						<td width="25%" align="center" valign="top">
								<div class="picWall_box">
									<img src="<%=vote.getContent()%>" width="100%" height="180px" />
									<div class="picWall_box_text">
										<%=vote.getName()%><%=vote.getRemark()%>
									</div>
									<div class="picWall_box_info">
										<span><%=vote.getSupportNum()%></span>
										<span style="float: right"><%=vote.getAddTime()%></span>
									</div>
									<div class="picWall_box_opt">
										<%
											if (vote.getStatus() == 0) {
										%>
										<a onclick="isPass(this,'<%=vote.getVoteId()%>');">审核</a>
										<%
											}
										%>
										&nbsp;
										<a href="/mngs/bygl?ac=getBg&token=<%=token%>&voteId=<%=vote.getVoteId()%>&topicId=<%=topicId%>">编辑</a>
										&nbsp;
										<a onclick="javascript:delete_(this, '<%=vote.getVoteId()%>');">删除</a>
									</div>
								</div>
							</td>
							<%
								}
								int len = 4 - i % 4;
								len = len == 4 ? 0 : len;
								for (int j = 0; j < len; j++) {
							%>
							<td>
								&nbsp;
							</td>
							<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<% if(edit.indexOf("add") > -1){
								%>
								<input type="button" value="新增照片" class="input_button"
									onclick="location='/mngs/bygl?ac=addBg_&token=<%=token%>&topicId=<%=topicId%>'">
								<%
							} 
						%>
						
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/bygl" name="loc" />
							</jsp:include>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
