<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String token = request.getParameter("token");
	String ac = request.getParameter("ac");
	String resId = "-1", foodId = "-1", foodName = "", price = "0", type = "1", sort = "1", locUrl = "";
	Food food = (Food) request.getAttribute("food");
	if (food != null) {
		foodId = food.getFoodId() + "";
		foodName = food.getFoodName();
		price = food.getPrice();
		type = food.getType() + "";
		sort = food.getSort() + "";
		locUrl = food.getLocUrl();
	} else {
		resId = request.getParameter("resId");
	}
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

		<script type="text/javascript">
$(function() {
	optionDefaultSelect($("#type").children(), '<%=type%>');
});

function check() {
	var foodName = document.getElementsByName("foodName")[0].value;
	var price = document.getElementsByName("price")[0].value;
	var type = document.getElementsByName("type")[0].value;
	var sort = document.getElementsByName("sort")[0].value;
	var locUrl = document.getElementsByName("locUrl")[0].value;
	
	if ($.trim(foodName) == "" || $.trim(price) == "" || $.trim(sort) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (foodName.length > 20 || price > 1000 || sort > 100 || locUrl > 500) {
		showNotice("数据过长！");
		return false;
	}

	if (!$.isNumeric(price)) {
		showNotice("价格为整数或者小数！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/food?ac=<%=ac%>&token=<%=token%>";
	$.post(url, {
		resId : '<%=resId%>',
		foodId : '<%=foodId%>',
		foodName : foodName,
		type : type,
		price : price,
		sort : sort,
		locUrl : locUrl
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
			$(":button").attr("disabled", false);
			$(":button").val("保存");
		} else {
			if ('<%=ac%>'.indexOf("add") >= 0) {
				isGoonUpt();
			} else {
				window.location.href = document.referrer;
			}
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
					添加/更新菜品
					<div style="float: right">
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div style="padding: 20px;">
					<form action="" method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									菜品名称
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="foodName" value="<%=foodName%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									价格
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="price" value="<%=price%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									顺序
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="sort" value="<%=sort%>"
										class="input_text" size="50">
									<br />
									<span class="textSpan">数字(0-100)越大越排在前面</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									类别
								</td>
								<td>
									<select name="type" id="type" style="width: 300px; padding: 0"
										class="input_text">
										<option value="1">
											盖饭
										</option>
										<option value="2">
											炒饭
										</option>
										<option value="3">
											拌饭
										</option>
										<option value="4">
											小炒
										</option>
										<option value="5">
											套餐
										</option>
										<option value="6">
											面食
										</option>
										<option value="7">
											饺子馄饨
										</option>
										<option value="8">
											饮料
										</option>
										<option value="9">
											小吃
										</option>
										<option value="10">
											特色
										</option>
										<option value="11">
											其它
										</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									外链地址
								</td>
								<td>
									<input type="text" name="locUrl" value="<%=locUrl%>"
										class="input_text" size="50">
									<br />
									<span style="font-size: 12px; color: #999;">用于跳转到菜品的其他网址</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
								</td>
								<td>
									<input type="button" value="保存" class="input_button"
										onclick="check();">
									<div id="erromsg" style="display: inline;"></div>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
