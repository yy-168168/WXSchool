<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>会员卡特权</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" /> 
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<script type="text/javascript">
function updateVisitPerson(mcId, locUrl) {
	$.get("/mobile/bns?ac=updateVisitPerson&wxaccount=<%=wxaccount%>&mcId=" + mcId,
			function() {
				window.location.href = locUrl;
			});
}
</script>
	</head>

	<body onload="checkMM();">
		<div>
			<%
				List<Merchant> merchants = (List<Merchant>) request
						.getAttribute("merchants");
				if (merchants == null || merchants.size() == 0) {
			%>
			<div class="html5yj" style="padding: 10px">
				无任何记录
			</div>
			<%
				} else {
					for (int i = 0; i < merchants.size(); i++) {
						Merchant mc = merchants.get(i);
			%>
			<div style="padding: 8px 0"
				onclick="updateVisitPerson('<%=mc.getMerchantId()%>','<%=mc.getLocUrl()%>');">
				<div style="float: left; width: 35%">
					<img alt="" src="<%=mc.getPicUrl()%>" width="90%" height="52px"
						style="border-radius: 8px">
				</div>
				<div style="float: left; width: 55%">
					<span><%=mc.getName()%></span>
					<div style="color: #666; font-size: 13px; margin-top: 6px;">
						<%=mc.getDesc()%>
					</div>
				</div>
				<div style="float: left; width: 10%; padding-top: 18px">
					<img alt="" src="static_/go.png" height="15px">
				</div>
				<div style="clear: both"></div>
			</div>
			<div class="fgx" style="margin: 0 -8px;"></div>
			<%
				}
				}
			%>
		</div>
		
		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
