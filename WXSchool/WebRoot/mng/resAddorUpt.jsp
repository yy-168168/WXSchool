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
	String resId = "-1", resName = "", address = "", picUrl = "", locUrl = "", sort = "1", area = "1", tel = "", notice = "欢迎您的到来，饭口请提前订餐！";
	Res res = (Res) request.getAttribute("res");
	if (res != null) {
		resId = res.getResId() + "";
		resName = res.getResName();
		address = res.getAddress();
		picUrl = res.getPicPath();
		locUrl = res.getLocUrl();
		sort = res.getSort() + "";
		area = res.getArea();
		tel = res.getTel();
		notice = res.getNotice();
	}
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

		<script type="text/javascript">
$(function() {
	optionDefaultSelect($("#area").children(), '<%=area%>');
});

function check() {
	var address = document.getElementsByName("address")[0].value;
	var resName = document.getElementsByName("resName")[0].value;
	var picUrl = document.getElementsByName("picUrl")[0].value;
	var locUrl = document.getElementsByName("locUrl")[0].value;
	var tel = document.getElementsByName("tel")[0].value;
	var sort = document.getElementsByName("sort")[0].value;
	var notice = document.getElementsByName("notice")[0].value;
	var area = document.getElementsByName("area")[0].value;

	if ($.trim(address) == "" || $.trim(resName) == "" || $.trim(picUrl) == ""
			|| $.trim(tel) == "" || $.trim(sort) == "" || $.trim(notice) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (address.length > 100 || resName.length > 20 || picUrl.length > 200
			|| locUrl.length > 200 || tel.length > 20 || sort.length > 10
			|| notice.length > 100 || sort > 100) {
		showNotice("数据过长！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/food?ac=<%=ac%>&token=<%=token%>";
	$.post(url, {
		resId : '<%=resId%>',
		resName : resName,
		address : address,
		notice : notice,
		picUrl : picUrl,
		locUrl : locUrl,
		tel : tel,
		sort : sort,
		area : area
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
			$(":button").attr("disabled", false);
			$(":button").val("保存");
		} else if (msg == "over") {
			showNotice("你已经达到配额上限，请联系管理员。");
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
					添加/更新餐店
					<div style="float: right">
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div style="padding: 20px;">
					<form action="" method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									餐店名称
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="resName" value="<%=resName%>"
										class="input_text" size="50">
									<span class="textSpan">8字以内为宜</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									餐店位置
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="address" value="<%=address%>"
										class="input_text" size="50">
									<span class="textSpan">10字以内为宜</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									图片外链地址
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="picUrl" value="<%=picUrl%>"
										class="input_text" size="50">
										<br/>
									<span class="textSpan">图片大小：110*60px</span>
									<a href="javascript:tuchuang();" style="font-size: 13px">获取外链</a>
								</td>
							</tr>
							<%
								if (picUrl != null && !picUrl.equals("")) {
							%>
							<tr>
								<td></td>
								<td>
									<img alt="" src="<%=picUrl%>" width="160px"
										style="border: 1px solid #EEE">
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<td class="form_title">
									订餐电话
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="tel" value="<%=tel%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									通知
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="notice" value="<%=notice%>"
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
									<span class="textSpan">仅管理员可修改&nbsp;&nbsp;数字(0-100)越大越排在前面</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									所在区域/校区
									<span class="myrequired">*</span>
								</td>
								<td>
									<select id="area" name="area" style="width: 300px; padding: 0"
										class="input_text">
										<option value="1">
											区域一
										</option>
										<option value="2">
											区域二
										</option>
										<option value="3">
											区域三
										</option>
									</select>
									<br />
									<span class="textSpan">在链接后加上&area=1/2/3即可得到相应区域所有餐店</span>
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
									<span style="font-size: 12px; color: #999;">用于跳转到餐店的其他网址</span>
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
