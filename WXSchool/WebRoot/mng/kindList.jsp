 <%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 类别管理</title>

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
</style>
	</head>

	<body>
		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div class="left">
				<jsp:include page="menuLeft.jsp"></jsp:include>
			</div>

			<div class="right">
				<div class="title">
					类别管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<table width="100%" cellpadding="0" cellspacing="0">
						<tr bgcolor="#F1F1F1">
							<th width="30%">
								分类名称
							</th>
							<th width="50%">
								分类图片外链地址
							</th>
							<th>
								操作
							</th>
						</tr>
						<%
							for (int i = 0; i < 5; i++) {
						%>
						<tr align="center">
							<td>
								<input class="input_text" type="text" name="" size="18">
							</td>
							<td>
								<input class="input_text" type="text" name="" size="36">
							</td>
							<td>
								<a href="javascript:void();">删除</a>
							</td>
						</tr>
						<%
							}
						%>
					</table>
					<input type="button" value="保存" class="input_button"
						style="margin-top: 15px">
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
