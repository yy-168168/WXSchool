<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String token = request.getParameter("token");
	String resId = request.getParameter("resId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 订餐管理 - 菜品管理</title>

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
					菜品管理
					<div style="float: right">
						<a href="javascript:window.location.reload();">刷新</a>
						<a
							href="javascript:location='/mngs/food?ac=listr&token=<%=token%>';">返回</a>
					</div>
				</div>
				<div class="list">
					<table width="100%" cellpadding="0" cellspacing="0" id="sortTable">
						<thead>
							<tr bgcolor="#F1F1F1">
								<th>
									菜品名称
								</th>
								<th width="19%">
									价格
								</th>
								<th width="19%">
									类别
								</th>
								<th width="12%">
									顺序
								</th>
								<th width="14%">
									操作
								</th>
							</tr>
						</thead>
						<%
							List<Food> foods = (List<Food>) request.getAttribute("foods");
							for (int i = 0; foods != null && i < foods.size(); i++) {
								Food food = foods.get(i);
						%>
						<tr align="center">
							<td>
								<%=food.getFoodName()%>
							</td>
							<td>
								￥<%=food.getPrice()%>
							</td>
							<td>
								<%
									String[] foodTypes = { "", "盖饭", "炒饭", "拌饭", "小炒", "套餐", "面食",
												"饺子馄饨", "饮料", "小吃", "特色", "其它" };
								%>
								<%=foodTypes[food.getType()]%>
							</td>
							<td>
								<%=food.getSort()%>
							</td>
							<td>
								<a
									href="/mngs/food?ac=getFood&token=<%=token%>&foodId=<%=food.getFoodId()%>">编辑</a>
								<a href="javascript:deletef('<%=food.getFoodId()%>');">删除</a>
								<script type="text/javascript">
function deletef(foodId) {
	syncSubmit("/mngs/food?ac=deletef&token=<%=token%>&foodId=" + foodId);
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
						<input type="button" value="新增菜品" class="input_button"
							onclick="location='/mngs/food?ac=addFood_&token=<%=token%>&resId=<%=resId%>'">
						<div style="float: right;">
							<jsp:include page="/mng/page.jsp">
								<jsp:param value="/mngs/food" name="loc" />
								<jsp:param value="<%=resId %>" name="resId" />
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
