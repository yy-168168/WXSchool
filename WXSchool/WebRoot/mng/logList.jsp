<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath_nop = request.getScheme() + "://"
			+ request.getServerName();
	String basePath = basePath_nop + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 日志管理</title>

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
function deleteLog(obj, logId) {
	$.get("/mngs/log?ac=deleteLog&token=<%=token%>", {
		logId: logId
	}, function(data){
		if(data == "true"){
			obj.parentNode.parentNode.style.display = "none";
		}
		//window.location.reload();
	});
}

function check() {
	var keyword = document.getElementsByName("keyword")[0].value;

	if (keyword == "") {
		return false;
	}
	
	$.get("/mngs/log?ac=deleteByKey&token=<%=token%>", {
		keyword: keyword
	}, function(data){
		if(data == "true"){
			window.location.reload();
		}
	});
	return false;
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
					日志管理
					<div style="float: right">
						<a target="_blank" href="http://mp.weixin.qq.com/wiki/17/fa4e1434e57290788bde25603fa2fcbd.html">微信返回码说明</a>
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<div style="text-align: right; margin-bottom: 15px;">
						<form id="search">
							<input type="text" size="30" maxlength="30" name="keyword">
							<input type="button" value="删除" onclick="return check();">
						</form>
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th width="">
									日志内容
								</th>
								<th width="19%">
									记录时间
								</th>
								<th width="10%">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Log> logs = (List<Log>) request.getAttribute("logs");
							for (int i = 0; logs != null && i < logs.size(); i++) {
								Log log = logs.get(i);
						%>
						<tr align="center">
							<td align="left">
								<%=log.getContent()%>
							</td>
							<td>
								<%=log.getLogTime()%>
							</td>
							<td>
								<a onclick="deleteLog(this, '<%=log.getLogId()%>');">删除</a>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/log" name="loc" />
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
