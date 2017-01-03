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

		<title>微接口 - 用户管理</title>

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
<script type="text/javascript">
	function check() {
		var keyword = document.getElementsByName("keyword")[0].value;

		if (keyword == "") {
			return false;
		}
	}
	
	function changeLevel(userwx, level){
		var url = "/mngs/user?ac=changeLevel&token=<%=token%>&wxaccount=<%=wxaccount%>&userwx="+userwx;
		$.get(url, {level : level}, function(data){
			if(data == 'true'){
				showNotice("操作成功！");
			}else{
				showNotice("操作失败！");
			}
		});
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
					用户管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div class="list">
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
								<input type="hidden" name="wxaccount" value="<%=wxaccount%>">
								<input type="text" size="20" maxlength="20" name="keyword">
								<input type="submit" value="搜索" onclick="return check();">
							</form>
						</div>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th>
									头像
								</th>
								<th width="20%">
									昵称
								</th>
								<th width="10%">
									性别
								</th>
								<th width="20%">
									地区
								</th>
								<th width="30%">
									操作时间
								</th>
								<th width="12%">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<WxUser> users = (List<WxUser>)request.getAttribute("users");
							for (int i = 0; users != null && i < users.size(); i++) {
								WxUser user = users.get(i);
								String imgUrl = user.getHeadImgUrl();
								int img_i = imgUrl.lastIndexOf("/");
								
								String imgUrl_46 = imgUrl;
								if(img_i > -1){
									imgUrl_46 = imgUrl.substring(0, img_i)+"/96";
								}
						%>
						<tr align="center">
							<td>
								<img width='50px' alt="" src="<%=imgUrl_46%>" onclick="bigImg(this, '<%=token %>', '<%=wxaccount %>', '<%=user.getUserwx() %>')">
							</td>
							<td>
								<a target="_blank" href="/mngs/operate?ac=listru&token=<%=token%>&wxaccount=<%=wxaccount %>&userwx=<%=user.getUserwx() %>"><%=user.getNickname() %></a>
							</td>
							<td>
								<%int sex = user.getSex();%>
								<%=sex==0?"未知":sex==1?"男":"女" %>
							</td>
							<td>
								<%=user.getCountry() %><%=user.getProvince() %><%=user.getCity() %>
							</td>
							<td>
								关注：<%=user.getSubscribeTime() %><br/>
								<%
									if(user.getStatus() == -1){
										%>取关：<%=user.getUnsubscribeTime() %><br/><%
									}else{
										%>最近：<%=user.getLastUsedTime() %><%
									}
								%>
							</td>
							<td>
								<%
									if(user.getLevel() == 0){
										%><a title="" href="javascript:changeLevel('<%=user.getUserwx()%>',1);">加精</a><%
									}else{
										%><a title="" href="javascript:changeLevel('<%=user.getUserwx()%>',0);">降级</a><%
									}
								%>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/user" name="loc" />
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
