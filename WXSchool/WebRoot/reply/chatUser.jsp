<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>随机匹配</title>

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
#chatUser {
	background-color: #fff;
}

#chatUser table {
	padding: 5px 10px;
	border-bottom: 1px solid #ddd;
}

#chatUser img {
	width: 50px;
	height: 50px;
	border-radius: 25px;
}
</style>
		<script type="text/javascript">

</script>
	</head>

	<body onload="checkMM();" style="margin: 0">
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
	});
</script>

		<div id="chatUser">
			<%
				List<ChatRecord> chatUsers = (List<ChatRecord>) request.getAttribute("chatUsers");
				for (int i = 0, len = chatUsers.size(); i < len; i++) {
					ChatRecord record = chatUsers.get(i);
					
					WxUser wxUser = record.getWxUser();
					Student stu = record.getStudent();
					
					String headImgUrl = wxUser.getHeadImgUrl();
					int img_i = headImgUrl.lastIndexOf("/");
					String imgUrl_46 = headImgUrl;
					if (img_i > -1) {
						imgUrl_46 = headImgUrl.substring(0, img_i) + "/96";
					}
					
					String sexImgUrl = "static_/boy2.png";
					if(wxUser.getSex() == 2){
						sexImgUrl = "static_/girl2.png";
					}
					
					String url = "mobile/chat/text?ac=chat&wxaccount="+wxaccount+"&userwx="+userwx+"&to="+UUID.randomUUID().toString()+wxUser.getUserId();
			%>
			<table width='100%' border='0' onclick="location='<%=url %>'">
				<tr>
					<td rowspan='2' width='60px'>
						<img alt='' src='<%=imgUrl_46%>'>
					</td>
					<td>
						<span style='font-weight: bold;'><%=wxUser.getNickname()%></span>
						<img alt='' src='<%=sexImgUrl %>' style='vertical-align: middle; width: 14px; height: 14px'>
					</td>
				</tr>
				<%
					if (!stu.getDepart().equals("")) {
				%>
				<tr>
					<td>
						<span style="font-size: 13px; color: #888;"><%=stu.getGrade()%>级<%=stu.getDepart()%><%=stu.getMajor()%>专业</span>
					</td>
				</tr>
				<%
					}
				%>
			</table>
			<%
				}
			%>
		</div>
		
		<div style="position: fixed; z-index: 10; right: 20px; bottom: 30px; background-color: #000; opacity: 0.6; border-radius: 5px;">
			<img alt='' src='static_/refresh2.png' onclick="javascript: this.style.display='none';window.location.reload();">
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
