<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
	String s_status = request.getParameter("s_t");
	int status = s_status == null ? 0 : Integer.parseInt(s_status);
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
	selectOfTransfer($(".transfer"));

	$(".picWall_box img").click(function() {
			var src = this.src;
			window.open("/mng/showPic.jsp?url=" + src);
		});

});

function transfer(obj) {
	var topicId = $(obj).val();
	var picId = $(obj).prop('id');
	if (topicId == "") {
		return false;
	}
	location.href = "/mngs/bygl?ac=getBg&token=<%=token%>&voteId=" + picId + "&topicId=" + topicId;
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

function selectOfTransfer(obj_sel) {
	var url = "/mngs/topic?ac=getTopicsOfPic&token=<%=token%>";
	$.get(url, function(data) {
		var obj = $.parseJSON(data);
		if (obj != null && obj != "") {
			var ops = "";
			$.each(obj, function(i, n) {
				ops += "<option value='" + n.topicId + "'>" + n.title
						+ "</option>";
			});
			obj_sel.append(ops);
		}
	});
}

function isPass(obj, id) {
	var r = window.confirm("是否确认审核通过？");
	if (r == true) {
		var picWall_box = obj.parentNode.parentNode;
		var src = $(picWall_box).find('img').attr('src');
		var url = "/mngs/picw?ac=isPass&token=<%=token%>";
		$.post(url, {
			picId : id,
			picUrl : src
		}, function(data) {
			if (data == "true") {
				obj.style.display = 'none';
				obj.style.display = 'none';
				var html = "<select class='transfer' id=" + id
						+ " style='width: 50px;' onchange='transfer(this);'>"
						+ "<option value=''>转移</option></select>";
				$(obj.parentNode).prepend(html);
				selectOfTransfer($(obj.parentNode).find('select'));
			} else if (data == "over") {
				showNotice("照片存储容量不够，请联系管理员");
			} else {
				showNotice("操作失败，请重试！");
			}
		});
	}
}

function check() {
	var keyword = document.getElementsByName("keyword")[0].value;

	if (keyword == "") {
		return false;
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
					<div class="list_cate" style="margin-bottom: 15px;">
						<%
							String url = "/mngs/picw?ac=list&token=" + token + "&s_t=";
						%>
						<ul>
							<li onclick="location='<%=url%>0'"> 
								未审核
							</li>
							<li onclick="location='<%=url%>1'">
								已审核
							</li>
						</ul>
						<script type="text/javascript">
							if('<%=status%>' == 1){
								$('.list_cate li:nth-child(2)').addClass('active');
							}else{
								$('.list_cate li:nth-child(1)').addClass('active');
							}
						</script>
						<div style="float: right;">
							<form id="search" method="get" action="/mngs/picw">
								<input type="hidden" name="ac" value="search">
								<input type="hidden" name="token" value="<%=token%>">
								<input type="text" size="20" maxlength="20" name="keyword">
								<input type="submit" value="搜索" onclick="return check();">
							</form>
						</div>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<%
								List<Vote> pics = (List<Vote>) request.getAttribute("votes");
								int i = 0;
								for (; pics != null && i < pics.size(); i++) {
									Vote pic = pics.get(i);
									if (i != 0 && i % 4 == 0) {
							%>
						</tr>
						<tr>
							<%
								}
							%>
							<td width="25%" align="center" valign="top">
								<div class="picWall_box">
									<img src="<%=pic.getContent()%>" width="100%" height="180px" />
									<div class="picWall_box_text">
										<%=pic.getName()%><%=pic.getRemark()%>
									</div>
									<div class="picWall_box_info">
										<span>&nbsp;</span>
										<span style="float: right"><%=pic.getAddTime()%></span>
									</div>
									<div class="picWall_box_opt">
										<%
											if (pic.getStatus() == 0) {
										%>
										<a onclick="isPass(this,'<%=pic.getVoteId()%>');">审核</a>
										<%
											} else if (pic.getStatus() == 1) {
										%>
										<select class="transfer" id="<%=pic.getVoteId()%>"
											style="width: 50px;" onchange="transfer(this);">
											<option value="">
												转移
											</option>
										</select>
										<%
											}
										%>
										&nbsp;
										<a onclick="delete_(this,'<%=pic.getVoteId()%>');">删除</a>
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
						</tr>
					</table>

					<div style="margin-top: 15px;">
						<!-- 
						<input type="button" value="新增照片" class="input_button"
							onclick="location='/mngs/bygl?ac=addBg_&token=<%=token%>&topicId=-100'">
						 -->
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/picw" name="loc" />
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
