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
	String keyword = "", title = "", picUrl = "", locUrl = "", cate = "nosel", artId = "-1", rank = "1";
	Article article = (Article) request.getAttribute("article");
	if (article != null) {
		keyword = article.getKeyword();
		title = article.getTitle();
		picUrl = article.getPicUrl();
		locUrl = article.getLocUrl();
		cate = article.getCate();
		rank = article.getRank() + "";
		artId = article.getArticleId() + "";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 素材管理</title>

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
	getArticleCate();
});

function getArticleCate() {
	var url = "/mngs/article?ac=getArtCate&token=<%=token%>";
	$.post(url, function(data) {
		var obj = $.parseJSON(data);
		if (obj == null) {
			window.location.reload();
		} else if (obj == "") {

		} else {
			var ops = "<option value='nosel'>请选择</option>";
			$.each(obj, function(i, n) {
				ops += "<option value=" + n + ">" + n + "</option>";
			});
			$("#cate").html(ops);
			optionDefaultSelect($("#cate").children(), '<%=cate%>');
		}
	});
}

function addCate() {
	var newCate = document.getElementsByName("newCate")[0].value;

	if ($.trim(newCate) == "" || newCate.length > 8) {
		return false;
	} else {
		var ops = "<option value=" + newCate + ">" + newCate + "</option>";
		$("#cate").append(ops);
		optionDefaultSelect($("#cate").children(), newCate);
		$("#addCate_btn").remove();
		$("#addCate").remove();
		show_hide();//隐藏
	}
}

function check() {
	var keyword = document.getElementsByName("keyword")[0].value;
	var title = document.getElementsByName("title")[0].value;
	var picUrl = document.getElementsByName("picUrl")[0].value;
	var locUrl = document.getElementsByName("locUrl")[0].value;
	var cate = document.getElementsByName("cate")[0].value;
	var rank = document.getElementsByName("rank")[0].value;

	if ($.trim(keyword) == "" || $.trim(title) == "" || $.trim(locUrl) == "" || $.trim(rank) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (cate == "nosel") {
		showNotice("请选择文章类别！");
		return false;
	}

	if (keyword.length > 50 || title.length > 100 || picUrl.length > 500
			|| locUrl.length > 500) {
		showNotice("数据过长！");
		return false;
	}

	$("#submit").attr("disabled", true);
	$("#submit").val("提交中...");

	var url = "/mngs/article?ac=<%=ac%>&token=<%=token%>";
	$.post(url, {
		artId : '<%=artId%>',
		keyword : keyword,
		title : title,
		picUrl : picUrl,
		locUrl : locUrl,
		cate : cate,
		rank : rank
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
			$("#submit").attr("disabled", false);
			$("#submit").val("保存");
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
					添加/更新素材
					<div style="float: right">
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div style="padding: 20px;">

					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									关键字
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="keyword" value="<%=keyword%>"
										class="input_text" size="30">
									<span class="textSpan">多个关键字之间用|隔开</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									文章标题
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="title" value="<%=title%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									图片外链地址
									<!-- <span class="myrequired">*</span> -->
								</td>
								<td>
									<input type="text" name="picUrl" value="<%=picUrl%>"
										class="input_text" size="50">
								</td>
							</tr>
							<%
								if (picUrl != null && !picUrl.equals("")) {
							%>
							<tr>
								<td></td>
								<td>
									<img alt="" src="<%=picUrl%>" width="260px"
										style="border: 1px solid #EEE">
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<td class="form_title">
									文章地址
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="locUrl" value="<%=locUrl%>"
										class="input_text" size="50">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									所属类别
								</td>
								<td>
									<select id="cate" name="cate" style="width: 240px; padding: 0"
										class="input_text">
										<option value='nosel'>
											请选择
										</option>
									</select>
									<input id="addCate_btn" type="button" value="新增类别"
										style="vertical-align: bottom" onclick="show_hide('addCate');">
								</td>
							</tr>
							<tr>
								<td class="form_title">
									顺序
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="rank" value="<%=rank%>"
										class="input_text" size="50">
									<br />
									<span class="textSpan">数字(0-100)越大越排在前面</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									附加说明
								</td>
								<td class="extra_info">
									1.关键字：用户回复您设置的关键字即可以图文的形式返回该素材
									<br />
									2.文章标题：微信公众平台图文素材里文章的标题
									<br />
									3.图片链接：文章的封面图片网址(进入文章，在图片上右键复制链接即是)
									<br />
									4.文章地址：文章的网页地址(进入文章，复制浏览器网址即是)
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

		<!-- 新增类别层 -->
		<div class="screenShadow"></div>
		<div id="addCate" class="infoOfScreenCenter" style="padding: 50px;">
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr align="center">
					<td style="font-size: 20px; font-weight: 700">
						新增类别
						<span class="textSpan">(8字以内)</span>
					</td>
				</tr>
				<tr>
					<td height="60px" align="center">
						<input type="text" name="newCate" class="input_text"
							style="width: 90%">
					</td>
				</tr>
				<tr>
					<td align="center">
						<input id="submit" type='button' value='提 交'
							class='input_button_special' style='width: 200px;'
							onclick='addCate();'>
						&nbsp;&nbsp;&nbsp;
						<a href='javascript:show_hide();' style='vertical-align: bottom;'>取消</a>
					</td>
				</tr>
			</table>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
