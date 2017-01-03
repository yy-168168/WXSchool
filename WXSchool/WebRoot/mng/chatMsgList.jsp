<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String token = request.getParameter("token");
	String wxaccount = request.getParameter("wxaccount");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 消息记录</title>

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
		<script type="text/javascript" src="static_/mng.js?v=3.1">
</script>
<script type="text/javascript">
	
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
					消息记录
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div class="list">
					<!-- 
					<div  class="list_cate" style="margin-bottom: 15px;">
						<%
							String url = "/mngs/user?ac=listu&token="+token+"&wxaccount="+wxaccount+"&orderBy=lastUsedTime";
						%>
						<ul style="padding: 0; margin: 0">
							<li onclick="location='<%=url%>'">
								按最近使用时间降序
							</li>
						</ul>
						<div style="float: right">
							<form id="search" method="get" action="/mngs/user">
								<input type="hidden" name="ac" value="search">
								<input type="hidden" name="token" value="<%=token%>">
								<input type="hidden" name="token" value="<%=wxaccount%>">
								<input type="text" size="20" maxlength="20" name="keyword">
								<input type="submit" value="搜索" onclick="return check();">
							</form>
						</div>
					</div>
					 -->
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th>
									头像
								</th>
								<th>
									昵称
								</th>
								<th>
									内容
								</th>
								<th width="18%">
									操作时间
								</th>
								<th width="15%">
									操作
								</th>
							</tr>
						</thead>
						<%
						List<ChatRecord> chatRecords = (List<ChatRecord>)request.getAttribute("chatRecords");
							for (int i = 0; chatRecords != null && i < chatRecords.size(); i++) {
								ChatRecord record = chatRecords.get(i);
								String imgUrl = record.getWxUser().getHeadImgUrl();
								int img_i = imgUrl.lastIndexOf("/");
								
								String imgUrl_46 = imgUrl;
								if(img_i > -1){
									imgUrl_46 = imgUrl.substring(0, img_i)+"/96";
								}
						%>
						<tr align="center">
							<td>
								<img width='50px' alt="" src="<%=imgUrl_46%>" onclick="bigImg(this, '<%=token %>', '<%=wxaccount %>', '<%=record.getFrom() %>')">
							</td>
							<td>
								<%=record.getWxUser().getNickname() %>
							</td>
							<td align="left">
								<%=record.getContent() %>
							</td>
							<td>
								<%=record.getAddTime() %>
							</td>
							<td>
								<a target="_blank" href="/mngs/chat?ac=listmu&token=<%=token%>&wxaccount=<%=wxaccount %>&userwx=<%=record.getFrom() %>&to=<%=record.getTo() %>">本次记录</a>
								<br/>
								<a target="_blank" href="/mngs/chat?ac=listmus&token=<%=token%>&wxaccount=<%=wxaccount %>&userwx=<%=record.getFrom() %>">所有记录</a>
								<br/>
								<a href="javascript:void(-1);">删除</a>
								<a href="javascript:insertBlack('<%=token %>', '<%=record.getFrom()%>', 1)">拉黑</a>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/chat" name="loc" />
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
