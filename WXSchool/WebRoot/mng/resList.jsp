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
<%
	String edit = (String)request.getAttribute("edit");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 订餐管理</title>

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
					餐店管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
					</div>
				</div>
				<div class="list">
					<div
						style="margin-bottom: 15px; border-radius: 5px; padding: 8px 10px; background-color: #eee;">
						自定义回复餐店地址链接：/mobile/food?ac=getRess
					</div>
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th style="min-width: 150px">
									餐店名称
								</th>
								<th style="min-width: 150px">
									餐店地址
								</th>
								<th width="110px">
									订餐电话
								</th>
								<th>
									通知
								</th>
								<th width="70px">
									访问量
								</th>
								<th width="50px">
									顺序
								</th>
								<th width="130px">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Res> ress = (List<Res>) request.getAttribute("ress");
							for (int i = 0; ress != null && i < ress.size(); i++) {
								Res res = ress.get(i);
						%>
						<tr align="center">
							<td>
								<%=res.getResName()%>
							</td>
							<td>
								<%=res.getAddress()%>
							</td>
							<td>
								<%=res.getTel()%>
							</td>
							<td align="left">
								<%=res.getNotice()%>
							</td>
							<td>
								<%=res.getVisitPerson()%>
							</td>
							<td>
								<%=res.getSort()%>
							</td>
							<td>
								<a
									href="/mngs/food?ac=getRes&token=<%=token%>&resId=<%=res.getResId()%>">编辑</a>
								<a href="javascript:deleter('<%=res.getResId()%>');">删除</a>
								<br/>
								<a
									href="/mngs/food?ac=listf&token=<%=token%>&resId=<%=res.getResId()%>">菜品管理</a>
								<script type="text/javascript">
function deleter(resId) {
	syncSubmit("/mngs/food?ac=deleter&token=<%=token%>&resId=" + resId);
	window.location.reload();
}
</script>
							</td>
						</tr>
						<%
							}
						%>
					</table>

					<div style="margin-top: 15px;">
						<% if(edit != null && edit.indexOf("add") > -1){
								%>
								<input type="button" value="新增餐店" class="input_button" onclick="location='/mngs/food?ac=addRes_&token=<%=token%>'">
								<%
							} 
						%>
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/food" name="loc" />
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
